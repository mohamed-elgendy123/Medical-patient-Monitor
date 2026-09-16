        #ifndef SHIFTREG_INTERFACE_H
#define SHIFTREG_INTERFACE_H

#include "../../LIB/STD_TYPES.h"

/*
 * Description : Initialize SPI in Master mode and configure PB4 (Latch/RCLK)
 *               as output for the 74HC595 shift register.
 */
void ShiftReg_voidInit(void);

/*
 * Description : Transmit a byte over SPI and generate a Latch pulse (LOW -> HIGH -> LOW)
 *               to display the 8-bit pattern on the vital status LED bar.
 */
void ShiftReg_voidWriteByte(uint8 Copy_u8Data);

#endif /* SHIFTREG_INTERFACE_H */