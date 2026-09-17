#ifndef TIMER_PRIVATE_H
#define TIMER_PRIVATE_H

#include "STD_TYPES.h"

#ifndef u8
typedef unsigned char u8;
#endif
#ifndef u16
typedef unsigned short int u16;
#endif
#ifndef u32
typedef unsigned long int u32;
#endif

#ifndef SET_BIT
#define SET_BIT(reg, bit) ((reg) |= (u8)(1U << (bit)))
#endif
#ifndef CLR_BIT
#define CLR_BIT(reg, bit) ((reg) &= (u8) ~(1U << (bit)))
#endif
#ifndef READ_BIT
#define READ_BIT(reg, bit) ((u8)(((reg) >> (bit)) & 1U))
#endif

/* ========================================================================= */
/*                              MCAL REGISTERS                               */
/* ========================================================================= */

/* Timer 0 Registers */
#define TIMER0_TCCR0 (*(volatile u8 *)0x53U)
#define TIMER0_TCNT0 (*(volatile u8 *)0x52U)
#define TIMER0_OCR0 (*(volatile u8 *)0x5CU)

/* Timer 1 Registers */
#define TIMER1_TCCR1A (*(volatile u8 *)0x4FU)
#define TIMER1_TCCR1B (*(volatile u8 *)0x4EU)
#define TIMER1_TCNT1L (*(volatile u8 *)0x4CU)
#define TIMER1_TCNT1H (*(volatile u8 *)0x4DU)
#define TIMER1_TCNT1 (*(volatile u16 *)0x4CU)
#define TIMER1_ICR1L (*(volatile u8 *)0x46U)
#define TIMER1_ICR1H (*(volatile u8 *)0x47U)
#define TIMER1_ICR1 (*(volatile u16 *)0x46U)

/* Timer 2 Registers */
#define TIMER2_TCCR2 (*(volatile u8 *)0x45U)
#define TIMER2_TCNT2 (*(volatile u8 *)0x44U)
#define TIMER2_OCR2 (*(volatile u8 *)0x43U)

/* Interrupt Mask & Flag Registers */
#define TIMER_TIMSK (*(volatile u8 *)0x59U)
#define TIMER_TIFR (*(volatile u8 *)0x58U)

/* GPIO Port D (For OC2 output direction and pin toggle) */
#define TIMER_DDRD (*(volatile u8 *)0x31U)
#define TIMER_PORTD (*(volatile u8 *)0x32U)
#define TIMER_OCIE2 7U

/* ========================================================================= */
/*                              BIT DEFINITIONS                              */
/* ========================================================================= */

/* Timer 0 Bits */
#define TIMER0_WGM01 3U
#define TIMER0_CS02 2U
#define TIMER0_CS00 0U
#define TIMER_OCIE0 1U

/* Timer 1 Bits */
#define TIMER1_ICES1 6U
#define TIMER1_ICNC1 7U
#define TIMER1_CS12 2U
#define TIMER1_CS11 1U
#define TIMER1_CS10 0U
#define TIMER1_TICIE1 5U
#define TIMER1_TOIE1 2U
#define TIMER1_ICF1 5U /* In TIFR */
#define TIMER1_TOV1 2U /* In TIFR */
/* Timer 2 Bits */
#define TIMER2_WGM21 3U
#define TIMER2_COM20 4U
#define TIMER2_CS22 2U
#define TIMER2_CS21 1U
#define TIMER2_CS20 0U
#define TIMER_OC2_PD7 7U

/* Buffer & Logic Limits */
#define TIMER1_CAPTURE_RING_SIZE 8U
#define TIMER1_ASYSTOLE_OVF_LIMIT 2U

#endif /* TIMER_PRIVATE_H */