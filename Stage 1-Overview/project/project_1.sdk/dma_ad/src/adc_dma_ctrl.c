/* ------------------------------------------------------------ */
/*				Include File Definitions						*/
/* ------------------------------------------------------------ */

#include "adc_dma_ctrl.h"
#include "wave/wave.h"
#include "wave/wavegen.h"
/*
 * DMA s2mm receiver buffer
 */
u32 DmaRxBuffer[MAX_DMA_LEN]  __attribute__ ((aligned(64)));
u32 DmaTxBuffer[MAX_DMA_LEN]  __attribute__ ((aligned(64)));

u16 RealBuffer[MAX_DMA_LEN]   __attribute__ ((aligned(64)));

double AmpBuffer[MAX_DMA_LEN]	  __attribute__ ((aligned(64)));

u16 WaveBuffer[MAX_DMA_LEN] __attribute__ ((aligned(64)));
/*
 * Canvas buffer for drawing grid and wave
 */
u8 CanvasBuffer[CANVAS_LEN] ;
/*
 * DMA struct
 */
XAxiDma AxiDma_0;
XAxiDma AxiDma_1;

XGpioPs GPIO_PTR ;
/*
 * s2mm interrupt flag
 */
volatile int s2mm_flag ;
volatile int mm2s_flag ;
volatile int key_flag ;
/*
 * Function declaration
 */
int XAxiDma_Write_Initial(u16 DeviceId, u16 IntrID, XAxiDma *XAxiDma, XScuGic *InstancePtr) ;
int XAxiDma_Read_Initial(u16 DeviceId, u16 IntrID, XAxiDma *XAxiDma, XScuGic *InstancePtr) ;
void Dma_Read_Interrupt_Handler(void *CallBackRef);
void Dma_Write_Interrupt_Handler(void *CallBackRef);
void frame_copy(u32 width, u32 height, u32 stride, int hor_x, int ver_y, u8 *frame, u8 *CanvasBufferPtr) ;
int KeySetup(XScuGic *InstancePtr, u16 IntrID, XGpioPs *GpioInstancePtr) ;
void GpioHandler(void *CallbackRef);

/*
 *Initial DMA,Draw grid and wave,Start ADC sample
 *
 *@param width is frame width
 *@param frame is display frame pointer
 *@param stride is frame stride
 *@param InstancePtr is GIC pointer
 */
int XAxiDma_Adc_Wave(u32 width, u8 *frame, u32 stride, XScuGic *InstancePtr)
{
	int Status;
	u32 wave_width = width ;

	s2mm_flag = 1 ;
	mm2s_flag = 1 ;

	XAxiDma_Write_Initial(DMA_1_DEV_ID, S2MM_INTR_ID, &AxiDma_1, InstancePtr) ;
	XAxiDma_Read_Initial(DMA_0_DEV_ID, MM2S_INTR_ID, &AxiDma_0, InstancePtr) ;

	while(1) {
		int wave_sel = 0;


		if (s2mm_flag)
		{
			/* clear s2mm_flag */
			s2mm_flag = 0 ;

			double real, imag;
			for (int i = 0; i < MAX_DMA_LEN; i++) {
				real = (double)((DmaRxBuffer[i] & 0xFFFF) / 128.0);
				imag = (double)((DmaRxBuffer[i] & 0xFFFF0000) / 128.0);
				AmpBuffer[i] = sqrt(real * real + imag * imag);
			}

			/* Grid Overlay */
			draw_grid(wave_width, WAVE_HEIGHT, CanvasBuffer) ;
			/* wave Overlay */
			draw_wave(wave_width, WAVE_HEIGHT, (void *)RealBuffer, CanvasBuffer, UNSIGNEDCHAR, ADC_BITS, YELLOW, ADC_COE) ;
			draw_wave(wave_width, WAVE_HEIGHT, (void *)DmaRxBuffer, CanvasBuffer, UNSIGNEDCHAR, ADC_BITS, YELLOW, ADC_COE) ;
			/* Copy Canvas to frame buffer */
			frame_copy(wave_width, WAVE_HEIGHT, stride, WAVE_START_COLUMN, WAVE_START_ROW1, frame, CanvasBuffer) ;
			frame_copy(wave_width, WAVE_HEIGHT, stride, WAVE_START_COLUMN, WAVE_START_ROW2, frame, CanvasBuffer) ;
			/* delay 100ms */
			usleep(100000) ;
			/* start DMA translation from FFT to DDR3 */
			Status = XAxiDma_SimpleTransfer(&AxiDma_1,(UINTPTR) DmaRxBuffer,
					MAX_DMA_LEN, XAXIDMA_DEVICE_TO_DMA);

			if (Status != XST_SUCCESS) {
				return XST_FAILURE;
			}
		}

		if (mm2s_flag)
		{
			mm2s_flag = 0;
		}
		if (key_flag)
		{
			switch(wave_sel)
			{
			case 0 : GetSquareWave(MAX_DMA_LEN, MAX_AMP_VAL, AMP_VAL, WaveBuffer) ; break ;
			case 1 : GetTriangleWave(MAX_DMA_LEN, MAX_AMP_VAL, AMP_VAL, WaveBuffer) ; break ;
			case 2 : GetSawtoothWave(MAX_DMA_LEN, MAX_AMP_VAL, AMP_VAL, WaveBuffer) ; break ;
			case 3 : GetSubSawtoothWave(MAX_DMA_LEN, MAX_AMP_VAL, AMP_VAL, WaveBuffer) ; break ;
			case 4 : GetSinWave(MAX_DMA_LEN, MAX_AMP_VAL, AMP_VAL, WaveBuffer) ; break ;
			default: GetSinWave(MAX_DMA_LEN, MAX_AMP_VAL, AMP_VAL, WaveBuffer) ; break ;
			}

			memcpy(RealBuffer, WaveBuffer, MAX_DMA_LEN) ;
			for (int i = 0; i < MAX_DMA_LEN; i++) {
				DmaTxBuffer[i] = (u32)RealBuffer[i];
			}

			Xil_DCacheFlushRange((UINTPTR)DmaTxBuffer, MAX_DMA_LEN);

			if (wave_sel == 4)
				wave_sel = 0 ;
			else
				wave_sel++ ;

			/* Clear flag */
			key_flag = 0 ;

			XAxiDma_SimpleTransfer(&AxiDma_0,(UINTPTR) DmaTxBuffer,
					MAX_DMA_LEN, XAXIDMA_DMA_TO_DEVICE);
		}
	}
}

/*
 *This is ADC sample function, use it and start sample adc data
 *
 *@param adc_addr ADC base address
 *@param adc_len is sample length in ADC data width
 */
//void ad9280_sample(u32 adc_addr, u32 adc_len)
//{
//	/* provide length to AD9280 module */
//	AD9280_SAMPLE_mWriteReg(adc_addr, AD9280_LENGTH, adc_len)  ;
//	/* start sample AD9280 */
//	AD9280_SAMPLE_mWriteReg(adc_addr, AD9280_START, 1) ;
//}

/*
 *Copy canvas buffer data to special position in frame
 *
 *@param hor_x  start horizontal position for copy
 *@param ver_y  start vertical position for copy
 *@param width  width for copy
 *@param height height for copy
 *
 *@note  hor_x+width should be less than frame width, ver_y+height should be less than frame height
 */
void frame_copy(u32 width, u32 height, u32 stride, int hor_x, int ver_y, u8 *frame, u8 *CanvasBufferPtr)
{
	int i ;
	u32 FrameOffset ;
	u32 CanvasOffset ;
	u32 CopyLen = width*BYTES_PIXEL ;

	for(i = 0 ; i < height;  i++)
	{
		FrameOffset = (ver_y+i)*stride + hor_x*BYTES_PIXEL ;
		CanvasOffset = i*width*BYTES_PIXEL ;
		memcpy(frame+FrameOffset, CanvasBufferPtr+CanvasOffset, CopyLen) ;
	}

	FrameOffset = ver_y*stride ;

	Xil_DCacheFlushRange((INTPTR) frame+FrameOffset, height*stride) ;
}


/*
 *Initial DMA and connect interrupt to handler, open s2mm interrupt
 *
 *@param DeviceId    DMA device id
 *@param IntrID      DMA interrupt id
 *@param XAxiDma     DMA pointer
 *@param InstancePtr GIC pointer
 *
 *@note  none
 */
int XAxiDma_Write_Initial(u16 DeviceId, u16 IntrID, XAxiDma *XAxiDma, XScuGic *InstancePtr)
{
	XAxiDma_Config *CfgPtr;
	int Status;
	/* Initialize the XAxiDma device. */
	CfgPtr = XAxiDma_LookupConfig(DeviceId);
	if (!CfgPtr) {
		xil_printf("No config found for %d\r\n", DeviceId);
		return XST_FAILURE;
	}

	Status = XAxiDma_CfgInitialize(XAxiDma, CfgPtr);
	if (Status != XST_SUCCESS) {
		xil_printf("Initialization failed %d\r\n", Status);
		return XST_FAILURE;
	}

	Status = XScuGic_Connect(InstancePtr, IntrID,
			(Xil_ExceptionHandler)Dma_Write_Interrupt_Handler,
			(void *)XAxiDma) ;

	if (Status != XST_SUCCESS) {
		return Status;
	}

	XScuGic_Enable(InstancePtr, IntrID);


	/* Disable MM2S interrupt, Enable S2MM interrupt */
	XAxiDma_IntrEnable(XAxiDma, XAXIDMA_IRQ_IOC_MASK,
			XAXIDMA_DEVICE_TO_DMA);
	XAxiDma_IntrDisable(XAxiDma, XAXIDMA_IRQ_ALL_MASK,
			XAXIDMA_DMA_TO_DEVICE);

	return XST_SUCCESS ;
}

int XAxiDma_Read_Initial(u16 DeviceId, u16 IntrID, XAxiDma *XAxiDma, XScuGic *InstancePtr)
{
		XAxiDma_Config *CfgPtr;
		int Status;
		/* Initialize the XAxiDma device. */
		CfgPtr = XAxiDma_LookupConfig(DeviceId);
		if (!CfgPtr) {
			xil_printf("No config found for %d\r\n", DeviceId);
			return XST_FAILURE;
		}

		Status = XAxiDma_CfgInitialize(XAxiDma, CfgPtr);
		if (Status != XST_SUCCESS) {
			xil_printf("Initialization failed %d\r\n", Status);
			return XST_FAILURE;
		}

		Status = XScuGic_Connect(InstancePtr, IntrID,
				(Xil_ExceptionHandler)Dma_Read_Interrupt_Handler,
				(void *)XAxiDma) ;

		if (Status != XST_SUCCESS) {
			return Status;
		}

		XScuGic_Enable(InstancePtr, IntrID);


		/* Disable S2MM interrupt, Enable MM2S interrupt */
		XAxiDma_IntrEnable(XAxiDma, XAXIDMA_IRQ_IOC_MASK,
				XAXIDMA_DMA_TO_DEVICE);
		XAxiDma_IntrDisable(XAxiDma, XAXIDMA_IRQ_ALL_MASK,
				XAXIDMA_DEVICE_TO_DMA);

		return XST_SUCCESS ;
}

int KeySetup(XScuGic *InstancePtr, u16 IntrID, XGpioPs *GpioInstancePtr)
{
	XGpioPs_Config *GPIO_CONFIG ;
	int Status ;
	key_flag = 0 ;


	GPIO_CONFIG = XGpioPs_LookupConfig(MIO_0_ID) ;
	Status = XGpioPs_CfgInitialize(GpioInstancePtr, GPIO_CONFIG, GPIO_CONFIG->BaseAddr) ;
	if (Status != XST_SUCCESS)
	{
		return XST_FAILURE ;
	}
	//set MIO 50 as input
	XGpioPs_SetDirectionPin(GpioInstancePtr, 50, GPIO_INPUT) ;
	//set interrupt type
	XGpioPs_SetIntrTypePin(GpioInstancePtr, 50, XGPIOPS_IRQ_TYPE_EDGE_RISING) ;


	//set priority and trigger type
	XScuGic_SetPriorityTriggerType(InstancePtr, IntrID,
			0xA0, 0x3);
	Status = XScuGic_Connect(InstancePtr, IntrID,
			(Xil_ExceptionHandler)GpioHandler,
			(void *)GpioInstancePtr) ;

	XScuGic_Enable(InstancePtr, IntrID) ;

	if (Status != XST_SUCCESS) {
		return Status;
	}


	XGpioPs_IntrEnablePin(GpioInstancePtr, 50) ;

	return XST_SUCCESS ;
}


/*
 *callback function
 *Check interrupt status and assert s2mm flag
 */
void Dma_Read_Interrupt_Handler(void *CallBackRef)
{
	XAxiDma *XAxiDmaPtr ;
	XAxiDmaPtr = (XAxiDma *) CallBackRef ;

	int s2mm_sr ;

	s2mm_sr = XAxiDma_IntrGetIrq(XAxiDmaPtr, XAXIDMA_DEVICE_TO_DMA) ;

	if (s2mm_sr & XAXIDMA_IRQ_IOC_MASK)
	{
		/* Clear interrupt */
		XAxiDma_IntrAckIrq(XAxiDmaPtr, XAXIDMA_IRQ_IOC_MASK,
				XAXIDMA_DEVICE_TO_DMA) ;
		/* Invalidate the Data cache for the given address range */
		Xil_DCacheInvalidateRange((INTPTR)DmaRxBuffer, ADC_CAPTURELEN);

		s2mm_flag = 1 ;
	}

}

void Dma_Write_Interrupt_Handler(void *CallBackRef)
{
	XAxiDma *XAxiDmaPtr ;
	XAxiDmaPtr = (XAxiDma *) CallBackRef ;

	int mm2s_sr;

	mm2s_sr = XAxiDma_IntrGetIrq(XAxiDmaPtr, XAXIDMA_DMA_TO_DEVICE) ;

	if (mm2s_sr & XAXIDMA_IRQ_IOC_MASK)
	{
		/* Clear interrupt */
		XAxiDma_IntrAckIrq(XAxiDmaPtr, XAXIDMA_IRQ_IOC_MASK,
				XAXIDMA_DMA_TO_DEVICE) ;

		mm2s_flag = 0;
	}

}

void GpioHandler(void *CallbackRef)
{
	XGpioPs *GpioInstancePtr = (XGpioPs *)CallbackRef ;
	int Int_val ;

	Int_val = XGpioPs_IntrGetStatusPin(GpioInstancePtr, 50) ;
	/* clear key interrupt */
	XGpioPs_IntrClearPin(GpioInstancePtr, 50) ;
	if (Int_val == TRUE)
		key_flag = 1 ;

}

