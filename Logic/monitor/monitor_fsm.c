#include "../../LIB/STD_TYPES.h"
#include "alarm_mgr.h"
#include "monitor_fsm.h"

static System_State_t g_current_state = SYSTEM_STATE_INIT;
static u16 g_init_ticks = 0;

void Monitor_Init(void) {
    g_current_state = SYSTEM_STATE_INIT;
    g_init_ticks = 0;
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
            if (current_priority != ALARM_PRIO_NONE) {
                g_current_state = SYSTEM_STATE_ALARM;
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
            /* If user presses acknowledge/silence button */
            // Note: Add condition if silence is triggered externally
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

System_State_t Monitor_GetState(void) {
    return g_current_state;
}