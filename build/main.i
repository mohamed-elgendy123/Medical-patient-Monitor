# 0 "main.c"
# 0 "<built-in>"
# 0 "<command-line>"
# 1 "main.c"
# 208 "main.c"
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
# 209 "main.c" 2
# 1 "C:/avr-gcc/avr/include/util/delay.h" 1 3
# 50 "C:/avr-gcc/avr/include/util/delay.h" 3
# 1 "C:/avr-gcc/avr/include/util/delay_basic.h" 1 3
# 40 "C:/avr-gcc/avr/include/util/delay_basic.h" 3
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
          16000000UL
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
          16000000UL
# 244 "C:/avr-gcc/avr/include/util/delay.h" 3
               ) / 1e6) * __us;
# 254 "C:/avr-gcc/avr/include/util/delay.h" 3
  __ticks_dc = (uint32_t)(__builtin_ceil(__builtin_fabs(__tmp)));


 __builtin_avr_delay_cycles(__ticks_dc);
# 281 "C:/avr-gcc/avr/include/util/delay.h" 3
}
# 210 "main.c" 2
# 1 "C:/avr-gcc/avr/include/stdlib.h" 1 3
# 48 "C:/avr-gcc/avr/include/stdlib.h" 3
# 1 "C:/avr-gcc/lib/gcc/avr/15.2.0/include/stddef.h" 1 3 4
# 229 "C:/avr-gcc/lib/gcc/avr/15.2.0/include/stddef.h" 3 4
typedef unsigned int size_t;
# 344 "C:/avr-gcc/lib/gcc/avr/15.2.0/include/stddef.h" 3 4
typedef int wchar_t;
# 49 "C:/avr-gcc/avr/include/stdlib.h" 2 3
# 71 "C:/avr-gcc/avr/include/stdlib.h" 3
typedef struct {
 int quot;
 int rem;
} div_t;


typedef struct {
 long quot;
 long rem;
} ldiv_t;


typedef int (*__compar_fn_t)(const void *, const void *);
# 121 "C:/avr-gcc/avr/include/stdlib.h" 3
extern void abort(void) __attribute__((__noreturn__));


static __inline__ __attribute__((__always_inline__))
int abs (int __i)
{
    return __builtin_abs (__i);
}




extern int abs(int __i) __attribute__((__const__));


static __inline__ __attribute__((__always_inline__))
long labs (long __i)
{
    return __builtin_labs (__i);
}





extern long labs(long __i) __attribute__((__const__));
# 166 "C:/avr-gcc/avr/include/stdlib.h" 3
extern void *bsearch(const void *__key, const void *__base, size_t __nmemb,
       size_t __size, int (*__compar)(const void *, const void *));







extern div_t div(int __num, int __denom) __asm__("__divmodhi4") __attribute__((__const__));





extern ldiv_t ldiv(long __num, long __denom) __asm__("__divmodsi4") __attribute__((__const__));
# 198 "C:/avr-gcc/avr/include/stdlib.h" 3
extern void qsort(void *__base, size_t __nmemb, size_t __size,
    __compar_fn_t __compar);
# 231 "C:/avr-gcc/avr/include/stdlib.h" 3
extern long strtol(const char *__nptr, char **__endptr, int __base);
# 265 "C:/avr-gcc/avr/include/stdlib.h" 3
extern unsigned long strtoul(const char *__nptr, char **__endptr, int __base);
# 277 "C:/avr-gcc/avr/include/stdlib.h" 3
extern long atol(const char *__s) __attribute__((__pure__));
# 289 "C:/avr-gcc/avr/include/stdlib.h" 3
extern int atoi(const char *__s) __attribute__((__pure__));
# 301 "C:/avr-gcc/avr/include/stdlib.h" 3
extern void exit(int __status) __attribute__((__noreturn__));
# 313 "C:/avr-gcc/avr/include/stdlib.h" 3
extern void *malloc(size_t __size) __attribute__((__malloc__));






extern void free(void *__ptr);




extern size_t __malloc_margin;




extern char *__malloc_heap_start;




extern char *__malloc_heap_end;






extern void *calloc(size_t __nele, size_t __size) __attribute__((__malloc__));
# 361 "C:/avr-gcc/avr/include/stdlib.h" 3
extern void *realloc(void *__ptr, size_t __size) __attribute__((__malloc__));

extern float strtof(const char *__nptr, char **__endptr);





extern double strtod(const char *__nptr, char **__endptr);






extern long double strtold(const char *__nptr, char **__endptr);







extern int atexit(void (*func)(void));
# 394 "C:/avr-gcc/avr/include/stdlib.h" 3
extern float atoff(const char *__nptr);
# 403 "C:/avr-gcc/avr/include/stdlib.h" 3
extern double atof(const char *__nptr);
# 412 "C:/avr-gcc/avr/include/stdlib.h" 3
extern long double atofl(const char *__nptr);
# 434 "C:/avr-gcc/avr/include/stdlib.h" 3
extern int rand(void);



extern void srand(unsigned int __seed);






extern int rand_r(unsigned long *__ctx);
# 479 "C:/avr-gcc/avr/include/stdlib.h" 3
extern __inline__ __attribute__((__gnu_inline__))
char *itoa (int __val, char *__s, int __radix)
{
    if (!__builtin_constant_p (__radix)) {
 extern char *__itoa (int, char *, int);
 return __itoa (__val, __s, __radix);
    } else if (__radix < 2 || __radix > 36) {
 *__s = 0;
 return __s;
    } else {
 extern char *__itoa_ncheck (int, char *, unsigned char);
 return __itoa_ncheck (__val, __s, __radix);
    }
}
# 524 "C:/avr-gcc/avr/include/stdlib.h" 3
extern __inline__ __attribute__((__gnu_inline__))
char *ltoa (long __val, char *__s, int __radix)
{
    if (!__builtin_constant_p (__radix))
    {
 extern char *__ltoa (long, char *, int);
 return __ltoa (__val, __s, __radix);
    }
    else if (__radix < 2 || __radix > 36)
    {
 *__s = 0;
 return __s;
    }
    else
    {
 extern char *__ltoa_ncheck (long, char *, unsigned char);
 return __ltoa_ncheck (__val, __s, __radix);
    }
}
# 572 "C:/avr-gcc/avr/include/stdlib.h" 3
extern __inline__ __attribute__((__gnu_inline__))
char *utoa (unsigned int __val, char *__s, int __radix)
{
    if (!__builtin_constant_p (__radix))
    {
 extern char *__utoa (unsigned int, char *, int);
 return __utoa (__val, __s, __radix);
    }
    else if (__radix < 2 || __radix > 36)
    {
 *__s = 0;
 return __s;
    }
    else
    {
 extern char *__utoa_ncheck (unsigned int, char *, unsigned char);
 return __utoa_ncheck (__val, __s, __radix);
    }
}
# 619 "C:/avr-gcc/avr/include/stdlib.h" 3
extern __inline__ __attribute__((__gnu_inline__))
char *ultoa (unsigned long __val, char *__s, int __radix)
{
    if (!__builtin_constant_p (__radix)) {
 extern char *__ultoa (unsigned long, char *, int);
 return __ultoa (__val, __s, __radix);
    } else if (__radix < 2 || __radix > 36) {
 *__s = 0;
 return __s;
    } else {
 extern char *__ultoa_ncheck (unsigned long, char *, unsigned char);
 return __ultoa_ncheck (__val, __s, __radix);
    }
}
# 651 "C:/avr-gcc/avr/include/stdlib.h" 3
extern long random(void);




extern void srandom(unsigned long __seed);







extern long random_r(unsigned long *__ctx);
# 708 "C:/avr-gcc/avr/include/stdlib.h" 3
extern char *ftostre(float __val, char *__s, unsigned char __prec,
                     unsigned char __flags);






extern char *dtostre(double __val, char *__s, unsigned char __prec,
       unsigned char __flags);







extern char *ldtostre(long double __val, char *__s, unsigned char __prec,
       unsigned char __flags);
# 742 "C:/avr-gcc/avr/include/stdlib.h" 3
extern char *ftostrf(float __val, signed char __width,
                     unsigned char __prec, char *__s);






extern char *dtostrf(double __val, signed char __width,
                     unsigned char __prec, char *__s);







extern char *ldtostrf(long double __val, signed char __width,
                      unsigned char __prec, char *__s);
# 778 "C:/avr-gcc/avr/include/stdlib.h" 3
extern int system (const char *);
extern char *getenv (const char *);
# 211 "main.c" 2



# 213 "main.c"
void UART_init(void) {
    uint16_t ubrr_value = 103;
    
# 215 "main.c" 3
   (*(volatile uint8_t *)((0x20) + 0x20)) 
# 215 "main.c"
         = (uint8_t)(ubrr_value >> 8);
    
# 216 "main.c" 3
   (*(volatile uint8_t *)((0x09) + 0x20)) 
# 216 "main.c"
         = (uint8_t)ubrr_value;
    
# 217 "main.c" 3
   (*(volatile uint8_t *)((0x0A) + 0x20)) 
# 217 "main.c"
         = (1 << 
# 217 "main.c" 3
                 3
# 217 "main.c"
                     );
    
# 218 "main.c" 3
   (*(volatile uint8_t *)((0x20) + 0x20)) 
# 218 "main.c"
         = (1 << 
# 218 "main.c" 3
                 7
# 218 "main.c"
                      ) | (1 << 
# 218 "main.c" 3
                                2
# 218 "main.c"
                                     ) | (1 << 
# 218 "main.c" 3
                                               1
# 218 "main.c"
                                                    );
}

void UART_sendChar(char data) {
    while (!(
# 222 "main.c" 3
            (*(volatile uint8_t *)((0x0B) + 0x20)) 
# 222 "main.c"
                  & (1 << 
# 222 "main.c" 3
                          5
# 222 "main.c"
                              )));
    
# 223 "main.c" 3
   (*(volatile uint8_t *)((0x0C) + 0x20)) 
# 223 "main.c"
       = data;
}

void UART_sendString(char *str) {
    while (*str) {
        UART_sendChar(*str++);
    }
}

void UART_sendNumber(uint16_t num) {
    char buffer[10];
    itoa(num, buffer, 10);
    UART_sendString(buffer);
}


void ADC_init(void) {
    
# 240 "main.c" 3
   (*(volatile uint8_t *)((0x07) + 0x20)) 
# 240 "main.c"
         = (1 << 
# 240 "main.c" 3
                 6
# 240 "main.c"
                      );
    
# 241 "main.c" 3
   (*(volatile uint8_t *)((0x06) + 0x20)) 
# 241 "main.c"
          = (1 << 
# 241 "main.c" 3
                  7
# 241 "main.c"
                      ) | (1 << 
# 241 "main.c" 3
                                2
# 241 "main.c"
                                     ) | (1 << 
# 241 "main.c" 3
                                               1
# 241 "main.c"
                                                    ) | (1 << 
# 241 "main.c" 3
                                                              0
# 241 "main.c"
                                                                   );
}

uint16_t ADC_read(uint8_t channel) {
    
# 245 "main.c" 3
   (*(volatile uint8_t *)((0x07) + 0x20)) 
# 245 "main.c"
         = (
# 245 "main.c" 3
            (*(volatile uint8_t *)((0x07) + 0x20)) 
# 245 "main.c"
                  & 0xF0) | (channel & 0x07);
    
# 246 "main.c" 3
   (*(volatile uint8_t *)((0x06) + 0x20)) 
# 246 "main.c"
          |= (1 << 
# 246 "main.c" 3
                   6
# 246 "main.c"
                       );
    while (
# 247 "main.c" 3
          (*(volatile uint8_t *)((0x06) + 0x20)) 
# 247 "main.c"
                 & (1 << 
# 247 "main.c" 3
                         6
# 247 "main.c"
                             ));
    return 
# 248 "main.c" 3
          (*(volatile uint16_t *)((0x04) + 0x20))
# 248 "main.c"
             ;
}

int main(void) {
    UART_init();
    ADC_init();

    
# 255 "main.c" 3
   (*(volatile uint8_t *)((0x17) + 0x20)) 
# 255 "main.c"
        |= (1 << 
# 255 "main.c" 3
                 0
# 255 "main.c"
                    );

    while (1) {
        
# 258 "main.c" 3
       (*(volatile uint8_t *)((0x18) + 0x20)) 
# 258 "main.c"
             ^= (1 << 
# 258 "main.c" 3
                      0
# 258 "main.c"
                         );

        UART_sendString("--- Patient Vitals ---\r\n");

        for (uint8_t ch = 0; ch < 4; ch++) {
            uint16_t val = ADC_read(ch);
            UART_sendString("Ch ");
            UART_sendNumber(ch);
            UART_sendString(": ");
            UART_sendNumber(val);
            UART_sendString("\r\n");
        }

        UART_sendString("\r\n");
        _delay_ms(500);
    }

    return 0;
}
