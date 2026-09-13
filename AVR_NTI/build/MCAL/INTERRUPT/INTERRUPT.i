# 0 "MCAL/INTERRUPT/INTERRUPT.c"
# 0 "<built-in>"
# 0 "<command-line>"
# 1 "MCAL/INTERRUPT/INTERRUPT.c"
# 9 "MCAL/INTERRUPT/INTERRUPT.c"
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
# 10 "MCAL/INTERRUPT/INTERRUPT.c" 2
# 1 "MCAL/INTERRUPT/INTERRUPT_interface.h" 1
# 28 "MCAL/INTERRUPT/INTERRUPT_interface.h"
typedef void (*EXTI_CallbackType)(void);




STD_ReturnType INTERRUPT_EnableGlobal(void);




STD_ReturnType INTERRUPT_DisableGlobal(void);





STD_ReturnType EXTI_SetSense(uint8 Copy_u8Int, uint8 Copy_u8Sense);





STD_ReturnType EXTI_Enable(uint8 Copy_u8Int);




STD_ReturnType EXTI_Disable(uint8 Copy_u8Int);




STD_ReturnType EXTI_ClearFlag(uint8 Copy_u8Int);
# 70 "MCAL/INTERRUPT/INTERRUPT_interface.h"
STD_ReturnType EXTI_SetCallback(uint8 Copy_u8Int, EXTI_CallbackType Copy_pfCallback);
# 11 "MCAL/INTERRUPT/INTERRUPT.c" 2
# 1 "MCAL/INTERRUPT/INTERRUPT_private.h" 1
# 12 "MCAL/INTERRUPT/INTERRUPT.c" 2
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
# 13 "MCAL/INTERRUPT/INTERRUPT.c" 2
# 21 "MCAL/INTERRUPT/INTERRUPT.c"

# 21 "MCAL/INTERRUPT/INTERRUPT.c"
STD_ReturnType INTERRUPT_EnableGlobal(void)
{
    __asm__("sei");
    return E_OK;
}

STD_ReturnType INTERRUPT_DisableGlobal(void)
{
    __asm__("cli");
    return E_OK;
}
# 42 "MCAL/INTERRUPT/INTERRUPT.c"
STD_ReturnType EXTI_SetSense(uint8 Copy_u8Int, uint8 Copy_u8Sense)
{
    STD_ReturnType Local_u8ErrorStatus = E_OK;

    switch (Copy_u8Int)
    {
    case 0u:

        if (Copy_u8Sense <= 3u)
        {
            
# 52 "MCAL/INTERRUPT/INTERRUPT.c" 3
           (*(volatile uint8_t *)((0x35) + 0x20)) 
# 52 "MCAL/INTERRUPT/INTERRUPT.c"
                 &= ~(0x03 << 0);
            
# 53 "MCAL/INTERRUPT/INTERRUPT.c" 3
           (*(volatile uint8_t *)((0x35) + 0x20)) 
# 53 "MCAL/INTERRUPT/INTERRUPT.c"
                 |= (Copy_u8Sense << 0);
        }
        else
        {
            Local_u8ErrorStatus = E_NOK;
        }
        break;

    case 1u:

        if (Copy_u8Sense <= 3u)
        {
            
# 65 "MCAL/INTERRUPT/INTERRUPT.c" 3
           (*(volatile uint8_t *)((0x35) + 0x20)) 
# 65 "MCAL/INTERRUPT/INTERRUPT.c"
                 &= ~(0x03 << 2);
            
# 66 "MCAL/INTERRUPT/INTERRUPT.c" 3
           (*(volatile uint8_t *)((0x35) + 0x20)) 
# 66 "MCAL/INTERRUPT/INTERRUPT.c"
                 |= (Copy_u8Sense << 2);
        }
        else
        {
            Local_u8ErrorStatus = E_NOK;
        }
        break;

    case 2u:

        if (Copy_u8Sense == 2u)
        {
            
# 78 "MCAL/INTERRUPT/INTERRUPT.c" 3
           (*(volatile uint8_t *)((0x34) + 0x20)) 
# 78 "MCAL/INTERRUPT/INTERRUPT.c"
                  &= ~(1 << 6);
        }
        else if (Copy_u8Sense == 3u)
        {
            
# 82 "MCAL/INTERRUPT/INTERRUPT.c" 3
           (*(volatile uint8_t *)((0x34) + 0x20)) 
# 82 "MCAL/INTERRUPT/INTERRUPT.c"
                  |= (1 << 6);
        }
        else
        {

            Local_u8ErrorStatus = E_NOK;
        }
        break;

    default:

        Local_u8ErrorStatus = E_NOK;
        break;
    }

    return Local_u8ErrorStatus;
}






STD_ReturnType EXTI_ClearFlag(uint8 Copy_u8Int)
{
    STD_ReturnType Local_u8ErrorStatus = E_OK;

    switch (Copy_u8Int)
    {
    case 0u:
        
# 112 "MCAL/INTERRUPT/INTERRUPT.c" 3
       (*(volatile uint8_t *)((0x3A) + 0x20)) 
# 112 "MCAL/INTERRUPT/INTERRUPT.c"
            = (1 << 6u);
        break;
    case 1u:
        
# 115 "MCAL/INTERRUPT/INTERRUPT.c" 3
       (*(volatile uint8_t *)((0x3A) + 0x20)) 
# 115 "MCAL/INTERRUPT/INTERRUPT.c"
            = (1 << 7u);
        break;
    case 2u:
        
# 118 "MCAL/INTERRUPT/INTERRUPT.c" 3
       (*(volatile uint8_t *)((0x3A) + 0x20)) 
# 118 "MCAL/INTERRUPT/INTERRUPT.c"
            = (1 << 5u);
        break;
    default:
        Local_u8ErrorStatus = E_NOK;
        break;
    }

    return Local_u8ErrorStatus;
}
# 138 "MCAL/INTERRUPT/INTERRUPT.c"
STD_ReturnType EXTI_Enable(uint8 Copy_u8Int)
{
    STD_ReturnType Local_u8ErrorStatus = E_OK;


    Local_u8ErrorStatus = EXTI_ClearFlag(Copy_u8Int);


    if (Local_u8ErrorStatus == E_OK)
    {
        switch (Copy_u8Int)
        {
        case 0u:
            
# 151 "MCAL/INTERRUPT/INTERRUPT.c" 3
           (*(volatile uint8_t *)((0x3B) + 0x20)) 
# 151 "MCAL/INTERRUPT/INTERRUPT.c"
                |= (1 << 6u);
            break;
        case 1u:
            
# 154 "MCAL/INTERRUPT/INTERRUPT.c" 3
           (*(volatile uint8_t *)((0x3B) + 0x20)) 
# 154 "MCAL/INTERRUPT/INTERRUPT.c"
                |= (1 << 7u);
            break;
        case 2u:
            
# 157 "MCAL/INTERRUPT/INTERRUPT.c" 3
           (*(volatile uint8_t *)((0x3B) + 0x20)) 
# 157 "MCAL/INTERRUPT/INTERRUPT.c"
                |= (1 << 5u);
            break;
        default:
            Local_u8ErrorStatus = E_NOK;
            break;
        }
    }

    return Local_u8ErrorStatus;
}

STD_ReturnType EXTI_Disable(uint8 Copy_u8Int)
{
    STD_ReturnType Local_u8ErrorStatus = E_OK;

    switch (Copy_u8Int)
    {
    case 0u:
        
# 175 "MCAL/INTERRUPT/INTERRUPT.c" 3
       (*(volatile uint8_t *)((0x3B) + 0x20)) 
# 175 "MCAL/INTERRUPT/INTERRUPT.c"
            &= ~(1 << 6u);
        break;
    case 1u:
        
# 178 "MCAL/INTERRUPT/INTERRUPT.c" 3
       (*(volatile uint8_t *)((0x3B) + 0x20)) 
# 178 "MCAL/INTERRUPT/INTERRUPT.c"
            &= ~(1 << 7u);
        break;
    case 2u:
        
# 181 "MCAL/INTERRUPT/INTERRUPT.c" 3
       (*(volatile uint8_t *)((0x3B) + 0x20)) 
# 181 "MCAL/INTERRUPT/INTERRUPT.c"
            &= ~(1 << 5u);
        break;
    default:
        Local_u8ErrorStatus = E_NOK;
        break;
    }

    return Local_u8ErrorStatus;
}


static EXTI_CallbackType EXTI_pfCallBackArr[3] = {((void *)0), ((void *)0), ((void *)0)};


STD_ReturnType EXTI_SetCallback(uint8 Copy_u8Int, EXTI_CallbackType Copy_pfCallback)
{
    if (Copy_pfCallback == ((void *)0) || Copy_u8Int > 2u)
    {
        return E_NOK;
    }

    EXTI_pfCallBackArr[Copy_u8Int] = Copy_pfCallback;
    return E_OK;
}


# 206 "MCAL/INTERRUPT/INTERRUPT.c" 3
void __vector_1 (void) __attribute__ ((__signal__,__used__, __externally_visible__)) ; void __vector_1 (void)

# 207 "MCAL/INTERRUPT/INTERRUPT.c"
{
    if (EXTI_pfCallBackArr[0u] != ((void *)0))
    {
        EXTI_pfCallBackArr[0u]();
    }
}


# 214 "MCAL/INTERRUPT/INTERRUPT.c" 3
void __vector_2 (void) __attribute__ ((__signal__,__used__, __externally_visible__)) ; void __vector_2 (void)

# 215 "MCAL/INTERRUPT/INTERRUPT.c"
{
    if (EXTI_pfCallBackArr[1u] != ((void *)0))
    {
        EXTI_pfCallBackArr[1u]();
    }
}


# 222 "MCAL/INTERRUPT/INTERRUPT.c" 3
void __vector_3 (void) __attribute__ ((__signal__,__used__, __externally_visible__)) ; void __vector_3 (void)

# 223 "MCAL/INTERRUPT/INTERRUPT.c"
{
    if (EXTI_pfCallBackArr[2u] != ((void *)0))
    {
        EXTI_pfCallBackArr[2u]();
    }
}
