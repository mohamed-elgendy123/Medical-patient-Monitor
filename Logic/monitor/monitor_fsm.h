#ifndef MONITOR_FSM_H
#define MONITOR_FSM_H

#include "../../LIB/STD_TYPES.h"

typedef enum {
    SYSTEM_STATE_INIT = 0,
    SYSTEM_STATE_STANDBY,
    SYSTEM_STATE_MONITORING,
    SYSTEM_STATE_ALARM,
    SYSTEM_STATE_SILENCED
} System_State_t;

void Monitor_Init(void);
void Monitor_Run(void);
System_State_t Monitor_GetState(void);

#endif /* MONITOR_FSM_H */