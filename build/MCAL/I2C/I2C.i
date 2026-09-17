# 0 "MCAL/I2C/I2C.c"
# 0 "<built-in>"
# 0 "<command-line>"
# 1 "MCAL/I2C/I2C.c"
# 9 "MCAL/I2C/I2C.c"
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
# 10 "MCAL/I2C/I2C.c" 2
# 1 "MCAL/I2C/I2C_interface.h" 1
# 32 "MCAL/I2C/I2C_interface.h"
STD_ReturnType I2C_InitMaster(uint32 Copy_u32SclHz);




STD_ReturnType I2C_SendStart(void);




STD_ReturnType I2C_SendRepeatedStart(void);




void I2C_SendStop(void);





STD_ReturnType I2C_SendSlaveAddressWithWrite(uint8 Copy_u8Address);
STD_ReturnType I2C_SendSlaveAddressWithRead(uint8 Copy_u8Address);




STD_ReturnType I2C_SendByte(uint8 Copy_u8Data);





STD_ReturnType I2C_ReceiveByte(uint8 *Copy_pu8Data, uint8 Copy_u8SendAck);
# 11 "MCAL/I2C/I2C.c" 2
# 1 "MCAL/I2C/I2C_private.h" 1
# 12 "MCAL/I2C/I2C.c" 2




# 1 "C:/avr-gcc/avr/include/util/delay.h" 1 3
# 49 "C:/avr-gcc/avr/include/util/delay.h" 3
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
# 50 "C:/avr-gcc/avr/include/util/delay.h" 2 3
# 1 "C:/avr-gcc/avr/include/util/delay_basic.h" 1 3
# 37 "C:/avr-gcc/avr/include/util/delay_basic.h" 3
# 1 "C:/avr-gcc/avr/include/inttypes.h" 1 3
# 77 "C:/avr-gcc/avr/include/inttypes.h" 3
typedef int32_t int_farptr_t;





typedef uint32_t uint_farptr_t;
# 38 "C:/avr-gcc/avr/include/util/delay_basic.h" 2 3


static __inline__ void _delay_loop_1(uint8_t __count) __attribute__((__always_inline__));
static __inline__ void _delay_loop_2(uint16_t __count) __attribute__((__always_inline__));
# 80 "C:/avr-gcc/avr/include/util/delay_basic.h" 3
void
_delay_loop_1(uint8_t __count)
{
 __asm__ volatile (
  "1: dec %0" "\n\t"
  "brne 1b"
  : "=r" (__count)
  : "0" (__count)
 );
}
# 102 "C:/avr-gcc/avr/include/util/delay_basic.h" 3
void
_delay_loop_2(uint16_t __count)
{
# 113 "C:/avr-gcc/avr/include/util/delay_basic.h" 3
 __asm__ volatile (
  "1: sbiw %0,1" "\n\t"
  "brne 1b"
  : "+w" (__count)
 );

}
# 51 "C:/avr-gcc/avr/include/util/delay.h" 2 3
# 151 "C:/avr-gcc/avr/include/util/delay.h" 3
static __inline__ __attribute__((__always_inline__)) void _delay_ms(double __ms);

void
_delay_ms(double __ms)
{
 double __tmp ;


 uint32_t __ticks_dc;
 extern void __builtin_avr_delay_cycles(uint32_t);
 __tmp = ((
# 161 "C:/avr-gcc/avr/include/util/delay.h"
          8000000UL
# 161 "C:/avr-gcc/avr/include/util/delay.h" 3
               ) / 1e3) * __ms;
# 171 "C:/avr-gcc/avr/include/util/delay.h" 3
  __ticks_dc = (uint32_t)(__builtin_ceil(__builtin_fabs(__tmp)));


 __builtin_avr_delay_cycles(__ticks_dc);
# 197 "C:/avr-gcc/avr/include/util/delay.h" 3
}
# 234 "C:/avr-gcc/avr/include/util/delay.h" 3
static __inline__ __attribute__((__always_inline__)) void _delay_us(double __us);

void
_delay_us(double __us)
{
 double __tmp ;


 uint32_t __ticks_dc;
 extern void __builtin_avr_delay_cycles(uint32_t);
 __tmp = ((
# 244 "C:/avr-gcc/avr/include/util/delay.h"
          8000000UL
# 244 "C:/avr-gcc/avr/include/util/delay.h" 3
               ) / 1e6) * __us;
# 254 "C:/avr-gcc/avr/include/util/delay.h" 3
  __ticks_dc = (uint32_t)(__builtin_ceil(__builtin_fabs(__tmp)));


 __builtin_avr_delay_cycles(__ticks_dc);
# 281 "C:/avr-gcc/avr/include/util/delay.h" 3
}
# 17 "MCAL/I2C/I2C.c" 2








# 24 "MCAL/I2C/I2C.c"
STD_ReturnType I2C_InitMaster(uint32 Copy_u32SclHz){
    if (Copy_u32SclHz == 0 || (8000000UL / Copy_u32SclHz) < 16) {
        return E_NOK;
    }

    uint32 Local_u32Twbr = (((8000000UL) / (Copy_u32SclHz) - 16) / 2);
    if (Local_u32Twbr > 255) {
        return E_NOK;
    }


    (*(volatile uint8*)0x35) |= (1u << 0) | (1u << 1);

    (*(volatile uint8*)0x20) = (uint8)Local_u32Twbr;
    (*(volatile uint8*)0x21) &= ~0x03u;
    (*(volatile uint8*)0x56) = (1u << 2);

    return E_OK;
}






STD_ReturnType I2C_SendStart(void){
    uint32 Local_u32Timeout = 1000UL;
    (*(volatile uint8*)0x56) = (1u << 7) | (1u << 2) | (1u << 5);
    while ((((*(volatile uint8*)0x56) & (1u << 7)) == 0) && (--Local_u32Timeout > 0)) ;
    if (Local_u32Timeout == 0) return E_NOK;
    uint8 status = (*(volatile uint8*)0x21) & 0xF8u;
    if (status != 0x08u && status != 0x10u) {
        return E_NOK;
    }
    return E_OK;
}





STD_ReturnType I2C_SendRepeatedStart(void){
    uint32 Local_u32Timeout = 1000UL;
    (*(volatile uint8*)0x56) = (1u << 7) | (1u << 2) | (1u << 5);
    while ((((*(volatile uint8*)0x56) & (1u << 7)) == 0) && (--Local_u32Timeout > 0)) ;
    if (Local_u32Timeout == 0) return E_NOK;
    uint8 status = (*(volatile uint8*)0x21) & 0xF8u;
    if (status != 0x08u && status != 0x10u) {
        return E_NOK;
    }
    return E_OK;
}





void I2C_SendStop(void){
    (*(volatile uint8*)0x56) = (1u << 7) | (1u << 4) | (1u << 2);
    _delay_us(50);
}
# 95 "MCAL/I2C/I2C.c"
STD_ReturnType I2C_SendSlaveAddressWithWrite(uint8 Copy_u8Address){
    if (Copy_u8Address > 0x7Fu) {
        return E_NOK;
    }

    (*(volatile uint8*)0x23) = (((Copy_u8Address) << 1) | 0);
    do { uint32 Local_u32Timeout = 1000UL; (*(volatile uint8*)0x56) = (1u << 7) | (1u << 2) | (0); while ((((*(volatile uint8*)0x56) & (1u << 7)) == 0) && (--Local_u32Timeout > 0)) ; if (Local_u32Timeout == 0) return E_NOK; if (((*(volatile uint8*)0x21) & 0xF8u) != (0x18u)) return E_NOK; } while(0);
    return E_OK;
}

STD_ReturnType I2C_SendSlaveAddressWithRead(uint8 Copy_u8Address){
    if (Copy_u8Address > 0x7Fu) {
        return E_NOK;
    }

    (*(volatile uint8*)0x23) = (((Copy_u8Address) << 1) | 1);
    do { uint32 Local_u32Timeout = 1000UL; (*(volatile uint8*)0x56) = (1u << 7) | (1u << 2) | (0); while ((((*(volatile uint8*)0x56) & (1u << 7)) == 0) && (--Local_u32Timeout > 0)) ; if (Local_u32Timeout == 0) return E_NOK; if (((*(volatile uint8*)0x21) & 0xF8u) != (0x40u)) return E_NOK; } while(0);
    return E_OK;
}





STD_ReturnType I2C_SendByte(uint8 Copy_u8Data){
    (*(volatile uint8*)0x23) = Copy_u8Data;
    do { uint32 Local_u32Timeout = 1000UL; (*(volatile uint8*)0x56) = (1u << 7) | (1u << 2) | (0); while ((((*(volatile uint8*)0x56) & (1u << 7)) == 0) && (--Local_u32Timeout > 0)) ; if (Local_u32Timeout == 0) return E_NOK; if (((*(volatile uint8*)0x21) & 0xF8u) != (0x28u)) return E_NOK; } while(0);
    return E_OK;
}
# 132 "MCAL/I2C/I2C.c"
STD_ReturnType I2C_ReceiveByte(uint8 *Copy_pu8Data, uint8 Copy_u8SendAck){
    if (Copy_pu8Data == ((void *)0)) {
        return E_NOK;
    }

    if (Copy_u8SendAck == 1u) {
        do { uint32 Local_u32Timeout = 1000UL; (*(volatile uint8*)0x56) = (1u << 7) | (1u << 2) | ((1u << 6)); while ((((*(volatile uint8*)0x56) & (1u << 7)) == 0) && (--Local_u32Timeout > 0)) ; if (Local_u32Timeout == 0) return E_NOK; if (((*(volatile uint8*)0x21) & 0xF8u) != (0x50u)) return E_NOK; } while(0);
    } else if (Copy_u8SendAck == 0u) {
        do { uint32 Local_u32Timeout = 1000UL; (*(volatile uint8*)0x56) = (1u << 7) | (1u << 2) | (0); while ((((*(volatile uint8*)0x56) & (1u << 7)) == 0) && (--Local_u32Timeout > 0)) ; if (Local_u32Timeout == 0) return E_NOK; if (((*(volatile uint8*)0x21) & 0xF8u) != (0x58u)) return E_NOK; } while(0);
    } else {
        return E_NOK;
    }

    *Copy_pu8Data = (*(volatile uint8*)0x23);
    return E_OK;
}
