# 0 "HAL/Vitals/vitals.c"
# 0 "<built-in>"
# 0 "<command-line>"
# 1 "HAL/Vitals/vitals.c"
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
# 2 "HAL/Vitals/vitals.c" 2
# 1 "MCAL/ADC/ADC_interface.h" 1
# 46 "MCAL/ADC/ADC_interface.h"
STD_ReturnType ADC_Init(uint8 Copy_u8Ref, uint8 Copy_u8Prescaler);





STD_ReturnType ADC_ReadChannel(uint8 Copy_u8Channel, uint16 *Copy_pu16Reading);




STD_ReturnType ADC_StartConversion(uint8 Copy_u8Channel);





STD_ReturnType ADC_GetResult(uint16 *Copy_pu16Reading);





STD_ReturnType ADC_SetInterrupt(uint8 Copy_u8State);
# 3 "HAL/Vitals/vitals.c" 2
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
# 4 "HAL/Vitals/vitals.c" 2

STD_ReturnType Vitals_Init(void)
{
    return ADC_Init(1u, 6u);
}

STD_ReturnType Vitals_Read(Vitals_t *Copy_pstrVitals)
{
    if (Copy_pstrVitals == ((void *)0))
    {
        return E_NOK;
    }

    uint16 Local_u16RawAdc = 0;


    if (ADC_ReadChannel(0u, &Local_u16RawAdc) == E_OK)
    {
        Copy_pstrVitals->spo2Pct = (uint8)(70 + ((uint32)Local_u16RawAdc * 30) / 1023);
        Copy_pstrVitals->spo2Status = VITALS_OK;
    }


    if (ADC_ReadChannel(1u, &Local_u16RawAdc) == E_OK)
    {
        Copy_pstrVitals->tempCx10 = (uint16)(300 + ((uint32)Local_u16RawAdc * 150) / 1023);
        Copy_pstrVitals->tempStatus = VITALS_OK;
    }


    if (ADC_ReadChannel(2u, &Local_u16RawAdc) == E_OK)
    {
        Copy_pstrVitals->nibpSys = (uint8)(50 + ((uint32)Local_u16RawAdc * 200) / 1023);
        Copy_pstrVitals->nibpDia = (uint8)((Copy_pstrVitals->nibpSys * 2) / 3);
        Copy_pstrVitals->bpStatus = VITALS_OK;
    }


    if (ADC_ReadChannel(3u, &Local_u16RawAdc) == E_OK)
    {
        Copy_pstrVitals->respBpm = (uint8)(((uint32)Local_u16RawAdc * 60) / 1023);
        Copy_pstrVitals->respStatus = VITALS_OK;
    }

    return E_OK;
}
