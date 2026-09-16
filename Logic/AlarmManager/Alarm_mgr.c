#include "Alarm_mgr.h"
#include "../../HAL/Annunciator/Annunciator_interface.h"
#include "../../HAL/NurseCall/NurseCall_interface.h"
#include "../../HAL/ShiftReg/ShiftReg_interface.h"
static PatientVitals_t g_currentVitals;
static u32 g_activeAlarmFlags = 0;
static Alarm_Priority_t g_highestPriority = ALARM_PRIO_NONE;
static u8 g_alarmSilenced = 0;

#define HR_CRIT_HIGH      150
#define HR_CRIT_LOW       40
#define HR_WARN_HIGH      120
#define HR_WARN_LOW       50
#define SPO2_CRIT_LOW     85
#define SPO2_WARN_LOW     90
#define RR_CRIT_HIGH      35
#define RR_CRIT_LOW       8
#define TEMP_WARN_HIGH    385
#define TEMP_WARN_LOW     350
#define SYS_BP_WARN_HIGH  140
#define SYS_BP_WARN_LOW   90

void Alarm_Init(void) {
    g_activeAlarmFlags = 0;
    g_highestPriority = ALARM_PRIO_NONE;
    g_alarmSilenced = 0;
    
    ANN_Visual_Init();
    NurseCall_voidInit();
    ShiftReg_Init();
}

void Alarm_UpdateVitals(const PatientVitals_t* vitals) {
    if (vitals != ((void*)0)) {
        g_currentVitals = *vitals;
    }
}

void Alarm_Process(void) {
    u32 flags = 0;
    
    if (g_currentVitals.heartRate == 0) flags |= (1UL << ALARM_ASYSTOLE);
    if (g_currentVitals.heartRate > HR_CRIT_HIGH) flags |= (1UL << ALARM_HR_CRIT_HIGH);
    if (g_currentVitals.heartRate > 0 && g_currentVitals.heartRate < HR_CRIT_LOW) flags |= (1UL << ALARM_HR_CRIT_LOW);
    if (g_currentVitals.spO2 > 0 && g_currentVitals.spO2 < SPO2_CRIT_LOW) flags |= (1UL << ALARM_SPO2_CRIT_LOW);
    if (g_currentVitals.respRate > RR_CRIT_HIGH) flags |= (1UL << ALARM_RR_CRIT_HIGH);
    if (g_currentVitals.respRate > 0 && g_currentVitals.respRate < RR_CRIT_LOW) flags |= (1UL << ALARM_RR_CRIT_LOW);

    if (g_currentVitals.heartRate > HR_WARN_HIGH && g_currentVitals.heartRate <= HR_CRIT_HIGH) flags |= (1UL << ALARM_HR_WARN_HIGH);
    if (g_currentVitals.heartRate >= HR_CRIT_LOW && g_currentVitals.heartRate < HR_WARN_LOW) flags |= (1UL << ALARM_HR_WARN_LOW);
    if (g_currentVitals.spO2 >= SPO2_CRIT_LOW && g_currentVitals.spO2 < SPO2_WARN_LOW) flags |= (1UL << ALARM_SPO2_WARN_LOW);
    if (g_currentVitals.tempC_x10 > TEMP_WARN_HIGH) flags |= (1UL << ALARM_TEMP_HIGH);
    if (g_currentVitals.tempC_x10 > 0 && g_currentVitals.tempC_x10 < TEMP_WARN_LOW) flags |= (1UL << ALARM_TEMP_LOW);
    if (g_currentVitals.sysBP > SYS_BP_WARN_HIGH) flags |= (1UL << ALARM_BP_HIGH);
    if (g_currentVitals.sysBP > 0 && g_currentVitals.sysBP < SYS_BP_WARN_LOW) flags |= (1UL << ALARM_BP_LOW);

    if (g_currentVitals.sensorConnected == 0) flags |= (1UL << ALARM_SENSOR_DISCONNECT);
    if (g_currentVitals.leadStatus == 0) flags |= (1UL << ALARM_LEAD_OFF);

    g_activeAlarmFlags = flags;

    if (flags & 0x007F) {
        g_highestPriority = ALARM_PRIO_HIGH;
    } else if (flags & 0x3F80) {
        g_highestPriority = ALARM_PRIO_MEDIUM;
    } else if (flags & 0x1C000) {
        g_highestPriority = ALARM_PRIO_LOW;
    } else {
        g_highestPriority = ALARM_PRIO_NONE;
    }

    if (g_alarmSilenced && g_highestPriority != ALARM_PRIO_HIGH) {
        ANN_Visual_SetPriority(ANN_PRI_NONE);
        NurseCall_voidDisable();
    } else {
        if (g_highestPriority == ALARM_PRIO_HIGH) {
            g_alarmSilenced = 0;
            NurseCall_voidEnable();
        } else {
            NurseCall_voidDisable();
        }

        switch (g_highestPriority) {
            case ALARM_PRIO_HIGH:   ANN_Visual_SetPriority(ANN_PRI_HIGH); break;
            case ALARM_PRIO_MEDIUM: ANN_Visual_SetPriority(ANN_PRI_MEDIUM); break;
            case ALARM_PRIO_LOW:    ANN_Visual_SetPriority(ANN_PRI_LOW); break;
            default:                ANN_Visual_SetPriority(ANN_PRI_NONE); break;
        }
    }

    ShiftReg_Write((u8)(flags & 0xFF));
}

Alarm_Priority_t Alarm_GetActivePriority(void) { return g_highestPriority; }
u16 Alarm_GetActiveFlags(void) { return (u16)(g_activeAlarmFlags & 0xFFFF); }
void Alarm_Acknowledge(void) { g_alarmSilenced = 1; }