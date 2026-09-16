/*
 * Author: Ahmed Ellamie
 * Email:  ahmed.ellamiee@gmail.com
 *
 * STUDENT TASK — ADC.c  (ATmega32, 10-bit)
 * Implement every prototype from ADC_interface.h.
 */

#include "STD_TYPES.h"
#include "ADC_interface.h"
#include "ADC_private.h"

#ifndef F_CPU
#define F_CPU 8000000UL
#endif
#include <util/delay.h>

/*
 * ADC_Init
 * 1. Reject an unknown reference or prescaler.
 * 2. Write REFS1:0 (and ADLAR = 0 for right adjust) in ADMUX.
 * 3. Write ADPS2:0, then set ADEN.
 * 4. Target ADC clock 50..200 kHz (8 MHz / 64 = 125 kHz).
 */
STD_ReturnType ADC_Init(uint8 Copy_u8Ref, uint8 Copy_u8Prescaler)
{
    if (Copy_u8Ref != ADC_REF_AVCC || Copy_u8Prescaler != ADC_PRESC_64)
    {
        return E_NOK;
    }

    ADC_ADMUX = (1u << REFS0);
    ADC_ADCSRA = (1u << ADEN) | (1u << ADPS2) | (1u << ADPS1);

    return E_OK;
}

/*
 * ADC_ReadChannel
 * 1. Reject Channel > 7 or a NULL pointer.
 * 2. Keep REFS bits, replace MUX4:0 with the channel.
 * 3. Settle analog multiplexer capacitor.
 * 4. Clear ADIF, set ADSC, poll ADIF until conversion completes.
 * 5. Read ADCL first, then ADCH strictly.
 */
STD_ReturnType ADC_ReadChannel(uint8 Copy_u8Channel, uint16 *Copy_pu16Reading)
{
    uint32 Local_u32Timeout = 50000UL;
    uint8 Local_u8Low = 0;
    uint8 Local_u8High = 0;

    if (Copy_u8Channel > ADC_CHANNEL_7 || Copy_pu16Reading == NULL)
    {
        return E_NOK;
    }

    /* 1. Select channel safely while keeping REFS bits intact */
    ADC_ADMUX = (ADC_ADMUX & 0xE0u) | (Copy_u8Channel & 0x07u);

    /* 2. Settling delay for analog multiplexer capacitor to charge */
    _delay_us(10);

    /* 3. Clear ADIF flag before starting conversion (writing 1 clears it) */
    ADC_ADCSRA |= (1u << ADIF);

    /* 4. Start conversion (Set ADSC) */
    ADC_ADCSRA |= (1u << ADSC);

    /* 5. Poll ADIF until conversion ends or timeout occurs */
    while (!(ADC_ADCSRA & (1u << ADIF)) && (Local_u32Timeout > 0UL))
    {
        Local_u32Timeout--;
    }

    if (Local_u32Timeout == 0UL)
    {
        return E_NOK;
    }

    /* 6. Clear ADIF flag by writing 1 to it */
    ADC_ADCSRA |= (1u << ADIF);

    /* 7. Read ADCL FIRST, then ADCH to prevent hardware lock */
    Local_u8Low = ADC_ADCL;
    Local_u8High = ADC_ADCH;
    *Copy_pu16Reading = (uint16)Local_u8Low | ((uint16)Local_u8High << 8);

    return E_OK;
}

/*
 * ADC_StartConversion
 * 1. Select the channel safely.
 * 2. Set ADSC and return. Used when the result will be read later or in an ISR.
 */
STD_ReturnType ADC_StartConversion(uint8 Copy_u8Channel)
{
    /* Reject invalid channel */
    if (Copy_u8Channel > ADC_CHANNEL_7)
    {
        return E_NOK;
    }

    /* 1. Select channel safely */
    ADC_ADMUX = (ADC_ADMUX & 0xE0u) | (Copy_u8Channel & 0x07u);

    /* 2. Start conversion (Set ADSC) */
    ADC_ADCSRA |= (1u << ADSC);

    return E_OK;
}

/*
 * ADC_GetResult
 * 1. If ADIF is 0, return E_NOK (still busy).
 * 2. Clear ADIF, read ADCL then ADCH, store the 10-bit value.
 */
STD_ReturnType ADC_GetResult(uint16 *Copy_pu16Reading)
{
    uint8 Local_u8Low = 0;
    uint8 Local_u8High = 0;

    if (Copy_pu16Reading == NULL)
    {
        return E_NOK;
    }

    /* Check if ADIF flag is set (Conversion Complete) */
    if (ADC_ADCSRA & (1u << ADIF))
    {
        /* Clear ADIF flag by writing 1 to it */
        ADC_ADCSRA |= (1u << ADIF);

        /* Read ADCL FIRST, then ADCH */
        Local_u8Low = ADC_ADCL;
        Local_u8High = ADC_ADCH;
        *Copy_pu16Reading = (uint16)Local_u8Low | ((uint16)Local_u8High << 8);

        return E_OK;
    }

    /* Return E_NOK if conversion is still running */
    return E_NOK;
}

/*
 * ADC_SetInterrupt
 * 1. Copy_u8State == 1 -> set ADIE.  == 0 -> clear ADIE.
 * 2. The ISR vector is ADC_vect. Do not write the ISR in this file unless asked.
 */
STD_ReturnType ADC_SetInterrupt(uint8 Copy_u8State)
{
    if (Copy_u8State == 1u)
    {
        /* Enable ADC Interrupt (Set ADIE) */
        ADC_ADCSRA |= (1u << ADIE);
    }
    else if (Copy_u8State == 0u)
    {
        /* Disable ADC Interrupt (Clear ADIE) */
        ADC_ADCSRA &= ~(1u << ADIE);
    }
    else
    {
        return E_NOK; /* Invalid state */
    }

    return E_OK;
}