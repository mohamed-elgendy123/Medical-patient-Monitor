#include "LIB/STD_TYPES.h"
#if defined(__has_include)
#if __has_include("LIB/BIT_MATH.h")
#include "LIB/BIT_MATH.h"
#endif
#endif
#include "MCAL/TIMER/TIMER_interface.h"
#include "HR_Capture_interface.h"
#include "HR_Capture_private.h"

static volatile u16 HRC_MedianIntervals[MEDIAN_WINDOW_SIZE];
static volatile u16 HRC_Intervals[HRV_WINDOW];
static volatile u8 HRC_MedianIndex;
static volatile u8 HRC_IntervalIndex;
static volatile u16 HRC_CurrentBpm;
static volatile u16 HRC_CurrentHrvMs;
static volatile u8 HRC_Asystole;

void HRC_Init(void)
{
    /* TODO: Implementation */
}

void HRC_Process(void)
{
    (void)HRC_CalculateMedian();
    (void)HRC_CalculateHrvMs();
    /* TODO: Implementation */
}

void HRC_OnCapture(u16 Copy_u16IntervalTicks)
{
    (void)Copy_u16IntervalTicks;
    /* TODO: Implementation */
}

void HRC_OnOverflow(void)
{
    /* TODO: Implementation */
}

u16 HRC_GetBpm(void)
{
    /* TODO: Implementation */
    return HRC_INVALID_HR;
}

u16 HRC_GetHrvMs(void)
{
    /* TODO: Implementation */
    return 0U;
}

u8 HRC_IsAsystole(void)
{
    /* TODO: Implementation */
    return 0U;
}

void HRC_ClearAsystole(void)
{
    /* TODO: Implementation */
}

static u16 HRC_CalculateMedian(void)
{
    /* TODO: Implementation */
    return HRC_INVALID_HR;
}

static u16 HRC_CalculateHrvMs(void)
{
    /* TODO: Implementation */
    return 0U;
}
