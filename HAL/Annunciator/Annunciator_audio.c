#include "LIB/STD_TYPES.h"
#if defined(__has_include)
#if __has_include("LIB/BIT_MATH.h")
#include "LIB/BIT_MATH.h"
#endif
#endif
#include "MCAL/TIMER/TIMER_interface.h"
#include "Annunciator_interface.h"
#include "Annunciator_private.h"

static volatile u8 Ann_CurrentPriority;
static volatile u8 Ann_Phase;
static volatile u8 Ann_PulseCount;
static volatile u16 Ann_PhaseTicks;
static volatile u16 Ann_CycleTicks;
static volatile u16 Ann_SilenceTicks;
static volatile u8 Ann_Muted;

static void ANN_ResetPattern(void)
{
    Ann_Phase = ANN_PHASE_ON;
    Ann_PulseCount = 0U;
    Ann_PhaseTicks = 0U;
    Ann_CycleTicks = 0U;

    if (Ann_CurrentPriority == ANN_PRI_HIGH)
    {
        TIMER2_SetTone(TIMER2_TONE_HIGH);
    }
    else if (Ann_CurrentPriority == ANN_PRI_MEDIUM)
    {
        TIMER2_SetTone(TIMER2_TONE_MEDIUM);
    }
    else if (Ann_CurrentPriority == ANN_PRI_LOW)
    {
        TIMER2_SetTone(TIMER2_TONE_LOW);
    }
    else
    {
        Ann_Phase = ANN_PHASE_DONE;
        TIMER2_SetTone(TIMER2_TONE_MUTE);
    }
}

static void ANN_StartPulse(void)
{
    Ann_Phase = ANN_PHASE_ON;
    Ann_PhaseTicks = 0U;

    if (Ann_CurrentPriority == ANN_PRI_HIGH)
    {
        TIMER2_SetTone(TIMER2_TONE_HIGH);
    }
    else if (Ann_CurrentPriority == ANN_PRI_MEDIUM)
    {
        TIMER2_SetTone(TIMER2_TONE_MEDIUM);
    }
    else if (Ann_CurrentPriority == ANN_PRI_LOW)
    {
        TIMER2_SetTone(TIMER2_TONE_LOW);
    }
}

static void ANN_StartSilence(void)
{
    Ann_Muted = 1U;
    Ann_SilenceTicks = ANN_SILENCE_TICKS;
    TIMER2_SetTone(TIMER2_TONE_MUTE);
}

void ANN_Audio_Init(void)
{
    Ann_CurrentPriority = ANN_PRI_NONE;
    Ann_Phase = ANN_PHASE_DONE;
    Ann_PulseCount = 0U;
    Ann_PhaseTicks = 0U;
    Ann_CycleTicks = 0U;
    Ann_SilenceTicks = 0U;
    Ann_Muted = 0U;
    TIMER2_Init();
    TIMER2_SetTone(TIMER2_TONE_MUTE);
}

void ANN_Audio_SetPriority(u8 Copy_u8Priority)
{
    if (Copy_u8Priority <= ANN_PRI_HIGH)
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
    u16 Local_u16OnTicks;
    u16 Local_u16OffTicks;
    u8 Local_u8PulseLimit;
    u16 Local_u16CycleLimit = 0U;

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

    if (Ann_CurrentPriority == ANN_PRI_NONE)
    {
        TIMER2_SetTone(TIMER2_TONE_MUTE);
        Ann_Phase = ANN_PHASE_DONE;
        return;
    }

    if (Ann_CurrentPriority == ANN_PRI_HIGH)
    {
        Local_u16OnTicks = ANN_HIGH_ON_TICKS;
        Local_u16OffTicks = ANN_HIGH_OFF_TICKS;
        Local_u8PulseLimit = ANN_HIGH_PULSES;
        Local_u16CycleLimit = ANN_HIGH_CYCLE_TICKS;
    }
    else if (Ann_CurrentPriority == ANN_PRI_MEDIUM)
    {
        Local_u16OnTicks = ANN_MEDIUM_ON_TICKS;
        Local_u16OffTicks = ANN_MEDIUM_OFF_TICKS;
        Local_u8PulseLimit = ANN_MEDIUM_PULSES;
        Local_u16CycleLimit = ANN_MEDIUM_CYCLE_TICKS;
    }
    else
    {
        Local_u16OnTicks = ANN_LOW_ON_TICKS;
        Local_u16OffTicks = ANN_LOW_OFF_TICKS;
        Local_u8PulseLimit = ANN_LOW_PULSES;
    }

    if (Ann_CycleTicks < 65535U)
    {
        Ann_CycleTicks++;
    }

    if (Ann_Phase == ANN_PHASE_ON)
    {
        Ann_PhaseTicks++;
        if (Ann_PhaseTicks >= Local_u16OnTicks)
        {
            Ann_Phase = ANN_PHASE_OFF;
            Ann_PhaseTicks = 0U;
            TIMER2_SetTone(TIMER2_TONE_MUTE);
        }
    }
    else if (Ann_Phase == ANN_PHASE_OFF)
    {
        Ann_PhaseTicks++;
        if (Ann_PhaseTicks >= Local_u16OffTicks)
        {
            Ann_PulseCount++;
            if (Ann_PulseCount < Local_u8PulseLimit)
            {
                ANN_StartPulse();
            }
            else if (Ann_CurrentPriority == ANN_PRI_LOW)
            {
                Ann_Phase = ANN_PHASE_DONE;
                TIMER2_SetTone(TIMER2_TONE_MUTE);
            }
            else
            {
                Ann_Phase = ANN_PHASE_WAIT;
                Ann_PhaseTicks = 0U;
                TIMER2_SetTone(TIMER2_TONE_MUTE);
            }
        }
    }
    else if (Ann_Phase == ANN_PHASE_WAIT)
    {
        if (Ann_CycleTicks >= Local_u16CycleLimit)
        {
            ANN_ResetPattern();
        }
    }
    else
    {
        TIMER2_SetTone(TIMER2_TONE_MUTE);
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
