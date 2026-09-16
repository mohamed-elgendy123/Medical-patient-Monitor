
#include "../../LIB/STD_TYPES.h"
#include "../../MCAL/GPIO/GPIO_interface.h"
#include "NurseCall_interface.h"

void NurseCall_voidInit(void)
{
    /* Set PD4 as Output and initialize to LOW */
    GPIO_SetPinDirection(GPIO_PORTD, GPIO_PIN4, GPIO_OUTPUT);
    GPIO_SetPinValue(GPIO_PORTD, GPIO_PIN4, GPIO_LOW);
}

void NurseCall_voidEnable(void)
{
    GPIO_SetPinValue(GPIO_PORTD, GPIO_PIN4, GPIO_HIGH);
}

void NurseCall_voidDisable(void)
{
    GPIO_SetPinValue(GPIO_PORTD, GPIO_PIN4, GPIO_LOW);
}