#include "../../LIB/STD_TYPES.h"
#include "../../MCAL/GPIO/GPIO_interface.h"
#include "../../MCAL/SPI/SPI_interface.h"
#include "ShiftReg_interface.h"

void ShiftReg_voidInit(void)
{
    /* Initialize SPI in Master Mode with f/16 */
    (void)SPI_InitMaster(SPI_PRESC_16);

    /* Configure PB4 (Latch / RCLK) as Output and keep it LOW initially */
    GPIO_SetPinDirection(GPIO_PORTB, GPIO_PIN4, GPIO_OUTPUT);
    GPIO_SetPinValue(GPIO_PORTB, GPIO_PIN4, GPIO_LOW);
}

void ShiftReg_voidWriteByte(uint8 Copy_u8Data)
{
    /* Transmit byte over SPI */
    (void)SPI_TransceiveByte(Copy_u8Data);

    /* Generate Latch Pulse (RCLK) on PB4: LOW -> HIGH -> LOW */
    GPIO_SetPinValue(GPIO_PORTB, GPIO_PIN4, GPIO_HIGH);
    GPIO_SetPinValue(GPIO_PORTB, GPIO_PIN4, GPIO_LOW);
}