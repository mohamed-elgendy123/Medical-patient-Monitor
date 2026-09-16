/*
 * Logic — Menu & live-dashboard implementation.
 *
 * Dashboard layout (16×2 LCD):
 *
 *   Row 0:  HR:nnn S:nnn T:nn       (Heart Rate, SpO2, Temperature)
 *   Row 1:  RR:nn  BP:nnn           (Respiratory Rate, NIBP)
 *        — or, alternating when an alarm is active —
 *   Row 1:  *HI xxxx ALARM*
 *
 * Disconnected sensors show "---" (Valid == 0).
 *
 * Pressing Menu enters the limits editor; Up/Down scroll vitals or
 * adjust values; Menu again confirms each step (Low → High → done).
 */

#include "STD_TYPES.h"
#include "LCD_I2C_interface.h"
#include "Panel_interface.h"
#include "patient_cfg.h"
#include "menu.h"

#include <string.h>   /* memset */

/* ======================== Private state ======================== */

static uint8  g_u8State         = MENU_DASHBOARD;
static uint8  g_u8SelectedVital = 0u;
static sint16 g_s16EditValue    = 0;

/* ======================== Helpers ======================== */

/*
 * FormatNumber — render sint16 into a char buffer, return length.
 * Buffer must be at least 7 bytes (−32768 + NUL).
 */
static uint8 FormatNumber(sint16 Copy_s16Val, char *Copy_pcBuf, uint8 Copy_u8BufLen)
{
    uint8  Local_u8Idx = 0;
    uint8  Local_u8Start;
    uint8  Local_u8J;
    uint8  Local_u8K;
    uint16 Local_u16Abs;
    char   Local_cTmp;

    if (Copy_u8BufLen < 2u) { Copy_pcBuf[0] = '\0'; return 0; }

    if (Copy_s16Val < 0) {
        Copy_pcBuf[Local_u8Idx++] = '-';
        Local_u16Abs = (uint16)(-Copy_s16Val);
    } else {
        Local_u16Abs = (uint16)Copy_s16Val;
    }

    if (Local_u16Abs == 0u) {
        Copy_pcBuf[Local_u8Idx++] = '0';
        Copy_pcBuf[Local_u8Idx]   = '\0';
        return Local_u8Idx;
    }

    Local_u8Start = Local_u8Idx;
    while (Local_u16Abs > 0u && Local_u8Idx < (Copy_u8BufLen - 1u)) {
        Copy_pcBuf[Local_u8Idx++] = (char)('0' + (uint8)(Local_u16Abs % 10u));
        Local_u16Abs /= 10u;
    }
    Copy_pcBuf[Local_u8Idx] = '\0';

    /* Reverse the digit portion (sign stays at front) */
    for (Local_u8J = Local_u8Start; Local_u8J < Local_u8Start + (Local_u8Idx - Local_u8Start) / 2u; Local_u8J++) {
        Local_u8K = (uint8)(Local_u8Start + (Local_u8Idx - 1u) - Local_u8J);
        Local_cTmp                = Copy_pcBuf[Local_u8J];
        Copy_pcBuf[Local_u8J]     = Copy_pcBuf[Local_u8K];
        Copy_pcBuf[Local_u8K]     = Local_cTmp;
    }

    return Local_u8Idx;
}

/*
 * FormatTemp — render °C×10 as "xx.x" into buffer.
 */
static uint8 FormatTemp(sint16 Copy_s16TempX10, char *Copy_pcBuf, uint8 Copy_u8BufLen)
{
    sint16 Local_s16Whole;
    sint16 Local_s16Abs;
    uint8  Local_u8Frac;
    char   Local_acNum[6];
    uint8  Local_u8Idx = 0;
    uint8  Local_u8Src = 0;

    if (Copy_u8BufLen < 5u) { Copy_pcBuf[0] = '\0'; return 0; }

    Local_s16Whole = Copy_s16TempX10 / 10;
    Local_s16Abs   = (Copy_s16TempX10 < 0) ? (sint16)(-Copy_s16TempX10) : Copy_s16TempX10;
    Local_u8Frac   = (uint8)(Local_s16Abs % 10);

    FormatNumber(Local_s16Whole, Local_acNum, sizeof(Local_acNum));

    while (Local_acNum[Local_u8Src] != '\0' && Local_u8Idx < (Copy_u8BufLen - 3u)) {
        Copy_pcBuf[Local_u8Idx++] = Local_acNum[Local_u8Src++];
    }
    Copy_pcBuf[Local_u8Idx++] = '.';
    Copy_pcBuf[Local_u8Idx++] = (char)('0' + Local_u8Frac);
    Copy_pcBuf[Local_u8Idx]   = '\0';

    return Local_u8Idx;
}

/* Place a string into a 16-char line buffer at a given column */
static void PutStr(char *Copy_pcLine, uint8 Copy_u8Col, const char *Copy_pcStr)
{
    while (*Copy_pcStr != '\0' && Copy_u8Col < LCD_I2C_COLS) {
        Copy_pcLine[Copy_u8Col++] = *Copy_pcStr++;
    }
}

/* Place a formatted number into the line buffer */
static void PutNum(char *Copy_pcLine, uint8 Copy_u8Col, sint16 Copy_s16Val)
{
    char Local_acBuf[7];
    FormatNumber(Copy_s16Val, Local_acBuf, sizeof(Local_acBuf));
    PutStr(Copy_pcLine, Copy_u8Col, Local_acBuf);
}


/* ======================== Menu screens ======================== */

/*
 * SELECT_VITAL screen:
 *   R0  Edit: <name>
 *   R1  L:xxx     H:xxx
 */
static void Menu_RenderSelect(void)
{
    char          Local_acLine[LCD_I2C_COLS + 1u];
    VitalLimits_t Local_stLim;

    /* Row 0 */
    memset(Local_acLine, ' ', LCD_I2C_COLS);
    Local_acLine[LCD_I2C_COLS] = '\0';
    PutStr(Local_acLine, 0, "Edit: ");
    PutStr(Local_acLine, 6, PatientCfg_VitalName(g_u8SelectedVital));
    LCD_I2C_SetCursor(0, 0);
    LCD_I2C_WriteString(Local_acLine);

    /* Row 1 */
    Local_stLim = PatientCfg_GetLimits(g_u8SelectedVital);
    memset(Local_acLine, ' ', LCD_I2C_COLS);
    Local_acLine[LCD_I2C_COLS] = '\0';
    PutStr(Local_acLine, 0, "L:");
    PutNum(Local_acLine, 2, Local_stLim.LowLimit);
    PutStr(Local_acLine, 8, "H:");
    PutNum(Local_acLine, 10, Local_stLim.HighLimit);
    LCD_I2C_SetCursor(1, 0);
    LCD_I2C_WriteString(Local_acLine);
}

/*
 * EDIT_LOW / EDIT_HIGH screen:
 *   R0  Set Low:    (or Set High:)
 *   R1  > xxx       <name>
 */
static void Menu_RenderEdit(void)
{
    char Local_acLine[LCD_I2C_COLS + 1u];
    char Local_acNum[7];

    /* Row 0 */
    memset(Local_acLine, ' ', LCD_I2C_COLS);
    Local_acLine[LCD_I2C_COLS] = '\0';
    if (g_u8State == MENU_EDIT_LOW) {
        PutStr(Local_acLine, 0, "Set Low:");
    } else {
        PutStr(Local_acLine, 0, "Set High:");
    }
    LCD_I2C_SetCursor(0, 0);
    LCD_I2C_WriteString(Local_acLine);

    /* Row 1: "> value   name" */
    memset(Local_acLine, ' ', LCD_I2C_COLS);
    Local_acLine[LCD_I2C_COLS] = '\0';
    PutStr(Local_acLine, 0, ">");

    if (g_u8SelectedVital == VITAL_TEMP) {
        FormatTemp(g_s16EditValue, Local_acNum, sizeof(Local_acNum));
    } else {
        FormatNumber(g_s16EditValue, Local_acNum, sizeof(Local_acNum));
    }
    PutStr(Local_acLine, 2, Local_acNum);
    PutStr(Local_acLine, 11, PatientCfg_VitalName(g_u8SelectedVital));

    LCD_I2C_SetCursor(1, 0);
    LCD_I2C_WriteString(Local_acLine);
}

/* ======================== Public API ======================== */

void Menu_Init(void)
{
    g_u8State         = MENU_DASHBOARD;
    g_u8SelectedVital = 0u;
    g_s16EditValue    = 0;
}

/* Inactivity timeout counter (at 50 Hz / 20 ms ticks: 3000 ticks = 60 s) */
static uint16 g_u16MenuTimeout = 0u;

void Menu_Update(void)
{
    VitalLimits_t Local_stLim;
    uint8 Local_u8Redraw = 0u;

    switch (g_u8State) {

    /* ---------- DASHBOARD ---------- */
    case MENU_DASHBOARD:
        /* Do NOT call Dashboard_Render() here — main.c Task_Lcd handles the live dashboard */
        if (Panel_IsPressed(BTN_MENU)) {
            g_u8State         = MENU_SELECT_VITAL;
            g_u8SelectedVital = 0u;
            g_u16MenuTimeout  = 0u;
            LCD_I2C_Clear();
            Menu_RenderSelect();
        }
        break;

    /* ---------- SELECT VITAL ---------- */
    case MENU_SELECT_VITAL:
        if (Panel_IsPressed(BTN_UP)) {
            g_u8SelectedVital = (g_u8SelectedVital == 0u)
                              ? (uint8)(VITAL_COUNT - 1u)
                              : (uint8)(g_u8SelectedVital - 1u);
            Local_u8Redraw = 1u;
        }
        if (Panel_IsPressed(BTN_DOWN)) {
            g_u8SelectedVital++;
            if (g_u8SelectedVital >= VITAL_COUNT) { g_u8SelectedVital = 0u; }
            Local_u8Redraw = 1u;
        }
        if (Panel_IsPressed(BTN_MENU)) {
            Local_stLim       = PatientCfg_GetLimits(g_u8SelectedVital);
            g_s16EditValue    = Local_stLim.LowLimit;
            g_u8State         = MENU_EDIT_LOW;
            g_u16MenuTimeout  = 0u;
            LCD_I2C_Clear();
            Menu_RenderEdit();
            break;
        }

        if (Local_u8Redraw != 0u) {
            g_u16MenuTimeout = 0u;
            Menu_RenderSelect();
        } else {
            g_u16MenuTimeout++;
            if (g_u16MenuTimeout >= 3000u) {
                /* 60s timeout -> return to dashboard */
                g_u8State = MENU_DASHBOARD;
                LCD_I2C_Clear();
            }
        }
        break;

    /* ---------- EDIT LOW LIMIT ---------- */
    case MENU_EDIT_LOW:
        if (Panel_IsPressed(BTN_UP)) {
            g_s16EditValue += PatientCfg_GetStep(g_u8SelectedVital);
            Local_u8Redraw = 1u;
        }
        if (Panel_IsPressed(BTN_DOWN)) {
            g_s16EditValue -= PatientCfg_GetStep(g_u8SelectedVital);
            Local_u8Redraw = 1u;
        }
        if (Panel_IsPressed(BTN_MENU)) {
            PatientCfg_SetLow(g_u8SelectedVital, g_s16EditValue);
            Local_stLim       = PatientCfg_GetLimits(g_u8SelectedVital);
            g_s16EditValue    = Local_stLim.HighLimit;
            g_u8State         = MENU_EDIT_HIGH;
            g_u16MenuTimeout  = 0u;
            LCD_I2C_Clear();
            Menu_RenderEdit();
            break;
        }

        if (Local_u8Redraw != 0u) {
            g_u16MenuTimeout = 0u;
            Menu_RenderEdit();
        } else {
            g_u16MenuTimeout++;
            if (g_u16MenuTimeout >= 3000u) {
                g_u8State = MENU_DASHBOARD;
                LCD_I2C_Clear();
            }
        }
        break;

    /* ---------- EDIT HIGH LIMIT ---------- */
    case MENU_EDIT_HIGH:
        if (Panel_IsPressed(BTN_UP)) {
            g_s16EditValue += PatientCfg_GetStep(g_u8SelectedVital);
            Local_u8Redraw = 1u;
        }
        if (Panel_IsPressed(BTN_DOWN)) {
            g_s16EditValue -= PatientCfg_GetStep(g_u8SelectedVital);
            Local_u8Redraw = 1u;
        }
        if (Panel_IsPressed(BTN_MENU)) {
            PatientCfg_SetHigh(g_u8SelectedVital, g_s16EditValue);
            g_u8State = MENU_DASHBOARD;
            LCD_I2C_Clear();
            break;
        }

        if (Local_u8Redraw != 0u) {
            g_u16MenuTimeout = 0u;
            Menu_RenderEdit();
        } else {
            g_u16MenuTimeout++;
            if (g_u16MenuTimeout >= 3000u) {
                g_u8State = MENU_DASHBOARD;
                LCD_I2C_Clear();
            }
        }
        break;

    default:
        g_u8State = MENU_DASHBOARD;
        break;
    }
}

uint8 Menu_IsInDashboard(void)
{
    return (g_u8State == MENU_DASHBOARD) ? 1u : 0u;
}
