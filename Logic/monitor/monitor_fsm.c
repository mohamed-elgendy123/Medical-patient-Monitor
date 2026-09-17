#include "../../LIB/STD_TYPES.h"
#include "Alarm_mgr.h"
#include "monitor_fsm.h"
#include "MCAL/TIMER/TIMER_interface.h"

static System_State_t g_current_state = SYSTEM_STATE_INIT;
static u16 g_init_ticks = 0;
static uint32 g_u32StandbySec = 0U;
static uint16 g_u16StandbyTicks = 0U;
static uint16 g_u16ChirpTicks = 0U;

void Monitor_Init(void) {
    g_current_state = SYSTEM_STATE_INIT;
    g_init_ticks = 0;
    g_u32StandbySec = 0U;
    g_u16StandbyTicks = 0U;
    g_u16ChirpTicks = 0U;
    Alarm_Init();
}

void Monitor_Run(void) {
    Alarm_Priority_t current_priority = Alarm_GetActivePriority();

    switch (g_current_state) {
        case SYSTEM_STATE_INIT:
            /* Self-test or startup delay simulation (e.g., 2 seconds) */
            g_init_ticks++;
            if (g_init_ticks >= 200) { /* Assuming 10ms cycle -> 200 ticks = 2 sec */
                g_current_state = SYSTEM_STATE_MONITORING;
            }
            break;

        case SYSTEM_STATE_STANDBY:
            /* FR-16: Track elapsed standby time & 60s reminder chirp */
            g_u16StandbyTicks++;
            if (g_u16StandbyTicks >= 100U) { /* 100 ticks x 10ms = 1 sec */
                g_u16StandbyTicks = 0U;
                g_u32StandbySec++;

                /* Reminder chirp every 60 s while in standby (TC-50 / FR-16) */
                if ((g_u32StandbySec > 0U) && ((g_u32StandbySec % 60U) == 0U)) {
                    g_u16ChirpTicks = 15U; /* 150 ms chirp */
                    TIMER2_SetTone(TIMER2_TONE_LOW);
                }
            }

            if (g_u16ChirpTicks > 0U) {
                g_u16ChirpTicks--;
                if (g_u16ChirpTicks == 0U) {
                    TIMER2_SetTone(TIMER2_TONE_MUTE);
                }
            }
            break;

        case SYSTEM_STATE_MONITORING:
            Alarm_Process();
            if (current_priority != ALARM_PRIO_NONE) {
                g_current_state = SYSTEM_STATE_ALARM;
            }
            break;

        case SYSTEM_STATE_ALARM:
            Alarm_Process();
            if (current_priority == ALARM_PRIO_NONE) {
                g_current_state = SYSTEM_STATE_MONITORING;
            }
            break;

        case SYSTEM_STATE_SILENCED:
            Alarm_Process();
            if (current_priority == ALARM_PRIO_NONE) {
                g_current_state = SYSTEM_STATE_MONITORING;
            }
            break;

        default:
            g_current_state = SYSTEM_STATE_MONITORING;
            break;
    }
}

void Monitor_ToggleStandby(void) {
    if (g_current_state == SYSTEM_STATE_STANDBY) {
        g_current_state = SYSTEM_STATE_MONITORING;
        g_u32StandbySec = 0U;
        g_u16StandbyTicks = 0U;
        g_u16ChirpTicks = 0U;
        TIMER2_SetTone(TIMER2_TONE_MUTE);
        Alarm_Process(); /* Clear any pending alarm timers */
    } else if (g_current_state != SYSTEM_STATE_INIT) {
        g_current_state = SYSTEM_STATE_STANDBY;
        g_u32StandbySec = 0U;
        g_u16StandbyTicks = 0U;
        g_u16ChirpTicks = 0U;
        TIMER2_SetTone(TIMER2_TONE_MUTE);
        Alarm_Process(); /* Immediately suspend physiological alarms */
    }
}

System_State_t Monitor_GetState(void) {
    return g_current_state;
}

uint32 Monitor_GetStandbyElapsedSec(void) {
    return g_u32StandbySec;
}