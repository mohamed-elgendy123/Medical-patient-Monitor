/*
 * Author: Ahmed Ellamie / Salma Eldeab
 * MCAL SPI Driver Implementation (ATmega32, Mode 0)
 */

#include "../../LIB/STD_TYPES.h"

/* Define return status and NULL_PTR locally if not in STD_TYPES.h */
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
         * PB4 (SS)   : Output (Driven HIGH idle)
         * PB5 (MOSI) : Output
         * PB6 (MISO) : Input
         * PB7 (SCK)  : Output
         */
        GPIO_SetPinDirection(GPIO_PORTB, GPIO_PIN4, GPIO_OUTPUT);
        GPIO_SetPinDirection(GPIO_PORTB, GPIO_PIN5, GPIO_OUTPUT);
        GPIO_SetPinDirection(GPIO_PORTB, GPIO_PIN6, GPIO_INPUT);
        GPIO_SetPinDirection(GPIO_PORTB, GPIO_PIN7, GPIO_OUTPUT);

        /* Idle SS Pin HIGH */
        GPIO_SetPinValue(GPIO_PORTB, GPIO_PIN4, GPIO_HIGH);

        /* SPCR Setup:
         * SPE  (Bit 6) : Enable SPI
         * MSTR (Bit 4) : Master Configuration
         * Mode 0       : CPOL = 0, CPHA = 0 (Bits 3 & 2 remain 0)
         * DORD         : MSB First (Bit 5 remains 0)
         * Prescaler    : SPR1:0 set via Copy_u8Prescaler
         */
        SPI_SPCR_REG = (1u << SPI_SPCR_SPE) | (1u << SPI_SPCR_MSTR) | (Copy_u8Prescaler & 0x03u);
    }

    return Local_u8Status;
}

STD_ReturnType SPI_InitSlave(void)
{
    /* Configure Slave Pins Direction:
     * PB4 (SS)   : Input
     * PB5 (MOSI) : Input
     * PB6 (MISO) : Output
     * PB7 (SCK)  : Input
     */
    GPIO_SetPinDirection(GPIO_PORTB, GPIO_PIN4, GPIO_INPUT);
    GPIO_SetPinDirection(GPIO_PORTB, GPIO_PIN5, GPIO_INPUT);
    GPIO_SetPinDirection(GPIO_PORTB, GPIO_PIN6, GPIO_OUTPUT);
    GPIO_SetPinDirection(GPIO_PORTB, GPIO_PIN7, GPIO_INPUT);

    /* Enable SPI in Slave Mode (MSTR = 0) */
    SPI_SPCR_REG = (1u << SPI_SPCR_SPE);

    return E_OK;
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
        /* Start transmission by writing data to SPDR */
        SPI_SPDR_REG = Copy_u8Sent;

        /* Wait for transmission completion (SPIF flag in SPSR set to 1) */
        while ((SPI_SPSR_REG & (1u << SPI_SPSR_SPIF)) == 0u)
        {
            /* Busy Wait */
        }

        /* Read received byte (Reading SPDR clears SPIF flag automatically) */
        *Copy_pu8Received = SPI_SPDR_REG;
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