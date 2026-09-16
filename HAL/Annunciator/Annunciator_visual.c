#include "../../LIB/STD_TYPES.h"
#include "../../MCAL/GPIO/GPIO_interface.h"
#include "Annunciator_interface.h"
#include "Annunciator_private.h"

/* Pin Definitions on PORTB */
#define ANN_RED_LED_PIN       GPIO_PIN0
#define ANN_YELLOW_LED_PIN    GPIO_PIN1
#define ANN_CYAN_LED_PIN      GPIO_PIN2
#define ANN_GREEN_LED_PIN     GPIO_PIN3

static volatile u8  Ann_VisualPriority = ANN_PRI_NONE;
static volatile u16 Ann_VisualTicks    = 0U;
static volatile u8  Ann_HeartbeatTicks = 0U;

void ANN_Visual_Init(void)
{
    /* Set PB0, PB1, PB2, PB3 as Outputs */
    GPIO_SetPinDirection(GPIO_PORTB, ANN_RED_LED_PIN, GPIO_OUTPUT);
    GPIO_SetPinDirection(GPIO_PORTB, ANN_YELLOW_LED_PIN, GPIO_OUTPUT);
    GPIO_SetPinDirection(GPIO_PORTB, ANN_CYAN_LED_PIN, GPIO_OUTPUT);
    GPIO_SetPinDirection(GPIO_PORTB, ANN_GREEN_LED_PIN, GPIO_OUTPUT);

    /* Initial state: All LEDs OFF */
    GPIO_SetPinValue(GPIO_PORTB, ANN_RED_LED_PIN, GPIO_LOW);
    GPIO_SetPinValue(GPIO_PORTB, ANN_YELLOW_LED_PIN, GPIO_LOW);
    GPIO_SetPinValue(GPIO_PORTB, ANN_CYAN_LED_PIN, GPIO_LOW);
    GPIO_SetPinValue(GPIO_PORTB, ANN_GREEN_LED_PIN, GPIO_LOW);

    Ann_VisualPriority = ANN_PRI_NONE;
    Ann_VisualTicks    = 0U;
    Ann_HeartbeatTicks = 0U;
}

void ANN_Visual_SetPriority(u8 Copy_u8Priority)
{
    if (Copy_u8Priority <= ANN_PRI_HIGH)
    {
        if (Copy_u8Priority != Ann_VisualPriority)
        {
            Ann_VisualPriority = Copy_u8Priority;
            Ann_VisualTicks    = 0U;
        }
    }
}

void ANN_Visual_TriggerHeartbeat(void)
{
    /* Start a 50ms (5 ticks) flash on Green LED */
    Ann_HeartbeatTicks = 5U;
    GPIO_SetPinValue(GPIO_PORTB, ANN_GREEN_LED_PIN, GPIO_HIGH);
}

void ANN_Visual_Tick(void)
{
    Ann_VisualTicks++;

    /* --- 1. Handle Heartbeat LED (PB3) --- */
    if (Ann_HeartbeatTicks > 0U)
    {
        Ann_HeartbeatTicks--;
        if (Ann_HeartbeatTicks == 0U)
        {
            GPIO_SetPinValue(GPIO_PORTB, ANN_GREEN_LED_PIN, GPIO_LOW);
        }
    }

    /* --- 2. Handle Alarm LEDs (PB0, PB1, PB2) --- */
    switch (Ann_VisualPriority)
    {
        case ANN_PRI_HIGH:
            GPIO_SetPinValue(GPIO_PORTB, ANN_YELLOW_LED_PIN, GPIO_LOW);
            GPIO_SetPinValue(GPIO_PORTB, ANN_CYAN_LED_PIN, GPIO_LOW);

            /* 2 Hz Toggle Rate (25 Ticks ON / 25 Ticks OFF @ 10ms Tick) */
            if ((Ann_VisualTicks / 25U) % 2U == 0U)
            {
                GPIO_SetPinValue(GPIO_PORTB, ANN_RED_LED_PIN, GPIO_HIGH);
            }
            else
            {
                GPIO_SetPinValue(GPIO_PORTB, ANN_RED_LED_PIN, GPIO_LOW);
            }
            break;

        case ANN_PRI_MEDIUM:
            GPIO_SetPinValue(GPIO_PORTB, ANN_RED_LED_PIN, GPIO_LOW);
            GPIO_SetPinValue(GPIO_PORTB, ANN_CYAN_LED_PIN, GPIO_LOW);

            /* 0.6 Hz Toggle Rate (~83 Ticks ON / 83 Ticks OFF @ 10ms Tick) */
            if ((Ann_VisualTicks / 83U) % 2U == 0U)
            {
                GPIO_SetPinValue(GPIO_PORTB, ANN_YELLOW_LED_PIN, GPIO_HIGH);
            }
            else
            {
                GPIO_SetPinValue(GPIO_PORTB, ANN_YELLOW_LED_PIN, GPIO_LOW);
            }
            break;

        case ANN_PRI_LOW:
            GPIO_SetPinValue(GPIO_PORTB, ANN_RED_LED_PIN, GPIO_LOW);
            GPIO_SetPinValue(GPIO_PORTB, ANN_YELLOW_LED_PIN, GPIO_LOW);

            /* Steady ON */
            GPIO_SetPinValue(GPIO_PORTB, ANN_CYAN_LED_PIN, GPIO_HIGH);
            break;

        case ANN_PRI_NONE:
        default:
            GPIO_SetPinValue(GPIO_PORTB, ANN_RED_LED_PIN, GPIO_LOW);
            GPIO_SetPinValue(GPIO_PORTB, ANN_YELLOW_LED_PIN, GPIO_LOW);
            GPIO_SetPinValue(GPIO_PORTB, ANN_CYAN_LED_PIN, GPIO_LOW);
            break;
    }
}