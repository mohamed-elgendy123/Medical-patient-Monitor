/*
#define F_CPU 8000000UL

#include "STD_TYPES.h"
#include "TIMER_interface.h"
#include "INTERRUPT_interface.h"
#include "GPIO_interface.h"
#include "HR_Capture_interface.h"
#include "Annunciator_interface.h"

#define CPU_LOAD_PORT GPIO_PORTC
#define CPU_LOAD_PIN GPIO_PIN7

#define HIGH_ALARM_LED_PIN GPIO_PIN0
#define MEDIUM_ALARM_LED_PIN GPIO_PIN1
#define LOW_ALARM_LED_PIN GPIO_PIN2
#define HEARTBEAT_LED_PIN GPIO_PIN3

#define SELF_TEST_TICKS 300U
#define SELF_TEST_TONE_TICKS 50U
#define SCHEDULER_CYCLE_TICKS 1000U

static void Task_Panel(void);
static void Task_Fsm(void);
static void Task_Console(void);
static void Task_Timers(void);
static void Task_Alarms(void);
static void Task_Lcd(void);
static void Task_FastVitals(void);
static void Task_OneHz(void);
static void Task_Report(void);
static void Task_Trend(void);
static void Clear_AlarmState(void);
static void Clear_TrendState(void);
static void Application_ClearState(void);
static void Application_SelfTest(void);
static void Application_Init(void);

static void Task_Panel(void)
{
}

static void Task_Fsm(void)
{
}

static void Task_Console(void)
{
}

static void Task_Timers(void)
{
}

static void Task_Alarms(void)
{
}

static void Task_Lcd(void)
{
}

static void Task_FastVitals(void)
{
  HRC_Process();
}

static void Task_OneHz(void)
{
}

static void Task_Report(void)
{
}

static void Task_Trend(void)
{
}

static void Clear_AlarmState(void)
{
}

static void Clear_TrendState(void)
{
}

static void Application_ClearState(void)
{
  Clear_AlarmState();
  Clear_TrendState();
  ANN_Audio_SetPriority(ANN_PRI_NONE);
  HRC_ClearAsystole();
}

static void Application_SelfTest(void)
{
  u16 Local_u16Ticks = 0U;

  GPIO_SetPinValue(GPIO_PORTB, HIGH_ALARM_LED_PIN, GPIO_HIGH);
  GPIO_SetPinValue(GPIO_PORTB, MEDIUM_ALARM_LED_PIN, GPIO_HIGH);
  GPIO_SetPinValue(GPIO_PORTB, LOW_ALARM_LED_PIN, GPIO_HIGH);
  ANN_Audio_SetPriority(ANN_PRI_MEDIUM);

  (void)INTERRUPT_EnableGlobal();
  while (Local_u16Ticks < SELF_TEST_TICKS)
  {
    if (TIMER0_IsTickPending() != 0U)
    {
      TIMER0_ClearTick();
      Local_u16Ticks++;
      ANN_Audio_Tick();
      if (Local_u16Ticks == SELF_TEST_TONE_TICKS)
      {
        ANN_Audio_Mute();
      }
    }
  }
  (void)INTERRUPT_DisableGlobal();

  GPIO_SetPinValue(GPIO_PORTB, HIGH_ALARM_LED_PIN, GPIO_LOW);
  GPIO_SetPinValue(GPIO_PORTB, MEDIUM_ALARM_LED_PIN, GPIO_LOW);
  GPIO_SetPinValue(GPIO_PORTB, LOW_ALARM_LED_PIN, GPIO_LOW);
  ANN_Audio_Init();
  Application_ClearState();
  TIMER0_ClearTick();
}

static void Application_Init(void)
{
  GPIO_SetPinDirection(GPIO_PORTB, HIGH_ALARM_LED_PIN, GPIO_OUTPUT);
  GPIO_SetPinDirection(GPIO_PORTB, MEDIUM_ALARM_LED_PIN, GPIO_OUTPUT);
  GPIO_SetPinDirection(GPIO_PORTB, LOW_ALARM_LED_PIN, GPIO_OUTPUT);
  GPIO_SetPinDirection(GPIO_PORTB, HEARTBEAT_LED_PIN, GPIO_OUTPUT);
  GPIO_SetPinDirection(CPU_LOAD_PORT, CPU_LOAD_PIN, GPIO_OUTPUT);

  GPIO_SetPinValue(CPU_LOAD_PORT, CPU_LOAD_PIN, GPIO_LOW);
  TIMER0_Init();
  HRC_Init();
  ANN_Audio_Init();
  Application_SelfTest();
  (void)INTERRUPT_EnableGlobal();
}

int main(void)
{
  u16 Local_u16Phase = 0U;

  Application_Init();

  while (1)
  {
    if (TIMER0_IsTickPending() != 0U)
    {
      TIMER0_ClearTick();
      GPIO_SetPinValue(CPU_LOAD_PORT, CPU_LOAD_PIN, GPIO_HIGH);

      if ((Local_u16Phase % 2U) == 1U)
      {
        Task_Console();
      }
      if ((Local_u16Phase % 5U) == 2U)
      {
        Task_Timers();
      }
      if ((Local_u16Phase % 10U) == 3U)
      {
        Task_Alarms();
      }
      if ((Local_u16Phase % 25U) == 5U)
      {
        Task_Lcd();
      }
      if ((Local_u16Phase % 50U) == 4U)
      {
        Task_FastVitals();
      }
      if ((Local_u16Phase % 100U) == 6U)
      {
        Task_OneHz();
      }
      if ((Local_u16Phase % 200U) == 7U)
      {
        Task_Report();
      }
      if ((Local_u16Phase % 1000U) == 8U)
      {
        Task_Trend();
      }

      Task_Panel();
      Task_Fsm();
      ANN_Audio_Tick();

      GPIO_SetPinValue(CPU_LOAD_PORT, CPU_LOAD_PIN, GPIO_LOW);
      Local_u16Phase++;
      if (Local_u16Phase >= SCHEDULER_CYCLE_TICKS)
      {
        Local_u16Phase = 0U;
      }
    }
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

    return 0;
}