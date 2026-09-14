#ifndef HR_CAPTURE_PRIVATE_H
#define HR_CAPTURE_PRIVATE_H

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

#define HR_NUM 1875000UL
#define TIMER1_TICK_US 32U
#define HRV_WINDOW 8U
#define MEDIAN_WINDOW_SIZE 3U

#define ABS_DIFF(a, b) (((a) >= (b)) ? ((a) - (b)) : ((b) - (a)))

static u16 HRC_CalculateMedian(void);
static u16 HRC_CalculateHrvMs(void);

#endif /* HR_CAPTURE_PRIVATE_H */
