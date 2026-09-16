#define F_CPU 8000000UL

#include "STD_TYPES.h"
#include "TIMER_interface.h"
#include "INTERRUPT_interface.h"
#include "GPIO_interface.h"
#include "HR_Capture_interface.h"
#include "Annunciator_interface.h"
#include "ShiftReg_interface.h"
#include "NurseCall_interface.h"

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
  ANN_Visual_SetPriority(ANN_PRI_NONE);
  NurseCall_Disable();
  HRC_ClearAsystole();
}

static void Application_SelfTest(void)
{
  u16 Local_u16Ticks = 0U;

  /* Test Audio & Visual Annunciators during Self-Test */
  ANN_Audio_SetPriority(ANN_PRI_MEDIUM);
  ANN_Visual_SetPriority(ANN_PRI_HIGH);
  NurseCall_Enable();
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
  NurseCall_Disable();
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
  NurseCall_Init();
  ANN_Audio_Init();
  ANN_Visual_Init();

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
}