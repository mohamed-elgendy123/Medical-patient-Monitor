# 1 "main.c"
# 1 "<built-in>"
# 1 "<command-line>"
# 1 "main.c"


# 1 "/usr/lib/avr/include/stdio.h" 1 3
# 44 "/usr/lib/avr/include/stdio.h" 3
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
# 45 "/usr/lib/avr/include/stdio.h" 2 3
# 1 "/usr/lib/gcc/avr/7.3.0/include/stdarg.h" 1 3 4
# 40 "/usr/lib/gcc/avr/7.3.0/include/stdarg.h" 3 4
typedef __builtin_va_list __gnuc_va_list;
# 99 "/usr/lib/gcc/avr/7.3.0/include/stdarg.h" 3 4
typedef __gnuc_va_list va_list;
# 46 "/usr/lib/avr/include/stdio.h" 2 3




# 1 "/usr/lib/gcc/avr/7.3.0/include/stddef.h" 1 3 4
# 216 "/usr/lib/gcc/avr/7.3.0/include/stddef.h" 3 4
typedef unsigned int size_t;
# 51 "/usr/lib/avr/include/stdio.h" 2 3
# 244 "/usr/lib/avr/include/stdio.h" 3
struct __file {
 char *buf;
 unsigned char unget;
 uint8_t flags;
# 263 "/usr/lib/avr/include/stdio.h" 3
 int size;
 int len;
 int (*put)(char, struct __file *);
 int (*get)(struct __file *);
 void *udata;
};
# 277 "/usr/lib/avr/include/stdio.h" 3
typedef struct __file FILE;
# 407 "/usr/lib/avr/include/stdio.h" 3
extern struct __file *__iob[];
# 419 "/usr/lib/avr/include/stdio.h" 3
extern FILE *fdevopen(int (*__put)(char, FILE*), int (*__get)(FILE*));
# 436 "/usr/lib/avr/include/stdio.h" 3
extern int fclose(FILE *__stream);
# 610 "/usr/lib/avr/include/stdio.h" 3
extern int vfprintf(FILE *__stream, const char *__fmt, va_list __ap);





extern int vfprintf_P(FILE *__stream, const char *__fmt, va_list __ap);






extern int fputc(int __c, FILE *__stream);




extern int putc(int __c, FILE *__stream);


extern int putchar(int __c);
# 651 "/usr/lib/avr/include/stdio.h" 3
extern int printf(const char *__fmt, ...);





extern int printf_P(const char *__fmt, ...);







extern int vprintf(const char *__fmt, va_list __ap);





extern int sprintf(char *__s, const char *__fmt, ...);





extern int sprintf_P(char *__s, const char *__fmt, ...);
# 687 "/usr/lib/avr/include/stdio.h" 3
extern int snprintf(char *__s, size_t __n, const char *__fmt, ...);





extern int snprintf_P(char *__s, size_t __n, const char *__fmt, ...);





extern int vsprintf(char *__s, const char *__fmt, va_list ap);





extern int vsprintf_P(char *__s, const char *__fmt, va_list ap);
# 715 "/usr/lib/avr/include/stdio.h" 3
extern int vsnprintf(char *__s, size_t __n, const char *__fmt, va_list ap);





extern int vsnprintf_P(char *__s, size_t __n, const char *__fmt, va_list ap);




extern int fprintf(FILE *__stream, const char *__fmt, ...);





extern int fprintf_P(FILE *__stream, const char *__fmt, ...);






extern int fputs(const char *__str, FILE *__stream);




extern int fputs_P(const char *__str, FILE *__stream);





extern int puts(const char *__str);




extern int puts_P(const char *__str);
# 764 "/usr/lib/avr/include/stdio.h" 3
extern size_t fwrite(const void *__ptr, size_t __size, size_t __nmemb,
         FILE *__stream);







extern int fgetc(FILE *__stream);




extern int getc(FILE *__stream);


extern int getchar(void);
# 812 "/usr/lib/avr/include/stdio.h" 3
extern int ungetc(int __c, FILE *__stream);
# 824 "/usr/lib/avr/include/stdio.h" 3
extern char *fgets(char *__str, int __size, FILE *__stream);






extern char *gets(char *__str);
# 842 "/usr/lib/avr/include/stdio.h" 3
extern size_t fread(void *__ptr, size_t __size, size_t __nmemb,
        FILE *__stream);




extern void clearerr(FILE *__stream);
# 859 "/usr/lib/avr/include/stdio.h" 3
extern int feof(FILE *__stream);
# 870 "/usr/lib/avr/include/stdio.h" 3
extern int ferror(FILE *__stream);






extern int vfscanf(FILE *__stream, const char *__fmt, va_list __ap);




extern int vfscanf_P(FILE *__stream, const char *__fmt, va_list __ap);







extern int fscanf(FILE *__stream, const char *__fmt, ...);




extern int fscanf_P(FILE *__stream, const char *__fmt, ...);






extern int scanf(const char *__fmt, ...);




extern int scanf_P(const char *__fmt, ...);







extern int vscanf(const char *__fmt, va_list __ap);







extern int sscanf(const char *__buf, const char *__fmt, ...);




extern int sscanf_P(const char *__buf, const char *__fmt, ...);
# 940 "/usr/lib/avr/include/stdio.h" 3
static __inline__ int fflush(FILE *stream __attribute__((unused)))
{
 return 0;
}






__extension__ typedef long long fpos_t;
extern int fgetpos(FILE *stream, fpos_t *pos);
extern FILE *fopen(const char *path, const char *mode);
extern FILE *freopen(const char *path, const char *mode, FILE *stream);
extern FILE *fdopen(int, const char *);
extern int fseek(FILE *stream, long offset, int whence);
extern int fsetpos(FILE *stream, fpos_t *pos);
extern long ftell(FILE *stream);
extern int fileno(FILE *);
extern void perror(const char *s);
extern int remove(const char *pathname);
extern int rename(const char *oldpath, const char *newpath);
extern void rewind(FILE *stream);
extern void setbuf(FILE *stream, char *buf);
extern int setvbuf(FILE *stream, char *buf, int mode, size_t size);
extern FILE *tmpfile(void);
extern char *tmpnam (char *s);
# 4 "main.c" 2
# 1 "/usr/lib/avr/include/stdlib.h" 1 3
# 48 "/usr/lib/avr/include/stdlib.h" 3
# 1 "/usr/lib/gcc/avr/7.3.0/include/stddef.h" 1 3 4
# 328 "/usr/lib/gcc/avr/7.3.0/include/stddef.h" 3 4
typedef int wchar_t;
# 49 "/usr/lib/avr/include/stdlib.h" 2 3
# 70 "/usr/lib/avr/include/stdlib.h" 3
typedef struct {
 int quot;
 int rem;
} div_t;


typedef struct {
 long quot;
 long rem;
} ldiv_t;


typedef int (*__compar_fn_t)(const void *, const void *);
# 116 "/usr/lib/avr/include/stdlib.h" 3
extern void abort(void) __attribute__((__noreturn__));




extern int abs(int __i) __attribute__((__const__));
# 130 "/usr/lib/avr/include/stdlib.h" 3
extern long labs(long __i) __attribute__((__const__));
# 153 "/usr/lib/avr/include/stdlib.h" 3
extern void *bsearch(const void *__key, const void *__base, size_t __nmemb,
       size_t __size, int (*__compar)(const void *, const void *));







extern div_t div(int __num, int __denom) __asm__("__divmodhi4") __attribute__((__const__));





extern ldiv_t ldiv(long __num, long __denom) __asm__("__divmodsi4") __attribute__((__const__));
# 185 "/usr/lib/avr/include/stdlib.h" 3
extern void qsort(void *__base, size_t __nmemb, size_t __size,
    __compar_fn_t __compar);
# 218 "/usr/lib/avr/include/stdlib.h" 3
extern long strtol(const char *__nptr, char **__endptr, int __base);
# 252 "/usr/lib/avr/include/stdlib.h" 3
extern unsigned long strtoul(const char *__nptr, char **__endptr, int __base);
# 264 "/usr/lib/avr/include/stdlib.h" 3
extern long atol(const char *__s) __attribute__((__pure__));
# 276 "/usr/lib/avr/include/stdlib.h" 3
extern int atoi(const char *__s) __attribute__((__pure__));
# 288 "/usr/lib/avr/include/stdlib.h" 3
extern void exit(int __status) __attribute__((__noreturn__));
# 300 "/usr/lib/avr/include/stdlib.h" 3
extern void *malloc(size_t __size) __attribute__((__malloc__));






extern void free(void *__ptr);




extern size_t __malloc_margin;




extern char *__malloc_heap_start;




extern char *__malloc_heap_end;






extern void *calloc(size_t __nele, size_t __size) __attribute__((__malloc__));
# 348 "/usr/lib/avr/include/stdlib.h" 3
extern void *realloc(void *__ptr, size_t __size) __attribute__((__malloc__));

extern double strtod(const char *__nptr, char **__endptr);
# 361 "/usr/lib/avr/include/stdlib.h" 3
extern double atof(const char *__nptr);
# 383 "/usr/lib/avr/include/stdlib.h" 3
extern int rand(void);



extern void srand(unsigned int __seed);






extern int rand_r(unsigned long *__ctx);
# 428 "/usr/lib/avr/include/stdlib.h" 3
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
# 473 "/usr/lib/avr/include/stdlib.h" 3
extern __inline__ __attribute__((__gnu_inline__))
char *ltoa (long __val, char *__s, int __radix)
{
    if (!__builtin_constant_p (__radix)) {
 extern char *__ltoa (long, char *, int);
 return __ltoa (__val, __s, __radix);
    } else if (__radix < 2 || __radix > 36) {
 *__s = 0;
 return __s;
    } else {
 extern char *__ltoa_ncheck (long, char *, unsigned char);
 return __ltoa_ncheck (__val, __s, __radix);
    }
}
# 516 "/usr/lib/avr/include/stdlib.h" 3
extern __inline__ __attribute__((__gnu_inline__))
char *utoa (unsigned int __val, char *__s, int __radix)
{
    if (!__builtin_constant_p (__radix)) {
 extern char *__utoa (unsigned int, char *, int);
 return __utoa (__val, __s, __radix);
    } else if (__radix < 2 || __radix > 36) {
 *__s = 0;
 return __s;
    } else {
 extern char *__utoa_ncheck (unsigned int, char *, unsigned char);
 return __utoa_ncheck (__val, __s, __radix);
    }
}
# 558 "/usr/lib/avr/include/stdlib.h" 3
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
# 590 "/usr/lib/avr/include/stdlib.h" 3
extern long random(void);




extern void srandom(unsigned long __seed);







extern long random_r(unsigned long *__ctx);
# 649 "/usr/lib/avr/include/stdlib.h" 3
extern char *dtostre(double __val, char *__s, unsigned char __prec,
       unsigned char __flags);
# 666 "/usr/lib/avr/include/stdlib.h" 3
extern char *dtostrf(double __val, signed char __width,
                     unsigned char __prec, char *__s);
# 685 "/usr/lib/avr/include/stdlib.h" 3
extern int atexit(void (*)(void));
extern int system (const char *);
extern char *getenv (const char *);
# 5 "main.c" 2
# 1 "/usr/lib/avr/include/util/delay.h" 1 3
# 45 "/usr/lib/avr/include/util/delay.h" 3
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
# 6 "main.c" 2

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
# 8 "main.c" 2
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
# 9 "main.c" 2
# 1 "MCAL/TIMER/TIMER_private.h" 1
# 10 "main.c" 2
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
# 11 "main.c" 2
# 1 "MCAL/GPIO/GPIO_interface.h" 1
# 42 "MCAL/GPIO/GPIO_interface.h"
STD_ReturnType GPIO_SetPinDirection(uint8 Copy_u8Port, uint8 Copy_u8Pin, uint8 Copy_u8Direction);




STD_ReturnType GPIO_SetPinValue(uint8 Copy_u8Port, uint8 Copy_u8Pin, uint8 Copy_u8Value);




STD_ReturnType GPIO_GetPinValue(uint8 Copy_u8Port, uint8 Copy_u8Pin, uint8 *Copy_pu8Value);




STD_ReturnType GPIO_TogglePinValue(uint8 Copy_u8Port, uint8 Copy_u8Pin);




STD_ReturnType GPIO_SetPortDirection(uint8 Copy_u8Port, uint8 Copy_u8Direction);




STD_ReturnType GPIO_SetPortValue(uint8 Copy_u8Port, uint8 Copy_u8Value);




STD_ReturnType GPIO_GetPortValue(uint8 Copy_u8Port, uint8 *Copy_pu8Value);
# 12 "main.c" 2
# 1 "HAL/HR_Capture/HR_Capture_interface.h" 1



# 1 "./LIB/STD_TYPES.h" 1
# 5 "HAL/HR_Capture/HR_Capture_interface.h" 2
# 20 "HAL/HR_Capture/HR_Capture_interface.h"
void HRC_Init(void);
void HRC_Process(void);
void HRC_OnCapture(uint16 Copy_u16IntervalTicks);
void HRC_OnOverflow(void);
uint16 HRC_GetBpm(void);
uint16 HRC_GetHrvMs(void);
uint8 HRC_IsAsystole(void);
void HRC_ClearAsystole(void);
# 13 "main.c" 2
# 1 "HAL/Annunciator/Annunciator_interface.h" 1
# 21 "HAL/Annunciator/Annunciator_interface.h"
void ANN_Audio_Init(void);
void ANN_Audio_SetPriority(uint8 Copy_u8Priority);
void ANN_Audio_Tick(void);
void ANN_Audio_Mute(void);
void ANN_Audio_Unmute(void);


void ANN_Visual_Init(void);
void ANN_Visual_SetPriority(uint8 Copy_u8Priority);
void ANN_Visual_Tick(void);
void ANN_Visual_TriggerHeartbeat(void);
# 14 "main.c" 2
# 1 "HAL/ShiftReg/ShiftReg_interface.h" 1



# 1 "HAL/ShiftReg/../../LIB/STD_TYPES.h" 1
# 5 "HAL/ShiftReg/ShiftReg_interface.h" 2





void ShiftReg_voidInit(void);





void ShiftReg_voidWriteByte(uint8 Copy_u8Data);
# 15 "main.c" 2
# 1 "HAL/NurseCall/NurseCall_interface.h" 1




# 1 "HAL/NurseCall/../../LIB/STD_TYPES.h" 1
# 6 "HAL/NurseCall/NurseCall_interface.h" 2


void NurseCall_voidInit(void);


void NurseCall_voidEnable(void);


void NurseCall_voidDisable(void);
# 16 "main.c" 2
# 1 "Logic/AlarmManager/Alarm_mgr.h" 1



# 1 "Logic/AlarmManager/../../LIB/STD_TYPES.h" 1
# 5 "Logic/AlarmManager/Alarm_mgr.h" 2


typedef uint8 uint8;
typedef uint16 uint16;
typedef uint32 uint32;

typedef enum {
    ALARM_PRIO_NONE = 0,
    ALARM_PRIO_LOW,
    ALARM_PRIO_MEDIUM,
    ALARM_PRIO_HIGH
} Alarm_Priority_t;

typedef enum {
    ALARM_ASYSTOLE = 0,
    ALARM_VFIB_VTAC,
    ALARM_HR_CRIT_HIGH,
    ALARM_HR_CRIT_LOW,
    ALARM_SPO2_CRIT_LOW,
    ALARM_RR_CRIT_HIGH,
    ALARM_RR_CRIT_LOW,
    ALARM_HR_WARN_HIGH,
    ALARM_HR_WARN_LOW,
    ALARM_SPO2_WARN_LOW,
    ALARM_TEMP_HIGH,
    ALARM_TEMP_LOW,
    ALARM_BP_HIGH,
    ALARM_BP_LOW,
    ALARM_SENSOR_DISCONNECT,
    ALARM_LEAD_OFF,
    ALARM_BATTERY_LOW,
    ALARM_COUNT
} Alarm_ID_t;

typedef struct {
    uint16 heartRate;
    uint8 spO2;
    uint8 respRate;
    uint16 tempC_x10;
    uint16 sysBP;
    uint16 diaBP;
    uint8 sensorConnected;
    uint8 leadStatus;
    uint8 codeBlue;
} PatientVitals_t;

void Alarm_Init(void);
void Alarm_UpdateVitals(const PatientVitals_t* vitals);
void Alarm_Process(void);
Alarm_Priority_t Alarm_GetActivePriority(void);
uint16 Alarm_GetActiveFlags(void);
void Alarm_Acknowledge(void);
# 17 "main.c" 2
# 1 "HAL/Vitals/vitals_interface.h" 1






typedef enum {
    VITALS_OK = 0,
    VITALS_SENSOR_FAULT
} Vitals_StatusType;


typedef struct {
    uint16 hrBpm;
    uint16 hrvMs;
    uint8 spo2Pct;
    uint16 tempCx10;
    uint8 nibpSys;
    uint8 nibpDia;
    uint8 respBpm;
    uint8 perfusionPct;


    uint8 leadOff : 1;
    uint8 probeOff : 1;
    uint8 beatFlag : 1;
    uint8 reserved : 5;

    uint32 monitorSec;


    Vitals_StatusType spo2Status;
    Vitals_StatusType tempStatus;
    Vitals_StatusType bpStatus;
    Vitals_StatusType respStatus;
} Vitals_t;


STD_ReturnType Vitals_Init(void);
STD_ReturnType Vitals_Read(Vitals_t *Copy_pstrVitals);
# 18 "main.c" 2
# 1 "Logic/patient_cfg.h" 1
# 43 "Logic/patient_cfg.h"
typedef struct {
    sint16 LowLimit;
    sint16 HighLimit;
} VitalLimits_t;

typedef struct {
    sint16 Value;
    uint8 Valid;
    uint8 AlarmLevel;
} VitalData_t;




void PatientCfg_Init(void);


void PatientCfg_LoadProfile(uint8 Copy_u8Profile);
uint8 PatientCfg_GetActiveProfile(void);


VitalLimits_t PatientCfg_GetLimits(uint8 Copy_u8VitalId);
void PatientCfg_SetLow (uint8 Copy_u8VitalId, sint16 Copy_s16Value);
void PatientCfg_SetHigh(uint8 Copy_u8VitalId, sint16 Copy_s16Value);


VitalData_t* PatientCfg_GetVital(uint8 Copy_u8VitalId);


void PatientCfg_EvalAlarms(void);


uint8 PatientCfg_GetHighestAlarm(void);
uint8 PatientCfg_GetAlarmSide(uint8 Copy_u8VitalId);
uint8 PatientCfg_GetAlarmPriority(uint8 Copy_u8VitalId);


const char* PatientCfg_VitalName(uint8 Copy_u8VitalId);
const char* PatientCfg_ProfileName(uint8 Copy_u8Profile);


sint16 PatientCfg_GetStep(uint8 Copy_u8VitalId);
# 19 "main.c" 2
# 1 "HAL/Panel/Panel_interface.h" 1
# 30 "HAL/Panel/Panel_interface.h"
void Panel_Init(void);





void Panel_Update(void);





uint8 Panel_IsPressed(uint8 Copy_u8Button);




uint8 Panel_IsSilenceActive(void);




uint8 Panel_HasEvent(void);
# 20 "main.c" 2
# 1 "Logic/monitor/monitor_fsm.h" 1



# 1 "Logic/monitor/../../LIB/STD_TYPES.h" 1
# 5 "Logic/monitor/monitor_fsm.h" 2

typedef enum {
    SYSTEM_STATE_INIT = 0,
    SYSTEM_STATE_STANDBY,
    SYSTEM_STATE_MONITORING,
    SYSTEM_STATE_ALARM,
    SYSTEM_STATE_SILENCED
} System_State_t;

void Monitor_Init(void);
void Monitor_Run(void);
void Monitor_ToggleStandby(void);
System_State_t Monitor_GetState(void);
uint32 Monitor_GetStandbyElapsedSec(void);
# 21 "main.c" 2
# 1 "Logic/console/console.h" 1
# 9 "Logic/console/console.h"
void CONSOLE_Init(void);





void CONSOLE_Task(void);
# 22 "main.c" 2
# 1 "Logic/menu.h" 1
# 29 "Logic/menu.h"
void Menu_Init(void);





void Menu_Update(void);




uint8 Menu_IsInDashboard(void);
# 23 "main.c" 2
# 1 "Logic/trends/trends.h" 1







typedef struct {
    uint16_t channels[4];
} TrendSample_t;

void Trends_Init(void);
void Task_Trend(void);
uint8_t Trends_GetCount(void);
void Trends_GetSampleLine(uint8_t index, char *dest);
# 24 "main.c" 2
# 1 "HAL/LCD_I2C/LCD_I2C_interface.h" 1
# 22 "HAL/LCD_I2C/LCD_I2C_interface.h"
STD_ReturnType LCD_I2C_Init(void);




STD_ReturnType LCD_I2C_Clear(void);




STD_ReturnType LCD_I2C_Home(void);




STD_ReturnType LCD_I2C_SetCursor(uint8 Copy_u8Row, uint8 Copy_u8Col);




STD_ReturnType LCD_I2C_WriteChar(uint8 Copy_u8Char);




STD_ReturnType LCD_I2C_WriteString(const char *Copy_pcStr);




STD_ReturnType LCD_I2C_WriteStringAt(uint8 Copy_u8Row, uint8 Copy_u8Col,
                                     const char *Copy_pcStr);




STD_ReturnType LCD_I2C_WriteNumber(sint16 Copy_s16Num);




STD_ReturnType LCD_I2C_BacklightOn(void);
STD_ReturnType LCD_I2C_BacklightOff(void);
# 25 "main.c" 2
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
# 26 "main.c" 2
# 1 "MCAL/UART/UART_interface.h" 1
# 20 "MCAL/UART/UART_interface.h"
STD_ReturnType UART_Init(uint32 Copy_u32BaudRate);




STD_ReturnType UART_SendByte(uint8 Copy_u8Data);




STD_ReturnType UART_ReceiveByte(uint8 *Copy_pu8Data);




STD_ReturnType UART_SendString(const uint8 *Copy_pu8String);





STD_ReturnType UART_IsDataReady(void);





STD_ReturnType UART_SetRxInterrupt(uint8 Copy_u8State);
STD_ReturnType UART_SetTxInterrupt(uint8 Copy_u8State);
# 27 "main.c" 2
# 42 "main.c"
static void Application_SelfTest(void)
{

  GPIO_SetPinValue(1u, 0u, 1u);
  GPIO_SetPinValue(1u, 1u, 1u);
  GPIO_SetPinValue(1u, 2u, 1u);
  GPIO_SetPinValue(1u, 3u, 1u);

  NurseCall_voidEnable();
  ShiftReg_voidWriteByte(0xFF);

  ANN_Audio_SetPriority(2U);

  UART_SendString((const uint8 *)"=== SYSTEM SELF-TEST ===\r\n");

  LCD_I2C_SetCursor(0, 0);
  LCD_I2C_WriteString("PATIENT MONITOR ");
  LCD_I2C_SetCursor(1, 0);
  LCD_I2C_WriteString("SELF-TEST...    ");


  _delay_ms(100);
  ANN_Audio_Mute();


  _delay_ms(200);


  GPIO_SetPinValue(1u, 0u, 0u);
  GPIO_SetPinValue(1u, 1u, 0u);
  GPIO_SetPinValue(1u, 2u, 0u);
  GPIO_SetPinValue(1u, 3u, 0u);

  NurseCall_voidDisable();
  ShiftReg_voidWriteByte(0x00);
  ANN_Audio_Init();
  ANN_Visual_Init();
  HRC_ClearAsystole();
  LCD_I2C_Clear();

  UART_SendString((const uint8 *)"PATIENT MONITOR READY\r\n");
}

static void Application_Init(void)
{

  GPIO_SetPinDirection(2u, 7u, 1u);
  GPIO_SetPinValue(2u, 7u, 0u);


  GPIO_SetPinDirection(3u, 7u, 1u);


  GPIO_SetPinDirection(3u, 2u, 2u);
  GPIO_SetPinDirection(3u, 3u, 2u);
  GPIO_SetPinDirection(3u, 5u, 2u);
  GPIO_SetPinDirection(3u, 6u, 0u);


  TIMER0_Init();
  HRC_Init();
  Vitals_Init();


  ShiftReg_voidInit();
  NurseCall_voidInit();
  ANN_Audio_Init();
  ANN_Visual_Init();


  Panel_Init();
  PatientCfg_Init();
  Monitor_Init();
  CONSOLE_Init();
  Trends_Init();


  I2C_InitMaster(100000UL);
  LCD_I2C_Init();
  Menu_Init();
  UART_Init(9600);


  Application_SelfTest();


  (void)INTERRUPT_EnableGlobal();
}

static volatile uint8 g_u8HeartbeatActive = 0U;

static void Process_Heartbeat(void)
{
  static uint8 s_u8PrevPD6 = 0U;
  static uint8 s_u8HbPulseTicks = 0U;
  static uint16 s_u16SilenceTicks = 0U;

  uint8 Local_u8CurrPD6 = 0U;
  GPIO_GetPinValue(3u, 6u, &Local_u8CurrPD6);


  if ((s_u8PrevPD6 == 0U) && (Local_u8CurrPD6 != 0U))
  {

    GPIO_SetPinValue(1u, 3u, 1u);
    s_u8HbPulseTicks = 5U;


    g_u8HeartbeatActive = 1U;
    HRC_ClearAsystole();
    s_u16SilenceTicks = 0U;
  }
  s_u8PrevPD6 = Local_u8CurrPD6;


  s_u16SilenceTicks++;
  if (s_u16SilenceTicks > 400U)
  {
    g_u8HeartbeatActive = 0U;
  }


  if (s_u8HbPulseTicks > 0U)
  {
    s_u8HbPulseTicks--;
    if (s_u8HbPulseTicks == 0U)
    {
      GPIO_SetPinValue(1u, 3u, 0u);
    }
  }
}


static void Task_Timers(void)
{

  if (Panel_IsPressed(0u))
  {
    Alarm_Acknowledge();
  }


  if (Panel_IsPressed(4u))
  {
    Monitor_ToggleStandby();
  }


  if (Menu_IsInDashboard() != 0U)
  {
    (void)Panel_IsPressed(2u);
    (void)Panel_IsPressed(3u);
  }
}

static void Task_Console(void)
{
  CONSOLE_Task();
}

static void Task_Alarms(void)
{
  Alarm_Process();
}

static void Task_Lcd(void)
{
  Menu_Update();
}

static void Task_FastVitals(void)
{
  Vitals_t rawVitals = {0};
  uint8 lead_off_pin = 1;
  uint8 probe_off_pin = 1;
  uint8 code_blue_pin = 1;

  GPIO_GetPinValue(3u, 3u, &lead_off_pin);
  GPIO_GetPinValue(3u, 5u, &probe_off_pin);
  GPIO_GetPinValue(3u, 2u, &code_blue_pin);

  uint8 lead_ok = (lead_off_pin != 0) ? 1 : 0;
  uint8 probe_ok = (probe_off_pin != 0) ? 1 : 0;
  uint8 code_blue_active = (code_blue_pin == 0) ? 1 : 0;

  if (Vitals_Read(&rawVitals) == E_OK)
  {



    uint16 hr = 0U;
    if (lead_ok && g_u8HeartbeatActive && (HRC_IsAsystole() == 0U))
    {
      uint16 hrc_val = HRC_GetBpm();
      if ((hrc_val != 0U) && (hrc_val > 0U))
      {
        hr = hrc_val;
      }
    }



    VitalData_t *v;
    v = PatientCfg_GetVital(0u);
    if (v) { v->Value = hr; v->Valid = (lead_ok && hr > 0U) ? 1U : 0U; }

    v = PatientCfg_GetVital(1u);
    if (v) { v->Value = rawVitals.spo2Pct; v->Valid = probe_ok; }

    v = PatientCfg_GetVital(2u);
    if (v) { v->Value = rawVitals.tempCx10; v->Valid = 1; }

    v = PatientCfg_GetVital(3u);
    if (v) { v->Value = rawVitals.respBpm; v->Valid = 1; }

    v = PatientCfg_GetVital(4u);
    if (v) { v->Value = rawVitals.nibpSys; v->Valid = 1; }

    PatientCfg_EvalAlarms();


    PatientVitals_t pVitals = {
      .heartRate = hr,
      .spO2 = rawVitals.spo2Pct,
      .respRate = rawVitals.respBpm,
      .tempC_x10 = rawVitals.tempCx10,
      .sysBP = rawVitals.nibpSys,
      .diaBP = rawVitals.nibpDia,
      .sensorConnected = probe_ok,
      .leadStatus = lead_ok,
      .codeBlue = code_blue_active
    };
    Alarm_UpdateVitals(&pVitals);
  }
}

static void Task_Report(void)
{
  char buf[64];
  VitalData_t *v_hr = PatientCfg_GetVital(0u);
  VitalData_t *v_spo2 = PatientCfg_GetVital(1u);
  VitalData_t *v_temp = PatientCfg_GetVital(2u);
  VitalData_t *v_rr = PatientCfg_GetVital(3u);
  VitalData_t *v_bp = PatientCfg_GetVital(4u);
  uint16 flags = Alarm_GetActiveFlags();

  int hr_val = (v_hr && v_hr->Valid) ? v_hr->Value : 0;
  int spo2_val = (v_spo2 && v_spo2->Valid) ? v_spo2->Value : 0;
  int temp_val = (v_temp && v_temp->Valid) ? v_temp->Value : 0;
  int rr_val = (v_rr && v_rr->Valid) ? v_rr->Value : 0;
  int bp_val = (v_bp && v_bp->Valid) ? v_bp->Value : 0;

  sprintf(buf, "!DAT,%d,%d,%d.%d,%d,%d,0x%04X\r\n",
          hr_val, spo2_val, temp_val / 10, 
# 295 "main.c" 3
                                          __builtin_abs(
# 295 "main.c"
                                          temp_val % 10
# 295 "main.c" 3
                                          )
# 295 "main.c"
                                                            ,
          rr_val, bp_val, flags);
  UART_SendString((const uint8 *)buf);
}

int main(void)
{
  uint16 Local_u16Phase = 0U;
  static uint8 s_u8LcdCooldown = 0U;

  Application_Init();


  HRC_ClearAsystole();
  TIMER0_ClearTick();
  (*(volatile uint8 *)0x58U) = 0xFF;


  Task_FastVitals();
  Task_Alarms();
  Task_Lcd();

  while (1)
  {






    uint8 Local_u8Tick = 1U;


    if (Local_u8Tick != 0U)
    {

      GPIO_SetPinValue(2u, 7u, 1u);


      Process_Heartbeat();


      if (TIMER1_IsCaptureReady() != 0U)
      {
        ANN_Visual_TriggerHeartbeat();
      }
      HRC_Process();


      Panel_Update();
      uint8 Local_u8BtnEvent = Panel_HasEvent();


      if ((Local_u16Phase % 2U) == 1U)
      {
        Task_Console();
      }


      if (((Local_u16Phase % 5U) == 2U) || (Local_u8BtnEvent != 0U))
      {
        Task_Timers();
      }


      if ((Local_u16Phase % 10U) == 3U)
      {
        Task_Alarms();
      }


      if (((Local_u16Phase % 25U) == 5U) || ((Local_u8BtnEvent != 0U) && (s_u8LcdCooldown == 0U)))
      {
        Task_Lcd();
        s_u8LcdCooldown = 5U;
      }
      if (s_u8LcdCooldown > 0U)
      {
        s_u8LcdCooldown--;
      }


      if ((Local_u16Phase % 50U) == 4U)
      {
        Task_FastVitals();
      }


      if ((Local_u16Phase % 200U) == 7U)
      {
        Task_Report();
      }


      if ((Local_u16Phase % 1000U) == 8U)
      {
        Task_Trend();
      }


      Monitor_Run();
      ANN_Audio_Tick();
      ANN_Visual_Tick();


      GPIO_SetPinValue(2u, 7u, 0u);




      _delay_ms(10);

      Local_u16Phase++;
      if (Local_u16Phase >= 1000U)
      {
        Local_u16Phase = 0U;
      }
    }

  }

  return 0;
}
