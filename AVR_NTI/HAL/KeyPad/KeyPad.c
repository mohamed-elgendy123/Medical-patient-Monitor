#include "KeyPad_interface.h"
#include "GPIO_interface.h"
STD_ReturnType KeyPad_Init(uint8 port) {
    if (port > GPIO_PORTD) {
        // Handle invalid port error
        return E_NOK; // Return an error code for invalid port
    }
    // Initialization code for the keypad
    GPIO_SetPortDirection(port, 0xF0); // Set lower 4 pins as input (rows), upper 4 pins as output (columns)
    return E_OK;
}

STD_ReturnType KeyPad_GetPressedKey(uint8 port, uint8 *PressedKey) {
    if (port > GPIO_PORTD || PressedKey == NULL) {
        // Handle invalid port or null pointer error
        return E_NOK; // Return an error code for invalid input
    }














    GPIO_SetPortValue(port, 0xF0); // Set upper 4 pins high (columns)
    // Code to read the pressed key from the keypad
    uint8 columnValues;
    GPIO_GetPortValue(port, &columnValues);
    // Example logic to determine which key is pressed (simplified)


for (uint8 row = 0; row < 4; row++)
    {
        // Set the current row pin to LOW and others to HIGH
        GPIO_SetPortValue(port, ~(1 << (row + 4)));

        for (uint8 col = 0; col < 4; col++){
GPIO_GetPortValue(port, &columnValues);

if (!(columnValues & (1 << col))) { // Check if the column pin is LOW
                *PressedKey = (row * 4 + col); // Calculate the pressed key value based on row and column
                return E_OK; // Return the pressed key value
            }
        }
        }
        *PressedKey = 0xFF; // Example: Assume no key is pressed
    return E_OK;   
    }


    
        