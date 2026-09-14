# 0 "MCAL/TIMER/TIMER.c"
# 0 "<built-in>"
# 0 "<command-line>"
# 1 "MCAL/TIMER/TIMER.c"
# 1 "C:/Users/amazon/AppData/Local/Microsoft/WinGet/Packages/ZakKemble.avr-gcc_Microsoft.Winget.Source_8wekyb3d8bbwe/avr-gcc-16.1.0-x64-windows/avr/include/avr/interrupt.h" 1 3
# 36 "C:/Users/amazon/AppData/Local/Microsoft/WinGet/Packages/ZakKemble.avr-gcc_Microsoft.Winget.Source_8wekyb3d8bbwe/avr-gcc-16.1.0-x64-windows/avr/include/avr/interrupt.h" 3
# 1 "C:/Users/amazon/AppData/Local/Microsoft/WinGet/Packages/ZakKemble.avr-gcc_Microsoft.Winget.Source_8wekyb3d8bbwe/avr-gcc-16.1.0-x64-windows/avr/include/avr/io.h" 1 3
# 93 "C:/Users/amazon/AppData/Local/Microsoft/WinGet/Packages/ZakKemble.avr-gcc_Microsoft.Winget.Source_8wekyb3d8bbwe/avr-gcc-16.1.0-x64-windows/avr/include/avr/io.h" 3
# 1 "C:/Users/amazon/AppData/Local/Microsoft/WinGet/Packages/ZakKemble.avr-gcc_Microsoft.Winget.Source_8wekyb3d8bbwe/avr-gcc-16.1.0-x64-windows/avr/include/avr/sfr_defs.h" 1 3
# 124 "C:/Users/amazon/AppData/Local/Microsoft/WinGet/Packages/ZakKemble.avr-gcc_Microsoft.Winget.Source_8wekyb3d8bbwe/avr-gcc-16.1.0-x64-windows/avr/include/avr/sfr_defs.h" 3
# 1 "C:/Users/amazon/AppData/Local/Microsoft/WinGet/Packages/ZakKemble.avr-gcc_Microsoft.Winget.Source_8wekyb3d8bbwe/avr-gcc-16.1.0-x64-windows/avr/include/inttypes.h" 1 3
# 35 "C:/Users/amazon/AppData/Local/Microsoft/WinGet/Packages/ZakKemble.avr-gcc_Microsoft.Winget.Source_8wekyb3d8bbwe/avr-gcc-16.1.0-x64-windows/avr/include/inttypes.h" 3
# 1 "C:/Users/amazon/AppData/Local/Microsoft/WinGet/Packages/ZakKemble.avr-gcc_Microsoft.Winget.Source_8wekyb3d8bbwe/avr-gcc-16.1.0-x64-windows/lib/gcc/avr/16.1.0/include/stdint.h" 1 3
# 9 "C:/Users/amazon/AppData/Local/Microsoft/WinGet/Packages/ZakKemble.avr-gcc_Microsoft.Winget.Source_8wekyb3d8bbwe/avr-gcc-16.1.0-x64-windows/lib/gcc/avr/16.1.0/include/stdint.h" 3
#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wpedantic"
# 1 "C:/Users/amazon/AppData/Local/Microsoft/WinGet/Packages/ZakKemble.avr-gcc_Microsoft.Winget.Source_8wekyb3d8bbwe/avr-gcc-16.1.0-x64-windows/avr/include/stdint.h" 1 3
# 135 "C:/Users/amazon/AppData/Local/Microsoft/WinGet/Packages/ZakKemble.avr-gcc_Microsoft.Winget.Source_8wekyb3d8bbwe/avr-gcc-16.1.0-x64-windows/avr/include/stdint.h" 3
typedef signed char int8_t;
typedef unsigned char uint8_t;



typedef int int16_t;
typedef unsigned int uint16_t;
typedef long int int32_t;
typedef long unsigned int uint32_t;
typedef long long int int64_t;
typedef long long unsigned int uint64_t;
# 157 "C:/Users/amazon/AppData/Local/Microsoft/WinGet/Packages/ZakKemble.avr-gcc_Microsoft.Winget.Source_8wekyb3d8bbwe/avr-gcc-16.1.0-x64-windows/avr/include/stdint.h" 3
__extension__ typedef __int24 int24_t;
__extension__ typedef __uint24 uint24_t;
typedef int24_t int_least24_t;
typedef uint24_t uint_least24_t;
typedef int24_t int_fast24_t;
typedef uint24_t uint_fast24_t;
# 179 "C:/Users/amazon/AppData/Local/Microsoft/WinGet/Packages/ZakKemble.avr-gcc_Microsoft.Winget.Source_8wekyb3d8bbwe/avr-gcc-16.1.0-x64-windows/avr/include/stdint.h" 3
typedef int16_t intptr_t;



typedef uint16_t uintptr_t;




typedef int_least24_t intptr24_t;




typedef uint_least24_t uintptr24_t;
# 204 "C:/Users/amazon/AppData/Local/Microsoft/WinGet/Packages/ZakKemble.avr-gcc_Microsoft.Winget.Source_8wekyb3d8bbwe/avr-gcc-16.1.0-x64-windows/avr/include/stdint.h" 3
typedef int8_t int_least8_t;



typedef uint8_t uint_least8_t;



typedef int16_t int_least16_t;



typedef uint16_t uint_least16_t;
# 232 "C:/Users/amazon/AppData/Local/Microsoft/WinGet/Packages/ZakKemble.avr-gcc_Microsoft.Winget.Source_8wekyb3d8bbwe/avr-gcc-16.1.0-x64-windows/avr/include/stdint.h" 3
typedef int32_t int_least32_t;



typedef uint32_t uint_least32_t;






typedef int64_t int_least64_t;





typedef uint64_t uint_least64_t;
# 263 "C:/Users/amazon/AppData/Local/Microsoft/WinGet/Packages/ZakKemble.avr-gcc_Microsoft.Winget.Source_8wekyb3d8bbwe/avr-gcc-16.1.0-x64-windows/avr/include/stdint.h" 3
typedef int8_t int_fast8_t;



typedef uint8_t uint_fast8_t;



typedef int16_t int_fast16_t;



typedef uint16_t uint_fast16_t;
# 291 "C:/Users/amazon/AppData/Local/Microsoft/WinGet/Packages/ZakKemble.avr-gcc_Microsoft.Winget.Source_8wekyb3d8bbwe/avr-gcc-16.1.0-x64-windows/avr/include/stdint.h" 3
typedef int32_t int_fast32_t;



typedef uint32_t uint_fast32_t;






typedef int64_t int_fast64_t;





typedef uint64_t uint_fast64_t;
# 329 "C:/Users/amazon/AppData/Local/Microsoft/WinGet/Packages/ZakKemble.avr-gcc_Microsoft.Winget.Source_8wekyb3d8bbwe/avr-gcc-16.1.0-x64-windows/avr/include/stdint.h" 3
typedef int64_t intmax_t;



typedef uint64_t uintmax_t;
# 12 "C:/Users/amazon/AppData/Local/Microsoft/WinGet/Packages/ZakKemble.avr-gcc_Microsoft.Winget.Source_8wekyb3d8bbwe/avr-gcc-16.1.0-x64-windows/lib/gcc/avr/16.1.0/include/stdint.h" 2 3
#pragma GCC diagnostic pop
# 36 "C:/Users/amazon/AppData/Local/Microsoft/WinGet/Packages/ZakKemble.avr-gcc_Microsoft.Winget.Source_8wekyb3d8bbwe/avr-gcc-16.1.0-x64-windows/avr/include/inttypes.h" 2 3
# 1 "C:/Users/amazon/AppData/Local/Microsoft/WinGet/Packages/ZakKemble.avr-gcc_Microsoft.Winget.Source_8wekyb3d8bbwe/avr-gcc-16.1.0-x64-windows/avr/include/bits/attribs.h" 1 3
# 37 "C:/Users/amazon/AppData/Local/Microsoft/WinGet/Packages/ZakKemble.avr-gcc_Microsoft.Winget.Source_8wekyb3d8bbwe/avr-gcc-16.1.0-x64-windows/avr/include/inttypes.h" 2 3
# 77 "C:/Users/amazon/AppData/Local/Microsoft/WinGet/Packages/ZakKemble.avr-gcc_Microsoft.Winget.Source_8wekyb3d8bbwe/avr-gcc-16.1.0-x64-windows/avr/include/inttypes.h" 3
typedef int32_t int_farptr_t;





typedef uint32_t uint_farptr_t;
# 125 "C:/Users/amazon/AppData/Local/Microsoft/WinGet/Packages/ZakKemble.avr-gcc_Microsoft.Winget.Source_8wekyb3d8bbwe/avr-gcc-16.1.0-x64-windows/avr/include/avr/sfr_defs.h" 2 3
# 94 "C:/Users/amazon/AppData/Local/Microsoft/WinGet/Packages/ZakKemble.avr-gcc_Microsoft.Winget.Source_8wekyb3d8bbwe/avr-gcc-16.1.0-x64-windows/avr/include/avr/io.h" 2 3
# 233 "C:/Users/amazon/AppData/Local/Microsoft/WinGet/Packages/ZakKemble.avr-gcc_Microsoft.Winget.Source_8wekyb3d8bbwe/avr-gcc-16.1.0-x64-windows/avr/include/avr/io.h" 3
# 1 "C:/Users/amazon/AppData/Local/Microsoft/WinGet/Packages/ZakKemble.avr-gcc_Microsoft.Winget.Source_8wekyb3d8bbwe/avr-gcc-16.1.0-x64-windows/avr/include/avr/iom32.h" 1 3
# 718 "C:/Users/amazon/AppData/Local/Microsoft/WinGet/Packages/ZakKemble.avr-gcc_Microsoft.Winget.Source_8wekyb3d8bbwe/avr-gcc-16.1.0-x64-windows/avr/include/avr/iom32.h" 3
       
# 719 "C:/Users/amazon/AppData/Local/Microsoft/WinGet/Packages/ZakKemble.avr-gcc_Microsoft.Winget.Source_8wekyb3d8bbwe/avr-gcc-16.1.0-x64-windows/avr/include/avr/iom32.h" 3

       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
# 234 "C:/Users/amazon/AppData/Local/Microsoft/WinGet/Packages/ZakKemble.avr-gcc_Microsoft.Winget.Source_8wekyb3d8bbwe/avr-gcc-16.1.0-x64-windows/avr/include/avr/io.h" 2 3
# 723 "C:/Users/amazon/AppData/Local/Microsoft/WinGet/Packages/ZakKemble.avr-gcc_Microsoft.Winget.Source_8wekyb3d8bbwe/avr-gcc-16.1.0-x64-windows/avr/include/avr/io.h" 3
# 1 "C:/Users/amazon/AppData/Local/Microsoft/WinGet/Packages/ZakKemble.avr-gcc_Microsoft.Winget.Source_8wekyb3d8bbwe/avr-gcc-16.1.0-x64-windows/avr/include/avr/portpins.h" 1 3
# 724 "C:/Users/amazon/AppData/Local/Microsoft/WinGet/Packages/ZakKemble.avr-gcc_Microsoft.Winget.Source_8wekyb3d8bbwe/avr-gcc-16.1.0-x64-windows/avr/include/avr/io.h" 2 3

# 1 "C:/Users/amazon/AppData/Local/Microsoft/WinGet/Packages/ZakKemble.avr-gcc_Microsoft.Winget.Source_8wekyb3d8bbwe/avr-gcc-16.1.0-x64-windows/avr/include/avr/common.h" 1 3
# 726 "C:/Users/amazon/AppData/Local/Microsoft/WinGet/Packages/ZakKemble.avr-gcc_Microsoft.Winget.Source_8wekyb3d8bbwe/avr-gcc-16.1.0-x64-windows/avr/include/avr/io.h" 2 3



# 1 "C:/Users/amazon/AppData/Local/Microsoft/WinGet/Packages/ZakKemble.avr-gcc_Microsoft.Winget.Source_8wekyb3d8bbwe/avr-gcc-16.1.0-x64-windows/avr/include/avr/version.h" 1 3
# 730 "C:/Users/amazon/AppData/Local/Microsoft/WinGet/Packages/ZakKemble.avr-gcc_Microsoft.Winget.Source_8wekyb3d8bbwe/avr-gcc-16.1.0-x64-windows/avr/include/avr/io.h" 2 3







# 1 "C:/Users/amazon/AppData/Local/Microsoft/WinGet/Packages/ZakKemble.avr-gcc_Microsoft.Winget.Source_8wekyb3d8bbwe/avr-gcc-16.1.0-x64-windows/avr/include/avr/fuse.h" 1 3
# 257 "C:/Users/amazon/AppData/Local/Microsoft/WinGet/Packages/ZakKemble.avr-gcc_Microsoft.Winget.Source_8wekyb3d8bbwe/avr-gcc-16.1.0-x64-windows/avr/include/avr/fuse.h" 3
typedef struct
{
    uint8_t low;
    uint8_t high;
} __fuse_t;
# 738 "C:/Users/amazon/AppData/Local/Microsoft/WinGet/Packages/ZakKemble.avr-gcc_Microsoft.Winget.Source_8wekyb3d8bbwe/avr-gcc-16.1.0-x64-windows/avr/include/avr/io.h" 2 3


# 1 "C:/Users/amazon/AppData/Local/Microsoft/WinGet/Packages/ZakKemble.avr-gcc_Microsoft.Winget.Source_8wekyb3d8bbwe/avr-gcc-16.1.0-x64-windows/avr/include/avr/lock.h" 1 3
# 741 "C:/Users/amazon/AppData/Local/Microsoft/WinGet/Packages/ZakKemble.avr-gcc_Microsoft.Winget.Source_8wekyb3d8bbwe/avr-gcc-16.1.0-x64-windows/avr/include/avr/io.h" 2 3
# 37 "C:/Users/amazon/AppData/Local/Microsoft/WinGet/Packages/ZakKemble.avr-gcc_Microsoft.Winget.Source_8wekyb3d8bbwe/avr-gcc-16.1.0-x64-windows/avr/include/avr/interrupt.h" 2 3
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





typedef void (*TIMER_CallbackType)(void);






void TIMER0_Init(void);
void TIMER0_SetCallback(TIMER_CallbackType Copy_pvCallback);
uint8 TIMER0_IsTickPending(void);
void TIMER0_ClearTick(void);

void TIMER1_Init(void);
uint8 TIMER1_IsCaptureReady(void);
void TIMER1_ClearCaptureFlag(void);
uint16 TIMER1_GetInterval(uint8 Copy_u8Index);
uint8 TIMER1_IsAsystole(void);
void TIMER1_ClearAsystole(void);

void TIMER2_Init(void);
void TIMER2_SetTone(uint8 Copy_u8Tone);
# 5 "MCAL/TIMER/TIMER.c" 2
# 1 "MCAL/TIMER/TIMER_private.h" 1
# 6 "MCAL/TIMER/TIMER.c" 2


static volatile uint32 Timer0_Ticks;
static volatile TIMER_CallbackType Timer0_Callback = (TIMER_CallbackType)0;
static volatile uint8 Timer0_TickPending = 0U;

static volatile uint16 Timer1_Intervals[8U];
static volatile uint16 Timer1_LastCapture = 0U;
static volatile uint8 Timer1_RingIndex = 0U;
static volatile uint8 Timer1_CaptureReady = 0U;
static volatile uint8 Timer1_Asystole = 0U;
static volatile uint16 Timer1_OverflowCount = 0U;





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


    (((*(volatile uint8 *)0x4EU)) |= (uint8)(1U << (7U)));
    (((*(volatile uint8 *)0x4EU)) |= (uint8)(1U << (6U)));


    (((*(volatile uint8 *)0x4EU)) |= (uint8)(1U << (2U)));


    (((*(volatile uint8 *)0x59U)) |= (uint8)(1U << (5U)));
    (((*(volatile uint8 *)0x59U)) |= (uint8)(1U << (2U)));


    for (Local_u8Idx = 0U; Local_u8Idx < 8U; Local_u8Idx++)
    {
        Timer1_Intervals[Local_u8Idx] = 0U;
    }


    Local_u8Idx = 0U;
    do
    {
        Timer1_LastCapture = 0U;
        Timer1_RingIndex = 0U;
        Timer1_CaptureReady = 0U;
        Timer1_Asystole = 0U;
        Timer1_OverflowCount = 0U;
        Local_u8Idx++;
    } while (Local_u8Idx < 1U);
}

uint8 TIMER1_IsCaptureReady(void)
{
    if (Timer1_CaptureReady == 1U)
    {
        return 1U;
    }
    return 0U;
}

void TIMER1_ClearCaptureFlag(void)
{
    Timer1_CaptureReady = 0U;
}

uint16 TIMER1_GetInterval(uint8 Copy_u8Index)
{

    if (Copy_u8Index < 8U)
    {
        return Timer1_Intervals[Copy_u8Index];
    }
    else
    {
        return 0U;
    }
}

uint8 TIMER1_IsAsystole(void)
{
    if (Timer1_Asystole != 0U)
    {
        return 1U;
    }
    else
    {
        return 0U;
    }
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

    (((*(volatile uint8 *)0x45U)) &= (uint8) ~(1U << (2U)));
    (((*(volatile uint8 *)0x45U)) &= (uint8) ~(1U << (1U)));
    (((*(volatile uint8 *)0x45U)) &= (uint8) ~(1U << (0U)));


    if (Copy_u8Tone == 1U)
    {

        (*(volatile uint8 *)0x43U) = 129U;
        (((*(volatile uint8 *)0x45U)) |= (uint8)(1U << (1U)));
        (((*(volatile uint8 *)0x45U)) |= (uint8)(1U << (0U)));
    }
    else if (Copy_u8Tone == 2U)
    {

        (*(volatile uint8 *)0x43U) = 97U;
        (((*(volatile uint8 *)0x45U)) |= (uint8)(1U << (2U)));
    }
    else if (Copy_u8Tone == 3U)
    {

        (*(volatile uint8 *)0x43U) = 129U;
        (((*(volatile uint8 *)0x45U)) |= (uint8)(1U << (2U)));
    }
    else
    {

        (*(volatile uint8 *)0x43U) = 0U;
    }
}






# 221 "MCAL/TIMER/TIMER.c" 3
void __vector_10 (void) __attribute__ ((__signal__,__used__, __externally_visible__)) ; void __vector_10 (void)

# 222 "MCAL/TIMER/TIMER.c"
{
    Timer0_Ticks++;
    Timer0_TickPending = 1U;

    if (Timer0_Callback != (TIMER_CallbackType)0)
    {
        Timer0_Callback();
    }
}


# 232 "MCAL/TIMER/TIMER.c" 3
void __vector_6 (void) __attribute__ ((__signal__,__used__, __externally_visible__)) ; void __vector_6 (void)

# 233 "MCAL/TIMER/TIMER.c"
{
    uint16 Local_u16Capture = (*(volatile uint16 *)0x46U);
    Timer1_Intervals[Timer1_RingIndex] = (uint16)(Local_u16Capture - Timer1_LastCapture);
    Timer1_LastCapture = Local_u16Capture;
    Timer1_RingIndex = (uint8)((Timer1_RingIndex + 1U) & 7U);
    Timer1_CaptureReady = 1U;
    Timer1_OverflowCount = 0U;
    Timer1_Asystole = 0U;
}


# 243 "MCAL/TIMER/TIMER.c" 3
void __vector_9 (void) __attribute__ ((__signal__,__used__, __externally_visible__)) ; void __vector_9 (void)

# 244 "MCAL/TIMER/TIMER.c"
{
    Timer1_OverflowCount++;


    if (Timer1_OverflowCount >= 2U)
    {
        Timer1_Asystole = 1U;
    }
}
