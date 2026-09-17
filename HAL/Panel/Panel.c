/*
 * HAL Panel — 10 ms debounced operator buttons on PORTC (PC2–PC6).
 *
 * Buttons are active-low (pressed = GND) with internal pull-ups enabled.
 * Debounce uses a counter: a new stable state is accepted only after
 * DEBOUNCE_COUNT consecutive identical readings.
 *
 * The Silence button (PC2) starts a 120 s countdown; Panel_IsSilenceActive()
 * returns 1 while the timer is still running.
 */

#include "STD_TYPES.h"
#include "GPIO_interface.h"
#include "Panel_interface.h"
#include "Panel_private.h"

/* ======================== Private state ======================== */

static uint8  g_au8Debounce[BTN_COUNT];    /* consecutive same-reading counter */
static uint8  g_au8Stable[BTN_COUNT];      /* debounced level  (1=released)   */
static uint8  g_au8Pressed[BTN_COUNT];     /* latched press event             */
static uint16 g_u16SilenceTimer;           /* ticks remaining (0 = inactive)  */

/* ======================== Functions ======================== */

void Panel_Init(void)
{
    /* Disable JTAG to free PC2..PC5 for GPIO buttons (Silence, Menu, Up, Down)
     * ATmega32 datasheet requires JTD (bit 7 of MCUCSR at IO 0x34) to be written
     * twice within 4 clock cycles. */
    uint8 Local_u8Temp;
    __asm__ __volatile__ (
        "in %0, 0x34\n\t"
        "ori %0, 0x80\n\t"
        "out 0x34, %0\n\t"
        "out 0x34, %0\n\t"
        : "=&d" (Local_u8Temp)
    );

    uint8 i;
    for (i = 0; i < BTN_COUNT; i++) {
        uint8 Local_u8InitVal = GPIO_HIGH;
        GPIO_SetPinDirection(PANEL_PORT, PANEL_PIN_BASE + i, GPIO_INPUT_PULLUP);
        GPIO_GetPinValue(PANEL_PORT, PANEL_PIN_BASE + i, &Local_u8InitVal);
        g_au8Debounce[i] = 0u;
        g_au8Stable[i]   = Local_u8InitVal;
        g_au8Pressed[i]  = 0u;
    }
    g_u16SilenceTimer = 0u;
}

void Panel_Update(void)
{
    uint8 i;
    uint8 Local_u8Raw;

    for (i = 0; i < BTN_COUNT; i++) {
        GPIO_GetPinValue(PANEL_PORT, PANEL_PIN_BASE + i, &Local_u8Raw);

        if (Local_u8Raw != g_au8Stable[i]) {
            /* Pin differs from accepted state — count up */
            g_au8Debounce[i]++;
            if (g_au8Debounce[i] >= DEBOUNCE_COUNT) {
                /* Accept the new level */
                uint8 Local_u8Prev = g_au8Stable[i];
                g_au8Stable[i]     = Local_u8Raw;
                g_au8Debounce[i]   = 0u;

                /* Falling edge  (1 → 0 = released → pressed) */
                if (Local_u8Prev == 1u && Local_u8Raw == 0u) {
                    g_au8Pressed[i] = 1u;

                    /* Silence button re-/starts the 120 s timer */
                    if (i == BTN_SILENCE) {
                        g_u16SilenceTimer = SILENCE_DURATION_TICKS;
                    }
                }
            }
        } else {
            /* Pin matches stable state — reset counter */
            g_au8Debounce[i] = 0u;
        }
    }

    /* Tick down the silence timer */
    if (g_u16SilenceTimer > 0u) {
        g_u16SilenceTimer--;
    }
}

uint8 Panel_IsPressed(uint8 Copy_u8Button)
{
    uint8 Local_u8Result;
    if (Copy_u8Button >= BTN_COUNT) { return 0u; }
    Local_u8Result = g_au8Pressed[Copy_u8Button];
    g_au8Pressed[Copy_u8Button] = 0u;     /* auto-clear on read */
    return Local_u8Result;
}

uint8 Panel_IsSilenceActive(void)
{
    return (g_u16SilenceTimer > 0u) ? 1u : 0u;
}

uint8 Panel_HasEvent(void)
{
    uint8 i;
    for (i = 0; i < BTN_COUNT; i++) {
        if (g_au8Pressed[i] != 0u) {
            return 1u;
        }
    }
    return 0u;
}
