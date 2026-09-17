#define F_CPU 8000000UL

#include <stdio.h>
#include <stdlib.h>
#include <util/delay.h>

#include "STD_TYPES.h"
#include "TIMER_interface.h"
#include "TIMER_private.h"
#include "INTERRUPT_interface.h"
#include "GPIO_interface.h"
#include "HR_Capture_interface.h"
#include "Annunciator_interface.h"
#include "ShiftReg_interface.h"
#include "NurseCall_interface.h"
#include "Alarm_mgr.h"
#include "vitals_interface.h"
#include "patient_cfg.h"
#include "Panel_interface.h"
#include "monitor_fsm.h"
#include "console.h"
#include "menu.h"
#include "trends.h"
#include "LCD_I2C_interface.h"
#include "I2C_interface.h"
#include "UART_interface.h"

#define CPU_LOAD_PORT GPIO_PORTC
#define CPU_LOAD_PIN  GPIO_PIN7

#define HIGH_ALARM_LED_PIN   GPIO_PIN0
#define MEDIUM_ALARM_LED_PIN GPIO_PIN1
#define LOW_ALARM_LED_PIN    GPIO_PIN2
#define HEARTBEAT_LED_PIN    GPIO_PIN3

#define CODE_BLUE_PIN GPIO_PIN2  /* PD2 / INT0 */
#define LEAD_OFF_PIN  GPIO_PIN3  /* PD3 / INT1 */
#define PROBE_OFF_PIN GPIO_PIN5  /* PD5 */

#define SCHEDULER_CYCLE_TICKS 1000U

static void Application_SelfTest(void)
{
  /* 1. Turn ON all annunciators per NFR-02 */
  GPIO_SetPinValue(GPIO_PORTB, HIGH_ALARM_LED_PIN,   GPIO_HIGH);
  GPIO_SetPinValue(GPIO_PORTB, MEDIUM_ALARM_LED_PIN, GPIO_HIGH);
  GPIO_SetPinValue(GPIO_PORTB, LOW_ALARM_LED_PIN,    GPIO_HIGH);
  GPIO_SetPinValue(GPIO_PORTB, HEARTBEAT_LED_PIN,    GPIO_HIGH);

  NurseCall_voidEnable();
  ShiftReg_voidWriteByte(0xFF); /* 8-LED bar all ON */

  ANN_Audio_SetPriority(ANN_PRI_MEDIUM);

  UART_SendString((const uint8 *)"=== SYSTEM SELF-TEST ===\r\n");

  LCD_I2C_SetCursor(0, 0);
  LCD_I2C_WriteString("PATIENT MONITOR ");
  LCD_I2C_SetCursor(1, 0);
  LCD_I2C_WriteString("SELF-TEST...    ");

  /* Short self-test indications to eliminate startup freezing */
  _delay_ms(100);
  ANN_Audio_Mute();

  /* Brief visual self-test */
  _delay_ms(200);

  /* Clear all test indicators */
  GPIO_SetPinValue(GPIO_PORTB, HIGH_ALARM_LED_PIN,   GPIO_LOW);
  GPIO_SetPinValue(GPIO_PORTB, MEDIUM_ALARM_LED_PIN, GPIO_LOW);
  GPIO_SetPinValue(GPIO_PORTB, LOW_ALARM_LED_PIN,    GPIO_LOW);
  GPIO_SetPinValue(GPIO_PORTB, HEARTBEAT_LED_PIN,    GPIO_LOW);

  NurseCall_voidDisable();
  ShiftReg_voidWriteByte(0x00);
  ANN_Audio_Init();
  ANN_Visual_Init();
  HRC_ClearAsystole();
  LCD_I2C_Clear();

  UART_SendString((const uint8 *)"PATIENT MONITOR READY\r\n");
}

static void Application_Init(void)
{
  /* CPU Load monitor pin (Oscilloscope track) */
  GPIO_SetPinDirection(CPU_LOAD_PORT, CPU_LOAD_PIN, GPIO_OUTPUT);
  GPIO_SetPinValue(CPU_LOAD_PORT, CPU_LOAD_PIN, GPIO_LOW);

  /* Alarm Speaker / Buzzer pin (PD7 / OC2) */
  GPIO_SetPinDirection(GPIO_PORTD, GPIO_PIN7, GPIO_OUTPUT);

  /* Configure digital inputs with pull-ups / floating */
  GPIO_SetPinDirection(GPIO_PORTD, CODE_BLUE_PIN, GPIO_INPUT_PULLUP);
  GPIO_SetPinDirection(GPIO_PORTD, LEAD_OFF_PIN,  GPIO_INPUT_PULLUP);
  GPIO_SetPinDirection(GPIO_PORTD, PROBE_OFF_PIN, GPIO_INPUT_PULLUP);
  GPIO_SetPinDirection(GPIO_PORTD, GPIO_PIN6,     GPIO_INPUT); /* PD6 (ICP1) Heartbeat Train */

  /* Timers & Hardware Peripherals */
  TIMER0_Init();
  HRC_Init();
  Vitals_Init();

  /* Annunciators & Indicators */
  ShiftReg_voidInit();
  NurseCall_voidInit();
  ANN_Audio_Init();
  ANN_Visual_Init();

  /* Panel, Patient Config, FSM, Console */
  Panel_Init();
  PatientCfg_Init();
  Monitor_Init();
  CONSOLE_Init();
  Trends_Init();

  /* Communication & Display */
  I2C_InitMaster(100000UL);
  LCD_I2C_Init();
  Menu_Init();
  UART_Init(9600);

  /* Hardware self-test on boot */
  Application_SelfTest();

  /* Enable global interrupts for normal operation */
  (void)INTERRUPT_EnableGlobal();
}

static volatile uint8  g_u8HeartbeatActive = 0U;

static void Process_Heartbeat(void)
{
  static uint8  s_u8PrevPD6      = 0U;
  static uint8  s_u8HbPulseTicks = 0U;
  static uint16 s_u16SilenceTicks = 0U; /* ticks since last rising edge */

  uint8 Local_u8CurrPD6 = 0U;
  GPIO_GetPinValue(GPIO_PORTD, GPIO_PIN6, &Local_u8CurrPD6);

  /* Rising edge on PD6: heartbeat pulse from Clock-15 */
  if ((s_u8PrevPD6 == 0U) && (Local_u8CurrPD6 != 0U))
  {
    /* Flash LED for 50 ms (5 ticks × 10 ms) — spec OUT-4 */
    GPIO_SetPinValue(GPIO_PORTB, HEARTBEAT_LED_PIN, GPIO_HIGH);
    s_u8HbPulseTicks  = 5U;

    /* Mark heartbeat active and reset asystole watchdog */
    g_u8HeartbeatActive = 1U;
    HRC_ClearAsystole();
    s_u16SilenceTicks = 0U;
  }
  s_u8PrevPD6 = Local_u8CurrPD6;

  /* Asystole watchdog: 400 ticks (≈4 s) without a rising edge */
  s_u16SilenceTicks++;
  if (s_u16SilenceTicks > 400U)
  {
    g_u8HeartbeatActive = 0U;
  }

  /* Turn LED off once pulse duration has elapsed */
  if (s_u8HbPulseTicks > 0U)
  {
    s_u8HbPulseTicks--;
    if (s_u8HbPulseTicks == 0U)
    {
      GPIO_SetPinValue(GPIO_PORTB, HEARTBEAT_LED_PIN, GPIO_LOW);
    }
  }
}


static void Task_Timers(void)
{
  /* Silence / Acknowledge button check */
  if (Panel_IsPressed(BTN_SILENCE))
  {
    Alarm_Acknowledge();
  }

  /* Standby button check (PC6) */
  if (Panel_IsPressed(BTN_STANDBY))
  {
    Monitor_ToggleStandby();
  }

  /* Discard any stray UP / DOWN events when in dashboard so they don't lock scheduler */
  if (Menu_IsInDashboard() != 0U)
  {
    (void)Panel_IsPressed(BTN_UP);
    (void)Panel_IsPressed(BTN_DOWN);
  }
}

static void Task_Console(void)
{
  CONSOLE_Task();
}

static void Task_Alarms(void)
{
  Alarm_Process();
}

static void Task_Lcd(void)
{
  Menu_Update();
}

static void Task_FastVitals(void)
{
  Vitals_t rawVitals = {0};
  uint8 lead_off_pin = 1;
  uint8 probe_off_pin = 1;
  uint8 code_blue_pin = 1;

  GPIO_GetPinValue(GPIO_PORTD, LEAD_OFF_PIN,  &lead_off_pin);
  GPIO_GetPinValue(GPIO_PORTD, PROBE_OFF_PIN, &probe_off_pin);
  GPIO_GetPinValue(GPIO_PORTD, CODE_BLUE_PIN, &code_blue_pin);

  uint8 lead_ok  = (lead_off_pin != 0) ? 1 : 0;
  uint8 probe_ok = (probe_off_pin != 0) ? 1 : 0;
  uint8 code_blue_active = (code_blue_pin == 0) ? 1 : 0;

  if (Vitals_Read(&rawVitals) == E_OK)
  {
    /* Heart rate from Timer1 Input Capture (spec FR-01, LO-1).
     * Formula: bpm = 1 875 000 / interval_ticks  (Timer1 prescaler 256, 8 MHz).
     * Show 0 (---) if lead disconnected, asystole, or no beat yet. */
    u16 hr = 0U;
    if (lead_ok && g_u8HeartbeatActive && (HRC_IsAsystole() == 0U))
    {
      u16 hrc_val = HRC_GetBpm();
      if ((hrc_val != HRC_INVALID_HR) && (hrc_val > 0U))
      {
        hr = hrc_val;
      }
    }


    /* Update PatientCfg so Dashboard and Limits Menu show live vitals */
    VitalData_t *v;
    v = PatientCfg_GetVital(VITAL_HR);
    if (v) { v->Value = hr; v->Valid = (lead_ok && hr > 0U) ? 1U : 0U; }

    v = PatientCfg_GetVital(VITAL_SPO2);
    if (v) { v->Value = rawVitals.spo2Pct; v->Valid = probe_ok; }

    v = PatientCfg_GetVital(VITAL_TEMP);
    if (v) { v->Value = rawVitals.tempCx10; v->Valid = 1; }

    v = PatientCfg_GetVital(VITAL_RR);
    if (v) { v->Value = rawVitals.respBpm; v->Valid = 1; }

    v = PatientCfg_GetVital(VITAL_NIBP);
    if (v) { v->Value = rawVitals.nibpSys; v->Valid = 1; }

    PatientCfg_EvalAlarms();

    /* Update Alarm Manager with live vitals and Code Blue status */
    PatientVitals_t pVitals = {
      .heartRate = hr,
      .spO2 = rawVitals.spo2Pct,
      .respRate = rawVitals.respBpm,
      .tempC_x10 = rawVitals.tempCx10,
      .sysBP = rawVitals.nibpSys,
      .diaBP = rawVitals.nibpDia,
      .sensorConnected = probe_ok,
      .leadStatus = lead_ok,
      .codeBlue = code_blue_active
    };
    Alarm_UpdateVitals(&pVitals);
  }
}

static void Task_Report(void)
{
  char buf[64];
  VitalData_t *v_hr   = PatientCfg_GetVital(VITAL_HR);
  VitalData_t *v_spo2 = PatientCfg_GetVital(VITAL_SPO2);
  VitalData_t *v_temp = PatientCfg_GetVital(VITAL_TEMP);
  VitalData_t *v_rr   = PatientCfg_GetVital(VITAL_RR);
  VitalData_t *v_bp   = PatientCfg_GetVital(VITAL_NIBP);
  u16 flags = Alarm_GetActiveFlags();

  int hr_val   = (v_hr && v_hr->Valid) ? v_hr->Value : 0;
  int spo2_val = (v_spo2 && v_spo2->Valid) ? v_spo2->Value : 0;
  int temp_val = (v_temp && v_temp->Valid) ? v_temp->Value : 0;
  int rr_val   = (v_rr && v_rr->Valid) ? v_rr->Value : 0;
  int bp_val   = (v_bp && v_bp->Valid) ? v_bp->Value : 0;

  sprintf(buf, "!DAT,%d,%d,%d.%d,%d,%d,0x%04X\r\n",
          hr_val, spo2_val, temp_val / 10, abs(temp_val % 10),
          rr_val, bp_val, flags);
  UART_SendString((const uint8 *)buf);
}

int main(void)
{
  u16 Local_u16Phase = 0U;
  static uint8 s_u8LcdCooldown = 0U;

  Application_Init();

  /* Clear any pending flags/asystole from startup */
  HRC_ClearAsystole();
  TIMER0_ClearTick();
  TIMER_TIFR = 0xFF;

  /* Perform immediate first vitals read so dashboard is not blank */
  Task_FastVitals();
  Task_Alarms();
  Task_Lcd();

  while (1)
  {
    /* ----------------------------------------------------------------
     * Scheduler pacing: _delay_ms(10) at end of each tick gives a
     * stable ~100 Hz rate without needing the Timer0 ISR or TIFR.
     * Timer1 HR measurement uses TCNT1 hardware directly so its
     * accuracy is independent of this software pacing.
     * ---------------------------------------------------------------- */
    uint8 Local_u8Tick = 1U; /* always process one tick per loop iteration */


    if (Local_u8Tick != 0U)
    {
      /* Oscilloscope load monitoring pin HIGH */
      GPIO_SetPinValue(CPU_LOAD_PORT, CPU_LOAD_PIN, GPIO_HIGH);

      /* 1. Direct Heartbeat pulse tracking and measurement */
      Process_Heartbeat();

      /* Also run HRC capture checks */
      if (TIMER1_IsCaptureReady() != 0U)
      {
        ANN_Visual_TriggerHeartbeat();
      }
      HRC_Process();

      /* 2. Update panel buttons and latch any pending event */
      Panel_Update();
      uint8 Local_u8BtnEvent = Panel_HasEvent();

      /* T-4: Console CLI (20 ms, Phase 1) */
      if ((Local_u16Phase % 2U) == 1U)
      {
        Task_Console();
      }

      /* T-5: Timers & Buttons (50 ms, Phase 2, or immediate on button event) */
      if (((Local_u16Phase % 5U) == 2U) || (Local_u8BtnEvent != 0U))
      {
        Task_Timers();
      }

      /* T-6: Alarms evaluation (100 ms, Phase 3) */
      if ((Local_u16Phase % 10U) == 3U)
      {
        Task_Alarms();
      }

      /* T-7: LCD Dashboard & Menu (250 ms, Phase 5, or immediate on button event with rate limiter) */
      if (((Local_u16Phase % 25U) == 5U) || ((Local_u8BtnEvent != 0U) && (s_u8LcdCooldown == 0U)))
      {
        Task_Lcd();
        s_u8LcdCooldown = 5U; /* Limit LCD repaint to at most once per 50 ms to prevent bus starvation */
      }
      if (s_u8LcdCooldown > 0U)
      {
        s_u8LcdCooldown--;
      }

      /* T-8: Fast Vitals Acquisition & Plausibility (500 ms, Phase 4) */
      if ((Local_u16Phase % 50U) == 4U)
      {
        Task_FastVitals();
      }

      /* T-10: Serial Telemetry Report (2 s, Phase 7) */
      if ((Local_u16Phase % 200U) == 7U)
      {
        Task_Report();
      }

      /* T-11: Trends Storage (10 s, Phase 8) */
      if ((Local_u16Phase % 1000U) == 8U)
      {
        Task_Trend();
      }

      /* Continuous 10 ms Executive Tasks */
      Monitor_Run();
      ANN_Audio_Tick();
      ANN_Visual_Tick();

      /* Oscilloscope load monitoring pin LOW */
      GPIO_SetPinValue(CPU_LOAD_PORT, CPU_LOAD_PIN, GPIO_LOW);

      /* Pace scheduler at ~100 Hz (10 ms/tick).
       * Timer1 HR capture uses hardware TCNT1 so its accuracy is
       * independent of this delay. */
      _delay_ms(10);

      Local_u16Phase++;
      if (Local_u16Phase >= SCHEDULER_CYCLE_TICKS)
      {
        Local_u16Phase = 0U;
      }
    }

  }

  return 0;
}