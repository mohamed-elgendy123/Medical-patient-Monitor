#ifndef F_CPU
#define F_CPU 8000000UL
#endif

#include "LIB/STD_TYPES.h"
#include "MCAL/GPIO/GPIO_interface.h"
#include "MCAL/SPI/SPI_interface.h"
#include "HAL/ShiftReg/ShiftReg_interface.h"
#include "HAL/NurseCall/NurseCall_interface.h"

/* دالة تأخير بسيطة للاختبار الميداني */
static void delay_ms(uint32 Copy_u32Time)
{
    uint32 i;
    for(i = 0; i < (Copy_u32Time * 500u); i++)
    {
        asm("NOP");
    }
}

int main(void)
{
    /* 1. Initialize HAL Drivers for Student 2 */
    ShiftReg_voidInit();
    NurseCall_voidInit();

    while (1)
    {
        /* Test Pattern 1: High Alarm State */
        ShiftReg_voidWriteByte(0xFF);  /* 8 LEDs ON */
        NurseCall_voidEnable();        /* Nurse Call Active */
        delay_ms(1000);

        /* Test Pattern 2: Normal State */
        ShiftReg_voidWriteByte(0x00);  /* 8 LEDs OFF */
        NurseCall_voidDisable();       /* Nurse Call Idle */
        delay_ms(1000);

        /* Test Pattern 3: Alternating Pattern */
        ShiftReg_voidWriteByte(0xAA);
        delay_ms(1000);
    }

    return 0;
}