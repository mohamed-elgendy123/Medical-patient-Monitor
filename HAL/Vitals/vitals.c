#include "STD_TYPES.h"
#include "ADC_interface.h"
#include "vitals_interface.h"

STD_ReturnType Vitals_Init(void)
{
    return ADC_Init(ADC_REF_AVCC, ADC_PRESC_64);
}

STD_ReturnType Vitals_Read(Vitals_t *Copy_pstrVitals)
{
    if (Copy_pstrVitals == NULL)
    {
        return E_NOK;
    }

    uint16 Local_u16RawAdc = 0;

    /* 1. ADC0 (PA0) -> SpO2 */
    if (ADC_ReadChannel(ADC_CHANNEL_0, &Local_u16RawAdc) == E_OK)
    {
        if (Local_u16RawAdc == 0 || Local_u16RawAdc == 1023)
        {
            Copy_pstrVitals->spo2Status = VITALS_SENSOR_FAULT;
        }
        else
        {
            Copy_pstrVitals->spo2Status = VITALS_OK;
            Copy_pstrVitals->spo2Pct = (uint8)(70 + ((uint32)Local_u16RawAdc * 30) / 1023);
        }
    }

    /* 2. ADC1 (PA1) -> Temperature (30.0 .. 45.0 °C stored x10) */
    if (ADC_ReadChannel(ADC_CHANNEL_1, &Local_u16RawAdc) == E_OK)
    {
        if (Local_u16RawAdc == 0 || Local_u16RawAdc == 1023)
        {
            Copy_pstrVitals->tempStatus = VITALS_SENSOR_FAULT;
        }
        else
        {
            Copy_pstrVitals->tempStatus = VITALS_OK;
            Copy_pstrVitals->tempCx10 = (uint16)(300 + ((uint32)Local_u16RawAdc * 150) / 1023);
        }
    }

    /* 3. ADC2 (PA2) -> Systolic & Diastolic BP */
    if (ADC_ReadChannel(ADC_CHANNEL_2, &Local_u16RawAdc) == E_OK)
    {
        if (Local_u16RawAdc == 0 || Local_u16RawAdc == 1023)
        {
            Copy_pstrVitals->bpStatus = VITALS_SENSOR_FAULT;
        }
        else
        {
            Copy_pstrVitals->bpStatus = VITALS_OK;
            Copy_pstrVitals->nibpSys = (uint8)(50 + ((uint32)Local_u16RawAdc * 200) / 1023);
            Copy_pstrVitals->nibpDia = (uint8)((Copy_pstrVitals->nibpSys * 2) / 3);
        }
    }

    /* 4. ADC3 (PA3) -> Respiration Rate */
    if (ADC_ReadChannel(ADC_CHANNEL_3, &Local_u16RawAdc) == E_OK)
    {
        if (Local_u16RawAdc == 0 || Local_u16RawAdc == 1023)
        {
            Copy_pstrVitals->respStatus = VITALS_SENSOR_FAULT;
        }
        else
        {
            Copy_pstrVitals->respStatus = VITALS_OK;
            Copy_pstrVitals->respBpm = (uint8)(((uint32)Local_u16RawAdc * 60) / 1023);
        }
    }

    return E_OK;
}