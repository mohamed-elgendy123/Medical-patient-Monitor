

/*
 * Author: Ahmed Ellamie
 * Email:  ahmed.ellamiee@gmail.com
 *
 * STUDENT TASK — GPIO private layer (ATmega32)
 * Include this file ONLY from GPIO.c. Never from main, HAL, or Logic.
 *
 * What you must add here:
 * 1. Register-address macros for every port (volatile uint8 pointers):
 *      DDRA  0x3A    PORTA  0x3B    PINA  0x39
 *      DDRB  0x37    PORTB  0x38    PINB  0x36
 *      DDRC  0x34    PORTC  0x35    PINC  0x33
 *      DDRD  0x31    PORTD  0x32    PIND  0x30
 *    Example shape:
 *      #define GPIO_DDRA   (*(volatile uint8 *)0x3A)
 *
 * 2. Optional helper macros used only by GPIO.c
 *      - pin mask: (1u << pin)
 *      - max pin index 7, max port index 3
 *
 * 3. Do NOT put public #defines such as GPIO_PORTA here — those belong
 *    in GPIO_interface.h so the application can see them.
 */


/* GPIO_PRIVATE_H */
#ifndef GPIO_PRIVATE_H
#define GPIO_PRIVATE_H

#include "../../LIB/STD_TYPES.h"

/* Hardware Registers Addresses */
#define GPIO_PORTA_REG    (*(volatile uint8 *)0x3B)
#define GPIO_DDRA_REG     (*(volatile uint8 *)0x3A)
#define GPIO_PINA_REG     (*(volatile uint8 *)0x39)

#define GPIO_PORTB_REG    (*(volatile uint8 *)0x38)
#define GPIO_DDRB_REG     (*(volatile uint8 *)0x37)
#define GPIO_PINB_REG     (*(volatile uint8 *)0x36)

#define GPIO_PORTC_REG    (*(volatile uint8 *)0x35)
#define GPIO_DDRC_REG     (*(volatile uint8 *)0x34)
#define GPIO_PINC_REG     (*(volatile uint8 *)0x33)

#define GPIO_PORTD_REG    (*(volatile uint8 *)0x32)
#define GPIO_DDRD_REG     (*(volatile uint8 *)0x31)
#define GPIO_PIND_REG     (*(volatile uint8 *)0x30)

#endif /* GPIO_PRIVATE_H */
