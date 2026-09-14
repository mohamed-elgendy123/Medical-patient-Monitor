#ifndef VITALS_INTERFACE_H
#define VITALS_INTERFACE_H

#include "STD_TYPES.h"

/* Sensor status enum */
typedef enum {
    VITALS_OK = 0,
    VITALS_SENSOR_FAULT
} Vitals_StatusType;

/* Structure for all 5 patient vital readings */
typedef struct {
    uint8  HeartRate;       /* Calculated from pulse train (Digital/Timer) */
    uint8  SpO2;            /* ADC0: Range 70 .. 100 % */
    uint16 Temp_Cx10;       /* ADC1: Range 300 .. 450 (30.0 .. 45.0 °C) */
    uint16 SystolicBP;      /* ADC2: Range 50 .. 250 mmHg */
    uint16 DiastolicBP;     /* Derived: ~ 2/3 of Systolic */
    uint8  RespirationRate; /* ADC3: Range 0 .. 60 breaths/min */

    /* Sensor Health Statuses */
    Vitals_StatusType SpO2_Status;
    Vitals_StatusType Temp_Status;
    Vitals_StatusType BP_Status;
    Vitals_StatusType Resp_Status;
} Vitals_t;

/* Function Prototypes */
STD_ReturnType Vitals_Init(void);
STD_ReturnType Vitals_Read(Vitals_t *Copy_pstrVitals);

#endif /* VITALS_INTERFACE_H */