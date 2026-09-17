# 0 "MCAL/TIMER/TIMER.c"
# 0 "<built-in>"
# 0 "<command-line>"
# 1 "MCAL/TIMER/TIMER.c"
# 1 "C:/avr-gcc/avr/include/avr/interrupt.h" 1 3
# 38 "C:/avr-gcc/avr/include/avr/interrupt.h" 3
# 1 "C:/avr-gcc/avr/include/avr/io.h" 1 3
# 99 "C:/avr-gcc/avr/include/avr/io.h" 3
# 1 "C:/avr-gcc/avr/include/avr/sfr_defs.h" 1 3
# 126 "C:/avr-gcc/avr/include/avr/sfr_defs.h" 3
# 1 "C:/avr-gcc/avr/include/inttypes.h" 1 3
# 37 "C:/avr-gcc/avr/include/inttypes.h" 3
# 1 "C:/avr-gcc/lib/gcc/avr/15.2.0/include/stdint.h" 1 3 4
# 9 "C:/avr-gcc/lib/gcc/avr/15.2.0/include/stdint.h" 3 4
#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wpedantic"
# 1 "C:/avr-gcc/avr/include/stdint.h" 1 3 4
# 125 "C:/avr-gcc/avr/include/stdint.h" 3 4
typedef signed int int8_t __attribute__((__mode__(__QI__)));
typedef unsigned int uint8_t __attribute__((__mode__(__QI__)));
typedef signed int int16_t __attribute__ ((__mode__ (__HI__)));
typedef unsigned int uint16_t __attribute__ ((__mode__ (__HI__)));
typedef signed int int32_t __attribute__ ((__mode__ (__SI__)));
typedef unsigned int uint32_t __attribute__ ((__mode__ (__SI__)));

typedef signed int int64_t __attribute__((__mode__(__DI__)));
typedef unsigned int uint64_t __attribute__((__mode__(__DI__)));
# 146 "C:/avr-gcc/avr/include/stdint.h" 3 4
typedef int16_t intptr_t;




typedef uint16_t uintptr_t;
# 163 "C:/avr-gcc/avr/include/stdint.h" 3 4
typedef int8_t int_least8_t;




typedef uint8_t uint_least8_t;




typedef int16_t int_least16_t;




typedef uint16_t uint_least16_t;




typedef int32_t int_least32_t;




typedef uint32_t uint_least32_t;







typedef int64_t int_least64_t;






typedef uint64_t uint_least64_t;
# 217 "C:/avr-gcc/avr/include/stdint.h" 3 4
typedef int8_t int_fast8_t;




typedef uint8_t uint_fast8_t;




typedef int16_t int_fast16_t;




typedef uint16_t uint_fast16_t;




typedef int32_t int_fast32_t;




typedef uint32_t uint_fast32_t;







typedef int64_t int_fast64_t;






typedef uint64_t uint_fast64_t;
# 277 "C:/avr-gcc/avr/include/stdint.h" 3 4
typedef int64_t intmax_t;




typedef uint64_t uintmax_t;
# 12 "C:/avr-gcc/lib/gcc/avr/15.2.0/include/stdint.h" 2 3 4
#pragma GCC diagnostic pop
# 38 "C:/avr-gcc/avr/include/inttypes.h" 2 3
# 77 "C:/avr-gcc/avr/include/inttypes.h" 3
typedef int32_t int_farptr_t;





typedef uint32_t uint_farptr_t;
# 127 "C:/avr-gcc/avr/include/avr/sfr_defs.h" 2 3
# 100 "C:/avr-gcc/avr/include/avr/io.h" 2 3
# 230 "C:/avr-gcc/avr/include/avr/io.h" 3
# 1 "C:/avr-gcc/avr/include/avr/iom32.h" 1 3
# 720 "C:/avr-gcc/avr/include/avr/iom32.h" 3
       
# 721 "C:/avr-gcc/avr/include/avr/iom32.h" 3

       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
# 231 "C:/avr-gcc/avr/include/avr/io.h" 2 3
# 785 "C:/avr-gcc/avr/include/avr/io.h" 3
# 1 "C:/avr-gcc/avr/include/avr/portpins.h" 1 3
# 786 "C:/avr-gcc/avr/include/avr/io.h" 2 3

# 1 "C:/avr-gcc/avr/include/avr/common.h" 1 3
# 788 "C:/avr-gcc/avr/include/avr/io.h" 2 3

# 1 "C:/avr-gcc/avr/include/avr/version.h" 1 3
# 790 "C:/avr-gcc/avr/include/avr/io.h" 2 3






# 1 "C:/avr-gcc/avr/include/avr/fuse.h" 1 3
# 248 "C:/avr-gcc/avr/include/avr/fuse.h" 3
typedef struct
{
    unsigned char low;
    unsigned char high;
} __fuse_t;
# 797 "C:/avr-gcc/avr/include/avr/io.h" 2 3


# 1 "C:/avr-gcc/avr/include/avr/lock.h" 1 3
# 800 "C:/avr-gcc/avr/include/avr/io.h" 2 3
# 39 "C:/avr-gcc/avr/include/avr/interrupt.h" 2 3
# 2 "MCAL/TIMER/TIMER.c" 2

# 1 "LIB/STD_TYPES.h" 1
# 13 "LIB/STD_TYPES.h"

# 13 "LIB/STD_TYPES.h"
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
    E_NOK = 1,
    E_PORT_Not_valid = 2,
    E_PIN_Not_valid = 3,
} STD_ReturnType;
# 4 "MCAL/TIMER/TIMER.c" 2
# 1 "MCAL/TIMER/TIMER_interface.h" 1
# 16 "MCAL/TIMER/TIMER_interface.h"
typedef void (*TIMER_CallbackType)(void);






void TIMER0_Init(void);
void TIMER0_SetCallback(TIMER_CallbackType Copy_pvCallback);
uint8 TIMER0_IsTickPending(void);
void TIMER0_ClearTick(void);

void TIMER1_Init(void);
void TIMER1_Poll(void);
uint8 TIMER1_IsCaptureReady(void);
void TIMER1_ClearCaptureFlag(void);
uint16 TIMER1_GetLastInterval(void);
uint8 TIMER1_IsAsystole(void);
void TIMER1_ClearAsystole(void);

void TIMER2_Init(void);
void TIMER2_SetTone(uint8 Copy_u8Tone);
# 5 "MCAL/TIMER/TIMER.c" 2
# 1 "MCAL/TIMER/TIMER_private.h" 1
# 6 "MCAL/TIMER/TIMER.c" 2
# 1 "MCAL/INTERRUPT/INTERRUPT_interface.h" 1
# 28 "MCAL/INTERRUPT/INTERRUPT_interface.h"
STD_ReturnType INTERRUPT_EnableGlobal(void);




STD_ReturnType INTERRUPT_DisableGlobal(void);





STD_ReturnType EXTI_SetSense(uint8 Copy_u8Int, uint8 Copy_u8Sense);





STD_ReturnType EXTI_Enable(uint8 Copy_u8Int);




STD_ReturnType EXTI_Disable(uint8 Copy_u8Int);




STD_ReturnType EXTI_ClearFlag(uint8 Copy_u8Int);
# 65 "MCAL/INTERRUPT/INTERRUPT_interface.h"
STD_ReturnType EXTI_SetCallback(uint8 Copy_u8Int, void (*Copy_pfCallback)(void));
# 7 "MCAL/TIMER/TIMER.c" 2


static volatile uint32 Timer0_Ticks;
static volatile TIMER_CallbackType Timer0_Callback = (TIMER_CallbackType)0;
static volatile uint8 Timer0_TickPending = 0U;

static volatile uint16 Timer1_Intervals[8U];
static volatile uint16 Timer1_LastCapture = 0U;
static volatile uint8 Timer1_RingIndex = 0U;
static volatile uint8 Timer1_CaptureReady = 0U;
static volatile uint8 Timer1_Asystole = 0U;
static volatile uint8 Timer1_OverflowCount = 0U;
static volatile uint8 Timer1_HasLastCapture = 0U;
static volatile uint16 Timer1_LastInterval = 0U;





void TIMER0_Init(void)
{

    (*(volatile uint8 *)0x53U) = 0U;
    (*(volatile uint8 *)0x52U) = 0U;


    (*(volatile uint8 *)0x5CU) = 77U;


    (((*(volatile uint8 *)0x53U)) |= (uint8)(1U << (3U)));


    (((*(volatile uint8 *)0x53U)) |= (uint8)(1U << (2U)));
    (((*(volatile uint8 *)0x53U)) |= (uint8)(1U << (0U)));


    (((*(volatile uint8 *)0x59U)) |= (uint8)(1U << (1U)));
}

void TIMER0_SetCallback(TIMER_CallbackType Copy_pvCallback)
{
    if (Copy_pvCallback != (TIMER_CallbackType)0)
    {
        Timer0_Callback = Copy_pvCallback;
    }
    else
    {
        Timer0_Callback = (TIMER_CallbackType)0;
    }
}

uint8 TIMER0_IsTickPending(void)
{

    if (Timer0_TickPending != 0U)
    {
        return 1U;
    }
    else
    {
        return 0U;
    }
}

void TIMER0_ClearTick(void)
{
    Timer0_TickPending = 0U;
}





void TIMER1_Init(void)
{
    uint8 Local_u8Idx = 0U;


    (*(volatile uint8 *)0x4FU) = 0U;
    (*(volatile uint8 *)0x4EU) = 0U;
    (*(volatile uint16 *)0x4CU) = 0U;


    (*(volatile uint8 *)0x58U) = (1U << 5U) | (1U << 2U);


    (((*(volatile uint8 *)0x4EU)) |= (uint8)(1U << (6U)));
    (((*(volatile uint8 *)0x4EU)) |= (uint8)(1U << (7U)));
    (((*(volatile uint8 *)0x4EU)) |= (uint8)(1U << (2U)));


    (((*(volatile uint8 *)0x59U)) |= (uint8)(1U << (5U)));
    (((*(volatile uint8 *)0x59U)) |= (uint8)(1U << (2U)));


    for (Local_u8Idx = 0U; Local_u8Idx < 8U; Local_u8Idx++)
    {
        Timer1_Intervals[Local_u8Idx] = 0U;
    }

    Timer1_LastCapture = 0U;
    Timer1_RingIndex = 0U;
    Timer1_CaptureReady = 0U;
    Timer1_Asystole = 0U;
    Timer1_OverflowCount = 0U;
    Timer1_HasLastCapture = 0U;
    Timer1_LastInterval = 0U;
}

static void TIMER1_ProcessCapture(uint16 Copy_u16Capture)
{
    if (Timer1_HasLastCapture == 0U)
    {
        Timer1_LastCapture = Copy_u16Capture;
        Timer1_HasLastCapture = 1U;
        return;
    }

    Timer1_LastInterval = (uint16)(Copy_u16Capture - Timer1_LastCapture);
    Timer1_Intervals[Timer1_RingIndex] = Timer1_LastInterval;
    Timer1_LastCapture = Copy_u16Capture;

    Timer1_RingIndex++;
    if (Timer1_RingIndex >= 8U)
    {
        Timer1_RingIndex = 0U;
    }

    Timer1_CaptureReady = 1U;
    Timer1_OverflowCount = 0U;
    Timer1_Asystole = 0U;
}

void TIMER1_Poll(void)
{

    if (((*(volatile uint8 *)0x58U) & (1U << 2U)) != 0U)
    {
        (*(volatile uint8 *)0x58U) = (1U << 2U);
        Timer1_OverflowCount++;
        if (Timer1_OverflowCount >= 2U)
        {
            Timer1_Asystole = 1U;
        }
    }


    static uint8 s_u8PrevPD6 = 0U;
    uint8 s_u8CurrPD6 = (((uint8)(((*(volatile uint8 *)0x30U) >> (6U)) & 1U)) != 0U) ? 1U : 0U;
    uint8 s_u8RisingEdge = ((s_u8PrevPD6 == 0U) && (s_u8CurrPD6 != 0U)) ? 1U : 0U;
    s_u8PrevPD6 = s_u8CurrPD6;

    if (Timer1_CaptureReady != 0U)
    {
        return;
    }


    if (((*(volatile uint8 *)0x58U) & (1U << 5U)) != 0U)
    {
        uint16 Local_u16Cap = (*(volatile uint16 *)0x46U);
        (*(volatile uint8 *)0x58U) = (1U << 5U);
        TIMER1_ProcessCapture(Local_u16Cap);
    }

    else if (s_u8RisingEdge != 0U)
    {
        uint16 Local_u16Count = (*(volatile uint16 *)0x4CU);
        TIMER1_ProcessCapture(Local_u16Count);
    }
}

uint8 TIMER1_IsCaptureReady(void)
{
    TIMER1_Poll();
    return (Timer1_CaptureReady != 0U) ? 1U : 0U;
}

void TIMER1_ClearCaptureFlag(void)
{
    Timer1_CaptureReady = 0U;
}

uint16 TIMER1_GetLastInterval(void)
{
    uint16 Local_u16Val;


    (void)INTERRUPT_DisableGlobal();
    Local_u16Val = Timer1_LastInterval;
    (void)INTERRUPT_EnableGlobal();

    return Local_u16Val;
}

uint8 TIMER1_IsAsystole(void)
{
    return (Timer1_Asystole != 0U) ? 1U : 0U;
}

void TIMER1_ClearAsystole(void)
{
    Timer1_Asystole = 0U;
    Timer1_OverflowCount = 0U;
}





void TIMER2_Init(void)
{

    (((*(volatile uint8 *)0x31U)) |= (uint8)(1U << (7U)));


    (*(volatile uint8 *)0x45U) = 0U;
    (*(volatile uint8 *)0x44U) = 0U;


    (((*(volatile uint8 *)0x45U)) |= (uint8)(1U << (3U)));


    (((*(volatile uint8 *)0x45U)) |= (uint8)(1U << (4U)));


    TIMER2_SetTone(0U);
}

void TIMER2_SetTone(uint8 Copy_u8Tone)
{

    (*(volatile uint8 *)0x44U) = 0U;

    if (Copy_u8Tone == 1U)
    {

        (*(volatile uint8 *)0x43U) = 129U;
        (*(volatile uint8 *)0x45U) = (1U << 4U) | (1U << 3U) |
                       (1U << 1U) | (1U << 0U);
        (((*(volatile uint8 *)0x59U)) |= (uint8)(1U << (7U)));
    }
    else if (Copy_u8Tone == 2U)
    {

        (*(volatile uint8 *)0x43U) = 97U;
        (*(volatile uint8 *)0x45U) = (1U << 4U) | (1U << 3U) |
                       (1U << 2U);
        (((*(volatile uint8 *)0x59U)) |= (uint8)(1U << (7U)));
    }
    else if (Copy_u8Tone == 3U)
    {

        (*(volatile uint8 *)0x43U) = 129U;
        (*(volatile uint8 *)0x45U) = (1U << 4U) | (1U << 3U) |
                       (1U << 2U);
        (((*(volatile uint8 *)0x59U)) |= (uint8)(1U << (7U)));
    }
    else
    {

        (((*(volatile uint8 *)0x59U)) &= (uint8) ~(1U << (7U)));
        (*(volatile uint8 *)0x45U) = (1U << 3U);
        (*(volatile uint8 *)0x43U) = 0U;
        (((*(volatile uint8 *)0x32U)) &= (uint8) ~(1U << (7U)));
    }
}






# 279 "MCAL/TIMER/TIMER.c" 3
void __vector_10 (void) __attribute__ ((__signal__,__used__, __externally_visible__)) ; void __vector_10 (void)

# 280 "MCAL/TIMER/TIMER.c"
{
    Timer0_Ticks++;
    Timer0_TickPending = 1U;

    if (Timer0_Callback != (TIMER_CallbackType)0)
    {
        Timer0_Callback();
    }
}


# 290 "MCAL/TIMER/TIMER.c" 3
void __vector_6 (void) __attribute__ ((__signal__,__used__, __externally_visible__)) ; void __vector_6 (void)

# 291 "MCAL/TIMER/TIMER.c"
{
    TIMER1_ProcessCapture((*(volatile uint16 *)0x46U));
}


# 295 "MCAL/TIMER/TIMER.c" 3
void __vector_9 (void) __attribute__ ((__signal__,__used__, __externally_visible__)) ; void __vector_9 (void)

# 296 "MCAL/TIMER/TIMER.c"
{
    Timer1_OverflowCount++;


    if (Timer1_OverflowCount >= 2U)
    {
        Timer1_Asystole = 1U;
    }
}


# 306 "MCAL/TIMER/TIMER.c" 3
void __vector_4 (void) __attribute__ ((__signal__,__used__, __externally_visible__)) ; void __vector_4 (void)

# 307 "MCAL/TIMER/TIMER.c"
{

    (*(volatile uint8 *)0x32U) ^= (1U << 7U);
}
