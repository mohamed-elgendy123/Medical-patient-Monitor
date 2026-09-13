/*


بتاع الليدات الكثير
 * Author: Ahmed Ellamie
 * Email:  ahmed.ellamiee@gmail.com
 *
 * AVR_NTI application entry.
 * Layers: LIB (types) -> MCAL (drivers) -> HAL (devices) -> Logic (app) ->
 * main.
 */
/*
#define F_CPU 8000000UL
#include "STD_TYPES.h"
#include "GPIO_interface.h"
#include "SevenSegment_interface.h"
#include "KeyPad_interface.h"
int main(void)
{

uint8 Keypad_Map[16] = {7,8,9,'/',4,5,6,'*',1,2,3,'-','c',0,'=','+'};




  uint8 pressedKey;
  KeyPad_Init(GPIO_PORTB);
  SevenSegment_Init(GPIO_PORTA);


  while (1){
KeyPad_GetPressedKey(GPIO_PORTB, &pressedKey);
    if (pressedKey == 0xFF) { // Check if a key is pressed
       continue; // No key pressed, continue the loop
    } else {
        SevenSegment_Display(GPIO_PORTA,Keypad_Map[pressedKey]); // Display the pressed key on the seven segment
    }

  }

  return 0;
}


*/

/*

#define F_CPU 8000000UL

#include "STD_TYPES.h"
#include "ADC_interface.h"
#include "GPIO_interface.h"

int main(void) {
    uint16 adcValue;

    GPIO_SetPinDirection(GPIO_PORTA, GPIO_PIN5, GPIO_OUTPUT);
    ADC_Init(ADC_REF_AVCC, ADC_PRESC_64);

    while (1) {
        ADC_ReadChannel(ADC_CHANNEL_0, &adcValue);
        if (adcValue > 512) {
            GPIO_SetPinValue(GPIO_PORTA, GPIO_PIN5, GPIO_HIGH);
        } else {
            GPIO_SetPinValue(GPIO_PORTA, GPIO_PIN5, GPIO_LOW);
        }
    }
    return 0;
}
*/



/*
#include "TIMER_interface.h"





#include "STD_TYPES.h"
#include "ADC_interface.h"
#include "GPIO_interface.h"


int main(void) {

    GPIO_SetPinDirection(GPIO_PORTA, GPIO_PIN5, GPIO_OUTPUT);
    TIMER0_Init();

    while (1) {
        GPIO_SetPinValue(GPIO_PORTA, GPIO_PIN5, GPIO_HIGH);
        TIMER0_DelayMS(1000);
        GPIO_SetPinValue(GPIO_PORTA, GPIO_PIN5, GPIO_LOW);
        TIMER0_DelayMS(1000);
    }

    return 0;
}
    */


#define F_CPU 8000000UL

#include "STD_TYPES.h"
#include "TIMER_interface.h"
#include "INTERRUPT_interface.h"
#include "GPIO_interface.h"

void INT0_Handler(void);
    

    int main(void) {

    GPIO_SetPinDirection(GPIO_PORTA, GPIO_PIN5, GPIO_OUTPUT);
    GPIO_SetPinDirection(GPIO_PORTA, GPIO_PIN6, GPIO_OUTPUT);
    GPIO_SetPinDirection(GPIO_PORTD, GPIO_PIN2, GPIO_INPUT);

    TIMER0_Init();

    /* Order matters: callback -> sense -> enable source -> enable global.
       Registering the callback last leaves a window where an edge can fire
       with no handler in place. */
    EXTI_SetCallback(EXTI_INT0, INT0_Handler);
    EXTI_SetSense(EXTI_INT0, EXTI_ANY_CHANGE);
    EXTI_Enable(EXTI_INT0);
    INTERRUPT_EnableGlobal();

    while (1) {
        GPIO_TogglePinValue(GPIO_PORTA, GPIO_PIN5);
        TIMER0_DelayMS(1000);
    }

    return 0;
}

void INT0_Handler(void) {
    GPIO_TogglePinValue(GPIO_PORTA, GPIO_PIN6);
}




