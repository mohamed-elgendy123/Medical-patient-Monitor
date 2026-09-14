# 0 "MCAL/INTERRUPT/INTERRUPT.c"
# 0 "<built-in>"
# 0 "<command-line>"
# 1 "MCAL/INTERRUPT/INTERRUPT.c"







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
# 9 "MCAL/INTERRUPT/INTERRUPT.c" 2

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
# 11 "MCAL/INTERRUPT/INTERRUPT.c" 2
# 1 "LIB/MATH.h" 1



# 1 "LIB/STD_TYPES.h" 1
# 5 "LIB/MATH.h" 2
# 12 "MCAL/INTERRUPT/INTERRUPT.c" 2
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
# 13 "MCAL/INTERRUPT/INTERRUPT.c" 2
# 1 "MCAL/INTERRUPT/INTERRUPT_private.h" 1
# 14 "MCAL/INTERRUPT/INTERRUPT.c" 2
# 23 "MCAL/INTERRUPT/INTERRUPT.c"
static void (* volatile callback[3])(void) = {((void *)0), ((void *)0), ((void *)0)};
# 33 "MCAL/INTERRUPT/INTERRUPT.c"
STD_ReturnType INTERRUPT_EnableGlobal(void){
    
# 34 "MCAL/INTERRUPT/INTERRUPT.c" 3
   __asm__ __volatile__ ("sei" ::: "memory")
# 34 "MCAL/INTERRUPT/INTERRUPT.c"
        ;
    return E_OK;
}

STD_ReturnType INTERRUPT_DisableGlobal(void){
    
# 39 "MCAL/INTERRUPT/INTERRUPT.c" 3
   __asm__ __volatile__ ("cli" ::: "memory")
# 39 "MCAL/INTERRUPT/INTERRUPT.c"
        ;
    return E_OK;
}
# 55 "MCAL/INTERRUPT/INTERRUPT.c"
STD_ReturnType EXTI_SetSense(uint8 Copy_u8Int, uint8 Copy_u8Sense){
    if(Copy_u8Int > 2u || Copy_u8Sense > 3u){
        return E_NOK;
    }
    switch(Copy_u8Int){
        case 0u:

            (*(volatile uint8*)0x55) = (uint8)(((*(volatile uint8*)0x55) & ~0x03u)
                                          | (Copy_u8Sense & 0x03u));
            break;
        case 1u:

            (*(volatile uint8*)0x55) = (uint8)(((*(volatile uint8*)0x55) & ~0x0Cu)
                                          | ((Copy_u8Sense << 2) & 0x0Cu));
            break;
        case 2u:

            if(Copy_u8Sense == 2u){
                (((*(volatile uint8*)0x54)) &= ~(1u << (6)));
            } else if(Copy_u8Sense == 3u){
                (((*(volatile uint8*)0x54)) |= (1u << (6)));
            } else {
                return E_NOK;
            }
            break;
    }

    (void)EXTI_ClearFlag(Copy_u8Int);
    return E_OK;
}
# 94 "MCAL/INTERRUPT/INTERRUPT.c"
STD_ReturnType EXTI_ClearFlag(uint8 Copy_u8Int){
    if(Copy_u8Int > 2u){
        return E_NOK;
    }
    switch(Copy_u8Int){
        case 0u: (*(volatile uint8*)0x5A) = (1u << 6); break;
        case 1u: (*(volatile uint8*)0x5A) = (1u << 7); break;
        case 2u: (*(volatile uint8*)0x5A) = (1u << 5); break;
    }
    return E_OK;
}
# 117 "MCAL/INTERRUPT/INTERRUPT.c"
STD_ReturnType EXTI_Enable(uint8 Copy_u8Int){
    if(Copy_u8Int > 2u){
        return E_NOK;
    }
    (void)EXTI_ClearFlag(Copy_u8Int);
    switch(Copy_u8Int){
        case 0u: (((*(volatile uint8*)0x5B)) |= (1u << (6))); break;
        case 1u: (((*(volatile uint8*)0x5B)) |= (1u << (7))); break;
        case 2u: (((*(volatile uint8*)0x5B)) |= (1u << (5))); break;
    }
    return E_OK;
}

STD_ReturnType EXTI_Disable(uint8 Copy_u8Int){
    if(Copy_u8Int > 2u){
        return E_NOK;
    }
    switch(Copy_u8Int){
        case 0u: (((*(volatile uint8*)0x5B)) &= ~(1u << (6))); break;
        case 1u: (((*(volatile uint8*)0x5B)) &= ~(1u << (7))); break;
        case 2u: (((*(volatile uint8*)0x5B)) &= ~(1u << (5))); break;
    }
    return E_OK;
}






STD_ReturnType EXTI_SetCallback(uint8 Copy_u8Int, void (*Copy_pfCallback)(void)){
    if(Copy_u8Int > 2u || Copy_pfCallback == ((void *)0)){
        return E_NOK;
    }
    callback[Copy_u8Int] = Copy_pfCallback;
    return E_OK;
}
# 182 "MCAL/INTERRUPT/INTERRUPT.c"

# 182 "MCAL/INTERRUPT/INTERRUPT.c" 3
void __vector_1 (void) __attribute__ ((__signal__,__used__, __externally_visible__)) ; void __vector_1 (void)
# 182 "MCAL/INTERRUPT/INTERRUPT.c"
             {
    if(callback[0u] != ((void *)0)){
        callback[0u]();
    }
}


# 188 "MCAL/INTERRUPT/INTERRUPT.c" 3
void __vector_2 (void) __attribute__ ((__signal__,__used__, __externally_visible__)) ; void __vector_2 (void)
# 188 "MCAL/INTERRUPT/INTERRUPT.c"
             {
    if(callback[1u] != ((void *)0)){
        callback[1u]();
    }
}


# 194 "MCAL/INTERRUPT/INTERRUPT.c" 3
void __vector_3 (void) __attribute__ ((__signal__,__used__, __externally_visible__)) ; void __vector_3 (void)
# 194 "MCAL/INTERRUPT/INTERRUPT.c"
             {
    if(callback[2u] != ((void *)0)){
        callback[2u]();
    }
}
