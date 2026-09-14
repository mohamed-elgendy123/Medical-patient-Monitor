#include "STD_TYPES.h"
#include "ADC_interface.h"
#include "vitals_interface.h"

STD_ReturnType Vitals_Init(void)
{
    /* Initialize ADC with AVCC reference voltage and prescaler 64 */
    return ADC_Init(ADC_REF_AVCC, ADC_PRESC_64);
}

STD_ReturnType Vitals_Read(Vitals_t *Copy_pstrVitals)
{
    if (Copy_pstrVitals == NULL)
    {
        return E_NOK;
    }

    uint16 Local_u16RawAdc = 0;

    /* 1. Read ADC0 (PA0) -> SpO2 (70 .. 100 %) */
    if (ADC_ReadChannel(ADC_CHANNEL_0, &Local_u16RawAdc) == E_OK)
    {
        if (Local_u16RawAdc == 0 || Local_u16RawAdc == 1023)
        {
            Copy_pstrVitals->SpO2_Status = VITALS_SENSOR_FAULT;
        }
        else
        {
            Copy_pstrVitals->SpO2_Status = VITALS_OK;
            Copy_pstrVitals->SpO2 = 70 + ((uint32)Local_u16RawAdc * 30) / 1023;
        }
    }

    /* 2. Read ADC1 (PA1) -> Body Temp (300 .. 450 = 30.0 .. 45.0 °C) */
    if (ADC_ReadChannel(ADC_CHANNEL_1, &Local_u16RawAdc) == E_OK)
    {
        if (Local_u16RawAdc == 0 || Local_u16RawAdc == 1023)
        {
            Copy_pstrVitals->Temp_Status = VITALS_SENSOR_FAULT;
        }
        else
        {
            Copy_pstrVitals->Temp_Status = VITALS_OK;
            Copy_pstrVitals->Temp_Cx10 = 300 + ((uint32)Local_u16RawAdc * 150) / 1023;
        }
    }

    /* 3. Read ADC2 (PA2) -> Systolic BP (50 .. 250 mmHg) & Diastolic BP (~2/3 Systolic) */
    if (ADC_ReadChannel(ADC_CHANNEL_2, &Local_u16RawAdc) == E_OK)
    {
        if (Local_u16RawAdc == 0 || Local_u16RawAdc == 1023)
        {
            Copy_pstrVitals->BP_Status = VITALS_SENSOR_FAULT;
        }
        else
        {
            Copy_pstrVitals->BP_Status = VITALS_OK;
            Copy_pstrVitals->SystolicBP = 50 + ((uint32)Local_u16RawAdc * 200) / 1023;
            Copy_pstrVitals->DiastolicBP = (Copy_pstrVitals->SystolicBP * 2) / 3;
        }
    }

    /* 4. Read ADC3 (PA3) -> Respiration Rate (0 .. 60 breaths/min) */
    if (ADC_ReadChannel(ADC_CHANNEL_3, &Local_u16RawAdc) == E_OK)
    {
        if (Local_u16RawAdc == 0 || Local_u16RawAdc == 1023)
        {
            Copy_pstrVitals->Resp_Status = VITALS_SENSOR_FAULT;
        }
        else
        {
            Copy_pstrVitals->Resp_Status = VITALS_OK;
            Copy_pstrVitals->RespirationRate = ((uint32)Local_u16RawAdc * 60) / 1023;
        }
    }

    return E_OK;
}