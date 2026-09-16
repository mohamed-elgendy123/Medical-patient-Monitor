# 0 "MCAL/ADC/ADC.c"
# 0 "<built-in>"
# 0 "<command-line>"
# 1 "MCAL/ADC/ADC.c"
# 9 "MCAL/ADC/ADC.c"
# 1 "LIB/STD_TYPES.h" 1
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
# 10 "MCAL/ADC/ADC.c" 2
# 1 "MCAL/ADC/ADC_interface.h" 1
# 46 "MCAL/ADC/ADC_interface.h"
STD_ReturnType ADC_Init(uint8 Copy_u8Ref, uint8 Copy_u8Prescaler);





STD_ReturnType ADC_ReadChannel(uint8 Copy_u8Channel, uint16 *Copy_pu16Reading);




STD_ReturnType ADC_StartConversion(uint8 Copy_u8Channel);





STD_ReturnType ADC_GetResult(uint16 *Copy_pu16Reading);





STD_ReturnType ADC_SetInterrupt(uint8 Copy_u8State);
# 11 "MCAL/ADC/ADC.c" 2
# 1 "MCAL/ADC/ADC_private.h" 1
# 12 "MCAL/ADC/ADC.c" 2




# 1 "C:/Users/amazon/AppData/Local/Microsoft/WinGet/Packages/ZakKemble.avr-gcc_Microsoft.Winget.Source_8wekyb3d8bbwe/avr-gcc-16.1.0-x64-windows/avr/include/util/delay.h" 1 3
# 45 "C:/Users/amazon/AppData/Local/Microsoft/WinGet/Packages/ZakKemble.avr-gcc_Microsoft.Winget.Source_8wekyb3d8bbwe/avr-gcc-16.1.0-x64-windows/avr/include/util/delay.h" 3
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
# 46 "C:/Users/amazon/AppData/Local/Microsoft/WinGet/Packages/ZakKemble.avr-gcc_Microsoft.Winget.Source_8wekyb3d8bbwe/avr-gcc-16.1.0-x64-windows/avr/include/util/delay.h" 2 3
# 1 "C:/Users/amazon/AppData/Local/Microsoft/WinGet/Packages/ZakKemble.avr-gcc_Microsoft.Winget.Source_8wekyb3d8bbwe/avr-gcc-16.1.0-x64-windows/avr/include/util/delay_basic.h" 1 3
# 35 "C:/Users/amazon/AppData/Local/Microsoft/WinGet/Packages/ZakKemble.avr-gcc_Microsoft.Winget.Source_8wekyb3d8bbwe/avr-gcc-16.1.0-x64-windows/avr/include/util/delay_basic.h" 3
# 1 "C:/Users/amazon/AppData/Local/Microsoft/WinGet/Packages/ZakKemble.avr-gcc_Microsoft.Winget.Source_8wekyb3d8bbwe/avr-gcc-16.1.0-x64-windows/avr/include/inttypes.h" 1 3
# 36 "C:/Users/amazon/AppData/Local/Microsoft/WinGet/Packages/ZakKemble.avr-gcc_Microsoft.Winget.Source_8wekyb3d8bbwe/avr-gcc-16.1.0-x64-windows/avr/include/inttypes.h" 3
# 1 "C:/Users/amazon/AppData/Local/Microsoft/WinGet/Packages/ZakKemble.avr-gcc_Microsoft.Winget.Source_8wekyb3d8bbwe/avr-gcc-16.1.0-x64-windows/avr/include/bits/attribs.h" 1 3
# 37 "C:/Users/amazon/AppData/Local/Microsoft/WinGet/Packages/ZakKemble.avr-gcc_Microsoft.Winget.Source_8wekyb3d8bbwe/avr-gcc-16.1.0-x64-windows/avr/include/inttypes.h" 2 3
# 77 "C:/Users/amazon/AppData/Local/Microsoft/WinGet/Packages/ZakKemble.avr-gcc_Microsoft.Winget.Source_8wekyb3d8bbwe/avr-gcc-16.1.0-x64-windows/avr/include/inttypes.h" 3
typedef int32_t int_farptr_t;





typedef uint32_t uint_farptr_t;
# 36 "C:/Users/amazon/AppData/Local/Microsoft/WinGet/Packages/ZakKemble.avr-gcc_Microsoft.Winget.Source_8wekyb3d8bbwe/avr-gcc-16.1.0-x64-windows/avr/include/util/delay_basic.h" 2 3



static __inline__ __attribute__((__always_inline__)) void _delay_loop_1(uint8_t __count);
static __inline__ __attribute__((__always_inline__)) void _delay_loop_2(uint16_t __count);
# 83 "C:/Users/amazon/AppData/Local/Microsoft/WinGet/Packages/ZakKemble.avr-gcc_Microsoft.Winget.Source_8wekyb3d8bbwe/avr-gcc-16.1.0-x64-windows/avr/include/util/delay_basic.h" 3
void
_delay_loop_1(uint8_t __count)
{
 __asm__ volatile (
  "1: dec %0" "\n\t"
  "brne 1b ; [[len=nl]]"
  : "=r" (__count)
  : "0" (__count)
 );
}
# 110 "C:/Users/amazon/AppData/Local/Microsoft/WinGet/Packages/ZakKemble.avr-gcc_Microsoft.Winget.Source_8wekyb3d8bbwe/avr-gcc-16.1.0-x64-windows/avr/include/util/delay_basic.h" 3
void
_delay_loop_2(uint16_t __count)
{
# 121 "C:/Users/amazon/AppData/Local/Microsoft/WinGet/Packages/ZakKemble.avr-gcc_Microsoft.Winget.Source_8wekyb3d8bbwe/avr-gcc-16.1.0-x64-windows/avr/include/util/delay_basic.h" 3
 __asm__ volatile (
  "1: sbiw %0,1" "\n\t"
  "brne 1b ; [[len=nl]]"
  : "+w" (__count)
 );

}
# 47 "C:/Users/amazon/AppData/Local/Microsoft/WinGet/Packages/ZakKemble.avr-gcc_Microsoft.Winget.Source_8wekyb3d8bbwe/avr-gcc-16.1.0-x64-windows/avr/include/util/delay.h" 2 3
# 166 "C:/Users/amazon/AppData/Local/Microsoft/WinGet/Packages/ZakKemble.avr-gcc_Microsoft.Winget.Source_8wekyb3d8bbwe/avr-gcc-16.1.0-x64-windows/avr/include/util/delay.h" 3
static __inline__ __attribute__((__always_inline__)) void
_delay_ms(double __ms)
{



    uint32_t __ticks_dc;
    double __tmp = ((
# 173 "C:/Users/amazon/AppData/Local/Microsoft/WinGet/Packages/ZakKemble.avr-gcc_Microsoft.Winget.Source_8wekyb3d8bbwe/avr-gcc-16.1.0-x64-windows/avr/include/util/delay.h"
                    8000000UL
# 173 "C:/Users/amazon/AppData/Local/Microsoft/WinGet/Packages/ZakKemble.avr-gcc_Microsoft.Winget.Source_8wekyb3d8bbwe/avr-gcc-16.1.0-x64-windows/avr/include/util/delay.h" 3
                         ) / 1e3) * __ms;







        __tmp = __builtin_ceil (__builtin_fabs (__tmp));




    __ticks_dc = __tmp >= 4294967040.0 ? 0xffffff00 : (uint32_t) __tmp;
    __builtin_avr_delay_cycles(__ticks_dc);
# 209 "C:/Users/amazon/AppData/Local/Microsoft/WinGet/Packages/ZakKemble.avr-gcc_Microsoft.Winget.Source_8wekyb3d8bbwe/avr-gcc-16.1.0-x64-windows/avr/include/util/delay.h" 3
}
# 253 "C:/Users/amazon/AppData/Local/Microsoft/WinGet/Packages/ZakKemble.avr-gcc_Microsoft.Winget.Source_8wekyb3d8bbwe/avr-gcc-16.1.0-x64-windows/avr/include/util/delay.h" 3
static __inline__ __attribute__((__always_inline__)) void
_delay_us(double __us)
{



    uint32_t __ticks_dc;
    double __tmp = ((
# 260 "C:/Users/amazon/AppData/Local/Microsoft/WinGet/Packages/ZakKemble.avr-gcc_Microsoft.Winget.Source_8wekyb3d8bbwe/avr-gcc-16.1.0-x64-windows/avr/include/util/delay.h"
                    8000000UL
# 260 "C:/Users/amazon/AppData/Local/Microsoft/WinGet/Packages/ZakKemble.avr-gcc_Microsoft.Winget.Source_8wekyb3d8bbwe/avr-gcc-16.1.0-x64-windows/avr/include/util/delay.h" 3
                         ) / 1e6) * __us;







        __tmp = __builtin_ceil (__builtin_fabs (__tmp));




    __ticks_dc = __tmp >= 4294967040.0 ? 0xffffff00 : (uint32_t) __tmp;
    __builtin_avr_delay_cycles(__ticks_dc);
# 296 "C:/Users/amazon/AppData/Local/Microsoft/WinGet/Packages/ZakKemble.avr-gcc_Microsoft.Winget.Source_8wekyb3d8bbwe/avr-gcc-16.1.0-x64-windows/avr/include/util/delay.h" 3
}
# 17 "MCAL/ADC/ADC.c" 2
# 25 "MCAL/ADC/ADC.c"

# 25 "MCAL/ADC/ADC.c"
STD_ReturnType ADC_Init(uint8 Copy_u8Ref, uint8 Copy_u8Prescaler)
{
    if (Copy_u8Ref != 1u || Copy_u8Prescaler != 6u)
    {
        return E_NOK;
    }

    (*((volatile uint8*)0x27)) = (1u << 6);
    (*((volatile uint8*)0x26)) = (1u << 7) | (1u << 2) | (1u << 1);

    return E_OK;
}
# 46 "MCAL/ADC/ADC.c"
STD_ReturnType ADC_ReadChannel(uint8 Copy_u8Channel, uint16 *Copy_pu16Reading)
{
    uint32 Local_u32Timeout = 50000UL;
    uint8 Local_u8Low = 0;
    uint8 Local_u8High = 0;

    if (Copy_u8Channel > 7u || Copy_pu16Reading == ((void *)0))
    {
        return E_NOK;
    }


    (*((volatile uint8*)0x27)) = ((*((volatile uint8*)0x27)) & 0xE0u) | (Copy_u8Channel & 0x07u);


    _delay_us(10);


    (*((volatile uint8*)0x26)) |= (1u << 4);


    (*((volatile uint8*)0x26)) |= (1u << 6);


    while (!((*((volatile uint8*)0x26)) & (1u << 4)) && (Local_u32Timeout > 0UL))
    {
        Local_u32Timeout--;
    }

    if (Local_u32Timeout == 0UL)
    {
        return E_NOK;
    }


    (*((volatile uint8*)0x26)) |= (1u << 4);


    Local_u8Low = (*((volatile uint8*)0x24));
    Local_u8High = (*((volatile uint8*)0x25));
    *Copy_pu16Reading = (uint16)Local_u8Low | ((uint16)Local_u8High << 8);

    return E_OK;
}






STD_ReturnType ADC_StartConversion(uint8 Copy_u8Channel)
{

    if (Copy_u8Channel > 7u)
    {
        return E_NOK;
    }


    (*((volatile uint8*)0x27)) = ((*((volatile uint8*)0x27)) & 0xE0u) | (Copy_u8Channel & 0x07u);


    (*((volatile uint8*)0x26)) |= (1u << 6);

    return E_OK;
}






STD_ReturnType ADC_GetResult(uint16 *Copy_pu16Reading)
{
    uint8 Local_u8Low = 0;
    uint8 Local_u8High = 0;

    if (Copy_pu16Reading == ((void *)0))
    {
        return E_NOK;
    }


    if ((*((volatile uint8*)0x26)) & (1u << 4))
    {

        (*((volatile uint8*)0x26)) |= (1u << 4);


        Local_u8Low = (*((volatile uint8*)0x24));
        Local_u8High = (*((volatile uint8*)0x25));
        *Copy_pu16Reading = (uint16)Local_u8Low | ((uint16)Local_u8High << 8);

        return E_OK;
    }


    return E_NOK;
}






STD_ReturnType ADC_SetInterrupt(uint8 Copy_u8State)
{
    if (Copy_u8State == 1u)
    {

        (*((volatile uint8*)0x26)) |= (1u << 3);
    }
    else if (Copy_u8State == 0u)
    {

        (*((volatile uint8*)0x26)) &= ~(1u << 3);
    }
    else
    {
        return E_NOK;
    }

    return E_OK;
}
