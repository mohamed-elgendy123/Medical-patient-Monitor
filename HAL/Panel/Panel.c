/*
 * HAL Panel — 10 ms debounced operator buttons.
 * Pin assignments per SimulIDE circuit:
 *   PC2 = Silence   (BTN_SILENCE = 0)
 *   PC3 = Menu      (BTN_MENU = 1)
 *   PC4 = Up        (BTN_UP = 2)
 *   PC5 = Down      (BTN_DOWN = 3)
 *   PC6 = Standby   (BTN_STANDBY = 4)
 *
 * All buttons are active-low (pressed = GND) with internal pull-ups enabled.
 * JTAG is disabled twice to free PC2..PC5 for GPIO.
 */

#include <avr/io.h>
#include "STD_TYPES.h"
#include "GPIO_interface.h"
#include "Panel_interface.h"
#include "Panel_private.h"

typedef struct {
    uint8 port;
    uint8 pin;
} ButtonPin_t;

static const ButtonPin_t g_asButtonPins[BTN_COUNT] = {
    { GPIO_PORTC, GPIO_PIN2 }, /* BTN_SILENCE */
    { GPIO_PORTC, GPIO_PIN3 }, /* BTN_MENU */
    { GPIO_PORTC, GPIO_PIN4 }, /* BTN_UP */
    { GPIO_PORTC, GPIO_PIN5 }, /* BTN_DOWN */
    { GPIO_PORTC, GPIO_PIN6 }  /* BTN_STANDBY */
};

/* ======================== Private state ======================== */

static uint8  g_au8Debounce[BTN_COUNT];    /* consecutive same-reading counter */
static uint8  g_au8Stable[BTN_COUNT];      /* debounced level  (1=released)   */
static uint8  g_au8Pressed[BTN_COUNT];     /* latched press event             */
static uint16 g_u16SilenceTimer;           /* ticks remaining (0 = inactive)  */

/* ======================== Functions ======================== */

void Panel_Init(void)
{
    uint8 i;

    /* 1. Disable JTAG twice within 4 cycles to release PC2..PC5 */
    MCUCSR |= (1u << 7);
    MCUCSR |= (1u << 7);

    /* 2. Configure PC2..PC6 as inputs with internal pull-ups enabled */
    DDRC &= ~(0x7Cu);
    PORTC |= 0x7Cu;

    for (i = 0; i < BTN_COUNT; i++) {
        GPIO_SetPinDirection(g_asButtonPins[i].port, g_asButtonPins[i].pin, GPIO_INPUT_PULLUP);
        g_au8Debounce[i] = 0u;
        g_au8Stable[i]   = 1u;   /* released (HIGH with pull-up) */
        g_au8Pressed[i]  = 0u;
    }
    g_u16SilenceTimer = 0u;
}

void Panel_Update(void)
{
    uint8 i;
    uint8 Local_u8Raw;

    for (i = 0; i < BTN_COUNT; i++) {
        GPIO_GetPinValue(g_asButtonPins[i].port, g_asButtonPins[i].pin, &Local_u8Raw);

        if (Local_u8Raw != g_au8Stable[i]) {
            /* Pin differs from accepted state — count up */
            g_au8Debounce[i]++;
            if (g_au8Debounce[i] >= DEBOUNCE_COUNT) {
                /* Accept the new level */
                uint8 Local_u8Prev = g_au8Stable[i];
                g_au8Stable[i]     = Local_u8Raw;
                g_au8Debounce[i]   = 0u;

                /* Falling edge  (1 -> 0 = released -> pressed) */
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
