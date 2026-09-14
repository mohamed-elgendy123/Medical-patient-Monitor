#ifndef TIMER_INTERFACE_H
#define TIMER_INTERFACE_H

#include "STD_TYPES.h"

#ifndef u8
#define u8 uint8
#endif
#ifndef u16
#define u16 uint16
#endif
#ifndef u32
#define u32 uint32
#endif

typedef void (*TIMER_CallbackType)(void);

#define TIMER2_TONE_MUTE 0U
#define TIMER2_TONE_HIGH 1U
#define TIMER2_TONE_MEDIUM 2U
#define TIMER2_TONE_LOW 3U

void TIMER0_Init(void);
void TIMER0_SetCallback(TIMER_CallbackType Copy_pvCallback);
u8 TIMER0_IsTickPending(void);
void TIMER0_ClearTick(void);

void TIMER1_Init(void);
u8 TIMER1_IsCaptureReady(void);
void TIMER1_ClearCaptureFlag(void);
u16 TIMER1_GetInterval(u8 Copy_u8Index);
u8 TIMER1_GetCaptureCount(void);
u8 TIMER1_GetCaptureWriteIndex(void);
u8 TIMER1_IsAsystole(void);
void TIMER1_ClearAsystole(void);

void TIMER2_Init(void);
void TIMER2_SetTone(uint8 Copy_u8Tone);

#endif /* TIMER_INTERFACE_H */
