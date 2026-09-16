#ifndef LCD_I2C_INTERFACE_H
#define LCD_I2C_INTERFACE_H

/*
 * HAL LCD_I2C — public API for 16×2 HD44780 LCD via PCF8574 I2C expander.
 *
 * Requires MCAL I2C master to be initialised first (I2C_InitMaster).
 * Pins: SCL = PC0, SDA = PC1 (shared I2C bus).
 *
 * Typical PCF8574 address: 0x27 (A0=A1=A2 high / floating).
 */

#include "STD_TYPES.h"

#define LCD_I2C_ROWS    2u
#define LCD_I2C_COLS    16u

/*
 * Description : Initialise HD44780 in 4-bit mode through PCF8574.
 *               Must be called after I2C_InitMaster().
 */
STD_ReturnType LCD_I2C_Init(void);

/*
 * Description : Clear the entire display (takes ~2 ms).
 */
STD_ReturnType LCD_I2C_Clear(void);

/*
 * Description : Return cursor to row 0, col 0.
 */
STD_ReturnType LCD_I2C_Home(void);

/*
 * Description : Move cursor.  Row 0–1, Col 0–15.
 */
STD_ReturnType LCD_I2C_SetCursor(uint8 Copy_u8Row, uint8 Copy_u8Col);

/*
 * Description : Write one ASCII character at the current cursor position.
 */
STD_ReturnType LCD_I2C_WriteChar(uint8 Copy_u8Char);

/*
 * Description : Write a null-terminated string starting at the current cursor.
 */
STD_ReturnType LCD_I2C_WriteString(const char *Copy_pcStr);

/*
 * Description : Convenience — SetCursor then WriteString.
 */
STD_ReturnType LCD_I2C_WriteStringAt(uint8 Copy_u8Row, uint8 Copy_u8Col,
                                     const char *Copy_pcStr);

/*
 * Description : Write a signed 16-bit integer in decimal at the current cursor.
 */
STD_ReturnType LCD_I2C_WriteNumber(sint16 Copy_s16Num);

/*
 * Description : Turn backlight ON / OFF.
 */
STD_ReturnType LCD_I2C_BacklightOn(void);
STD_ReturnType LCD_I2C_BacklightOff(void);

#endif /* LCD_I2C_INTERFACE_H */
