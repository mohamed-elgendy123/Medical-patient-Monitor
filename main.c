<<<<<<< HEAD
#ifndef F_CPU
=======
/*
>>>>>>> f271b1c5d989dc0d068c2e73d7cebb91479a2773
#define F_CPU 8000000UL
#endif

#include "LIB/STD_TYPES.h"
#include "MCAL/GPIO/GPIO_interface.h"
#include "MCAL/SPI/SPI_interface.h"
#include "HAL/ShiftReg/ShiftReg_interface.h"
#include "HAL/NurseCall/NurseCall_interface.h"

/* دالة تأخير بسيطة للاختبار الميداني */
static void delay_ms(uint32 Copy_u32Time)
{
    uint32 i;
    for(i = 0; i < (Copy_u32Time * 500u); i++)
    {
        asm("NOP");
    }
}

int main(void)
{
    /* 1. Initialize HAL Drivers for Student 2 */
    ShiftReg_voidInit();
    NurseCall_voidInit();

    while (1)
    {
        /* Test Pattern 1: High Alarm State */
        ShiftReg_voidWriteByte(0xFF);  /* 8 LEDs ON */
        NurseCall_voidEnable();        /* Nurse Call Active */
        delay_ms(1000);

        /* Test Pattern 2: Normal State */
        ShiftReg_voidWriteByte(0x00);  /* 8 LEDs OFF */
        NurseCall_voidDisable();       /* Nurse Call Idle */
        delay_ms(1000);

        /* Test Pattern 3: Alternating Pattern */
        ShiftReg_voidWriteByte(0xAA);
        delay_ms(1000);
    }
<<<<<<< HEAD
=======
  }
}

*/


//كود اختبار ربط الtrends مع الUART و الADC
#define F_CPU 16000000UL
#include <avr/io.h>
#include <util/delay.h>
#include <stdlib.h>
#include "Logic/trends/trends.h"

// 1. تهيئة الـ UART (Baud Rate: 9600 @ 16MHz)
void UART_init(void) {
    uint16_t ubrr_value = 103; 
    UBRRH = (uint8_t)(ubrr_value >> 8);
    UBRRL = (uint8_t)(ubrr_value);
    UCSRB = (1 << TXEN) | (1 << RXEN); // تفعيل الإرسال والاستقبال
    UCSRC = (1 << URSEL) | (1 << UCSZ1) | (1 << UCSZ0); // 8-bit data, 1 stop bit
}

void UART_sendChar(char data) {
    while (!(UCSRA & (1 << UDRE)));
    UDR = data;
}

void UART_sendString(char *str) {
    while (*str) {
        UART_sendChar(*str++);
    }
}

void UART_sendNumber(uint16_t num) {
    char buffer[10];
    itoa(num, buffer, 10);
    UART_sendString(buffer);
}

// 2. تهيئة الـ ADC
void ADC_init(void) {
    ADMUX = (1 << REFS0); // AVcc (5V) مرجع
    ADCSRA = (1 << ADEN) | (1 << ADPS2) | (1 << ADPS1) | (1 << ADPS0); // Prescaler 128
}

uint16_t ADC_read(uint8_t channel) {
    ADMUX = (ADMUX & 0xF0) | (channel & 0x07);
    ADCSRA |= (1 << ADSC);
    while (ADCSRA & (1 << ADSC));
    return ADC;
}

int main(void) {
    UART_init();
    ADC_init();
    Trends_Init(); // تهيئة مخزن الـ Trends

    DDRB |= (1 << PB0); // جعل PB0 مخرج لـ LED

    uint8_t trend_timer = 0; // عداد لحساب الـ 10 ثواني

    while (1) {
        PORTB ^= (1 << PB0); // Blink test في كل دورة
        
        UART_sendString("--- Patient Vitals ---\r\n");

        for (uint8_t ch = 0; ch < 4; ch++) {
            uint16_t val = ADC_read(ch);
            UART_sendString("Ch ");
            UART_sendNumber(ch);
            UART_sendString(": ");
            UART_sendNumber(val);
            UART_sendString("\r\n");
        }
        
        UART_sendString("\r\n");

        // تخزين عينة جديدة في الـ Ring Buffer كل 10 ثواني (20 دورة × 500ms)
        trend_timer++;
        if (trend_timer >= 20) {
            trend_timer = 0;
            Task_Trend(); // تسجيل عينة الـ Trends الجديدة تلقائياً
        }

        _delay_ms(500);

// --- فحص واستقبال أمر TREND? مؤقتاً للتجربة ---
        if (UCSRA & (1 << RXC)) { // لو فيه بيانات واصلة من الـ UART
            char received_char = UDR; // قراءة الحرف الوارد
            
            // للتبسيط في التجربة: لو استقبلنا حرف 'T' كمثال، نطبع الـ Trends مباشرة
            if (received_char == 'T' || received_char == 't') {
                UART_sendString("\r\n--- Sending Trends CSV Data ---\r\n");
                
                uint8_t count = Trends_GetCount();
                char line_buffer[50];
                
                for (uint8_t i = 0; i < count; i++) {
                    Trends_GetSampleLine(i, line_buffer);
                    UART_sendString(line_buffer);
                }
                UART_sendString("--- End of Trends ---\r\n\r\n");
            }
        }


    }
>>>>>>> f271b1c5d989dc0d068c2e73d7cebb91479a2773

    return 0;
}