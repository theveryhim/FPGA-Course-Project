################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
../src/wave/wave.c \
../src/wave/wave2.c 

OBJS += \
./src/wave/wave.o \
./src/wave/wave2.o 

C_DEPS += \
./src/wave/wave.d \
./src/wave/wave2.d 


# Each subdirectory must supply rules for building sources it contributes
src/wave/%.o: ../src/wave/%.c
	@echo 'Building file: $<'
	@echo 'Invoking: ARM v7 gcc compiler'
	arm-none-eabi-gcc -Wall -O0 -g3 -c -fmessage-length=0 -MT"$@" -mcpu=cortex-a9 -mfpu=vfpv3 -mfloat-abi=hard -I../../dma_ad_bsp/ps7_cortexa9_0/include -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@)" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


