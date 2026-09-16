#ifndef NURSECALL_INTERFACE_H
#define NURSECALL_INTERFACE_H


#include "../../LIB/STD_TYPES.h"

/* Initialize PD4 as output and set it LOW */
void NurseCall_voidInit(void);

/* Enable Nurse Call Output (PD4 HIGH) */
void NurseCall_voidEnable(void);

/* Disable Nurse Call Output (PD4 LOW) */
void NurseCall_voidDisable(void);

#endif /* NURSECALL_INTERFACE_H */