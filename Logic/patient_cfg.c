/*
 * Logic — Patient configuration implementation.
 *
 * Default alarm limits for three age profiles are stored in Flash (PROGMEM).
 * At runtime the active limits live in RAM and can be tuned via the menu.
 */

#include "STD_TYPES.h"
#include "patient_cfg.h"
#include <avr/pgmspace.h>

/* ======================== Private data ======================== */

static VitalLimits_t g_astLimits[VITAL_COUNT];
static VitalData_t   g_astVitals[VITAL_COUNT];
static uint8         g_u8ActiveProfile = PROFILE_ADULT;

/*
 * PROGMEM defaults — [profile][vital][0=low, 1=high]
 *
 *                       HR         SpO2      Temp×10      RR       NIBP
 * Adult            60–100 bpm   90–100 %   36.0–37.5   12–20    90–140 mmHg
 * Paediatric       70–120       92–100     36.0–37.5   18–30    80–120
 * Neonatal        100–160       88– 98     36.5–37.5   30–60    60– 90
 */
static const sint16 g_as16Defaults[PROFILE_COUNT][VITAL_COUNT][2] PROGMEM = {
    /* Adult */
    { {60, 100}, {90, 100}, {360, 375}, {12, 20}, {90, 140} },
    /* Paediatric */
    { {70, 120}, {92, 100}, {360, 375}, {18, 30}, {80, 120} },
    /* Neonatal */
    { {100, 160}, {88, 98}, {365, 375}, {30, 60}, {60, 90} }
};

/* Short display names  (25 bytes RAM — acceptable) */
static const char g_acNames[VITAL_COUNT][5] = {
    "HR", "SpO2", "Temp", "RR", "BP"
};

static const char g_acProfiles[PROFILE_COUNT][9] = {
    "Adult", "Paed", "Neonatal"
};

/* Menu step sizes */
static const sint16 g_as16Steps[VITAL_COUNT] = {
    1,   /* HR   : 1 bpm          */
    1,   /* SpO2 : 1 %            */
    5,   /* Temp : 0.5 °C  (×10)  */
    1,   /* RR   : 1 /min         */
    5    /* NIBP : 5 mmHg         */
};

/* ======================== Functions ======================== */

void PatientCfg_Init(void)
{
    uint8 i;
    for (i = 0; i < VITAL_COUNT; i++) {
        g_astVitals[i].Value      = 0;
        g_astVitals[i].Valid      = 0;
        g_astVitals[i].AlarmLevel = ALARM_NONE;
    }
    PatientCfg_LoadProfile(PROFILE_ADULT);
}

void PatientCfg_LoadProfile(uint8 Copy_u8Profile)
{
    uint8 i;
    if (Copy_u8Profile >= PROFILE_COUNT) { return; }

    g_u8ActiveProfile = Copy_u8Profile;
    for (i = 0; i < VITAL_COUNT; i++) {
        g_astLimits[i].LowLimit  =
            (sint16)pgm_read_word(&g_as16Defaults[Copy_u8Profile][i][0]);
        g_astLimits[i].HighLimit =
            (sint16)pgm_read_word(&g_as16Defaults[Copy_u8Profile][i][1]);
    }
}

uint8 PatientCfg_GetActiveProfile(void)
{
    return g_u8ActiveProfile;
}

VitalLimits_t PatientCfg_GetLimits(uint8 Copy_u8VitalId)
{
    VitalLimits_t Local_stDummy = {0, 0};
    if (Copy_u8VitalId >= VITAL_COUNT) { return Local_stDummy; }
    return g_astLimits[Copy_u8VitalId];
}

void PatientCfg_SetLow(uint8 Copy_u8VitalId, sint16 Copy_s16Value)
{
    if (Copy_u8VitalId >= VITAL_COUNT) { return; }
    g_astLimits[Copy_u8VitalId].LowLimit = Copy_s16Value;
}

void PatientCfg_SetHigh(uint8 Copy_u8VitalId, sint16 Copy_s16Value)
{
    if (Copy_u8VitalId >= VITAL_COUNT) { return; }
    g_astLimits[Copy_u8VitalId].HighLimit = Copy_s16Value;
}

VitalData_t* PatientCfg_GetVital(uint8 Copy_u8VitalId)
{
    if (Copy_u8VitalId >= VITAL_COUNT) { return NULL; }
    return &g_astVitals[Copy_u8VitalId];
}

void PatientCfg_EvalAlarms(void)
{
    uint8 i;
    for (i = 0; i < VITAL_COUNT; i++) {
        if (g_astVitals[i].Valid == 0u) {
            g_astVitals[i].AlarmLevel = ALARM_NONE;
            continue;
        }
        if (g_astVitals[i].Value < g_astLimits[i].LowLimit ||
            g_astVitals[i].Value > g_astLimits[i].HighLimit)
        {
            g_astVitals[i].AlarmLevel = ALARM_HIGH;
        } else {
            g_astVitals[i].AlarmLevel = ALARM_NONE;
        }
    }
}

uint8 PatientCfg_GetHighestAlarm(void)
{
    uint8 i;
    for (i = 0; i < VITAL_COUNT; i++) {
        if (g_astVitals[i].AlarmLevel != ALARM_NONE) {
            return i;
        }
    }
    return VITAL_COUNT;  /* no alarm active */
}

const char* PatientCfg_VitalName(uint8 Copy_u8VitalId)
{
    if (Copy_u8VitalId >= VITAL_COUNT) { return "?"; }
    return g_acNames[Copy_u8VitalId];
}

const char* PatientCfg_ProfileName(uint8 Copy_u8Profile)
{
    if (Copy_u8Profile >= PROFILE_COUNT) { return "?"; }
    return g_acProfiles[Copy_u8Profile];
}

sint16 PatientCfg_GetStep(uint8 Copy_u8VitalId)
{
    if (Copy_u8VitalId >= VITAL_COUNT) { return 1; }
    return g_as16Steps[Copy_u8VitalId];
}
