#include <avr/interrupt.h>

#include "STD_TYPES.h"
#include "TIMER_interface.h"
#include "TIMER_private.h"
#include "INTERRUPT_interface.h"

/* Static variables to hold system states */
static volatile u32 Timer0_Ticks;
static volatile TIMER_CallbackType Timer0_Callback = (TIMER_CallbackType)0;
static volatile u8 Timer0_TickPending = 0U;

static volatile u16 Timer1_Intervals[TIMER1_CAPTURE_RING_SIZE];
static volatile u16 Timer1_LastCapture = 0U;
static volatile u8 Timer1_RingIndex = 0U;
static volatile u8 Timer1_CaptureReady = 0U;
static volatile u8 Timer1_Asystole = 0U;
static volatile u8 Timer1_OverflowCount = 0U;
static volatile u8 Timer1_HasLastCapture = 0U;
static volatile u16 Timer1_LastInterval = 0U;

/* ========================================================================= */
/* TIMER 0                                    */
/* ========================================================================= */

void TIMER0_Init(void)
{
    /* Reset registers to a clean state */
    TIMER0_TCCR0 = 0U;
    TIMER0_TCNT0 = 0U;

    /* 10 ms CTC Match Value @ 8MHz, Prescaler 1024 */
    TIMER0_OCR0 = 77U;

    /* CTC Mode (WGM01 = 1) */
    SET_BIT(TIMER0_TCCR0, TIMER0_WGM01);

    /* Clock Select: Prescaler 1024 (CS02 = 1, CS00 = 1) */
    SET_BIT(TIMER0_TCCR0, TIMER0_CS02);
    SET_BIT(TIMER0_TCCR0, TIMER0_CS00);

    /* Enable Compare Match Interrupt */
    SET_BIT(TIMER_TIMSK, TIMER_OCIE0);
}

void TIMER0_SetCallback(TIMER_CallbackType Copy_pvCallback)
{
    if (Copy_pvCallback != (TIMER_CallbackType)0)
    {
        Timer0_Callback = Copy_pvCallback;
    }
    else
    {
        Timer0_Callback = (TIMER_CallbackType)0;
    }
}

uint8 TIMER0_IsTickPending(void)
{
    if (Timer0_TickPending != 0U)
    {
        return 1U;
    }
    else
    {
        return 0U;
    }
}

void TIMER0_ClearTick(void)
{
    Timer0_TickPending = 0U;
}

/* ========================================================================= */
/* TIMER 1                                    */
/* ========================================================================= */

void TIMER1_Init(void)
{
    u8 Local_u8Idx = 0U;

    /* 1. ضبط مسجلات التحكم والعداد على النمط الطبيعي Normal Mode */
    TIMER1_TCCR1A = 0U;
    TIMER1_TCCR1B = 0U;
    TIMER1_TCNT1 = 0U;

    /* 2. مسح أي رايات مقاطعة معلقة في TIFR بكتابة 1 منطقي */
    SET_BIT(TIMER_TIFR, TIMER1_ICF1);
    SET_BIT(TIMER_TIFR, TIMER1_TOV1);

    /* 3. تفعيل مانع الضوضاء ICNC1، والحافة الصاعدة ICES1، والمقسم 256 */
    SET_BIT(TIMER1_TCCR1B, TIMER1_ICNC1);
    SET_BIT(TIMER1_TCCR1B, TIMER1_ICES1);
    SET_BIT(TIMER1_TCCR1B, TIMER1_CS12);

    /* 4. تفعيل مقاطعة الالتقاط والفيضان في TIMSK */
    SET_BIT(TIMER_TIMSK, TIMER1_TICIE1);
    SET_BIT(TIMER_TIMSK, TIMER1_TOIE1);

    /* 5. تصفير مصفوفة العينات الدائرية */
    for (Local_u8Idx = 0U; Local_u8Idx < TIMER1_CAPTURE_RING_SIZE; Local_u8Idx++)
    {
        Timer1_Intervals[Local_u8Idx] = 0U;
    }

    Timer1_LastCapture = 0U;
    Timer1_RingIndex = 0U;
    Timer1_CaptureReady = 0U;
    Timer1_Asystole = 0U;
    Timer1_OverflowCount = 0U;
    Timer1_HasLastCapture = 0U;
    Timer1_LastInterval = 0U;
}

u8 TIMER1_IsCaptureReady(void)
{
    return (Timer1_CaptureReady != 0U) ? 1U : 0U;
}

void TIMER1_ClearCaptureFlag(void)
{
    Timer1_CaptureReady = 0U;
}

u16 TIMER1_GetLastInterval(void)
{
    u16 Local_u16Val;

    (void)INTERRUPT_DisableGlobal();
    Local_u16Val = Timer1_LastInterval;
    (void)INTERRUPT_EnableGlobal();

    return Local_u16Val;
}

u8 TIMER1_IsAsystole(void)
{
    return (Timer1_Asystole != 0U) ? 1U : 0U;
}

void TIMER1_ClearAsystole(void)
{
    Timer1_Asystole = 0U;
    Timer1_OverflowCount = 0U;
    Timer1_HasLastCapture = 0U;
}

/* ========================================================================= */
/* TIMER 2                                    */
/* ========================================================================= */

void TIMER2_Init(void)
{
    /* Set PD7 (OC2) as Output */
    SET_BIT(TIMER_DDRD, TIMER_OC2_PD7);

    /* Reset Timer2 registers */
    TIMER2_TCCR2 = 0U;
    TIMER2_TCNT2 = 0U;

    /* CTC Mode (WGM21 = 1) */
    SET_BIT(TIMER2_TCCR2, TIMER2_WGM21);

    /* Toggle OC2 on Compare Match (COM20 = 1) */
    SET_BIT(TIMER2_TCCR2, TIMER2_COM20);

    /* Start in Mute State */
    TIMER2_SetTone(TIMER2_TONE_MUTE);
}

void TIMER2_SetTone(uint8 Copy_u8Tone)
{
    /* Stop Clock Source first (CS22=0, CS21=0, CS20=0) */
    CLR_BIT(TIMER2_TCCR2, TIMER2_CS22);
    CLR_BIT(TIMER2_TCCR2, TIMER2_CS21);
    CLR_BIT(TIMER2_TCCR2, TIMER2_CS20);

    if (Copy_u8Tone == TIMER2_TONE_HIGH)
    {
        /* 960 Hz Tone: Prescaler 32, OCR2 = 129 */
        TIMER2_OCR2 = 129U;
        SET_BIT(TIMER2_TCCR2, TIMER2_CS21);
        SET_BIT(TIMER2_TCCR2, TIMER2_CS20);
    }
    else if (Copy_u8Tone == TIMER2_TONE_MEDIUM)
    {
        /* 640 Hz Tone: Prescaler 64, OCR2 = 97 */
        TIMER2_OCR2 = 97U;
        SET_BIT(TIMER2_TCCR2, TIMER2_CS22);
    }
    else if (Copy_u8Tone == TIMER2_TONE_LOW)
    {
        /* 480 Hz Tone: Prescaler 64, OCR2 = 129 */
        TIMER2_OCR2 = 129U;
        SET_BIT(TIMER2_TCCR2, TIMER2_CS22);
    }
    else
    {
        /* TIMER2_TONE_MUTE or invalid value */
        TIMER2_OCR2 = 0U;
    }
}

/* ========================================================================= */
/* INTERRUPT SERVICE ROUTINES                        */
/* ========================================================================= */

ISR(TIMER0_COMP_vect)
{
    Timer0_Ticks++;
    Timer0_TickPending = 1U;

    if (Timer0_Callback != (TIMER_CallbackType)0)
    {
        Timer0_Callback();
    }
}

ISR(TIMER1_CAPT_vect)
{
    u16 Local_u16Capture = TIMER1_ICR1;

    /* إعادة الضبط المرجعي عند أول نبضة أو بعد زوال توقف القلب */
    if ((Timer1_HasLastCapture == 0U) || (Timer1_Asystole != 0U))
    {
        Timer1_LastCapture = Local_u16Capture;
        Timer1_HasLastCapture = 1U;
        Timer1_OverflowCount = 0U;
        Timer1_Asystole = 0U;
        return;
    }

    /* حساب الفارق الزمني */
    Timer1_LastInterval = (u16)(Local_u16Capture - Timer1_LastCapture);
    Timer1_LastCapture = Local_u16Capture;

    Timer1_Intervals[Timer1_RingIndex] = Timer1_LastInterval;
    Timer1_RingIndex++;
    if (Timer1_RingIndex >= TIMER1_CAPTURE_RING_SIZE)
    {
        Timer1_RingIndex = 0U;
    }

    Timer1_CaptureReady = 1U;
    Timer1_OverflowCount = 0U;
    Timer1_Asystole = 0U;
}

ISR(TIMER1_OVF_vect)
{
    if (Timer1_OverflowCount < 255U)
    {
        Timer1_OverflowCount++;
    }

    if (Timer1_HasLastCapture != 0U)
    {
        /* 4.0 seconds @ 31,250 Hz = 125,000 ticks.
         * Each overflow is 65,536 ticks.
         */
        u32 Local_u32Elapsed = ((u32)Timer1_OverflowCount << 16) + (u32)TIMER1_TCNT1 - (u32)Timer1_LastCapture;
        if (Local_u32Elapsed >= 125000UL)
        {
            Timer1_Asystole = 1U;
            Timer1_HasLastCapture = 0U;
        }
    }
    else
    {
        if (Timer1_OverflowCount >= 2U)
        {
            Timer1_Asystole = 1U;
        }
    }
}