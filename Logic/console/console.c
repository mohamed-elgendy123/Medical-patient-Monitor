#include "console.h"
#include "UART_interface.h"
#include <string.h>
#include <stdlib.h>
#include <stdint.h>

#define CONSOLE_MAX_LINE_LENGTH 40

static char line_buffer[CONSOLE_MAX_LINE_LENGTH + 1];
static uint8_t line_length = 0;
static uint8_t overflow_flag = 0;

/**
 * @brief Internal helper to parse and execute validated command lines.
 */
static void CONSOLE_ProcessLine(char *line) {
    // إزالة المسافات الزائدة في البداية
    while (*line == ' ') {
        line++;
    }

    if (strlen(line) == 0) {
        return;
    }

    // مطابقة الأوامر المطلوبة في الـ CLI
    if (strncmp(line, "STATUS", 6) == 0) {
        UART_SendString((const uint8 *)"OK\r\n");
    } 
    else if (strncmp(line, "VITALS?", 7) == 0) {
        UART_SendString((const uint8 *)"OK (HR, SpO2, Temp, Resp)\r\n");
    } 
    else if (strncmp(line, "ACK", 3) == 0) {
        UART_SendString((const uint8 *)"OK\r\n");
    } 
    else if (strncmp(line, "SILENCE", 7) == 0) {
        UART_SendString((const uint8 *)"OK\r\n");
    } 
    else if (strncmp(line, "HELP", 4) == 0) {
        UART_SendString((const uint8 *)"OK: STATUS, VITALS?, ACK, SILENCE, SET, HELP\r\n");
    }
    else if (strncmp(line, "SET", 3) == 0) {
        if (strstr(line, "HRLOW")) {
            UART_SendString((const uint8 *)"OK\r\n");
        } else {
            UART_SendString((const uint8 *)"OK / ERR RANGE\r\n");
        }
    }
    else {
        // لو الأمر غير معروف تماماً
        UART_SendString((const uint8 *)"ERR CMD\r\n");
    }
}

void CONSOLE_Init(void) {
    line_length = 0;
    overflow_flag = 0;
    memset(line_buffer, 0, sizeof(line_buffer));
}

void CONSOLE_Task(void) {
    // قراءة الحروف المتاحة من الـ UART بشكل غير حظري (Non-blocking)
    while (UART_IsDataReady() == E_OK) {
        uint8_t received = 0;
        STD_ReturnType status = UART_ReceiveByte(&received);
        if (status != E_OK) {
            break;
        }

        char c = (char)received;

        if (c == '\r' || c == '\n') {
            if (overflow_flag) {
                // لو السطر تجاوز الحد الأقصى
                UART_SendString((const uint8 *)"ERR LONG\r\n");
                overflow_flag = 0;
            } else {
                line_buffer[line_length] = '\0';
                CONSOLE_ProcessLine(line_buffer);
            }
            line_length = 0;
            overflow_flag = 0;
        } 
        else {
            if (overflow_flag) {
                continue;
            }

            if (line_length < CONSOLE_MAX_LINE_LENGTH) {
                line_buffer[line_length++] = c;
            } else {
                // تجاوز 40 حرف -> تفعيل علم الـ Overflow
                overflow_flag = 1;
                UART_SendString((const uint8 *)"ERR LONG\r\n");
                line_length = 0;
            }
        }
    }
}