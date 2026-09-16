#ifndef PATIENT_CFG_H
#define PATIENT_CFG_H

/*
 * Logic — Patient configuration: vital signs, alarm limits, age-profile presets.
 *
 * Vitals are identified by index.  Temperature is stored as °C × 10
 * (e.g. 365 = 36.5 °C) so one decimal place is available without floats.
 *
 * Sensor drivers set Value and Valid through PatientCfg_GetVital().
 * The menu / alarm modules read limits and evaluate alarms.
 */

#include "STD_TYPES.h"

/* -------------------- Vital-sign identifiers -------------------- */
#define VITAL_HR      0u   /* Heart Rate          (bpm)           */
#define VITAL_SPO2    1u   /* Oxygen Saturation   (%)             */
#define VITAL_TEMP    2u   /* Temperature          (°C × 10)      */
#define VITAL_RR      3u   /* Respiratory Rate    (breaths / min) */
#define VITAL_NIBP    4u   /* NIBP Systolic       (mmHg)          */
#define VITAL_COUNT   5u

/* -------------------- Age-profile presets -------------------- */
#define PROFILE_ADULT   0u
#define PROFILE_PAED    1u
#define PROFILE_NEO     2u
#define PROFILE_COUNT   3u

/* -------------------- Alarm severity -------------------- */
#define ALARM_NONE    0u
#define ALARM_HIGH    1u

/* -------------------- Data types -------------------- */
typedef struct {
    sint16 LowLimit;
    sint16 HighLimit;
} VitalLimits_t;

typedef struct {
    sint16 Value;       /* Current reading  (TEMP uses °C × 10)        */
    uint8  Valid;       /* 1 = sensor connected,  0 = disconnected     */
    uint8  AlarmLevel;  /* ALARM_NONE or ALARM_HIGH                    */
} VitalData_t;

/* -------------------- Functions -------------------- */

/* Call once at startup — loads Adult profile and zeros all vitals */
void            PatientCfg_Init(void);

/* Load a preset into the current limits (Adult / Paed / Neonatal) */
void            PatientCfg_LoadProfile(uint8 Copy_u8Profile);
uint8           PatientCfg_GetActiveProfile(void);

/* Per-vital limit access */
VitalLimits_t   PatientCfg_GetLimits(uint8 Copy_u8VitalId);
void            PatientCfg_SetLow (uint8 Copy_u8VitalId, sint16 Copy_s16Value);
void            PatientCfg_SetHigh(uint8 Copy_u8VitalId, sint16 Copy_s16Value);

/* Vital-data access — sensor drivers write Value & Valid through pointer */
VitalData_t*    PatientCfg_GetVital(uint8 Copy_u8VitalId);

/* Compare every valid vital against its limits, set AlarmLevel */
void            PatientCfg_EvalAlarms(void);

/* Return the vital-ID with the highest active alarm, or VITAL_COUNT if none */
uint8           PatientCfg_GetHighestAlarm(void);

/* Short display names — returns pointer to RAM string ("HR", "SpO2", …) */
const char*     PatientCfg_VitalName(uint8 Copy_u8VitalId);
const char*     PatientCfg_ProfileName(uint8 Copy_u8Profile);

/* Step size used by menu Up/Down for each vital */
sint16          PatientCfg_GetStep(uint8 Copy_u8VitalId);

#endif /* PATIENT_CFG_H */
