#include "SevenSegment_interface.h"

STD_ReturnType SevenSegment_Init(uint8 Port) {
    if (Port > GPIO_PORTD) {
        // Handle invalid port error
        return E_NOK; // Return an error code for invalid port
    }
    // Initialization code for the seven segment display
    GPIO_SetPortDirection(Port, 0xFF); // Set all pins of the port as output
    return E_OK;
}



STD_ReturnType SevenSegment_Display(uint8 Port, uint8 digit) {
    if (digit > 9) {
        // Handle invalid digit error
        return E_NOK; // Return an error code for invalid digit
    }
    const uint8 sevenSegmentMap[10] = {
        0b00111111,
        0b00000110,
        0b01011011,
        0b01001111,
        0b01100110,
        0b01101101,
        0b01111101,
        0b00000111,
        0b01111111,
        0b01101111
    };
    // Code to display the digit on the seven segment display
    // This would typically involve setting the appropriate pins high or low
    // based on the digit to be displayed.
    GPIO_SetPortValue(Port, sevenSegmentMap[digit]); // Example function to set port value
    return E_OK;
}

