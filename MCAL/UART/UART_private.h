#ifndef UART_PRIVATE_H
#define UART_PRIVATE_H

/*
 * Author: Ahmed Ellamie
 * Email:  ahmed.ellamiee@gmail.com
 *
 * STUDENT TASK — UART private layer (ATmega32 USART)
 * Include this file ONLY from UART.c.
 *
 * What you must add here:
 * 1. Registers:
 *      UDR    0x2C    shared TX / RX data
 *      UCSRA  0x2B    RXC TXC UDRE FE DOR PE U2X MPCM
 *      UCSRB  0x2A    RXCIE TXCIE UDRIE RXEN TXEN UCSZ2 RXB8 TXB8
 *      UCSRC  0x40    URSEL UMSEL UPM1 UPM0 USBS UCSZ1 UCSZ0 UCPOL
 *      UBRRL  0x29
 *      UBRRH  0x40    same address as UCSRC — URSEL selects which one
 *
 * 2. Bit names you will poll:
 *      UDRE = 5 in UCSRA  (transmitter ready)
 *      RXC  = 7 in UCSRA  (byte received)
 *      RXEN = 4, TXEN = 3 in UCSRB
 *
 * 3. 8N1 in UCSRC (must set URSEL = 1 when writing UCSRC):
 *      URSEL=1, UMSEL=0 (async), UPM=00 (no parity), USBS=0 (1 stop),
 *      UCSZ1:0 = 11 (8-bit). UCSZ2 in UCSRB stays 0.
 *
 * 4. Baud helper:
 *      ubrr = (F_CPU / (16UL * baud)) - 1     // U2X = 0
 *      write UBRRH (URSEL=0) then UBRRL.
 *
 * 5. This project uses F_CPU 8000000UL unless you override it.
 */

/* TODO: map UDR, UCSRA, UCSRB, UCSRC, UBRRL, UBRRH and the bit names. */




/* ATmega32 USART Registers Addresses */
#define UDR       (*((volatile uint8*)0x2C))
#define UCSRA     (*((volatile uint8*)0x2B))
#define UCSRB     (*((volatile uint8*)0x2A))
#define UCSRC     (*((volatile uint8*)0x40))
#define UBRRH     (*((volatile uint8*)0x40))
#define UBRRL     (*((volatile uint8*)0x29))

/* UCSRA Bits */
#define RXC       7
#define TXC       6
#define UDRE      5

/* UCSRB Bits */
#define RXCIE     7
#define TXCIE     6
#define UDRIE     5
#define RXEN      4
#define TXEN      3

/* UCSRC Bits */
#define URSEL     7
#define UMSEL     6
#define UPM1      5
#define UPM0      4
#define USBS      3
#define UCSZ1     2
#define UCSZ0     1









#endif /* UART_PRIVATE_H */
