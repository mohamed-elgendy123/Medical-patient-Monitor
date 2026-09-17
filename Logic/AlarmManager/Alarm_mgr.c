#include "Alarm_mgr.h"
#include "monitor_fsm.h"
#include "../../HAL/Annunciator/Annunciator_interface.h"
#include "../../HAL/NurseCall/NurseCall_interface.h"
#include "../../HAL/ShiftReg/ShiftReg_interface.h"
static PatientVitals_t g_currentVitals;
static u32 g_activeAlarmFlags = 0;
static Alarm_Priority_t g_highestPriority = ALARM_PRIO_NONE;
static u8 g_alarmSilenced = 0;
static u8 g_nurseCallAck = 0;
static u32 g_prevHighFlags = 0;

#define HIGH_PRIO_MASK    0x239FUL
#define MED_PRIO_MASK     0xDC60UL
#define LOW_PRIO_MASK     0x10000UL

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
    g_nurseCallAck = 0;
    g_prevHighFlags = 0;
    
    ANN_Visual_Init();
    NurseCall_voidInit();
    ShiftReg_voidInit();
}

void Alarm_UpdateVitals(const PatientVitals_t* vitals) {
    if (vitals != ((void*)0)) {
        g_currentVitals = *vitals;
    }
}

void Alarm_Process(void) {
    u32 flags = 0;
    
    /* Physiological alarms are suspended during Standby (FR-16 / TC-49) */
    if (Monitor_GetState() != SYSTEM_STATE_STANDBY) {
        /* Physiological HR / Asystole: only if Lead is connected */
        if (g_currentVitals.leadStatus != 0) {
            if (g_currentVitals.heartRate == 0) flags |= (1UL << ALARM_ASYSTOLE);
            if (g_currentVitals.heartRate > HR_CRIT_HIGH) flags |= (1UL << ALARM_HR_CRIT_HIGH);
            if (g_currentVitals.heartRate > 0 && g_currentVitals.heartRate < HR_CRIT_LOW) flags |= (1UL << ALARM_HR_CRIT_LOW);
            if (g_currentVitals.heartRate > HR_WARN_HIGH && g_currentVitals.heartRate <= HR_CRIT_HIGH) flags |= (1UL << ALARM_HR_WARN_HIGH);
            if (g_currentVitals.heartRate >= HR_CRIT_LOW && g_currentVitals.heartRate < HR_WARN_LOW) flags |= (1UL << ALARM_HR_WARN_LOW);
        }

        /* Physiological SpO2: only if Probe is connected */
        if (g_currentVitals.sensorConnected != 0) {
            if (g_currentVitals.spO2 > 0 && g_currentVitals.spO2 < SPO2_CRIT_LOW) flags |= (1UL << ALARM_SPO2_CRIT_LOW);
            if (g_currentVitals.spO2 >= SPO2_CRIT_LOW && g_currentVitals.spO2 < SPO2_WARN_LOW) flags |= (1UL << ALARM_SPO2_WARN_LOW);
        }

        if (g_currentVitals.respRate > RR_CRIT_HIGH) flags |= (1UL << ALARM_RR_CRIT_HIGH);
        if (g_currentVitals.respRate > 0 && g_currentVitals.respRate < RR_CRIT_LOW) flags |= (1UL << ALARM_RR_CRIT_LOW);

        if (g_currentVitals.tempC_x10 > TEMP_WARN_HIGH) flags |= (1UL << ALARM_TEMP_HIGH);
        if (g_currentVitals.tempC_x10 > 0 && g_currentVitals.tempC_x10 < TEMP_WARN_LOW) flags |= (1UL << ALARM_TEMP_LOW);
        if (g_currentVitals.sysBP > SYS_BP_WARN_HIGH) flags |= (1UL << ALARM_BP_HIGH);
        if (g_currentVitals.sysBP > 0 && g_currentVitals.sysBP < SYS_BP_WARN_LOW) flags |= (1UL << ALARM_BP_LOW);
    }

    /* Technical Alarms (Remain active during standby per FR-16 / TC-51) */
    if (g_currentVitals.sensorConnected == 0) flags |= (1UL << ALARM_SENSOR_DISCONNECT);
    if (g_currentVitals.leadStatus == 0) flags |= (1UL << ALARM_LEAD_OFF);

    /* Code Blue (Manual High Priority Alarm) */
    if (g_currentVitals.codeBlue != 0) {
        flags |= (1UL << ALARM_VFIB_VTAC);
    }

    g_activeAlarmFlags = flags;

    /* Priority arbitration per README §9.3 & §11.2 */
    if (flags & HIGH_PRIO_MASK) {
        g_highestPriority = ALARM_PRIO_HIGH;
    } else if (flags & MED_PRIO_MASK) {
        g_highestPriority = ALARM_PRIO_MEDIUM;
    } else if (flags & LOW_PRIO_MASK) {
        g_highestPriority = ALARM_PRIO_LOW;
    } else {
        g_highestPriority = ALARM_PRIO_NONE;
    }

    /* Track new high-priority alarm conditions (README §9.2 Rule 5) */
    u32 currentHighFlags = (flags & HIGH_PRIO_MASK);
    if ((currentHighFlags & ~g_prevHighFlags) != 0) {
        /* A new high-priority alarm occurred -> break silence & require new ack */
        g_alarmSilenced = 0;
        g_nurseCallAck  = 0;
    }

    /* Nurse Call (README FR-12 & §11.3):
     * Asserted while any high-priority alarm is active and unacknowledged.
     * Released within 1 s of acknowledgement or clearing (TC-43, TC-45). */
    if ((currentHighFlags != 0) && (g_nurseCallAck == 0)) {
        NurseCall_voidEnable();
    } else {
        NurseCall_voidDisable();
        if (currentHighFlags == 0) {
            g_nurseCallAck = 0;
        }
    }
    g_prevHighFlags = currentHighFlags;

    /* Drive Visual Annunciator */
    switch (g_highestPriority) {
        case ALARM_PRIO_HIGH:   ANN_Visual_SetPriority(ANN_PRI_HIGH); break;
        case ALARM_PRIO_MEDIUM: ANN_Visual_SetPriority(ANN_PRI_MEDIUM); break;
        case ALARM_PRIO_LOW:    ANN_Visual_SetPriority(ANN_PRI_LOW); break;
        default:                ANN_Visual_SetPriority(ANN_PRI_NONE); break;
    }

    /* Drive Audio Annunciator */
    if (g_alarmSilenced) {
        ANN_Audio_SetPriority(ANN_PRI_NONE);
    } else {
        switch (g_highestPriority) {
            case ALARM_PRIO_HIGH:   ANN_Audio_SetPriority(ANN_PRI_HIGH); break;
            case ALARM_PRIO_MEDIUM: ANN_Audio_SetPriority(ANN_PRI_MEDIUM); break;
            case ALARM_PRIO_LOW:    ANN_Audio_SetPriority(ANN_PRI_LOW); break;
            default:                ANN_Audio_SetPriority(ANN_PRI_NONE); break;
        }
    }

    /* Update Shift Register 8-LED Bar */
    uint8 shiftVal = (uint8)(flags & 0xFF) | (uint8)((flags >> 8) & 0xFF);
    if (g_currentVitals.leadStatus != 0 && g_currentVitals.heartRate > 0) {
        shiftVal |= 0x01; /* Pulse/QRS active */
    }
    ShiftReg_voidWriteByte(shiftVal);
}

Alarm_Priority_t Alarm_GetActivePriority(void) { return g_highestPriority; }
u16 Alarm_GetActiveFlags(void) { return (u16)(g_activeAlarmFlags & 0xFFFF); }
void Alarm_Acknowledge(void) {
    g_alarmSilenced = 1;
    g_nurseCallAck  = 1;
    NurseCall_voidDisable();
}