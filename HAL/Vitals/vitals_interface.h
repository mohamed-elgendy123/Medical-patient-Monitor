#ifndef VITALS_INTERFACE_H
#define VITALS_INTERFACE_H

#include "STD_TYPES.h"

/* Sensor health status enum */
typedef enum {
    VITALS_OK = 0,
    VITALS_SENSOR_FAULT
} Vitals_StatusType;

/* Runtime vitals structure - strictly matching Data Dictionary (DB-01) */
typedef struct {
    uint16 hrBpm;         /* 0..250, 0 = no beat detected */
    uint16 hrvMs;         /* mean abs successive difference, ms */
    uint8  spo2Pct;       /* 70..100 % */
    uint16 tempCx10;      /* 300..450 (30.0 .. 45.0 °C) */
    uint8  nibpSys;       /* 50..250 mmHg */
    uint8  nibpDia;       /* derived, ~ 2/3 of systolic */
    uint8  respBpm;       /* 0..60 breaths/min */
    uint8  perfusionPct;  /* pulse strength */
    
    /* Hardware Flags */
    uint8  leadOff      : 1;
    uint8  probeOff     : 1;
    uint8  beatFlag     : 1; /* set for one tick on each beat */
    uint8  reserved     : 5;
    
    uint32 monitorSec;    /* seconds monitoring this patient */

    /* Sensor Statuses for fault detection */
    Vitals_StatusType spo2Status;
    Vitals_StatusType tempStatus;
    Vitals_StatusType bpStatus;
    Vitals_StatusType respStatus;
} Vitals_t;

/* Function Prototypes */
STD_ReturnType Vitals_Init(void);
STD_ReturnType Vitals_Read(Vitals_t *Copy_pstrVitals);

#endif /* VITALS_INTERFACE_H */