#ifndef ANNUNCIATOR_INTERFACE_H
#define ANNUNCIATOR_INTERFACE_H

#include "LIB/STD_TYPES.h"

#ifndef u8
#define u8 uint8
#endif
#ifndef u16
#define u16 uint16
#endif
#ifndef u32
#define u32 uint32
#endif

#define ANN_PRI_NONE 0U
#define ANN_PRI_LOW 1U
#define ANN_PRI_MEDIUM 2U
#define ANN_PRI_HIGH 3U

void ANN_Audio_Init(void);
void ANN_Audio_SetPriority(u8 Copy_u8Priority);
void ANN_Audio_Tick(void);
void ANN_Audio_Mute(void);
void ANN_Audio_Unmute(void);

#endif /* ANNUNCIATOR_INTERFACE_H */
