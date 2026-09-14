#ifndef HR_CAPTURE_INTERFACE_H
#define HR_CAPTURE_INTERFACE_H

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

#define HRC_INVALID_HR 0U
#define HRC_MIN_BPM 30U
#define HRC_MAX_BPM 250U

void HRC_Init(void);
void HRC_Process(void);
void HRC_OnCapture(u16 Copy_u16IntervalTicks);
void HRC_OnOverflow(void);
u16 HRC_GetBpm(void);
u16 HRC_GetHrvMs(void);
u8 HRC_IsAsystole(void);
void HRC_ClearAsystole(void);

#endif /* HR_CAPTURE_INTERFACE_H */
