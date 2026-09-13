#ifndef MATH_H
#define MATH_H

#include "STD_TYPES.h"

#define SET_BIT(REG, BIT) ((REG) |= (1 << (BIT)))
#define CLEAR_BIT(REG, BIT) ((REG) &= ~(1 << (BIT)))
#define TOGGLE_BIT(REG, BIT) ((REG) ^= (1 << (BIT)))
#define GET_BIT(REG, BIT) (((REG) >> (BIT)) & 1)

/* أسماء بديلة للتوافق مع كود GPIO */
#define CLR_BIT CLEAR_BIT
#define TOG_BIT TOGGLE_BIT

#endif /* MATH_H */