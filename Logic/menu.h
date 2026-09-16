#ifndef MENU_H
#define MENU_H

/*
 * Logic — Menu & dashboard controller.
 *
 * States:
 *   DASHBOARD      — live vital-sign display with alarm banner.
 *   SELECT_VITAL   — scroll through vitals to choose which to edit.
 *   EDIT_LOW       — adjust the low alarm limit with Up/Down.
 *   EDIT_HIGH      — adjust the high alarm limit with Up/Down.
 *
 * Buttons (from HAL/Panel):
 *   Menu   — enter menu from dashboard, advance / confirm in editor.
 *   Up     — increase value or scroll.
 *   Down   — decrease value or scroll.
 */

#include "STD_TYPES.h"

#define MENU_DASHBOARD      0u
#define MENU_SELECT_VITAL   1u
#define MENU_EDIT_LOW       2u
#define MENU_EDIT_HIGH      3u

/*
 * Description : Initialise to dashboard state.
 */
void Menu_Init(void);

/*
 * Description : Refresh the LCD and process button events.
 *               Call periodically (≈ 100–200 ms) from the main loop.
 */
void Menu_Update(void);

/*
 * Description : Returns 1 when the dashboard is displayed (not editing).
 */
uint8 Menu_IsInDashboard(void);

#endif /* MENU_H */
