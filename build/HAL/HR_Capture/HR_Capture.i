# 0 "HAL/HR_Capture/HR_Capture.c"
# 0 "<built-in>"
# 0 "<command-line>"
# 1 "HAL/HR_Capture/HR_Capture.c"
# 1 "./LIB/STD_TYPES.h" 1
# 13 "./LIB/STD_TYPES.h"
typedef unsigned char uint8;
typedef unsigned short uint16;
typedef unsigned long uint32;
typedef signed char sint8;
typedef signed short sint16;
typedef signed long sint32;

typedef unsigned char uint8_h;

typedef enum
{
    E_OK = 0,
    E_NOK = 1,
    E_PORT_Not_valid = 2,
    E_PIN_Not_valid = 3,
} STD_ReturnType;
# 2 "HAL/HR_Capture/HR_Capture.c" 2





# 1 "./MCAL/TIMER/TIMER_interface.h" 1



# 1 "LIB/STD_TYPES.h" 1
# 5 "./MCAL/TIMER/TIMER_interface.h" 2

typedef void (*TIMER_CallbackType)(void);






void TIMER0_Init(void);
void TIMER0_SetCallback(TIMER_CallbackType Copy_pvCallback);
uint8 TIMER0_IsTickPending(void);
void TIMER0_ClearTick(void);

void TIMER1_Init(void);
uint8 TIMER1_IsCaptureReady(void);
void TIMER1_ClearCaptureFlag(void);
uint16 TIMER1_GetInterval(uint8 Copy_u8Index);
uint8 TIMER1_IsAsystole(void);
void TIMER1_ClearAsystole(void);

void TIMER2_Init(void);
void TIMER2_SetTone(uint8 Copy_u8Tone);
# 8 "HAL/HR_Capture/HR_Capture.c" 2
# 1 "HAL/HR_Capture/HR_Capture_interface.h" 1
# 20 "HAL/HR_Capture/HR_Capture_interface.h"
void HRC_Init(void);
void HRC_Process(void);
void HRC_OnCapture(uint16 Copy_u16IntervalTicks);
void HRC_OnOverflow(void);
uint16 HRC_GetBpm(void);
uint16 HRC_GetHrvMs(void);
uint8 HRC_IsAsystole(void);
void HRC_ClearAsystole(void);
# 9 "HAL/HR_Capture/HR_Capture.c" 2
# 1 "HAL/HR_Capture/HR_Capture_private.h" 1
# 23 "HAL/HR_Capture/HR_Capture_private.h"
static uint16 HRC_CalculateMedian(void);
static uint16 HRC_CalculateHrvMs(void);
# 10 "HAL/HR_Capture/HR_Capture.c" 2

static volatile uint16 HRC_MedianIntervals[3U];
static volatile uint16 HRC_Intervals[8U];
static volatile uint8 HRC_MedianIndex;
static volatile uint8 HRC_IntervalIndex;
static volatile uint16 HRC_CurrentBpm;
static volatile uint16 HRC_CurrentHrvMs;
static volatile uint8 HRC_Asystole;

void HRC_Init(void)
{
    uint8 Local_u8Index;

    HRC_MedianIndex = 0U;
    HRC_IntervalIndex = 0U;
    HRC_CurrentBpm = 0U;
    HRC_CurrentHrvMs = 0U;
    HRC_Asystole = 0U;

    for (Local_u8Index = 0U; Local_u8Index < 3U; Local_u8Index++)
    {
        HRC_MedianIntervals[Local_u8Index] = 0U;
    }

    for (Local_u8Index = 0U; Local_u8Index < 8U; Local_u8Index++)
    {
        HRC_Intervals[Local_u8Index] = 0U;
    }

    TIMER1_Init();
}

void HRC_Process(void)
{
    uint8 Local_u8Index;

    if ((TIMER1_IsAsystole() != 0U) || (HRC_Asystole != 0U))
    {
        HRC_CurrentBpm = 0U;
        HRC_CurrentHrvMs = 0U;
        HRC_Asystole = 1U;
        return;
    }

    if (TIMER1_IsCaptureReady() != 0U)
    {
        for (Local_u8Index = 0U; Local_u8Index < 8U; Local_u8Index++)
        {
            HRC_OnCapture(TIMER1_GetInterval(Local_u8Index));
        }
        TIMER1_ClearCaptureFlag();
    }

    HRC_CurrentBpm = HRC_CalculateMedian();
    HRC_CurrentHrvMs = HRC_CalculateHrvMs();
}

void HRC_OnCapture(uint16 Copy_u16IntervalTicks)
{
    if (Copy_u16IntervalTicks != 0U)
    {
        HRC_MedianIntervals[HRC_MedianIndex] = Copy_u16IntervalTicks;
        HRC_MedianIndex++;
        if (HRC_MedianIndex >= 3U)
        {
            HRC_MedianIndex = 0U;
        }

        HRC_Intervals[HRC_IntervalIndex] = Copy_u16IntervalTicks;
        HRC_IntervalIndex++;
        if (HRC_IntervalIndex >= 8U)
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
        HRC_CurrentBpm = 0U;
    }
}

uint16 HRC_GetBpm(void)
{
    return HRC_CurrentBpm;
}

uint16 HRC_GetHrvMs(void)
{
    return HRC_CurrentHrvMs;
}

uint8 HRC_IsAsystole(void)
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

static uint16 HRC_CalculateMedian(void)
{
    uint16 Local_u16Arr[3U];
    uint16 Local_u16LatestInterval = 0U;
    uint16 Local_u16Bpm;
    uint16 Local_u16Temp;
    uint8 Local_u8Index;
    uint8 Local_u8HasEmpty = 0U;

    for (Local_u8Index = 0U; Local_u8Index < 3U; Local_u8Index++)
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
        return 0U;
    }

    if (Local_u8HasEmpty != 0U)
    {
        Local_u16Bpm = (uint16)(1875000UL / Local_u16LatestInterval);
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

        Local_u16Bpm = (uint16)(1875000UL / Local_u16Arr[1]);
    }

    if ((Local_u16Bpm < 30U) || (Local_u16Bpm > 250U))
    {
        return 0U;
    }

    return Local_u16Bpm;
}

static uint16 HRC_CalculateHrvMs(void)
{
    uint32 Local_u32DiffSum = 0UL;
    uint32 Local_u32AverageDiff;
    uint32 Local_u32HrvMs;
    uint8 Local_u8Index;

    for (Local_u8Index = 1U; Local_u8Index < 8U; Local_u8Index++)
    {
        Local_u32DiffSum += (((HRC_Intervals[Local_u8Index]) >= (HRC_Intervals[Local_u8Index - 1U])) ? ((HRC_Intervals[Local_u8Index]) - (HRC_Intervals[Local_u8Index - 1U])) : ((HRC_Intervals[Local_u8Index - 1U]) - (HRC_Intervals[Local_u8Index])))
                                                                       ;
    }

    Local_u32AverageDiff = Local_u32DiffSum / 7UL;
    Local_u32HrvMs = (Local_u32AverageDiff * 32U) / 1000UL;

    if (Local_u32HrvMs > 65535UL)
    {
        return 65535U;
    }

    return (uint16)Local_u32HrvMs;
}
