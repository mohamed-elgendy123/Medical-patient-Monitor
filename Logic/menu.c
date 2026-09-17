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
#include "monitor_fsm.h"
#include "menu.h"

#include <string.h>   /* memset */

/* ======================== Private state ======================== */

static uint8  g_u8State         = MENU_DASHBOARD;
static uint8  g_u8SelectedVital = 0u;
static sint16 g_s16EditValue    = 0;
static uint8  g_u8DashTick      = 0u;  /* for alarm banner alternation */

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

/* ======================== Dashboard ======================== */

/*
 * Layout:
 *   Col  0123456789012345
 *   R0   HR:nnn S:nnn T:nn
 *   R1   RR:nn  BP:nnn      (or alarm banner)
 */
static void Dashboard_Render(void)
{
    char        Local_acLine[LCD_I2C_COLS + 1u];
    VitalData_t *Local_pstV;
    uint8       Local_u8Alarm;

    if (Monitor_GetState() == SYSTEM_STATE_STANDBY) {
        /* FR-16: All physiological alarms are suspended; the LCD shows STANDBY
         * with a large reminder and the elapsed standby time. */
        uint32 Local_u32Sec = Monitor_GetStandbyElapsedSec();
        uint16 Local_u16Min = (uint16)(Local_u32Sec / 60U);
        uint8  Local_u8Sec  = (uint8)(Local_u32Sec % 60U);

        /* Line 0: "*** STANDBY  ***" */
        memset(Local_acLine, ' ', LCD_I2C_COLS);
        Local_acLine[LCD_I2C_COLS] = '\0';
        PutStr(Local_acLine, 0, "*** STANDBY  ***");
        LCD_I2C_SetCursor(0, 0);
        LCD_I2C_WriteString(Local_acLine);

        /* Line 1: "TIME:    mm:ss" */
        memset(Local_acLine, ' ', LCD_I2C_COLS);
        Local_acLine[LCD_I2C_COLS] = '\0';
        PutStr(Local_acLine, 0, "TIME:    ");
        if (Local_u16Min < 10U) {
            Local_acLine[9]  = '0';
            Local_acLine[10] = (char)('0' + Local_u16Min);
        } else {
            Local_acLine[9]  = (char)('0' + (Local_u16Min / 10U));
            Local_acLine[10] = (char)('0' + (Local_u16Min % 10U));
        }
        Local_acLine[11] = ':';
        Local_acLine[12] = (char)('0' + (Local_u8Sec / 10U));
        Local_acLine[13] = (char)('0' + (Local_u8Sec % 10U));

        LCD_I2C_SetCursor(1, 0);
        LCD_I2C_WriteString(Local_acLine);
        return;
    }

    /* ---------- Row 0: "HR:xxx S:xxx T:xx" (16 chars) ---------- */
    memset(Local_acLine, ' ', LCD_I2C_COLS);
    Local_acLine[LCD_I2C_COLS] = '\0';

    /* HR (col 0-5): "HR:" + 3 chars */
    PutStr(Local_acLine, 0, "HR:");
    Local_pstV = PatientCfg_GetVital(VITAL_HR);
    if (Local_pstV != NULL && Local_pstV->Valid) {
        PutNum(Local_acLine, 3, Local_pstV->Value);
    } else {
        PutStr(Local_acLine, 3, "---");
    }

    /* SpO2 (col 6-11): " S:" + 3 chars */
    PutStr(Local_acLine, 6, " S:");
    Local_pstV = PatientCfg_GetVital(VITAL_SPO2);
    if (Local_pstV != NULL && Local_pstV->Valid) {
        PutNum(Local_acLine, 9, Local_pstV->Value);
    } else {
        PutStr(Local_acLine, 9, "---");
    }

    /* Temp (col 12-15): "T:" + 2 chars */
    PutStr(Local_acLine, 12, "T:");
    Local_pstV = PatientCfg_GetVital(VITAL_TEMP);
    if (Local_pstV != NULL && Local_pstV->Valid) {
        PutNum(Local_acLine, 14, Local_pstV->Value / 10);
    } else {
        PutStr(Local_acLine, 14, "--");
    }

    LCD_I2C_SetCursor(0, 0);
    LCD_I2C_WriteString(Local_acLine);

    /* ---------- Row 1 ---------- */
    memset(Local_acLine, ' ', LCD_I2C_COLS);
    Local_acLine[LCD_I2C_COLS] = '\0';

    {
        Local_u8Alarm = PatientCfg_GetHighestAlarm();

        if (Local_u8Alarm < VITAL_COUNT && (g_u8DashTick & 0x04u)) {
            /* Alarm banner per FR-17 — alternates every ~4 update cycles */
            uint8        Local_u8Side = PatientCfg_GetAlarmSide(Local_u8Alarm);
            uint8        Local_u8Prio = PatientCfg_GetAlarmPriority(Local_u8Alarm);
            VitalData_t *Local_pstAlarmV = PatientCfg_GetVital(Local_u8Alarm);
            sint16       Local_s16Val = (Local_pstAlarmV != NULL) ? Local_pstAlarmV->Value : 0;

            if (Local_u8Prio == ALARM_PRIO_HIGH) {
                /* High priority alarm: enclosed in '!!' and '!!' per FR-17 */
                Local_acLine[0]  = '!';
                Local_acLine[1]  = '!';
                Local_acLine[14] = '!';
                Local_acLine[15] = '!';

                if (Local_u8Alarm == VITAL_HR) {
                    PutStr(Local_acLine, 2, (Local_u8Side == ALARM_LOW_SIDE) ? "HR LOW   " : "HR HIGH  ");
                    PutNum(Local_acLine, 11, Local_s16Val);
                } else if (Local_u8Alarm == VITAL_SPO2) {
                    PutStr(Local_acLine, 2, "SPO2 LOW ");
                    PutNum(Local_acLine, 11, Local_s16Val);
                } else if (Local_u8Alarm == VITAL_NIBP) {
                    PutStr(Local_acLine, 2, "BP LOW   ");
                    PutNum(Local_acLine, 11, Local_s16Val);
                }
            } else {
                /* Medium priority alarm: enclosed in '!' and '!' per FR-17 */
                Local_acLine[0]  = '!';
                Local_acLine[15] = '!';

                if (Local_u8Alarm == VITAL_TEMP) {
                    char Local_acTBuf[6];
                    FormatTemp(Local_s16Val, Local_acTBuf, sizeof(Local_acTBuf));
                    PutStr(Local_acLine, 1, (Local_u8Side == ALARM_LOW_SIDE) ? "TEMP LOW  " : "TEMP HIGH ");
                    PutStr(Local_acLine, 11, Local_acTBuf);
                } else if (Local_u8Alarm == VITAL_RR) {
                    PutStr(Local_acLine, 1, (Local_u8Side == ALARM_LOW_SIDE) ? "RESP LOW  " : "RESP HIGH ");
                    PutNum(Local_acLine, 11, Local_s16Val);
                } else if (Local_u8Alarm == VITAL_NIBP) {
                    PutStr(Local_acLine, 1, "BP HIGH   ");
                    PutNum(Local_acLine, 11, Local_s16Val);
                } else if (Local_u8Alarm == VITAL_HR) {
                    PutStr(Local_acLine, 1, (Local_u8Side == ALARM_LOW_SIDE) ? "HR LOW    " : "HR HIGH   ");
                    PutNum(Local_acLine, 11, Local_s16Val);
                }
            }
        } else {
            /* Normal: RR (col 0-5) + BP (col 7-15) */
            PutStr(Local_acLine, 0, "RR:");
            Local_pstV = PatientCfg_GetVital(VITAL_RR);
            if (Local_pstV != NULL && Local_pstV->Valid) {
                PutNum(Local_acLine, 3, Local_pstV->Value);
            } else {
                PutStr(Local_acLine, 3, "--");
            }

            PutStr(Local_acLine, 7, "  BP:");
            Local_pstV = PatientCfg_GetVital(VITAL_NIBP);
            if (Local_pstV != NULL && Local_pstV->Valid) {
                PutNum(Local_acLine, 12, Local_pstV->Value);
            } else {
                PutStr(Local_acLine, 12, "---");
            }
        }
    }

    LCD_I2C_SetCursor(1, 0);
    LCD_I2C_WriteString(Local_acLine);

    g_u8DashTick++;
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
    g_u8DashTick      = 0u;
}

void Menu_Update(void)
{
    VitalLimits_t Local_stLim;

    switch (g_u8State) {

    /* ---------- DASHBOARD ---------- */
    case MENU_DASHBOARD:
        if (Panel_IsPressed(BTN_MENU)) {
            g_u8State         = MENU_SELECT_VITAL;
            g_u8SelectedVital = 0u;
            LCD_I2C_Clear();
            Menu_RenderSelect();
            return;
        }
        Dashboard_Render();
        break;

    /* ---------- SELECT VITAL ---------- */
    case MENU_SELECT_VITAL:
        if (Panel_IsPressed(BTN_UP)) {
            g_u8SelectedVital = (g_u8SelectedVital == 0u)
                              ? (uint8)(VITAL_COUNT - 1u)
                              : (uint8)(g_u8SelectedVital - 1u);
        }
        if (Panel_IsPressed(BTN_DOWN)) {
            g_u8SelectedVital++;
            if (g_u8SelectedVital >= VITAL_COUNT) { g_u8SelectedVital = 0u; }
        }
        if (Panel_IsPressed(BTN_MENU)) {
            Local_stLim    = PatientCfg_GetLimits(g_u8SelectedVital);
            g_s16EditValue = Local_stLim.LowLimit;
            g_u8State      = MENU_EDIT_LOW;
            LCD_I2C_Clear();
            Menu_RenderEdit();
            return;
        }
        Menu_RenderSelect();
        break;

    /* ---------- EDIT LOW LIMIT ---------- */
    case MENU_EDIT_LOW:
        if (Panel_IsPressed(BTN_UP)) {
            g_s16EditValue += PatientCfg_GetStep(g_u8SelectedVital);
        }
        if (Panel_IsPressed(BTN_DOWN)) {
            g_s16EditValue -= PatientCfg_GetStep(g_u8SelectedVital);
        }
        if (Panel_IsPressed(BTN_MENU)) {
            PatientCfg_SetLow(g_u8SelectedVital, g_s16EditValue);
            Local_stLim    = PatientCfg_GetLimits(g_u8SelectedVital);
            g_s16EditValue = Local_stLim.HighLimit;
            g_u8State      = MENU_EDIT_HIGH;
            LCD_I2C_Clear();
            Menu_RenderEdit();
            return;
        }
        Menu_RenderEdit();
        break;

    /* ---------- EDIT HIGH LIMIT ---------- */
    case MENU_EDIT_HIGH:
        if (Panel_IsPressed(BTN_UP)) {
            g_s16EditValue += PatientCfg_GetStep(g_u8SelectedVital);
        }
        if (Panel_IsPressed(BTN_DOWN)) {
            g_s16EditValue -= PatientCfg_GetStep(g_u8SelectedVital);
        }
        if (Panel_IsPressed(BTN_MENU)) {
            PatientCfg_SetHigh(g_u8SelectedVital, g_s16EditValue);
            g_u8State = MENU_DASHBOARD;
            LCD_I2C_Clear();
            Dashboard_Render();
            return;
        }
        Menu_RenderEdit();
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
