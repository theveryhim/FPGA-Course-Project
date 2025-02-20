/* ------------------------------------------------------------ */
/*				Include File Definitions						*/
/* ------------------------------------------------------------ */

#include "math.h"
#include "xscugic.h"
#include "xaxidma.h"
#include "sleep.h"
#include "xil_exception.h"
#include "xgpiops.h"

/*
 *DMA redefines
 */
#define MAX_DMA_LEN		   0x400      /* DMA max length in byte */
#define DMA_0_DEV_ID	   XPAR_AXIDMA_0_DEVICE_ID
#define DMA_1_DEV_ID	   XPAR_AXIDMA_1_DEVICE_ID
#define MM2S_INTR_ID       XPAR_FABRIC_AXI_DMA_0_MM2S_INTROUT_INTR
#define S2MM_INTR_ID       XPAR_FABRIC_AXI_DMA_1_S2MM_INTROUT_INTR
#define KEY_INTR_ID        XPAR_XGPIOPS_0_INTR

#define MAX_AMP_VAL        256	/* 2^8, do not change */
#define AMP_VAL            256	/* must be less than 2^8 */
#define MIO_0_ID           XPAR_PS7_GPIO_0_DEVICE_ID

#define GPIO_INPUT         0


#define ADC_CAPTURELEN     1920           /* ADC capture length */
#define ADC_COE            1              /* ADC coefficient */
#define ADC_BYTE           1              /* ADC data byte number */
#define ADC_BITS           8

/*
 *
 *

 *Wave defines
 */
#define CANVAS_LEN          1920*1080*3    /* Canvas total length in byte */
#define WAVE_START_ROW1     50             /* Grid and Wave start row in frame */
#define WAVE_START_ROW2		300
#define WAVE_START_COLUMN   0              /* Grid and Wave start column in frame */
#define WAVE_HEIGHT         256   		   /* Grid and Wave height */
/*
 *Function defines
 */
int XAxiDma_Adc_Wave(u32 width, u8 *frame, u32 stride, XScuGic *InstancePtr);


