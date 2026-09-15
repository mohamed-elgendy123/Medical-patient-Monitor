#ifndef SHIFTREG_INTERFACE_H
#define SHIFTREG_INTERFACE_H


#include "../../LIB/STD_TYPES.h"

/* Initialize Latch pin (PB4) and SPI Master */
void ShiftReg_voidInit(void);

/* Send byte via SPI and toggle Latch (RCLK) pin to update LEDs */
void ShiftReg_voidWriteByte(uint8 Copy_u8Data);

#endif /* SHIFTREG_INTERFACE_H */