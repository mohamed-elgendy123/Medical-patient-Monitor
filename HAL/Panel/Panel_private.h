#ifndef PANEL_PRIVATE_H
#define PANEL_PRIVATE_H

/*
 * HAL Panel — private constants.  Include ONLY from Panel.c.
 */

/* PORTC pin assignments (PC0 = SCL, PC1 = SDA are I2C — do not touch) */
#define PANEL_PORT       GPIO_PORTC
#define PANEL_PIN_BASE   2u            /* first button on PC2 */

/*
 * Debounce: require DEBOUNCE_COUNT consecutive identical readings
 * before accepting the new state.  At 10 ms per sample → 30 ms settle.
 */
#define DEBOUNCE_COUNT   3u

/* Silence duration: 120 s at 10 ms per tick = 12 000 ticks (fits uint16) */
#define SILENCE_DURATION_TICKS  12000u

#endif /* PANEL_PRIVATE_H */
