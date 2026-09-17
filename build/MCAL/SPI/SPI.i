# 0 "MCAL/SPI/SPI.c"
# 0 "<built-in>"
# 0 "<command-line>"
# 1 "MCAL/SPI/SPI.c"
# 1 "MCAL/SPI/../../LIB/STD_TYPES.h" 1
# 13 "MCAL/SPI/../../LIB/STD_TYPES.h"
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
# 2 "MCAL/SPI/SPI.c" 2
# 15 "MCAL/SPI/SPI.c"
# 1 "MCAL/SPI/../GPIO/GPIO_interface.h" 1
# 42 "MCAL/SPI/../GPIO/GPIO_interface.h"
STD_ReturnType GPIO_SetPinDirection(uint8 Copy_u8Port, uint8 Copy_u8Pin, uint8 Copy_u8Direction);




STD_ReturnType GPIO_SetPinValue(uint8 Copy_u8Port, uint8 Copy_u8Pin, uint8 Copy_u8Value);




STD_ReturnType GPIO_GetPinValue(uint8 Copy_u8Port, uint8 Copy_u8Pin, uint8 *Copy_pu8Value);




STD_ReturnType GPIO_TogglePinValue(uint8 Copy_u8Port, uint8 Copy_u8Pin);




STD_ReturnType GPIO_SetPortDirection(uint8 Copy_u8Port, uint8 Copy_u8Direction);




STD_ReturnType GPIO_SetPortValue(uint8 Copy_u8Port, uint8 Copy_u8Value);




STD_ReturnType GPIO_GetPortValue(uint8 Copy_u8Port, uint8 *Copy_pu8Value);
# 16 "MCAL/SPI/SPI.c" 2
# 1 "MCAL/SPI/SPI_interface.h" 1
# 30 "MCAL/SPI/SPI_interface.h"
STD_ReturnType SPI_InitMaster(uint8 Copy_u8Prescaler);




STD_ReturnType SPI_InitSlave(void);




uint8 SPI_TransceiveByte(uint8 Copy_u8Data);





STD_ReturnType SPI_Transceive(uint8 Copy_u8Sent, uint8 *Copy_pu8Received);





STD_ReturnType SPI_SelectSlave(uint8 Copy_u8Port, uint8 Copy_u8Pin);
STD_ReturnType SPI_ReleaseSlave(uint8 Copy_u8Port, uint8 Copy_u8Pin);
# 17 "MCAL/SPI/SPI.c" 2
# 1 "MCAL/SPI/SPI_private.h" 1
# 18 "MCAL/SPI/SPI.c" 2

STD_ReturnType SPI_InitMaster(uint8 Copy_u8Prescaler)
{
    STD_ReturnType Local_u8Status = 0u;

    if (Copy_u8Prescaler > 3u)
    {
        Local_u8Status = 1u;
    }
    else
    {






        GPIO_SetPinDirection(1u, 4u, 1u);
        GPIO_SetPinDirection(1u, 5u, 1u);
        GPIO_SetPinDirection(1u, 6u, 0u);
        GPIO_SetPinDirection(1u, 7u, 1u);


        GPIO_SetPinValue(1u, 4u, 0u);


        (*((volatile uint8*)0x2D)) = (1u << 6u) | (1u << 4u) | (Copy_u8Prescaler & 0x03u);
    }

    return Local_u8Status;
}

uint8 SPI_TransceiveByte(uint8 Copy_u8Data)
{
    uint16 Local_u16Timeout = 2000U;
    (*((volatile uint8*)0x2F)) = Copy_u8Data;

    while ((((*((volatile uint8*)0x2E)) & (1u << 7u)) == 0u) && (--Local_u16Timeout > 0U))
    {

    }

    return (*((volatile uint8*)0x2F));
}

STD_ReturnType SPI_Transceive(uint8 Copy_u8Sent, uint8 *Copy_pu8Received)
{
    STD_ReturnType Local_u8Status = 0u;

    if (Copy_pu8Received == ((void*)0))
    {
        Local_u8Status = 1u;
    }
    else
    {
        *Copy_pu8Received = SPI_TransceiveByte(Copy_u8Sent);
    }

    return Local_u8Status;
}

STD_ReturnType SPI_SelectSlave(uint8 Copy_u8Port, uint8 Copy_u8Pin)
{
    GPIO_SetPinDirection(Copy_u8Port, Copy_u8Pin, 1u);
    GPIO_SetPinValue(Copy_u8Port, Copy_u8Pin, 0u);
    return 0u;
}

STD_ReturnType SPI_ReleaseSlave(uint8 Copy_u8Port, uint8 Copy_u8Pin)
{
    GPIO_SetPinValue(Copy_u8Port, Copy_u8Pin, 1u);
    return 0u;
}
