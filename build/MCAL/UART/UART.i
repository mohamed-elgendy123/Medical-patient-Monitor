# 1 "MCAL/UART/UART.c"
# 1 "<built-in>"
# 1 "<command-line>"
# 1 "MCAL/UART/UART.c"
# 9 "MCAL/UART/UART.c"
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
# 10 "MCAL/UART/UART.c" 2
# 1 "MCAL/UART/UART_interface.h" 1
# 20 "MCAL/UART/UART_interface.h"
STD_ReturnType UART_Init(uint32 Copy_u32BaudRate);




STD_ReturnType UART_SendByte(uint8 Copy_u8Data);




STD_ReturnType UART_ReceiveByte(uint8 *Copy_pu8Data);




STD_ReturnType UART_SendString(const uint8 *Copy_pu8String);





STD_ReturnType UART_IsDataReady(void);





STD_ReturnType UART_SetRxInterrupt(uint8 Copy_u8State);
STD_ReturnType UART_SetTxInterrupt(uint8 Copy_u8State);
# 11 "MCAL/UART/UART.c" 2
# 1 "MCAL/UART/UART_private.h" 1
# 12 "MCAL/UART/UART.c" 2
# 22 "MCAL/UART/UART.c"
STD_ReturnType UART_Init(uint32 Copy_u32BaudRate)
{

    if (Copy_u32BaudRate == 0)
    {
        return E_NOK;
    }


    uint16 Local_u16UBRR = (uint16)((8000000UL / (16UL * Copy_u32BaudRate)) - 1);
    (*((volatile uint8*)0x40)) = (uint8)(Local_u16UBRR >> 8);
    (*((volatile uint8*)0x29)) = (uint8)Local_u16UBRR;


    (*((volatile uint8*)0x40)) = (1 << 7) | (1 << 2) | (1 << 1);


    (*((volatile uint8*)0x2A)) = (1 << 4) | (1 << 3);

    return E_OK;
}
# 52 "MCAL/UART/UART.c"
STD_ReturnType UART_SendByte(uint8 Copy_u8Data)
{

    uint16 Local_u16Timeout = 5000U;
    while (!((*((volatile uint8*)0x2B)) & (1 << 5)) && (--Local_u16Timeout > 0U));


    (*((volatile uint8*)0x2C)) = Copy_u8Data;

    return E_OK;
}
# 72 "MCAL/UART/UART.c"
 STD_ReturnType UART_ReceiveByte(uint8 *Copy_pu8Data)
{

    if (Copy_pu8Data == ((void *)0))
    {
        return E_NOK;
    }


    while (!((*((volatile uint8*)0x2B)) & (1 << 7)));


    *Copy_pu8Data = (*((volatile uint8*)0x2C));

    return E_OK;
}
# 97 "MCAL/UART/UART.c"
STD_ReturnType UART_SendString(const uint8 *Copy_pu8String)
{

    if (Copy_pu8String == ((void *)0))
    {
        return E_NOK;
    }


    uint32 Local_u32Index = 0;
    while (Copy_pu8String[Local_u32Index] != '\0')
    {
        UART_SendByte(Copy_pu8String[Local_u32Index]);
        Local_u32Index++;
    }

    return E_OK;
}
# 123 "MCAL/UART/UART.c"
STD_ReturnType UART_IsDataReady(void)
{

    if ((*((volatile uint8*)0x2B)) & (1 << 7))
    {
        return E_OK;
    }

    return E_NOK;
}
# 141 "MCAL/UART/UART.c"
STD_ReturnType UART_SetRxInterrupt(uint8 Copy_u8State)
{
    if (Copy_u8State == 1)
    {
        (*((volatile uint8*)0x2A)) |= (1 << 7);
    }
    else
    {
        (*((volatile uint8*)0x2A)) &= ~(1 << 7);
    }

    return E_OK;
}

STD_ReturnType UART_SetTxInterrupt(uint8 Copy_u8State)
{
    if (Copy_u8State == 1)
    {
        (*((volatile uint8*)0x2A)) |= (1 << 5);
    }
    else
    {
        (*((volatile uint8*)0x2A)) &= ~(1 << 5);
    }

    return E_OK;
}
