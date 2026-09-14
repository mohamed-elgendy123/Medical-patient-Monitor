#ifndef ANNUNCIATOR_PRIVATE_H
#define ANNUNCIATOR_PRIVATE_H

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

#define ANN_TICK_MS 10U
#define ANN_SILENCE_TICKS 12000U

#define ANN_HIGH_PULSES 10U
#define ANN_HIGH_ON_TICKS 15U
#define ANN_HIGH_OFF_TICKS 10U
#define ANN_HIGH_CYCLE_TICKS 500U

#define ANN_MEDIUM_PULSES 3U
#define ANN_MEDIUM_ON_TICKS 20U
#define ANN_MEDIUM_OFF_TICKS 15U
#define ANN_MEDIUM_CYCLE_TICKS 1500U

#define ANN_LOW_PULSES 2U
#define ANN_LOW_ON_TICKS 25U
#define ANN_LOW_OFF_TICKS 20U

#define ANN_PHASE_ON 0U
#define ANN_PHASE_OFF 1U
#define ANN_PHASE_WAIT 2U
#define ANN_PHASE_DONE 3U

#endif /* ANNUNCIATOR_PRIVATE_H */
