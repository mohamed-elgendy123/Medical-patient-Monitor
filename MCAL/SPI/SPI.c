

#include "../../LIB/STD_TYPES.h"

#ifndef NULL_PTR
#define NULL_PTR    ((void*)0)
#endif

#ifndef E_OK
#define E_OK        0u
#endif

#ifndef E_NOT_OK
#define E_NOT_OK    1u
#endif

#include "../GPIO/GPIO_interface.h"
#include "SPI_interface.h"
#include "SPI_private.h"

STD_ReturnType SPI_InitMaster(uint8 Copy_u8Prescaler)
{
    STD_ReturnType Local_u8Status = E_OK;

    if (Copy_u8Prescaler > SPI_PRESC_128)
    {
        Local_u8Status = E_NOT_OK;
    }
    else
    {
        /* Configure Master Pins Direction:
         * PB4 (SS / Latch) : Output
         * PB5 (MOSI)       : Output
         * PB6 (MISO)       : Input
         * PB7 (SCK)        : Output
         */
        GPIO_SetPinDirection(GPIO_PORTB, GPIO_PIN4, GPIO_OUTPUT);
        GPIO_SetPinDirection(GPIO_PORTB, GPIO_PIN5, GPIO_OUTPUT);
        GPIO_SetPinDirection(GPIO_PORTB, GPIO_PIN6, GPIO_INPUT);
        GPIO_SetPinDirection(GPIO_PORTB, GPIO_PIN7, GPIO_OUTPUT);

        /* Idle SS Pin HIGH */
        GPIO_SetPinValue(GPIO_PORTB, GPIO_PIN4, GPIO_HIGH);

        /* SPI Setup: Enable, Master, Mode 0 (CPOL=0, CPHA=0) */
        SPI_SPCR_REG = (1u << SPI_SPCR_SPE) | (1u << SPI_SPCR_MSTR) | (Copy_u8Prescaler & 0x03u);
    }

    return Local_u8Status;
}

uint8 SPI_TransceiveByte(uint8 Copy_u8Data)
{
    SPI_SPDR_REG = Copy_u8Data;

    while ((SPI_SPSR_REG & (1u << SPI_SPSR_SPIF)) == 0u)
    {
        /* Wait */
    }

    return SPI_SPDR_REG;
}

STD_ReturnType SPI_Transceive(uint8 Copy_u8Sent, uint8 *Copy_pu8Received)
{
    STD_ReturnType Local_u8Status = E_OK;

    if (Copy_pu8Received == NULL_PTR)
    {
        Local_u8Status = E_NOT_OK;
    }
    else
    {
        *Copy_pu8Received = SPI_TransceiveByte(Copy_u8Sent);
    }

    return Local_u8Status;
}

STD_ReturnType SPI_SelectSlave(uint8 Copy_u8Port, uint8 Copy_u8Pin)
{
    GPIO_SetPinDirection(Copy_u8Port, Copy_u8Pin, GPIO_OUTPUT);
    GPIO_SetPinValue(Copy_u8Port, Copy_u8Pin, GPIO_LOW);
    return E_OK;
}

STD_ReturnType SPI_ReleaseSlave(uint8 Copy_u8Port, uint8 Copy_u8Pin)
{
    GPIO_SetPinValue(Copy_u8Port, Copy_u8Pin, GPIO_HIGH);
    return E_OK;
}