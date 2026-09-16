#include <avr/io.h>
#include "STD_TYPES.h"
#include "ADC_interface.h"
#include "GPIO_interface.h"
#include "vitals_interface.h"
#include "HR_Capture_interface.h"

STD_ReturnType Vitals_Init(void)
{
    /* Configure ADC Channels (PA0..PA3) as Inputs with NO pull-up */
    DDRA &= ~0x0Fu;
    PORTA &= ~0x0Fu;

    /* Configure Lead-Off (PD3) and Probe-Off (PD5) with internal pull-ups */
    DDRD &= ~((1u << 3) | (1u << 5));
    PORTD |= ((1u << 3) | (1u << 5));

    return ADC_Init(ADC_REF_AVCC, ADC_PRESC_64);
}

STD_ReturnType Vitals_Read(Vitals_t *Copy_pstrVitals)
{
    uint8 Local_u8LeadPin = GPIO_HIGH;
    uint8 Local_u8ProbePin = GPIO_HIGH;
    uint16 Local_u16RawAdc = 0;

    if (Copy_pstrVitals == NULL)
    {
        return E_NOK;
    }

    /* ----------------------------------------------------------
     * 1. Read Lead-Off (PD3) and Probe-Off (PD5) hardware pins.
     *    Active-low logic:
     *      Pin == 0 (LOW / GND)  -> Fault ACTIVE
     *      Pin != 0 (HIGH / 5 V) -> Normal Operation
     * ---------------------------------------------------------- */
    Local_u8LeadPin = (PIND & (1u << PD3)) ? GPIO_HIGH : GPIO_LOW;
    Local_u8ProbePin = (PIND & (1u << PD5)) ? GPIO_HIGH : GPIO_LOW;

    if (Local_u8LeadPin == GPIO_LOW)
    {
        Copy_pstrVitals->leadOff = 1U;
        Copy_pstrVitals->hrBpm = 0U;
    }
    else
    {
        Copy_pstrVitals->leadOff = 0U;
        Copy_pstrVitals->hrBpm = HRC_GetBpm();
    }

    if (Local_u8ProbePin == GPIO_LOW)
    {
        Copy_pstrVitals->probeOff = 1U;
    }
    else
    {
        Copy_pstrVitals->probeOff = 0U;
    }

    /* ----------------------------------------------------------
     * 2. Sample ADC Channels (PA0..PA3)
     * ---------------------------------------------------------- */

    /* ADC0 (PA0) -> SpO2 (70% ... 100%) */
    if (ADC_ReadChannel(ADC_CHANNEL_0, &Local_u16RawAdc) == E_OK)
    {
        if (Copy_pstrVitals->probeOff == 1U)
        {
            Copy_pstrVitals->spo2Pct = 0U;
            Copy_pstrVitals->spo2Status = VITALS_SENSOR_FAULT;
        }
        else
        {
            Copy_pstrVitals->spo2Pct = (uint8)(70U + ((uint32)Local_u16RawAdc * 30U) / 1023U);
            Copy_pstrVitals->spo2Status = VITALS_OK;
        }
    }
    else
    {
        Copy_pstrVitals->spo2Status = VITALS_SENSOR_FAULT;
    }

    /* ADC1 (PA1) -> Temperature (30.0 ... 45.0 °C -> 300 ... 450) */
    if (ADC_ReadChannel(ADC_CHANNEL_1, &Local_u16RawAdc) == E_OK)
    {
        Copy_pstrVitals->tempCx10 = (uint16)(300U + ((uint32)Local_u16RawAdc * 150U) / 1023U);
        Copy_pstrVitals->tempStatus = VITALS_OK;
    }
    else
    {
        Copy_pstrVitals->tempStatus = VITALS_SENSOR_FAULT;
    }

    /* ADC2 (PA2) -> NIBP (50 ... 250 mmHg) */
    if (ADC_ReadChannel(ADC_CHANNEL_2, &Local_u16RawAdc) == E_OK)
    {
        Copy_pstrVitals->nibpSys = (uint8)(50U + ((uint32)Local_u16RawAdc * 200U) / 1023U);
        Copy_pstrVitals->nibpDia = (uint8)((Copy_pstrVitals->nibpSys * 2U) / 3U);
        Copy_pstrVitals->bpStatus = VITALS_OK;
    }
    else
    {
        Copy_pstrVitals->bpStatus = VITALS_SENSOR_FAULT;
    }

    /* ADC3 (PA3) -> Respiration Rate (0 ... 60 BrPM) */
    if (ADC_ReadChannel(ADC_CHANNEL_3, &Local_u16RawAdc) == E_OK)
    {
        Copy_pstrVitals->respBpm = (uint8)(((uint32)Local_u16RawAdc * 60U) / 1023U);
        Copy_pstrVitals->respStatus = VITALS_OK;
    }
    else
    {
        Copy_pstrVitals->respStatus = VITALS_SENSOR_FAULT;
    }

    return E_OK;
}