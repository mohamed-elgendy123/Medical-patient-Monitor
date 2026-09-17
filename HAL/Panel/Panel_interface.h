#ifndef PANEL_INTERFACE_H
#define PANEL_INTERFACE_H

/*
 * HAL Panel — operator buttons with 10 ms software debounce.
 *
 * Five active-low buttons on PORTC with internal pull-ups:
 *   PC2 = Silence   (mute audio alarm for 120 s)
 *   PC3 = Menu      (enter / confirm in limits editor)
 *   PC4 = Up        (increase value or scroll)
 *   PC5 = Down      (decrease value or scroll)
 *   PC6 = Standby   (toggle monitoring on / off)
 *
 * PC0 (SCL) and PC1 (SDA) are reserved for I2C — not touched.
 */

#include "STD_TYPES.h"

/* -------------------- Button identifiers -------------------- */
#define BTN_SILENCE   0u   /* PC2 */
#define BTN_MENU      1u   /* PC3 */
#define BTN_UP        2u   /* PC4 */
#define BTN_DOWN      3u   /* PC5 */
#define BTN_STANDBY   4u   /* PC6 */
#define BTN_COUNT     5u

/*
 * Description : Configure PC2–PC6 as inputs with pull-ups.
 */
void Panel_Init(void);

/*
 * Description : Sample all buttons and run the debounce filter.
 *               Must be called every 10 ms (e.g. from a timer ISR or main loop).
 */
void Panel_Update(void);

/*
 * Description : Returns 1 on the first call after a debounced press is detected
 *               (falling edge: released → pressed).  Latched — auto-clears on read.
 */
uint8 Panel_IsPressed(uint8 Copy_u8Button);

/*
 * Description : Returns 1 while the 120 s silence timer is still counting down.
 */
uint8 Panel_IsSilenceActive(void);

/*
 * Description : Returns 1 if any button press event is currently pending.
 */
uint8 Panel_HasEvent(void);

#endif /* PANEL_INTERFACE_H */
