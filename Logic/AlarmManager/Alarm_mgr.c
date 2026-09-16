#include "Alarm_mgr.h"
#include "../../HAL/Annunciator/Annunciator_interface.h"
#include "../../HAL/NurseCall/NurseCall_interface.h"
#include "../../HAL/ShiftReg/ShiftReg_interface.h"
static PatientVitals_t g_currentVitals;
static u32 g_activeAlarmFlags = 0;
static Alarm_Priority_t g_highestPriority = ALARM_PRIO_NONE;
static u8 g_alarmSilenced = 0;

#define HR_CRIT_HIGH 150
#define HR_CRIT_LOW 40
#define HR_WARN_HIGH 120
#define HR_WARN_LOW 50
#define SPO2_CRIT_LOW 85
#define SPO2_WARN_LOW 90
#define RR_CRIT_HIGH 35
#define RR_CRIT_LOW 8
#define TEMP_WARN_HIGH 385
#define TEMP_WARN_LOW 350
#define SYS_BP_WARN_HIGH 140
#define SYS_BP_WARN_LOW 90

void Alarm_Init(void)
{
    g_activeAlarmFlags = 0;
    g_highestPriority = ALARM_PRIO_NONE;
    g_alarmSilenced = 0;

    ANN_Visual_Init();
    NurseCall_voidInit();
    ShiftReg_voidInit();
}

void Alarm_UpdateVitals(const PatientVitals_t *vitals)
{
    if (vitals != ((void *)0))
    {
        g_currentVitals = *vitals;
    }
}

void Alarm_Process(void)
{
    u32 flags = 0;

    /* ----------------------------------------------------------
     * Technical-alarm checks (lead-off / sensor-disconnect).
     *
     * sensorConnected == 0  -> probe is physically off (PD5 LOW)
     * leadStatus      == 0  -> ECG lead is physically off (PD3 LOW)
     * ---------------------------------------------------------- */
    if (g_currentVitals.sensorConnected == 0)
        flags |= (1UL << ALARM_SENSOR_DISCONNECT);
    if (g_currentVitals.leadStatus == 0)
        flags |= (1UL << ALARM_LEAD_OFF);

    /* ----------------------------------------------------------
     * Physiological-alarm checks.
     * Per FR-10: Physiological alarms for a channel MUST BE SUSPENDED
     * while that channel's sensor is disconnected.
     * ---------------------------------------------------------- */
    if (g_currentVitals.leadStatus != 0)
    {
        if (g_currentVitals.heartRate == 0)
            flags |= (1UL << ALARM_ASYSTOLE);
        else if (g_currentVitals.heartRate > HR_CRIT_HIGH)
            flags |= (1UL << ALARM_HR_CRIT_HIGH);
        else if (g_currentVitals.heartRate < HR_CRIT_LOW)
            flags |= (1UL << ALARM_HR_CRIT_LOW);
        else if (g_currentVitals.heartRate > HR_WARN_HIGH)
            flags |= (1UL << ALARM_HR_WARN_HIGH);
        else if (g_currentVitals.heartRate < HR_WARN_LOW)
            flags |= (1UL << ALARM_HR_WARN_LOW);
    }

    if (g_currentVitals.sensorConnected != 0)
    {
        if (g_currentVitals.spO2 > 0 && g_currentVitals.spO2 < SPO2_CRIT_LOW)
            flags |= (1UL << ALARM_SPO2_CRIT_LOW);
        else if (g_currentVitals.spO2 >= SPO2_CRIT_LOW && g_currentVitals.spO2 < SPO2_WARN_LOW)
            flags |= (1UL << ALARM_SPO2_WARN_LOW);
    }

    if (g_currentVitals.respRate > RR_CRIT_HIGH)
        flags |= (1UL << ALARM_RR_CRIT_HIGH);
    else if (g_currentVitals.respRate > 0 && g_currentVitals.respRate < RR_CRIT_LOW)
        flags |= (1UL << ALARM_RR_CRIT_LOW);

    if (g_currentVitals.tempC_x10 > TEMP_WARN_HIGH)
        flags |= (1UL << ALARM_TEMP_HIGH);
    else if (g_currentVitals.tempC_x10 > 0 && g_currentVitals.tempC_x10 < TEMP_WARN_LOW)
        flags |= (1UL << ALARM_TEMP_LOW);

    if (g_currentVitals.sysBP > SYS_BP_WARN_HIGH)
        flags |= (1UL << ALARM_BP_HIGH);
    else if (g_currentVitals.sysBP > 0 && g_currentVitals.sysBP < SYS_BP_WARN_LOW)
        flags |= (1UL << ALARM_BP_LOW);

    g_activeAlarmFlags = flags;

    /* Determine highest active priority tier */
    if (flags & 0x007F)
    {
        g_highestPriority = ALARM_PRIO_HIGH;
    }
    else if (flags & 0xFF80)
    {
        g_highestPriority = ALARM_PRIO_MEDIUM;
    }
    else if (flags & 0x10000)
    {
        g_highestPriority = ALARM_PRIO_LOW;
    }
    else
    {
        g_highestPriority = ALARM_PRIO_NONE;
    }

    if (g_highestPriority == ALARM_PRIO_HIGH)
    {
        g_alarmSilenced = 0;
        NurseCall_voidEnable();
    }
    else
    {
        NurseCall_voidDisable();
    }

<<<<<<< HEAD
    /* Visual LEDs always reflect highest active alarm (IEC 60601-1-8 / TC-26) */
    ANN_Visual_SetPriority((u8)g_highestPriority);

    /* Audio is muted if silenced; otherwise sounds priority tone */
    if ((g_alarmSilenced != 0) || (g_highestPriority == ALARM_PRIO_NONE))
    {
        ANN_Audio_SetPriority(ANN_PRI_NONE);
    }
    else
    {
        ANN_Audio_SetPriority((u8)g_highestPriority);
    }

    /* Shift register 8-LED bar: bits 0..5 physiological, bit 6 Lead-Off, bit 7 Probe-Off */
    u8 shiftByte = (u8)(flags & 0xFF);
    if (flags & (1UL << ALARM_LEAD_OFF))          shiftByte |= (1u << 6);
    if (flags & (1UL << ALARM_SENSOR_DISCONNECT)) shiftByte |= (1u << 7);
    ShiftReg_voidWriteByte(shiftByte);
=======
    ShiftReg_voidWriteByte((uint8)(flags & 0xFF));
>>>>>>> d9c22b66226e0b37b25c4d23605075309880d886
}

Alarm_Priority_t Alarm_GetActivePriority(void) { return g_highestPriority; }
u16 Alarm_GetActiveFlags(void) { return (u16)(g_activeAlarmFlags & 0xFFFF); }
void Alarm_Acknowledge(void) { g_alarmSilenced = 1; }