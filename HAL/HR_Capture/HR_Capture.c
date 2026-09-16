#include "LIB/STD_TYPES.h"
#if defined(__has_include)
#if __has_include("LIB/BIT_MATH.h")
#include "LIB/BIT_MATH.h"
#endif
#endif
#include "MCAL/TIMER/TIMER_interface.h"
#include "HR_Capture_interface.h"
#include "HR_Capture_private.h"

#ifndef HRC_INVALID_HR
#define HRC_INVALID_HR 0U
#endif

#ifndef HRC_MIN_BPM
#define HRC_MIN_BPM 30U
#endif

#ifndef HRC_MAX_BPM
#define HRC_MAX_BPM 250U
#endif

#ifndef MEDIAN_WINDOW_SIZE
#define MEDIAN_WINDOW_SIZE 3U
#endif

#ifndef HRV_WINDOW
#define HRV_WINDOW 8U
#endif

/* 8MHz Clock / 256 Prescaler = 31,250 Ticks/sec -> (60 * 31250) = 1,875,000 */
#ifndef HR_NUM
#define HR_NUM 1875000UL
#endif

#ifndef TIMER1_TICK_US
#define TIMER1_TICK_US 32UL
#endif

#ifndef ABS_DIFF
#define ABS_DIFF(a, b) (((a) > (b)) ? ((a) - (b)) : ((b) - (a)))
#endif

static volatile u16 HRC_MedianIntervals[MEDIAN_WINDOW_SIZE];
static volatile u16 HRC_Intervals[HRV_WINDOW];
static volatile u8 HRC_MedianIndex;
static volatile u8 HRC_MedianCount;
static volatile u8 HRC_IntervalIndex;
static volatile u16 HRC_CurrentBpm;
static volatile u16 HRC_CurrentHrvMs;
static volatile u8 HRC_Asystole;
static volatile u16 HRC_LastRawInterval;

static u16 HRC_CalculateMedian(void);
static u16 HRC_CalculateHrvMs(void);

void HRC_Init(void)
{
    u8 Local_u8Index;

    HRC_MedianIndex = 0U;
    HRC_MedianCount = 0U;
    HRC_IntervalIndex = 0U;
    HRC_CurrentBpm = HRC_INVALID_HR;
    HRC_CurrentHrvMs = 0U;
    HRC_Asystole = 0U;
    HRC_LastRawInterval = 0U;

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
    /* 1. استهلاك أي فاصل زمني ملتقط من المولد أولاً لإلغاء التوقف */
    if (TIMER1_IsCaptureReady() != 0U)
    {
        u16 Local_u16Interval = TIMER1_GetLastInterval();
        if (Local_u16Interval > 0U)
        {
            HRC_OnCapture(Local_u16Interval);
        }
        TIMER1_ClearCaptureFlag();
    }

    /* 2. التحقق من حالة توقف القلب */
    if (TIMER1_IsAsystole() != 0U)
    {
        HRC_Asystole = 1U;
        HRC_CurrentBpm = 0U;
        HRC_CurrentHrvMs = 0U;
        return;
    }

    /* 3. Compute Heart Rate: Median filter first, fallback to last interval while accumulating */
    u16 Local_u16Bpm = HRC_CalculateMedian();
    if ((Local_u16Bpm == HRC_INVALID_HR) && (HRC_LastRawInterval > 0U))
    {
        u32 Local_u32DirectBpm = HR_NUM / (u32)HRC_LastRawInterval;
        if ((Local_u32DirectBpm >= HRC_MIN_BPM) && (Local_u32DirectBpm <= HRC_MAX_BPM))
        {
            Local_u16Bpm = (u16)Local_u32DirectBpm;
        }
    }

    HRC_CurrentBpm = Local_u16Bpm;
    HRC_CurrentHrvMs = HRC_CalculateHrvMs();
}

void HRC_OnCapture(u16 Copy_u16IntervalTicks)
{
    if (Copy_u16IntervalTicks != 0U)
    {
        HRC_LastRawInterval = Copy_u16IntervalTicks;

        HRC_MedianIntervals[HRC_MedianIndex] = Copy_u16IntervalTicks;
        HRC_MedianIndex++;
        if (HRC_MedianIndex >= MEDIAN_WINDOW_SIZE)
        {
            HRC_MedianIndex = 0U;
        }
        if (HRC_MedianCount < MEDIAN_WINDOW_SIZE)
        {
            HRC_MedianCount++;
        }

        HRC_Intervals[HRC_IntervalIndex] = Copy_u16IntervalTicks;
        HRC_IntervalIndex++;
        if (HRC_IntervalIndex >= HRV_WINDOW)
        {
            HRC_IntervalIndex = 0U;
        }

        /* إلغاء راية توقف القلب فور وصول النبضة وتصفير راية التايمر */
        HRC_Asystole = 0U;
        TIMER1_ClearAsystole();
    }
}

void HRC_OnOverflow(void)
{
    if (TIMER1_IsAsystole() != 0U)
    {
        HRC_Asystole = 1U;
        HRC_CurrentBpm = 0U;
    }
}

u16 HRC_GetBpm(void)
{
    return HRC_CurrentBpm;
}

u16 HRC_GetRate(void)
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
    return 0U;
}

void HRC_ClearAsystole(void)
{
    HRC_Asystole = 0U;
    TIMER1_ClearAsystole();
}

static u16 HRC_CalculateMedian(void)
{
    u16 Local_u16Arr[3];
    u16 Local_u16Temp;

    Local_u16Arr[0] = HRC_MedianIntervals[0];
    Local_u16Arr[1] = HRC_MedianIntervals[1];
    Local_u16Arr[2] = HRC_MedianIntervals[2];

    if ((HRC_MedianCount < MEDIAN_WINDOW_SIZE) ||
        (Local_u16Arr[0] == 0U) || (Local_u16Arr[1] == 0U) || (Local_u16Arr[2] == 0U))
    {
        return HRC_INVALID_HR;
    }

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

    u16 Local_u16Median = Local_u16Arr[1];
    if (Local_u16Median == 0U)
    {
        return HRC_INVALID_HR;
    }

    u32 Local_u32Bpm = HR_NUM / (u32)Local_u16Median;

    if ((Local_u32Bpm < HRC_MIN_BPM) || (Local_u32Bpm > HRC_MAX_BPM))
    {
        return HRC_INVALID_HR;
    }

    return (u16)Local_u32Bpm;
}

static u16 HRC_CalculateHrvMs(void)
{
    u32 Local_u32DiffSum = 0UL;
    u32 Local_u32AverageDiff;
    u32 Local_u32HrvMs;
    u8 Local_u8Index;

    for (Local_u8Index = 1U; Local_u8Index < HRV_WINDOW; Local_u8Index++)
    {
        if ((HRC_Intervals[Local_u8Index] == 0U) ||
            (HRC_Intervals[Local_u8Index - 1U] == 0U))
        {
            return 0U;
        }
        Local_u32DiffSum += ABS_DIFF(HRC_Intervals[Local_u8Index],
                                     HRC_Intervals[Local_u8Index - 1U]);
    }

    Local_u32AverageDiff = Local_u32DiffSum / (u32)(HRV_WINDOW - 1U);
    Local_u32HrvMs = (Local_u32AverageDiff * TIMER1_TICK_US) / 1000UL;

    if (Local_u32HrvMs > 65535UL)
    {
        return 65535U;
    }

    return (u16)Local_u32HrvMs;
}