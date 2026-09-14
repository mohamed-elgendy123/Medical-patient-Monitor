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
    u8 Local_u8Index;

    HRC_MedianIndex = 0U;
    HRC_IntervalIndex = 0U;
    HRC_CurrentBpm = HRC_INVALID_HR;
    HRC_CurrentHrvMs = 0U;
    HRC_Asystole = 0U;

    for (Local_u8Index = 0U; Local_u8Index < MEDIAN_WINDOW_SIZE; Local_u8Index++)
    {
        HRC_MedianIntervals[Local_u8Index] = 0U;
    }

    for (Local_u8Index = 0U; Local_u8Index < HRV_WINDOW; Local_u8Index++)
    {
        HRC_Intervals[Local_u8Index] = 0U;
    }

    TIMER1_Init();
}

void HRC_Process(void)
{
    u8 Local_u8Index;

    if ((TIMER1_IsAsystole() != 0U) || (HRC_Asystole != 0U))
    {
        HRC_CurrentBpm = HRC_INVALID_HR;
        HRC_CurrentHrvMs = 0U;
        HRC_Asystole = 1U;
        return;
    }

    if (TIMER1_IsCaptureReady() != 0U)
    {
        for (Local_u8Index = 0U; Local_u8Index < HRV_WINDOW; Local_u8Index++)
        {
            HRC_OnCapture(TIMER1_GetInterval(Local_u8Index));
        }
        TIMER1_ClearCaptureFlag();
    }

    HRC_CurrentBpm = HRC_CalculateMedian();
    HRC_CurrentHrvMs = HRC_CalculateHrvMs();
}

void HRC_OnCapture(u16 Copy_u16IntervalTicks)
{
    if (Copy_u16IntervalTicks != 0U)
    {
        HRC_MedianIntervals[HRC_MedianIndex] = Copy_u16IntervalTicks;
        HRC_MedianIndex++;
        if (HRC_MedianIndex >= MEDIAN_WINDOW_SIZE)
        {
            HRC_MedianIndex = 0U;
        }

        HRC_Intervals[HRC_IntervalIndex] = Copy_u16IntervalTicks;
        HRC_IntervalIndex++;
        if (HRC_IntervalIndex >= HRV_WINDOW)
        {
            HRC_IntervalIndex = 0U;
        }

        HRC_Asystole = 0U;
    }
}

void HRC_OnOverflow(void)
{
    if (TIMER1_IsAsystole() != 0U)
    {
        HRC_Asystole = 1U;
        HRC_CurrentBpm = HRC_INVALID_HR;
    }
}

u16 HRC_GetBpm(void)
{
    return HRC_CurrentBpm;
}

u16 HRC_GetHrvMs(void)
{
    return HRC_CurrentHrvMs;
}

u8 HRC_IsAsystole(void)
{
    if ((TIMER1_IsAsystole() != 0U) || (HRC_Asystole != 0U))
    {
        return 1U;
    }
    else
    {
        return 0U;
    }
}

void HRC_ClearAsystole(void)
{
    HRC_Asystole = 0U;
    TIMER1_ClearAsystole();
}

static u16 HRC_CalculateMedian(void)
{
    u16 Local_u16Arr[MEDIAN_WINDOW_SIZE];
    u16 Local_u16LatestInterval = 0U;
    u16 Local_u16Bpm;
    u16 Local_u16Temp;
    u8 Local_u8Index;
    u8 Local_u8HasEmpty = 0U;

    for (Local_u8Index = 0U; Local_u8Index < MEDIAN_WINDOW_SIZE; Local_u8Index++)
    {
        Local_u16Arr[Local_u8Index] = HRC_MedianIntervals[Local_u8Index];
        if (Local_u16Arr[Local_u8Index] == 0U)
        {
            Local_u8HasEmpty = 1U;
        }
        else
        {
            Local_u16LatestInterval = Local_u16Arr[Local_u8Index];
        }
    }

    if (Local_u16LatestInterval == 0U)
    {
        return HRC_INVALID_HR;
    }

    if (Local_u8HasEmpty != 0U)
    {
        Local_u16Bpm = (u16)(HR_NUM / Local_u16LatestInterval);
    }
    else
    {
        if (Local_u16Arr[0] > Local_u16Arr[1])
        {
            Local_u16Temp = Local_u16Arr[0];
            Local_u16Arr[0] = Local_u16Arr[1];
            Local_u16Arr[1] = Local_u16Temp;
        }
        if (Local_u16Arr[1] > Local_u16Arr[2])
        {
            Local_u16Temp = Local_u16Arr[1];
            Local_u16Arr[1] = Local_u16Arr[2];
            Local_u16Arr[2] = Local_u16Temp;
        }
        if (Local_u16Arr[0] > Local_u16Arr[1])
        {
            Local_u16Temp = Local_u16Arr[0];
            Local_u16Arr[0] = Local_u16Arr[1];
            Local_u16Arr[1] = Local_u16Temp;
        }

        Local_u16Bpm = (u16)(HR_NUM / Local_u16Arr[1]);
    }

    if ((Local_u16Bpm < HRC_MIN_BPM) || (Local_u16Bpm > HRC_MAX_BPM))
    {
        return HRC_INVALID_HR;
    }

    return Local_u16Bpm;
}

static u16 HRC_CalculateHrvMs(void)
{
    u32 Local_u32DiffSum = 0UL;
    u32 Local_u32AverageDiff;
    u32 Local_u32HrvMs;
    u8 Local_u8Index;

    for (Local_u8Index = 1U; Local_u8Index < HRV_WINDOW; Local_u8Index++)
    {
        Local_u32DiffSum += ABS_DIFF(HRC_Intervals[Local_u8Index],
                                     HRC_Intervals[Local_u8Index - 1U]);
    }

    Local_u32AverageDiff = Local_u32DiffSum / 7UL;
    Local_u32HrvMs = (Local_u32AverageDiff * TIMER1_TICK_US) / 1000UL;

    if (Local_u32HrvMs > 65535UL)
    {
        return 65535U;
    }

    return (u16)Local_u32HrvMs;
}
