# 0 "MCAL/ADC/ADC.c"
# 0 "<built-in>"
# 0 "<command-line>"
# 1 "MCAL/ADC/ADC.c"
# 9 "MCAL/ADC/ADC.c"
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
# 13 "MCAL/ADC/ADC.c" 2
# 21 "MCAL/ADC/ADC.c"

# 21 "MCAL/ADC/ADC.c"
STD_ReturnType ADC_Init(uint8 Copy_u8Ref, uint8 Copy_u8Prescaler) {
    if ((Copy_u8Ref != 0u && Copy_u8Ref != 1u && Copy_u8Ref != 3u) ||
        (Copy_u8Prescaler < 1u || Copy_u8Prescaler > 7u)) {
        return E_NOK;
    }


    
# 28 "MCAL/ADC/ADC.c" 3
   (*(volatile uint8_t *)((0x07) + 0x20)) 
# 28 "MCAL/ADC/ADC.c"
         = (Copy_u8Ref << 6) | (0u << 5);


    
# 31 "MCAL/ADC/ADC.c" 3
   (*(volatile uint8_t *)((0x06) + 0x20)) 
# 31 "MCAL/ADC/ADC.c"
          = (Copy_u8Prescaler & 0x07) | (1 << 7);

    return E_OK;
}
# 43 "MCAL/ADC/ADC.c"
STD_ReturnType ADC_ReadChannel(uint8 Copy_u8Channel, uint16 *Copy_pu16Reading) {
    if (Copy_u8Channel > 7u || Copy_pu16Reading == ((void *)0)) {
        return E_NOK;
    }


    
# 49 "MCAL/ADC/ADC.c" 3
   (*(volatile uint8_t *)((0x07) + 0x20)) 
# 49 "MCAL/ADC/ADC.c"
         |= (Copy_u8Channel & 0x1F);


    
# 52 "MCAL/ADC/ADC.c" 3
   (*(volatile uint8_t *)((0x06) + 0x20)) 
# 52 "MCAL/ADC/ADC.c"
          |= (1 << 6);


    while ((
# 55 "MCAL/ADC/ADC.c" 3
           (*(volatile uint8_t *)((0x06) + 0x20)) 
# 55 "MCAL/ADC/ADC.c"
                  & (1 << 4)) == 0);


    
# 58 "MCAL/ADC/ADC.c" 3
   (*(volatile uint8_t *)((0x06) + 0x20)) 
# 58 "MCAL/ADC/ADC.c"
          |= (1 << 4);


    *Copy_pu16Reading = 
# 61 "MCAL/ADC/ADC.c" 3
                       (*(volatile uint8_t *)((0x04) + 0x20)) 
# 61 "MCAL/ADC/ADC.c"
                            | ((uint16)
# 61 "MCAL/ADC/ADC.c" 3
                                       (*(volatile uint8_t *)((0x05) + 0x20)) 
# 61 "MCAL/ADC/ADC.c"
                                            << 8);

    return E_OK;
}
