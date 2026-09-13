# 0 "MCAL/TIMER/TIMER.c"
# 0 "<built-in>"
# 0 "<command-line>"
# 1 "MCAL/TIMER/TIMER.c"
# 19 "MCAL/TIMER/TIMER.c"
# 1 "LIB/STD_TYPES.h" 1
# 11 "LIB/STD_TYPES.h"
typedef unsigned char uint8;
typedef unsigned short uint16;
typedef unsigned long uint32;
typedef signed char sint8;
typedef signed short sint16;
typedef signed long sint32;

typedef unsigned char uint8_h;

typedef enum
{
    E_OK = 0,
    E_NOK = 1
} STD_ReturnType;
# 20 "MCAL/TIMER/TIMER.c" 2
# 1 "MCAL/TIMER/TIMER_interface.h" 1
# 29 "MCAL/TIMER/TIMER_interface.h"
STD_ReturnType TIMER0_Init(void);




STD_ReturnType TIMER0_DelayMS(uint16 Copy_u16Milliseconds);




STD_ReturnType TIMER0_DelayS(uint16 Copy_u16Seconds);







STD_ReturnType TIMER0_PWM(uint8 Copy_u8DutyPercent);




STD_ReturnType TIMER0_Stop(void);






STD_ReturnType TIMER1_Init(void);




STD_ReturnType TIMER1_DelayMS(uint16 Copy_u16Milliseconds);
# 73 "MCAL/TIMER/TIMER_interface.h"
STD_ReturnType TIMER1_PWM(uint16 Copy_u16FrequencyHz, uint8 Copy_u8DutyPercent);




STD_ReturnType TIMER1_Stop(void);
# 21 "MCAL/TIMER/TIMER.c" 2
# 1 "MCAL/TIMER/TIMER_private.h" 1
# 22 "MCAL/TIMER/TIMER.c" 2
# 35 "MCAL/TIMER/TIMER.c"
static void TIMER_WaitFlag(volatile uint8 *Copy_pu8Register, uint8 Copy_u8BitMask);
# 44 "MCAL/TIMER/TIMER.c"
static uint16 TIMER_DutyToCompare(uint16 Copy_u16Top, uint8 Copy_u8DutyPercent);





STD_ReturnType TIMER0_Init(void)
{
# 62 "MCAL/TIMER/TIMER.c"
    (*(volatile uint8*)0x53) = (1 << 3) | (0 << 6);
    (*(volatile uint8*)0x5C) = 124;
    (*(volatile uint8*)0x52) = 0;
    return E_OK;
}

STD_ReturnType TIMER0_DelayMS(uint16 Copy_u16Milliseconds)
{
# 81 "MCAL/TIMER/TIMER.c"
    (*(volatile uint8*)0x58) |= (1 << 1);
    (*(volatile uint8*)0x53) |= (1 << 0) | (1 << 1);

    for (uint16 i = 0; i < Copy_u16Milliseconds; i++)
    {
        TIMER_WaitFlag(&(*(volatile uint8*)0x58), (1 << 1));
    }

    (*(volatile uint8*)0x53) &= ~((1 << 2) | (1 << 1) | (1 << 0));


    return E_OK;
}

STD_ReturnType TIMER0_DelayS(uint16 Copy_u16Seconds)
{






}

STD_ReturnType TIMER0_PWM(uint8 Copy_u8DutyPercent)
{
# 120 "MCAL/TIMER/TIMER.c"
}

STD_ReturnType TIMER0_Stop(void)
{






}





STD_ReturnType TIMER1_Init(void)
{
# 147 "MCAL/TIMER/TIMER.c"
}

STD_ReturnType TIMER1_DelayMS(uint16 Copy_u16Milliseconds)
{






}

STD_ReturnType TIMER1_PWM(uint16 Copy_u16FrequencyHz, uint8 Copy_u8DutyPercent)
{
# 178 "MCAL/TIMER/TIMER.c"
}

STD_ReturnType TIMER1_Stop(void)
{





}





static void TIMER_WaitFlag(volatile uint8 *Copy_pu8Register, uint8 Copy_u8BitMask)
{







    while (!(*Copy_pu8Register & Copy_u8BitMask));



    *Copy_pu8Register |= Copy_u8BitMask;
# 221 "MCAL/TIMER/TIMER.c"
}



static uint16 TIMER_DutyToCompare(uint16 Copy_u16Top, uint8 Copy_u8DutyPercent)
{





}
