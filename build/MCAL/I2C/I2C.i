# 1 "MCAL/I2C/I2C.c"
# 1 "<built-in>"
# 1 "<command-line>"
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




# 1 "/usr/lib/avr/include/util/delay.h" 1 3
# 44 "/usr/lib/avr/include/util/delay.h" 3
# 1 "/usr/lib/avr/include/inttypes.h" 1 3
# 37 "/usr/lib/avr/include/inttypes.h" 3
# 1 "/usr/lib/gcc/avr/7.3.0/include/stdint.h" 1 3 4
# 9 "/usr/lib/gcc/avr/7.3.0/include/stdint.h" 3 4
# 1 "/usr/lib/avr/include/stdint.h" 1 3 4
# 125 "/usr/lib/avr/include/stdint.h" 3 4

# 125 "/usr/lib/avr/include/stdint.h" 3 4
typedef signed int int8_t __attribute__((__mode__(__QI__)));
typedef unsigned int uint8_t __attribute__((__mode__(__QI__)));
typedef signed int int16_t __attribute__ ((__mode__ (__HI__)));
typedef unsigned int uint16_t __attribute__ ((__mode__ (__HI__)));
typedef signed int int32_t __attribute__ ((__mode__ (__SI__)));
typedef unsigned int uint32_t __attribute__ ((__mode__ (__SI__)));

typedef signed int int64_t __attribute__((__mode__(__DI__)));
typedef unsigned int uint64_t __attribute__((__mode__(__DI__)));
# 146 "/usr/lib/avr/include/stdint.h" 3 4
typedef int16_t intptr_t;




typedef uint16_t uintptr_t;
# 163 "/usr/lib/avr/include/stdint.h" 3 4
typedef int8_t int_least8_t;




typedef uint8_t uint_least8_t;




typedef int16_t int_least16_t;




typedef uint16_t uint_least16_t;




typedef int32_t int_least32_t;




typedef uint32_t uint_least32_t;







typedef int64_t int_least64_t;






typedef uint64_t uint_least64_t;
# 217 "/usr/lib/avr/include/stdint.h" 3 4
typedef int8_t int_fast8_t;




typedef uint8_t uint_fast8_t;




typedef int16_t int_fast16_t;




typedef uint16_t uint_fast16_t;




typedef int32_t int_fast32_t;




typedef uint32_t uint_fast32_t;







typedef int64_t int_fast64_t;






typedef uint64_t uint_fast64_t;
# 277 "/usr/lib/avr/include/stdint.h" 3 4
typedef int64_t intmax_t;




typedef uint64_t uintmax_t;
# 10 "/usr/lib/gcc/avr/7.3.0/include/stdint.h" 2 3 4
# 38 "/usr/lib/avr/include/inttypes.h" 2 3
# 77 "/usr/lib/avr/include/inttypes.h" 3
typedef int32_t int_farptr_t;



typedef uint32_t uint_farptr_t;
# 45 "/usr/lib/avr/include/util/delay.h" 2 3
# 1 "/usr/lib/avr/include/util/delay_basic.h" 1 3
# 40 "/usr/lib/avr/include/util/delay_basic.h" 3
static __inline__ void _delay_loop_1(uint8_t __count) __attribute__((__always_inline__));
static __inline__ void _delay_loop_2(uint16_t __count) __attribute__((__always_inline__));
# 80 "/usr/lib/avr/include/util/delay_basic.h" 3
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
# 102 "/usr/lib/avr/include/util/delay_basic.h" 3
void
_delay_loop_2(uint16_t __count)
{
 __asm__ volatile (
  "1: sbiw %0,1" "\n\t"
  "brne 1b"
  : "=w" (__count)
  : "0" (__count)
 );
}
# 46 "/usr/lib/avr/include/util/delay.h" 2 3
# 1 "/usr/lib/avr/include/math.h" 1 3
# 127 "/usr/lib/avr/include/math.h" 3
extern double cos(double __x) __attribute__((__const__));





extern double sin(double __x) __attribute__((__const__));





extern double tan(double __x) __attribute__((__const__));






extern double fabs(double __x) __attribute__((__const__));






extern double fmod(double __x, double __y) __attribute__((__const__));
# 168 "/usr/lib/avr/include/math.h" 3
extern double modf(double __x, double *__iptr);


extern float modff (float __x, float *__iptr);




extern double sqrt(double __x) __attribute__((__const__));


extern float sqrtf (float) __attribute__((__const__));




extern double cbrt(double __x) __attribute__((__const__));
# 195 "/usr/lib/avr/include/math.h" 3
extern double hypot (double __x, double __y) __attribute__((__const__));







extern double square(double __x) __attribute__((__const__));






extern double floor(double __x) __attribute__((__const__));






extern double ceil(double __x) __attribute__((__const__));
# 235 "/usr/lib/avr/include/math.h" 3
extern double frexp(double __x, int *__pexp);







extern double ldexp(double __x, int __exp) __attribute__((__const__));





extern double exp(double __x) __attribute__((__const__));





extern double cosh(double __x) __attribute__((__const__));





extern double sinh(double __x) __attribute__((__const__));





extern double tanh(double __x) __attribute__((__const__));







extern double acos(double __x) __attribute__((__const__));







extern double asin(double __x) __attribute__((__const__));






extern double atan(double __x) __attribute__((__const__));
# 299 "/usr/lib/avr/include/math.h" 3
extern double atan2(double __y, double __x) __attribute__((__const__));





extern double log(double __x) __attribute__((__const__));





extern double log10(double __x) __attribute__((__const__));





extern double pow(double __x, double __y) __attribute__((__const__));






extern int isnan(double __x) __attribute__((__const__));
# 334 "/usr/lib/avr/include/math.h" 3
extern int isinf(double __x) __attribute__((__const__));






__attribute__((__const__)) static inline int isfinite (double __x)
{
    unsigned char __exp;
    __asm__ (
 "mov	%0, %C1		\n\t"
 "lsl	%0		\n\t"
 "mov	%0, %D1		\n\t"
 "rol	%0		"
 : "=r" (__exp)
 : "r" (__x) );
    return __exp != 0xff;
}






__attribute__((__const__)) static inline double copysign (double __x, double __y)
{
    __asm__ (
 "bst	%D2, 7	\n\t"
 "bld	%D0, 7	"
 : "=r" (__x)
 : "0" (__x), "r" (__y) );
    return __x;
}
# 377 "/usr/lib/avr/include/math.h" 3
extern int signbit (double __x) __attribute__((__const__));






extern double fdim (double __x, double __y) __attribute__((__const__));
# 393 "/usr/lib/avr/include/math.h" 3
extern double fma (double __x, double __y, double __z) __attribute__((__const__));







extern double fmax (double __x, double __y) __attribute__((__const__));







extern double fmin (double __x, double __y) __attribute__((__const__));






extern double trunc (double __x) __attribute__((__const__));
# 427 "/usr/lib/avr/include/math.h" 3
extern double round (double __x) __attribute__((__const__));
# 440 "/usr/lib/avr/include/math.h" 3
extern long lround (double __x) __attribute__((__const__));
# 454 "/usr/lib/avr/include/math.h" 3
extern long lrint (double __x) __attribute__((__const__));
# 47 "/usr/lib/avr/include/util/delay.h" 2 3
# 86 "/usr/lib/avr/include/util/delay.h" 3
static __inline__ void _delay_us(double __us) __attribute__((__always_inline__));
static __inline__ void _delay_ms(double __ms) __attribute__((__always_inline__));
# 165 "/usr/lib/avr/include/util/delay.h" 3
void
_delay_ms(double __ms)
{
 double __tmp ;



 uint32_t __ticks_dc;
 extern void __builtin_avr_delay_cycles(unsigned long);
 __tmp = ((
# 174 "/usr/lib/avr/include/util/delay.h"
          8000000UL
# 174 "/usr/lib/avr/include/util/delay.h" 3
               ) / 1e3) * __ms;
# 184 "/usr/lib/avr/include/util/delay.h" 3
  __ticks_dc = (uint32_t)(ceil(fabs(__tmp)));


 __builtin_avr_delay_cycles(__ticks_dc);
# 210 "/usr/lib/avr/include/util/delay.h" 3
}
# 254 "/usr/lib/avr/include/util/delay.h" 3
void
_delay_us(double __us)
{
 double __tmp ;



 uint32_t __ticks_dc;
 extern void __builtin_avr_delay_cycles(unsigned long);
 __tmp = ((
# 263 "/usr/lib/avr/include/util/delay.h"
          8000000UL
# 263 "/usr/lib/avr/include/util/delay.h" 3
               ) / 1e6) * __us;
# 273 "/usr/lib/avr/include/util/delay.h" 3
  __ticks_dc = (uint32_t)(ceil(fabs(__tmp)));


 __builtin_avr_delay_cycles(__ticks_dc);
# 299 "/usr/lib/avr/include/util/delay.h" 3
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
