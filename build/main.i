# 0 "main.c"
# 0 "<built-in>"
# 0 "<command-line>"
# 1 "main.c"


# 1 "LIB/STD_TYPES.h" 1
# 13 "LIB/STD_TYPES.h"
typedef unsigned char uint8;
typedef unsigned short uint16;
typedef unsigned long uint32;
typedef signed char sint8;
typedef signed short sint16;
typedef signed long sint32;

typedef unsigned char uint8_h;

typedef enum
{
    E_OK = 0,
    E_NOK = 1,
    E_PORT_Not_valid = 2,
    E_PIN_Not_valid = 3,
} STD_ReturnType;
# 4 "main.c" 2
# 1 "MCAL/TIMER/TIMER_interface.h" 1
# 16 "MCAL/TIMER/TIMER_interface.h"
typedef void (*TIMER_CallbackType)(void);






void TIMER0_Init(void);
void TIMER0_SetCallback(TIMER_CallbackType Copy_pvCallback);
uint8 TIMER0_IsTickPending(void);
void TIMER0_ClearTick(void);

void TIMER1_Init(void);
uint8 TIMER1_IsCaptureReady(void);
void TIMER1_ClearCaptureFlag(void);
uint16 TIMER1_GetInterval(uint8 Copy_u8Index);
uint8 TIMER1_GetCaptureCount(void);
uint8 TIMER1_GetCaptureWriteIndex(void);
uint8 TIMER1_IsAsystole(void);
void TIMER1_ClearAsystole(void);

void TIMER2_Init(void);
void TIMER2_SetTone(uint8 Copy_u8Tone);
# 5 "main.c" 2
# 1 "MCAL/INTERRUPT/INTERRUPT_interface.h" 1
# 28 "MCAL/INTERRUPT/INTERRUPT_interface.h"
STD_ReturnType INTERRUPT_EnableGlobal(void);




STD_ReturnType INTERRUPT_DisableGlobal(void);





STD_ReturnType EXTI_SetSense(uint8 Copy_u8Int, uint8 Copy_u8Sense);





STD_ReturnType EXTI_Enable(uint8 Copy_u8Int);




STD_ReturnType EXTI_Disable(uint8 Copy_u8Int);




STD_ReturnType EXTI_ClearFlag(uint8 Copy_u8Int);
# 65 "MCAL/INTERRUPT/INTERRUPT_interface.h"
STD_ReturnType EXTI_SetCallback(uint8 Copy_u8Int, void (*Copy_pfCallback)(void));
# 6 "main.c" 2
# 1 "MCAL/GPIO/GPIO_interface.h" 1
# 42 "MCAL/GPIO/GPIO_interface.h"
STD_ReturnType GPIO_SetPinDirection(uint8 Copy_u8Port, uint8 Copy_u8Pin, uint8 Copy_u8Direction);




STD_ReturnType GPIO_SetPinValue(uint8 Copy_u8Port, uint8 Copy_u8Pin, uint8 Copy_u8Value);




STD_ReturnType GPIO_GetPinValue(uint8 Copy_u8Port, uint8 Copy_u8Pin, uint8 *Copy_pu8Value);




STD_ReturnType GPIO_TogglePinValue(uint8 Copy_u8Port, uint8 Copy_u8Pin);




STD_ReturnType GPIO_SetPortDirection(uint8 Copy_u8Port, uint8 Copy_u8Direction);




STD_ReturnType GPIO_SetPortValue(uint8 Copy_u8Port, uint8 Copy_u8Value);




STD_ReturnType GPIO_GetPortValue(uint8 Copy_u8Port, uint8 *Copy_pu8Value);
# 7 "main.c" 2
# 1 "HAL/HR_Capture/HR_Capture_interface.h" 1



# 1 "./LIB/STD_TYPES.h" 1
# 5 "HAL/HR_Capture/HR_Capture_interface.h" 2
# 20 "HAL/HR_Capture/HR_Capture_interface.h"
void HRC_Init(void);
void HRC_Process(void);
void HRC_OnCapture(uint16 Copy_u16IntervalTicks);
void HRC_OnOverflow(void);
uint16 HRC_GetBpm(void);
uint16 HRC_GetHrvMs(void);
uint8 HRC_IsAsystole(void);
void HRC_ClearAsystole(void);
# 8 "main.c" 2
# 1 "HAL/Annunciator/Annunciator_interface.h" 1
# 21 "HAL/Annunciator/Annunciator_interface.h"
void ANN_Audio_Init(void);
void ANN_Audio_SetPriority(uint8 Copy_u8Priority);
void ANN_Audio_Tick(void);
void ANN_Audio_Mute(void);
void ANN_Audio_Unmute(void);
# 9 "main.c" 2
# 22 "main.c"
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
  ANN_Audio_SetPriority(0U);
  HRC_ClearAsystole();
}

static void Application_SelfTest(void)
{
  uint16 Local_u16Ticks = 0U;

  GPIO_SetPinValue(1u, 0u, 1u);
  GPIO_SetPinValue(1u, 1u, 1u);
  GPIO_SetPinValue(1u, 2u, 1u);
  ANN_Audio_SetPriority(2U);

  (void)INTERRUPT_EnableGlobal();
  while (Local_u16Ticks < 300U)
  {
    if (TIMER0_IsTickPending() != 0U)
    {
      TIMER0_ClearTick();
      Local_u16Ticks++;
      ANN_Audio_Tick();
      if (Local_u16Ticks == 50U)
      {
        ANN_Audio_Mute();
      }
    }
  }
  (void)INTERRUPT_DisableGlobal();

  GPIO_SetPinValue(1u, 0u, 0u);
  GPIO_SetPinValue(1u, 1u, 0u);
  GPIO_SetPinValue(1u, 2u, 0u);
  ANN_Audio_Init();
  Application_ClearState();
  TIMER0_ClearTick();
}

static void Application_Init(void)
{
  GPIO_SetPinDirection(1u, 0u, 1u);
  GPIO_SetPinDirection(1u, 1u, 1u);
  GPIO_SetPinDirection(1u, 2u, 1u);
  GPIO_SetPinDirection(1u, 3u, 1u);
  GPIO_SetPinDirection(2u, 7u, 1u);

  GPIO_SetPinValue(2u, 7u, 0u);
  TIMER0_Init();
  HRC_Init();
  ANN_Audio_Init();
  Application_SelfTest();
  (void)INTERRUPT_EnableGlobal();
}

int main(void)
{
  uint16 Local_u16Phase = 0U;

  Application_Init();

  while (1)
  {
    if (TIMER0_IsTickPending() != 0U)
    {
      TIMER0_ClearTick();
      GPIO_SetPinValue(2u, 7u, 1u);

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

      GPIO_SetPinValue(2u, 7u, 0u);
      Local_u16Phase++;
      if (Local_u16Phase >= 1000U)
      {
        Local_u16Phase = 0U;
      }
    }
  }
}
