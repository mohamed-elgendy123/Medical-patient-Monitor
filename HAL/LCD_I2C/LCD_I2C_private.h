#ifndef LCD_I2C_PRIVATE_H
#define LCD_I2C_PRIVATE_H

/*
 * HAL LCD_I2C — private constants.  Include ONLY from LCD_I2C.c.
 *
 * PCF8574 I2C address — most 16×2 backpack modules ship as 0x27.
 * Change here if your module uses a different address (0x20–0x27).
 */
#define PCF8574_ADDRESS    0x20u

/*
 * PCF8574 pin-to-HD44780 mapping (de-facto standard backpack wiring):
 *
 *   PCF8574 pin   HD44780 pin   Purpose
 *   ───────────   ───────────   ────────────────────
 *   P0            RS            Register Select (0=cmd, 1=data)
 *   P1            RW            Read/Write      (always 0)
 *   P2            E             Enable          (pulse ↑↓)
 *   P3            —             Backlight transistor
 *   P4            D4            Data bit 4
 *   P5            D5            Data bit 5
 *   P6            D6            Data bit 6
 *   P7            D7            Data bit 7
 */
#define LCD_RS    (1u << 0)
#define LCD_RW    (1u << 1)
#define LCD_EN    (1u << 2)
#define LCD_BL    (1u << 3)

/* -------------------- HD44780 command set -------------------- */
#define LCD_CMD_CLEAR           0x01u
#define LCD_CMD_HOME            0x02u
#define LCD_CMD_ENTRY_MODE      0x06u   /* cursor increment, no shift */
#define LCD_CMD_DISPLAY_ON      0x0Cu   /* display on, cursor off     */
#define LCD_CMD_FUNCTION_4BIT   0x28u   /* 4-bit, 2-line, 5×8 font   */
#define LCD_CMD_SET_DDRAM       0x80u

/* Row start addresses for a standard 16×2 module */
#define LCD_ROW0_ADDR   0x00u
#define LCD_ROW1_ADDR   0x40u

#endif /* LCD_I2C_PRIVATE_H */
