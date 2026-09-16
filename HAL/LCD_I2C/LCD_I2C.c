/*
 * HAL LCD_I2C — HD44780 16×2 LCD via PCF8574 I2C I/O expander.
 *
 * Every character/command is sent in 4-bit mode:
 *   high nibble → EN pulse → low nibble → EN pulse.
 *
 * Each EN pulse is two consecutive I2C writes to PCF8574
 * (one with EN=1, one with EN=0).
 *
 * At 100 kHz I2C, one byte ≈ 90 µs, so a full LCD byte (4 I2C writes)
 * takes ~360 µs — well above the 40 µs HD44780 command time.
 * Only Clear and Home need an explicit extra delay (≈ 2 ms).
 */

#include "STD_TYPES.h"
#include "I2C_interface.h"
#include "LCD_I2C_interface.h"
#include "LCD_I2C_private.h"

#include <stdarg.h>
#include <stdio.h>

#ifndef F_CPU
#define F_CPU 8000000UL
#endif
#include <util/delay.h>

/* Backlight state persisted across writes */
static uint8 g_u8Backlight = LCD_BL;

/* ==================== Low-level helpers ==================== */

/* Write one byte to the PCF8574 via I2C */
static STD_ReturnType PCF8574_Write(uint8 Copy_u8Data)
{
    STD_ReturnType Local_enRet;

    Local_enRet = I2C_SendStart();
    if (Local_enRet != E_OK)
    {
        return E_NOK;
    }

    Local_enRet = I2C_SendSlaveAddressWithWrite(PCF8574_ADDRESS);
    if (Local_enRet != E_OK)
    {
        I2C_SendStop();
        return E_NOK;
    }

    Local_enRet = I2C_SendByte(Copy_u8Data);
    I2C_SendStop();
    return Local_enRet;
}

/* Pulse EN: write byte with EN=1, then with EN=0 */
static STD_ReturnType LCD_PulseNibble(uint8 Copy_u8Nibble)
{
    STD_ReturnType Local_enRet;

    Local_enRet = PCF8574_Write(Copy_u8Nibble | LCD_EN);
    if (Local_enRet != E_OK)
    {
        return E_NOK;
    }

    _delay_us(10);

    Local_enRet = PCF8574_Write(Copy_u8Nibble & (uint8)~LCD_EN);
    return Local_enRet;
}

/*
 * Send a full byte in 4-bit mode (high nibble first, then low nibble).
 * Copy_u8IsData: 0 = command (RS=0), non-zero = data (RS=1).
 */
static STD_ReturnType LCD_WriteByte(uint8 Copy_u8Data, uint8 Copy_u8IsData)
{
    STD_ReturnType Local_enRet;
    uint8 Local_u8Flags = g_u8Backlight;

    if (Copy_u8IsData)
    {
        Local_u8Flags |= LCD_RS;
    }

    /* High nibble */
    Local_enRet = LCD_PulseNibble((Copy_u8Data & 0xF0u) | Local_u8Flags);
    if (Local_enRet != E_OK)
    {
        return E_NOK;
    }

    /* Low nibble */
    Local_enRet = LCD_PulseNibble(((uint8)(Copy_u8Data << 4) & 0xF0u) | Local_u8Flags);
    return Local_enRet;
}

static STD_ReturnType LCD_Command(uint8 Copy_u8Cmd)
{
    return LCD_WriteByte(Copy_u8Cmd, 0u);
}

static STD_ReturnType LCD_Data(uint8 Copy_u8Char)
{
    STD_ReturnType Local_enRet = LCD_WriteByte(Copy_u8Char, 1u);
    _delay_us(40);
    return Local_enRet;
}

/* ==================== Public API ==================== */

STD_ReturnType LCD_I2C_Init(void)
{
    STD_ReturnType Local_enRet;

    /* HD44780 power-on: wait > 40 ms */
    _delay_ms(50);

    /*
     * 4-bit init sequence (per HD44780 datasheet):
     *   three times Function-Set 8-bit (0x3x nibble) then switch to 4-bit.
     *   During this phase only single nibbles are sent.
     */
    Local_enRet = LCD_PulseNibble(0x30u | g_u8Backlight);
    if (Local_enRet != E_OK)
    {
        return E_NOK;
    }
    _delay_ms(5);

    Local_enRet = LCD_PulseNibble(0x30u | g_u8Backlight);
    if (Local_enRet != E_OK)
    {
        return E_NOK;
    }
    _delay_us(150);

    Local_enRet = LCD_PulseNibble(0x30u | g_u8Backlight);
    if (Local_enRet != E_OK)
    {
        return E_NOK;
    }
    _delay_us(150);

    /* Switch to 4-bit interface */
    Local_enRet = LCD_PulseNibble(0x20u | g_u8Backlight);
    if (Local_enRet != E_OK)
    {
        return E_NOK;
    }
    _delay_us(150);

    /* From here on, normal 4-bit command path (two nibbles per byte) */
    Local_enRet = LCD_Command(LCD_CMD_FUNCTION_4BIT); /* 4-bit, 2-line, 5×8 */
    if (Local_enRet != E_OK)
    {
        return E_NOK;
    }

    Local_enRet = LCD_Command(LCD_CMD_DISPLAY_ON); /* display ON, cursor OFF */
    if (Local_enRet != E_OK)
    {
        return E_NOK;
    }

    Local_enRet = LCD_Command(LCD_CMD_CLEAR);
    if (Local_enRet != E_OK)
    {
        return E_NOK;
    }
    _delay_ms(2);

    Local_enRet = LCD_Command(LCD_CMD_ENTRY_MODE); /* increment, no shift */
    return Local_enRet;
}

STD_ReturnType LCD_I2C_Clear(void)
{
    STD_ReturnType Local_enRet = LCD_Command(LCD_CMD_CLEAR);
    _delay_ms(2);
    return Local_enRet;
}

STD_ReturnType LCD_I2C_Home(void)
{
    STD_ReturnType Local_enRet = LCD_Command(LCD_CMD_HOME);
    _delay_ms(2);
    return Local_enRet;
}

STD_ReturnType LCD_I2C_SetCursor(uint8 Copy_u8Row, uint8 Copy_u8Col)
{
    uint8 Local_u8Addr;

    if (Copy_u8Row >= LCD_I2C_ROWS || Copy_u8Col >= LCD_I2C_COLS)
    {
        return E_NOK;
    }

    Local_u8Addr = (Copy_u8Row == 0u) ? LCD_ROW0_ADDR : LCD_ROW1_ADDR;
    Local_u8Addr += Copy_u8Col;

    return LCD_Command(LCD_CMD_SET_DDRAM | Local_u8Addr);
}

STD_ReturnType LCD_I2C_WriteChar(uint8 Copy_u8Char)
{
    return LCD_Data(Copy_u8Char);
}

STD_ReturnType LCD_I2C_WriteString(const char *Copy_pcStr)
{
    STD_ReturnType Local_enRet;

    if (Copy_pcStr == NULL)
    {
        return E_NOK;
    }

    while (*Copy_pcStr != '\0')
    {
        Local_enRet = LCD_Data((uint8)*Copy_pcStr);
        if (Local_enRet != E_OK)
        {
            return E_NOK;
        }
        Copy_pcStr++;
    }
    return E_OK;
}

STD_ReturnType LCD_I2C_WriteStringAt(uint8 Copy_u8Row, uint8 Copy_u8Col,
                                     const char *Copy_pcStr)
{
    STD_ReturnType Local_enRet;

    Local_enRet = LCD_I2C_SetCursor(Copy_u8Row, Copy_u8Col);
    if (Local_enRet != E_OK)
    {
        return E_NOK;
    }

    return LCD_I2C_WriteString(Copy_pcStr);
}

STD_ReturnType LCD_I2C_FormatLine(uint8 Copy_u8Row, const char *Copy_pcFormat, ...)
{
    char Local_acLine[LCD_I2C_COLS + 1u];
    va_list Local_args;
    uint8 Local_u8Index;
    STD_ReturnType Local_enRet;

    if (Copy_pcFormat == NULL || Copy_u8Row >= LCD_I2C_ROWS)
    {
        return E_NOK;
    }

    for (Local_u8Index = 0u; Local_u8Index < LCD_I2C_COLS; Local_u8Index++)
    {
        Local_acLine[Local_u8Index] = ' ';
    }
    Local_acLine[LCD_I2C_COLS] = '\0';

    va_start(Local_args, Copy_pcFormat);
    (void)vsnprintf(Local_acLine, sizeof(Local_acLine), Copy_pcFormat, Local_args);
    va_end(Local_args);

    Local_enRet = LCD_I2C_SetCursor(Copy_u8Row, 0u);
    if (Local_enRet != E_OK)
    {
        return E_NOK;
    }

    for (Local_u8Index = 0u; Local_u8Index < LCD_I2C_COLS; Local_u8Index++)
    {
        Local_enRet = LCD_Data((uint8)Local_acLine[Local_u8Index]);
        if (Local_enRet != E_OK)
        {
            return E_NOK;
        }
    }

    return E_OK;
}

STD_ReturnType LCD_I2C_WriteNumber(sint16 Copy_s16Num)
{
    char Local_acBuf[7]; /* −32768\0 worst case */
    uint8 Local_u8Idx = 0;
    uint16 Local_u16Abs;
    STD_ReturnType Local_enRet;

    if (Copy_s16Num < 0)
    {
        Local_enRet = LCD_Data((uint8)'-');
        if (Local_enRet != E_OK)
        {
            return E_NOK;
        }
        Local_u16Abs = (uint16)(-Copy_s16Num);
    }
    else
    {
        Local_u16Abs = (uint16)Copy_s16Num;
    }

    if (Local_u16Abs == 0u)
    {
        return LCD_Data((uint8)'0');
    }

    /* Build digits in reverse order */
    while (Local_u16Abs > 0u && Local_u8Idx < 6u)
    {
        Local_acBuf[Local_u8Idx++] = (char)('0' + (uint8)(Local_u16Abs % 10u));
        Local_u16Abs /= 10u;
    }

    /* Print in correct order (MSB first) */
    while (Local_u8Idx > 0u)
    {
        Local_u8Idx--;
        Local_enRet = LCD_Data((uint8)Local_acBuf[Local_u8Idx]);
        if (Local_enRet != E_OK)
        {
            return E_NOK;
        }
    }

    return E_OK;
}

STD_ReturnType LCD_I2C_BacklightOn(void)
{
    g_u8Backlight = LCD_BL;
    return PCF8574_Write(g_u8Backlight);
}

STD_ReturnType LCD_I2C_BacklightOff(void)
{
    g_u8Backlight = 0u;
    return PCF8574_Write(g_u8Backlight);
}
