#ifndef CONSOLE_H
#define CONSOLE_H

#include <stdint.h>

/**
 * @brief Initialize the console command parser module.
 */
void CONSOLE_Init(void);

/**
 * @brief Periodic console task to process incoming characters 
 *        and parse command lines (matches scheduler Task_Console).
 */
void CONSOLE_Task(void);

#endif /* CONSOLE_H */