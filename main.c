<<<<<<< HEAD
#define F_CPU 8000000UL

#include <avr/io.h>
#include <avr/interrupt.h>
#include <util/delay.h>
#include <stdio.h>
#include <string.h>

#include "STD_TYPES.h"
#include "TIMER_interface.h"
#include "INTERRUPT_interface.h"
#include "GPIO_interface.h"
#include "HR_Capture_interface.h"
#include "Annunciator_interface.h"
#include "ShiftReg_interface.h"
#include "NurseCall_interface.h"
#include "Alarm_mgr.h"
#include "I2C_interface.h"
#include "LCD_I2C_interface.h"
#include "vitals_interface.h"
#include "Panel_interface.h"
#include "patient_cfg.h"
#include "menu.h"
#include "ADC_interface.h"

#define HIGH_ALARM_LED_PIN   GPIO_PIN0
#define MEDIUM_ALARM_LED_PIN GPIO_PIN1
#define LOW_ALARM_LED_PIN    GPIO_PIN2
#define HEARTBEAT_LED_PIN    GPIO_PIN3

#define SCHEDULER_CYCLE_TICKS 1000U

<<<<<<< HEAD
static void Task_Panel(void);
static void Task_Timers(void);
static void Task_FastVitals(void);
static void Task_Alarms(void);
static void Task_Lcd(void);
static void Application_Init(void);

static u8 Heartbeat_Counter = 0U;
static u16 g_schedulerPhase = 0U;
static uint8 g_standbyActive = 0U;
static Vitals_t g_vitals;

/* Differential string buffers to prevent I2C LCD flicker */
static char g_lastLine0[21] = "";
static char g_lastLine1[21] = "";

static void Task_Timers(void)
=======




static void Application_SelfTest(void)
>>>>>>> bc2a737000a66a64e11cd2e17089e177312200fa
{
    /* 50 ms flash on Heartbeat LED (PB3) */
    if (Heartbeat_Counter > 0U)
    {
        Heartbeat_Counter--;
        PORTB |= (1u << HEARTBEAT_LED_PIN);
    }
    else
    {
        PORTB &= ~(1u << HEARTBEAT_LED_PIN);
    }
}

static void Task_FastVitals(void)
{
    u16 Local_u16Interval = 0U;

    if (TIMER1_IsCaptureReady() != 0U)
    {
        Local_u16Interval = TIMER1_GetLastInterval();
    }

    HRC_Process();

    /* Flash heartbeat indicator LED on valid beat */
    if (Local_u16Interval > 0U)
    {
        Heartbeat_Counter = 3U;
    }
}

static void Task_Panel(void)
{
    Panel_Update();

    if (Panel_IsPressed(BTN_SILENCE) != 0U)
    {
        ANN_Audio_Mute();
        Alarm_Acknowledge();
    }

    if (Panel_IsPressed(BTN_STANDBY) != 0U)
    {
        if (Menu_IsInDashboard() == 0U)
        {
            /* Pressing Standby while inside menu returns to dashboard */
            Menu_Init();
            LCD_I2C_Clear();
        }
        else
        {
            /* In dashboard: toggle standby state */
            g_standbyActive = (g_standbyActive == 0U) ? 1U : 0U;
            if (g_standbyActive != 0U)
            {
                ANN_Audio_SetPriority(ANN_PRI_NONE);
                ANN_Visual_SetPriority(ANN_PRI_NONE);
                NurseCall_voidDisable();
            }
        }
        g_lastLine0[0] = '\0';
        g_lastLine1[0] = '\0';
    }

    Menu_Update();
}

static void Task_Alarms(void)
{
    PatientVitals_t Local_stPatientVitals;

    if (g_standbyActive != 0U)
    {
        ANN_Audio_SetPriority(ANN_PRI_NONE);
        ANN_Visual_SetPriority(ANN_PRI_NONE);
        NurseCall_voidDisable();
        return;
    }

    /* Update vitals from sensors so alarms evaluate fresh ADC readings */
    (void)Vitals_Read(&g_vitals);

    uint16 hr = HRC_GetBpm();
    Local_stPatientVitals.heartRate = (HRC_IsAsystole() != 0U) ? 0U : hr;
    Local_stPatientVitals.spO2 = g_vitals.spo2Pct;
    Local_stPatientVitals.respRate = g_vitals.respBpm;
    Local_stPatientVitals.tempC_x10 = g_vitals.tempCx10;
    Local_stPatientVitals.sysBP = g_vitals.nibpSys;
    Local_stPatientVitals.diaBP = g_vitals.nibpDia;

    /* PD3 HIGH = Lead Attached (normal). PD3 LOW = Lead Off (fault) */
    Local_stPatientVitals.leadStatus = (uint8)((PIND & (1u << PD3)) ? 1U : 0U);

    /* PD5 HIGH = Probe Attached (normal). PD5 LOW = Probe Off (fault) */
    Local_stPatientVitals.sensorConnected = (uint8)((PIND & (1u << PD5)) ? 1U : 0U);

    Alarm_UpdateVitals(&Local_stPatientVitals);
    Alarm_Process();

    if (Panel_IsSilenceActive() != 0U)
    {
        ANN_Audio_Mute();
    }
}

static void Task_Lcd(void)
{
    char currentLine0[21];
    char currentLine1[21];
    static uint8 s_lcdBannerPhase = 0U;

    /* Sample ADC channels PA0..PA3 continuously so potentiometers track smoothly */
    (void)Vitals_Read(&g_vitals);

    /* If user is inside the limits menu, menu.c controls the LCD */
    if (Menu_IsInDashboard() == 0U)
    {
        g_lastLine0[0] = '\0';
        g_lastLine1[0] = '\0';
        return;
    }

    if (g_standbyActive != 0U)
    {
        snprintf(currentLine0, sizeof(currentLine0), "STANDBY MODE    ");
        snprintf(currentLine1, sizeof(currentLine1), "MONITORING OFF  ");
    }
    else
    {
        uint16 hr = HRC_GetBpm();
        /* PD3 LOW = Lead Off fault; HRC_IsAsystole() = Asystole */
        uint8 lead_fault = (!(PIND & (1u << PD3))) || (HRC_IsAsystole() != 0U);
        /* PD5 LOW = Probe Off fault */
        uint8 probe_fault = !(PIND & (1u << PD5));

        /* Line 0: HR and SpO2 (always exactly 16 characters) */
        if (lead_fault && probe_fault)
        {
            snprintf(currentLine0, sizeof(currentLine0), "HR:--- SpO2:--- ");
        }
        else if (lead_fault)
        {
            if (g_vitals.spo2Pct >= 100U)
            {
                snprintf(currentLine0, sizeof(currentLine0), "HR:--- SpO2:100%%");
            }
            else
            {
                snprintf(currentLine0, sizeof(currentLine0), "HR:--- SpO2:%2u%% ", (unsigned int)g_vitals.spo2Pct);
            }
        }
        else if (probe_fault)
        {
            snprintf(currentLine0, sizeof(currentLine0), "HR:%3u SpO2:--- ", (unsigned int)hr);
        }
        else
        {
            if (g_vitals.spo2Pct >= 100U)
            {
                snprintf(currentLine0, sizeof(currentLine0), "HR:%3u SpO2:100%%", (unsigned int)hr);
            }
            else
            {
                snprintf(currentLine0, sizeof(currentLine0), "HR:%3u SpO2:%2u%% ", (unsigned int)hr, (unsigned int)g_vitals.spo2Pct);
            }
        }

        /* Line 1: Temperature, NIBP, Respiration (alternates with ALARM BANNER if alarm active) */
        s_lcdBannerPhase++;
        if (s_lcdBannerPhase >= 20U)
        {
            s_lcdBannerPhase = 0U;
        }

        Alarm_Priority_t activePrio = Alarm_GetActivePriority();
        if ((activePrio != ALARM_PRIO_NONE) && (s_lcdBannerPhase >= 10U))
        {
            u16 flags = Alarm_GetActiveFlags();
            if (flags & (1UL << ALARM_ASYSTOLE))
            {
                snprintf(currentLine1, sizeof(currentLine1), "!  ASYSTOLE   !");
            }
            else if (flags & (1UL << ALARM_LEAD_OFF))
            {
                snprintf(currentLine1, sizeof(currentLine1), "!  LEAD OFF   !");
            }
            else if (flags & (1UL << ALARM_SENSOR_DISCONNECT))
            {
                snprintf(currentLine1, sizeof(currentLine1), "!  PROBE OFF  !");
            }
            else if (flags & (1UL << ALARM_HR_CRIT_HIGH))
            {
                snprintf(currentLine1, sizeof(currentLine1), "! HR CRIT HIGH !");
            }
            else if (flags & (1UL << ALARM_HR_CRIT_LOW))
            {
                snprintf(currentLine1, sizeof(currentLine1), "! HR CRIT LOW  !");
            }
            else if (flags & (1UL << ALARM_SPO2_CRIT_LOW))
            {
                snprintf(currentLine1, sizeof(currentLine1), "!SPO2 CRIT LOW !");
            }
            else if (flags & (1UL << ALARM_RR_CRIT_HIGH))
            {
                snprintf(currentLine1, sizeof(currentLine1), "!RR CRIT HIGH  !");
            }
            else if (flags & (1UL << ALARM_RR_CRIT_LOW))
            {
                snprintf(currentLine1, sizeof(currentLine1), "! RR CRIT LOW  !");
            }
            else if (flags & (1UL << ALARM_TEMP_HIGH))
            {
                snprintf(currentLine1, sizeof(currentLine1), "!  TEMP HIGH   !");
            }
            else if (flags & (1UL << ALARM_TEMP_LOW))
            {
                snprintf(currentLine1, sizeof(currentLine1), "!   TEMP LOW   !");
            }
            else if (flags & (1UL << ALARM_BP_HIGH))
            {
                snprintf(currentLine1, sizeof(currentLine1), "!   BP HIGH    !");
            }
            else if (flags & (1UL << ALARM_BP_LOW))
            {
                snprintf(currentLine1, sizeof(currentLine1), "!    BP LOW    !");
            }
            else if (flags & (1UL << ALARM_HR_WARN_HIGH))
            {
                snprintf(currentLine1, sizeof(currentLine1), "! HR HIGH WARN !");
            }
            else if (flags & (1UL << ALARM_HR_WARN_LOW))
            {
                snprintf(currentLine1, sizeof(currentLine1), "! HR LOW WARN  !");
            }
            else if (flags & (1UL << ALARM_SPO2_WARN_LOW))
            {
                snprintf(currentLine1, sizeof(currentLine1), "!SPO2 LOW WARN !");
            }
            else
            {
                snprintf(currentLine1, sizeof(currentLine1), " !ALARM BANNER! ");
            }
        }
        else
        {
            snprintf(currentLine1, sizeof(currentLine1), "T%2u.%u %3u/%2u R%2u",
                     (unsigned int)(g_vitals.tempCx10 / 10U),
                     (unsigned int)(g_vitals.tempCx10 % 10U),
                     (unsigned int)g_vitals.nibpSys,
                     (unsigned int)g_vitals.nibpDia,
                     (unsigned int)g_vitals.respBpm);
        }
    }

    /* Strict differential string caching: only write I2C when text changes */
    if (strcmp(currentLine0, g_lastLine0) != 0)
    {
        (void)LCD_I2C_SetCursor(0U, 0U);
        (void)LCD_I2C_WriteString(currentLine0);
        strncpy(g_lastLine0, currentLine0, sizeof(g_lastLine0) - 1U);
        g_lastLine0[sizeof(g_lastLine0) - 1U] = '\0';
    }

    if (strcmp(currentLine1, g_lastLine1) != 0)
    {
        (void)LCD_I2C_SetCursor(1U, 0U);
        (void)LCD_I2C_WriteString(currentLine1);
        strncpy(g_lastLine1, currentLine1, sizeof(g_lastLine1) - 1U);
        g_lastLine1[sizeof(g_lastLine1) - 1U] = '\0';
    }
}

static void Application_Init(void)
{
    /* 1. Disable JTAG twice within 4 cycles to release PC2..PC5 for UI buttons */
    MCUCSR |= (1u << 7);
    MCUCSR |= (1u << 7);

    /* 2. Configure PC2..PC6 (Silence, Menu, Up, Down, Standby) as inputs with pull-ups */
    DDRC &= ~(0x7Cu);
    PORTC |= 0x7Cu;

    /* 3. Configure PD3 (Lead-Off), PD5 (Probe-Off) with pull-ups */
    DDRD &= ~((1u << 3) | (1u << 5));
    PORTD |= ((1u << 3) | (1u << 5));

    /* 4. Configure PD6 (Timer1 ICP1) as input without pull-up */
    DDRD &= ~(1u << 6);
    PORTD &= ~(1u << 6);

    /* 5. Configure PA0..PA3 (ADC0..ADC3) as inputs without pull-ups */
    DDRA &= ~0x0Fu;
    PORTA &= ~0x0Fu;

    /* 6. Configure alarm and heartbeat indicator LEDs on Port B */
    DDRB |= (1u << HIGH_ALARM_LED_PIN) | (1u << MEDIUM_ALARM_LED_PIN) |
            (1u << LOW_ALARM_LED_PIN) | (1u << HEARTBEAT_LED_PIN);
    PORTB &= ~((1u << HIGH_ALARM_LED_PIN) | (1u << MEDIUM_ALARM_LED_PIN) |
               (1u << LOW_ALARM_LED_PIN) | (1u << HEARTBEAT_LED_PIN));

    /* 7. CPU load pin PC7 as output */
    DDRC |= (1u << 7);
    PORTC &= ~(1u << 7);

    /* 8. Initialize MCAL & HAL drivers */
    I2C_InitMaster(100000UL);
    LCD_I2C_Init();
    LCD_I2C_Clear();
    LCD_I2C_BacklightOn();

    TIMER0_Init();
    HRC_Init();
    Vitals_Init();
    Panel_Init();
    PatientCfg_Init();
    Menu_Init();
    Alarm_Init();
    ANN_Audio_Init();
    ANN_Visual_Init();
    NurseCall_voidInit();
    ShiftReg_voidInit();

    (void)INTERRUPT_EnableGlobal();
}

int main(void)
{
    Application_Init();

    while (1)
    {
        if (TIMER0_IsTickPending() != 0U)
        {
            TIMER0_ClearTick();
            PORTC |= (1u << 7); /* CPU Load Pin HIGH */

            /* 10 ms: Pulse interval capture & audio/visual annunciator state machines */
            Task_FastVitals();
            ANN_Audio_Tick();
            ANN_Visual_Tick();

            /* 20 ms: Pushbutton scanning & debouncing */
            if ((g_schedulerPhase % 2U) == 1U)
            {
                Task_Panel();
            }

            /* 50 ms: Heartbeat LED pulse duration */
            if ((g_schedulerPhase % 5U) == 0U)
            {
                Task_Timers();
            }

            /* 100 ms: Alarm manager evaluation */
            if ((g_schedulerPhase % 10U) == 3U)
            {
                Task_Alarms();
            }

            /* 100 ms (offset phase 7): LCD differential refresh */
            if ((g_schedulerPhase % 10U) == 7U)
            {
                Task_Lcd();
            }

            PORTC &= ~(1u << 7); /* CPU Load Pin LOW */

            g_schedulerPhase++;
            if (g_schedulerPhase >= SCHEDULER_CYCLE_TICKS)
            {
                g_schedulerPhase = 0U;
            }
        }
    }
    return 0;
=======
#define F_CPU 8000000UL

#include "STD_TYPES.h"
#include "TIMER_interface.h"
#include "INTERRUPT_interface.h"
#include "GPIO_interface.h"
#include "HR_Capture_interface.h"
#include "Annunciator_interface.h"
#include "ShiftReg_interface.h"
#include "NurseCall_interface.h"
#include "Alarm_mgr.h"

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

/* متغير لتتبع وميض النبض */
static u8 Heartbeat_Counter = 0U;

static void Task_Timers(void)
{
  /* وميض ليد B3 لمدة 50ms فقط مع كل نبضة قلب */
  if (Heartbeat_Counter > 0U)
  {
    Heartbeat_Counter--;
    GPIO_SetPinValue(GPIO_PORTB, HEARTBEAT_LED_PIN, GPIO_HIGH);
  }
  else
  {
    GPIO_SetPinValue(GPIO_PORTB, HEARTBEAT_LED_PIN, GPIO_LOW);
  }
}

static void Task_FastVitals(void)
{
  u16 Local_u16Interval = 0U;

  if (TIMER1_IsCaptureReady() != 0U)
  {
    Local_u16Interval = TIMER1_GetLastInterval();
  }

  HRC_Process();

  if (Local_u16Interval > 0U)
  {
    Heartbeat_Counter = 2U;
  }

  if ((HRC_IsAsystole() != 0U) || (HRC_GetBpm() == HRC_INVALID_HR))
  {
    /* توقف قلب حقيقي: أشعل الليد الأحمر */
    GPIO_SetPinValue(GPIO_PORTB, HIGH_ALARM_LED_PIN, GPIO_HIGH);
  }
  else
  {
    /* القلب ينبض: أطفئ الليد الأحمر فوراً */
    GPIO_SetPinValue(GPIO_PORTB, HIGH_ALARM_LED_PIN, GPIO_LOW);
  }
}

static void Task_Panel(void)
{
}

static void Task_Fsm(void)
{
}

static void Task_Console(void)
{
}

static void Task_Alarms(void)
{
  Alarm_Process();
}

static void Task_Lcd(void)
{
}

static void Task_OneHz(void)
{
  /* Test Simulation Input: Send Test Patient Vitals to Alarm Manager */
  PatientVitals_t testVitals = {
      .heartRate = 160,     /* > 150 -> HR_CRIT_HIGH (HIGH PRIORITY) */
      .spO2 = 82,           /* < 85  -> SPO2_CRIT_LOW (HIGH PRIORITY) */
      .respRate = 18,       /* Normal */
      .tempC_x10 = 370,     /* 37.0 C Normal */
      .sysBP = 120,         /* Normal */
      .diaBP = 80,          /* Normal */
      .sensorConnected = 1, /* OK */
      .leadStatus = 1       /* OK */
  };

  Alarm_UpdateVitals(&testVitals);
}







/* دالة حساب الـ Checksum بالـ XOR لكل الحروف */
static uint8 Calculate_Checksum(const char *buffer)
{
  uint8 checksum = 0;
  while (*buffer)
  {
    checksum ^= (uint8)(*buffer);
    buffer++;
  }
  return checksum;
}

/* دالة إرسال التليمتري الكاملة بدلاً من OK */


static void Send_Telemetry_Frame(void)
{
  char payload[110];
  char frame[130];

  VitalData_t *v_hr   = PatientCfg_GetVital(VITAL_HR);
  VitalData_t *v_spo2 = PatientCfg_GetVital(VITAL_SPO2);
  VitalData_t *v_temp = PatientCfg_GetVital(VITAL_TEMP);
  VitalData_t *v_rr   = PatientCfg_GetVital(VITAL_RR);
  VitalData_t *v_bp   = PatientCfg_GetVital(VITAL_NIBP);
  u16 flags           = Alarm_GetActiveFlags();

  int hr_val   = (v_hr && v_hr->Valid)     ? v_hr->Value   : 0;
  int hrv_val  = 38; // قيمة افتراضية أو خذها من متغير الـ HRV لديك
  int spo2_val = (v_spo2 && v_spo2->Valid) ? v_spo2->Value : 0;
  int temp_val = (v_temp && v_temp->Valid) ? v_temp->Value : 0;
  int rr_val   = (v_rr && v_rr->Valid)   ? v_rr->Value   : 0;
  int sys_val  = (v_bp && v_bp->Valid)   ? v_bp->Value   : 0;
  int dia_val  = 80; // قيمة الضغط الانبساطي الافتراضية










  /* 1. تجميع الـ Payload المطلوب بدون $ و * */
  sprintf(payload,
          "PM,ID=BED0012,HR=%d,HV=%d,SP=%d,T=%d,NS=%d,ND=%d,RR=%d,AL=%04X,PRI=0,ST=MON,SIL=0,UP=3600",
          hr_val, hrv_val, spo2_val, temp_val, sys_val, dia_val, rr_val, flags);

  /* 2. حساب الـ Checksum للـ Payload */
  uint8 chk = Calculate_Checksum(payload);

  /* 3. تجميع الإطار النهائي بالتنسيق القياسي */
  sprintf(frame, "$%s*%02X\r\n", payload, chk);

  /* 4. إرسال الإطار عبر UART */
  UART_SendString((const uint8 *)frame);
}




/*


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
  ANN_Visual_SetPriority(ANN_PRI_NONE);
  NurseCall_voidDisable();
  HRC_ClearAsystole();
}

static void Application_SelfTest(void)
{
  u16 Local_u16Ticks = 0U;

  /* Test Audio & Visual Annunciators during Self-Test */
  ANN_Audio_SetPriority(ANN_PRI_MEDIUM);
  ANN_Visual_SetPriority(ANN_PRI_HIGH);
  NurseCall_voidEnable();
  ShiftReg_voidWriteByte(0xFF); /* Turn ON Vital Status LEDs */

  (void)INTERRUPT_EnableGlobal();
  while (Local_u16Ticks < SELF_TEST_TICKS)
  {
    if (TIMER0_IsTickPending() != 0U)
    {
      TIMER0_ClearTick();
      Local_u16Ticks++;
      ANN_Audio_Tick();
      ANN_Visual_Tick();

      if (Local_u16Ticks == SELF_TEST_TONE_TICKS)
      {
        ANN_Audio_Mute();
      }
    }
  }
  (void)INTERRUPT_DisableGlobal();

  ANN_Audio_Init();
  ANN_Visual_Init();
  NurseCall_voidDisable();
  ShiftReg_voidWriteByte(0x00);
  Application_ClearState();
  TIMER0_ClearTick();
}

static void Application_Init(void)
{
  GPIO_SetPinDirection(CPU_LOAD_PORT, CPU_LOAD_PIN, GPIO_OUTPUT);
  GPIO_SetPinValue(CPU_LOAD_PORT, CPU_LOAD_PIN, GPIO_LOW);

  TIMER0_Init();
  HRC_Init();

  /* Initialize Student 2 HAL Drivers */
  ShiftReg_voidInit();
  NurseCall_voidInit();
  ANN_Audio_Init();
  ANN_Visual_Init();

  Application_SelfTest();
  (void)INTERRUPT_EnableGlobal();
}


*/





static void Task_Report(void)
{
  uint8 rx_data = 0;

  /* فحص ما إذا كان هناك أمر قادم عبر السيريال */
  if (UART_IsDataReady() == E_OK)
  {
    UART_ReceiveByte(&rx_data);

    /* إذا كان الأمر هو طلب الحالة STATUS (أو حرف S اختصاراً) */
    if (rx_data == 'S' || rx_data == 's')
    {
      Send_Telemetry_Frame(); /* إرسال الإطار الصحيح مع Checksum */
    }
    else
    {
      UART_SendString((const uint8 *)"OK\r\n"); /* باقي الأوامر التنفيذية */
    }
  }
  else
  {
    /* إرسال التليمتري الدوري كل ثانيتين بشكل طبيعي */
    Send_Telemetry_Frame();
  }
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
<<<<<<< HEAD
      if ((Local_u16Phase % 100U) == 6U)
      {
        Task_OneHz();
      }
=======

      /* T-10: Serial Telemetry Report (2 s, Phase 7) */
      /*
>>>>>>> bc2a737000a66a64e11cd2e17089e177312200fa
      if ((Local_u16Phase % 200U) == 7U)
      {
        Task_Report();
      }
<<<<<<< HEAD
=======
*/
/* T-10: Serial Telemetry Report (10 s, Phase 7) */
      if ((Local_u16Phase % 1000U) == 7U)
      {
        Task_Report();
      }


      /* T-11: Trends Storage (10 s, Phase 8) */
>>>>>>> bc2a737000a66a64e11cd2e17089e177312200fa
      if ((Local_u16Phase % 1000U) == 8U)
      {
        Task_Trend();
      }

      Task_Panel();
      Task_Fsm();

      /* Executive Ticks */
      ANN_Audio_Tick();
      ANN_Visual_Tick();

      GPIO_SetPinValue(CPU_LOAD_PORT, CPU_LOAD_PIN, GPIO_LOW);
      Local_u16Phase++;
      if (Local_u16Phase >= SCHEDULER_CYCLE_TICKS)
      {
        Local_u16Phase = 0U;
      }
    }
  }
>>>>>>> d9c22b66226e0b37b25c4d23605075309880d886
}