# 0 "HAL/Annunciator/Annunciator_audio.c"
# 0 "<built-in>"
# 0 "<command-line>"
# 1 "HAL/Annunciator/Annunciator_audio.c"
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
# 2 "HAL/Annunciator/Annunciator_audio.c" 2





# 1 "./MCAL/TIMER/TIMER_interface.h" 1



# 1 "LIB/STD_TYPES.h" 1
# 5 "./MCAL/TIMER/TIMER_interface.h" 2
# 16 "./MCAL/TIMER/TIMER_interface.h"
typedef void (*TIMER_CallbackType)(void);






void TIMER0_Init(void);
void TIMER0_SetCallback(TIMER_CallbackType Copy_pvCallback);
uint8 TIMER0_IsTickPending(void);
void TIMER0_ClearTick(void);

void TIMER1_Init(void);
uint8 TIMER1_IsCaptureReady(void);
void TIMER1_ClearCaptureFlag(void);
uint16 TIMER1_GetInterval(uint8 Copy_u8Index);
uint8 TIMER1_GetCaptureCount(void);
uint8 TIMER1_GetCaptureWriteIndex(void);
uint8 TIMER1_IsAsystole(void);
void TIMER1_ClearAsystole(void);

void TIMER2_Init(void);
void TIMER2_SetTone(uint8 Copy_u8Tone);
# 8 "HAL/Annunciator/Annunciator_audio.c" 2
# 1 "HAL/Annunciator/Annunciator_interface.h" 1
# 21 "HAL/Annunciator/Annunciator_interface.h"
void ANN_Audio_Init(void);
void ANN_Audio_SetPriority(uint8 Copy_u8Priority);
void ANN_Audio_Tick(void);
void ANN_Audio_Mute(void);
void ANN_Audio_Unmute(void);
# 9 "HAL/Annunciator/Annunciator_audio.c" 2
# 1 "HAL/Annunciator/Annunciator_private.h" 1
# 10 "HAL/Annunciator/Annunciator_audio.c" 2

static volatile uint8 Ann_CurrentPriority;
static volatile uint8 Ann_Phase;
static volatile uint8 Ann_PulseCount;
static volatile uint16 Ann_PhaseTicks;
static volatile uint16 Ann_CycleTicks;
static volatile uint16 Ann_SilenceTicks;
static volatile uint8 Ann_Muted;

static void ANN_ResetPattern(void)
{
    Ann_Phase = 0U;
    Ann_PulseCount = 0U;
    Ann_PhaseTicks = 0U;
    Ann_CycleTicks = 0U;

    if (Ann_CurrentPriority == 3U)
    {
        TIMER2_SetTone(1U);
    }
    else if (Ann_CurrentPriority == 2U)
    {
        TIMER2_SetTone(2U);
    }
    else if (Ann_CurrentPriority == 1U)
    {
        TIMER2_SetTone(3U);
    }
    else
    {
        Ann_Phase = 3U;
        TIMER2_SetTone(0U);
    }
}

static void ANN_StartPulse(void)
{
    Ann_Phase = 0U;
    Ann_PhaseTicks = 0U;

    if (Ann_CurrentPriority == 3U)
    {
        TIMER2_SetTone(1U);
    }
    else if (Ann_CurrentPriority == 2U)
    {
        TIMER2_SetTone(2U);
    }
    else if (Ann_CurrentPriority == 1U)
    {
        TIMER2_SetTone(3U);
    }
}

static void ANN_StartSilence(void)
{
    Ann_Muted = 1U;
    Ann_SilenceTicks = 12000U;
    TIMER2_SetTone(0U);
}

void ANN_Audio_Init(void)
{
    Ann_CurrentPriority = 0U;
    Ann_Phase = 3U;
    Ann_PulseCount = 0U;
    Ann_PhaseTicks = 0U;
    Ann_CycleTicks = 0U;
    Ann_SilenceTicks = 0U;
    Ann_Muted = 0U;
    TIMER2_Init();
    TIMER2_SetTone(0U);
}

void ANN_Audio_SetPriority(uint8 Copy_u8Priority)
{
    if (Copy_u8Priority <= 3U)
    {
        if (Copy_u8Priority != Ann_CurrentPriority)
        {
            Ann_CurrentPriority = Copy_u8Priority;
            Ann_Muted = 0U;
            Ann_SilenceTicks = 0U;
            ANN_ResetPattern();
        }
    }
}

void ANN_Audio_Tick(void)
{
    uint16 Local_u16OnTicks;
    uint16 Local_u16OffTicks;
    uint8 Local_u8PulseLimit;
    uint16 Local_u16CycleLimit = 0U;

    if (Ann_Muted != 0U)
    {
        if (Ann_SilenceTicks > 0U)
        {
            Ann_SilenceTicks--;
        }
        if (Ann_SilenceTicks == 0U)
        {
            Ann_Muted = 0U;
            ANN_ResetPattern();
        }
        return;
    }

    if (Ann_CurrentPriority == 0U)
    {
        TIMER2_SetTone(0U);
        Ann_Phase = 3U;
        return;
    }

    if (Ann_CurrentPriority == 3U)
    {
        Local_u16OnTicks = 15U;
        Local_u16OffTicks = 10U;
        Local_u8PulseLimit = 10U;
        Local_u16CycleLimit = 500U;
    }
    else if (Ann_CurrentPriority == 2U)
    {
        Local_u16OnTicks = 20U;
        Local_u16OffTicks = 15U;
        Local_u8PulseLimit = 3U;
        Local_u16CycleLimit = 1500U;
    }
    else
    {
        Local_u16OnTicks = 25U;
        Local_u16OffTicks = 20U;
        Local_u8PulseLimit = 2U;
    }

    if (Ann_CycleTicks < 65535U)
    {
        Ann_CycleTicks++;
    }

    if (Ann_Phase == 0U)
    {
        Ann_PhaseTicks++;
        if (Ann_PhaseTicks >= Local_u16OnTicks)
        {
            Ann_Phase = 1U;
            Ann_PhaseTicks = 0U;
            TIMER2_SetTone(0U);
        }
    }
    else if (Ann_Phase == 1U)
    {
        Ann_PhaseTicks++;
        if (Ann_PhaseTicks >= Local_u16OffTicks)
        {
            Ann_PulseCount++;
            if (Ann_PulseCount < Local_u8PulseLimit)
            {
                ANN_StartPulse();
            }
            else if (Ann_CurrentPriority == 1U)
            {
                Ann_Phase = 3U;
                TIMER2_SetTone(0U);
            }
            else
            {
                Ann_Phase = 2U;
                Ann_PhaseTicks = 0U;
                TIMER2_SetTone(0U);
            }
        }
    }
    else if (Ann_Phase == 2U)
    {
        if (Ann_CycleTicks >= Local_u16CycleLimit)
        {
            ANN_ResetPattern();
        }
    }
    else
    {
        TIMER2_SetTone(0U);
    }
}

void ANN_Audio_Mute(void)
{
    ANN_StartSilence();
}

void ANN_Audio_Unmute(void)
{
    Ann_Muted = 0U;
    Ann_SilenceTicks = 0U;
    ANN_ResetPattern();
}
