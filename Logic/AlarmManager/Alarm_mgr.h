#ifndef ALARM_MGR_H_
#define ALARM_MGR_H_

#include "../../LIB/STD_TYPES.h"

/* Define u8, u16, u32 aliases */
typedef uint8  u8;
typedef uint16 u16;
typedef uint32 u32;

typedef enum {
    ALARM_PRIO_NONE = 0,
    ALARM_PRIO_LOW,
    ALARM_PRIO_MEDIUM,
    ALARM_PRIO_HIGH
} Alarm_Priority_t;

typedef enum {
    ALARM_ASYSTOLE = 0,
    ALARM_VFIB_VTAC,
    ALARM_HR_CRIT_HIGH,
    ALARM_HR_CRIT_LOW,
    ALARM_SPO2_CRIT_LOW,
    ALARM_RR_CRIT_HIGH,
    ALARM_RR_CRIT_LOW,
    ALARM_HR_WARN_HIGH,
    ALARM_HR_WARN_LOW,
    ALARM_SPO2_WARN_LOW,
    ALARM_TEMP_HIGH,
    ALARM_TEMP_LOW,
    ALARM_BP_HIGH,
    ALARM_BP_LOW,
    ALARM_SENSOR_DISCONNECT,
    ALARM_LEAD_OFF,
    ALARM_BATTERY_LOW,
    ALARM_COUNT
} Alarm_ID_t;

typedef struct {
    u16 heartRate;
    u8  spO2;
    u8  respRate;
    u16 tempC_x10;
    u16 sysBP;
    u16 diaBP;
    u8  sensorConnected;
    u8  leadStatus;
    u8  codeBlue;
} PatientVitals_t;

void Alarm_Init(void);
void Alarm_UpdateVitals(const PatientVitals_t* vitals);
void Alarm_Process(void);
Alarm_Priority_t Alarm_GetActivePriority(void);
u16  Alarm_GetActiveFlags(void);
void Alarm_Acknowledge(void);

#endif