#ifndef TIMER_INTERFACE_H
#define TIMER_INTERFACE_H

#include "STD_TYPES.h"

typedef void (*TIMER_CallbackType)(void);

#define TIMER2_TONE_MUTE 0U
#define TIMER2_TONE_HIGH 1U
#define TIMER2_TONE_MEDIUM 2U
#define TIMER2_TONE_LOW 3U

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

#endif /* TIMER_INTERFACE_H */
