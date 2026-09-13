# 0 "MCAL/GPIO/GPIO.c"
# 0 "<built-in>"
# 0 "<command-line>"
# 1 "MCAL/GPIO/GPIO.c"
# 9 "MCAL/GPIO/GPIO.c"
# 1 "LIB/STD_TYPES.h" 1
# 11 "LIB/STD_TYPES.h"
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
    E_NOK = 1
} STD_ReturnType;
# 10 "MCAL/GPIO/GPIO.c" 2
# 1 "LIB/MATH.h" 1



# 1 "LIB/STD_TYPES.h" 1
# 5 "LIB/MATH.h" 2
# 11 "MCAL/GPIO/GPIO.c" 2
# 1 "MCAL/GPIO/GPIO_interface.h" 1
# 43 "MCAL/GPIO/GPIO_interface.h"
STD_ReturnType GPIO_SetPinDirection(uint8 Copy_u8Port, uint8 Copy_u8Pin, uint8 Copy_u8Direction);




STD_ReturnType GPIO_SetPinValue(uint8 Copy_u8Port, uint8 Copy_u8Pin, uint8 Copy_u8Value);




STD_ReturnType GPIO_GetPinValue(uint8 Copy_u8Port, uint8 Copy_u8Pin, uint8 *Copy_pu8Value);




STD_ReturnType GPIO_TogglePinValue(uint8 Copy_u8Port, uint8 Copy_u8Pin);




STD_ReturnType GPIO_SetPortDirection(uint8 Copy_u8Port, uint8 Copy_u8Direction);




STD_ReturnType GPIO_SetPortValue(uint8 Copy_u8Port, uint8 Copy_u8Value);




STD_ReturnType GPIO_GetPortValue(uint8 Copy_u8Port, uint8 *Copy_pu8Value);
# 12 "MCAL/GPIO/GPIO.c" 2
# 1 "MCAL/GPIO/GPIO_private.h" 1
# 32 "MCAL/GPIO/GPIO_private.h"
# 1 "MCAL/GPIO/../../LIB/STD_TYPES.h" 1
# 33 "MCAL/GPIO/GPIO_private.h" 2
# 13 "MCAL/GPIO/GPIO.c" 2
# 23 "MCAL/GPIO/GPIO.c"
STD_ReturnType GPIO_SetPinDirection(uint8 Copy_u8Port, uint8 Copy_u8Pin, uint8 Copy_u8Direction)
{
    if (Copy_u8Port > 3u || Copy_u8Pin > 7u)
    {
        return E_NOK;
    }

    switch (Copy_u8Direction)
    {
    case 0u:
        switch (Copy_u8Port)
        {
        case 0u:
            (((*(volatile uint8 *)0x3A)) &= ~(1 << (Copy_u8Pin)));
            (((*(volatile uint8 *)0x3B)) &= ~(1 << (Copy_u8Pin)));
            break;
        case 1u:
            (((*(volatile uint8 *)0x37)) &= ~(1 << (Copy_u8Pin)));
            (((*(volatile uint8 *)0x38)) &= ~(1 << (Copy_u8Pin)));
            break;
        case 2u:
            (((*(volatile uint8 *)0x34)) &= ~(1 << (Copy_u8Pin)));
            (((*(volatile uint8 *)0x35)) &= ~(1 << (Copy_u8Pin)));
            break;
        case 3u:
            (((*(volatile uint8 *)0x31)) &= ~(1 << (Copy_u8Pin)));
            (((*(volatile uint8 *)0x32)) &= ~(1 << (Copy_u8Pin)));
            break;
        }
        break;

    case 1u:
        switch (Copy_u8Port)
        {
        case 0u:
            (((*(volatile uint8 *)0x3A)) |= (1 << (Copy_u8Pin)));
            break;
        case 1u:
            (((*(volatile uint8 *)0x37)) |= (1 << (Copy_u8Pin)));
            break;
        case 2u:
            (((*(volatile uint8 *)0x34)) |= (1 << (Copy_u8Pin)));
            break;
        case 3u:
            (((*(volatile uint8 *)0x31)) |= (1 << (Copy_u8Pin)));
            break;
        }
        break;

    case 2u:
        switch (Copy_u8Port)
        {
        case 0u:
            (((*(volatile uint8 *)0x3A)) &= ~(1 << (Copy_u8Pin)));
            (((*(volatile uint8 *)0x3B)) |= (1 << (Copy_u8Pin)));
            break;
        case 1u:
            (((*(volatile uint8 *)0x37)) &= ~(1 << (Copy_u8Pin)));
            (((*(volatile uint8 *)0x38)) |= (1 << (Copy_u8Pin)));
            break;
        case 2u:
            (((*(volatile uint8 *)0x34)) &= ~(1 << (Copy_u8Pin)));
            (((*(volatile uint8 *)0x35)) |= (1 << (Copy_u8Pin)));
            break;
        case 3u:
            (((*(volatile uint8 *)0x31)) &= ~(1 << (Copy_u8Pin)));
            (((*(volatile uint8 *)0x32)) |= (1 << (Copy_u8Pin)));
            break;
        }
        break;

    default:
        return E_NOK;
    }

    return E_OK;
}






STD_ReturnType GPIO_SetPinValue(uint8 Copy_u8Port, uint8 Copy_u8Pin, uint8 Copy_u8Value)
{
    if (Copy_u8Port > 3u || Copy_u8Pin > 7u)
    {
        return E_NOK;
    }

    if (Copy_u8Value == 1u)
    {
        switch (Copy_u8Port)
        {
        case 0u:
            (((*(volatile uint8 *)0x3B)) |= (1 << (Copy_u8Pin)));
            break;
        case 1u:
            (((*(volatile uint8 *)0x38)) |= (1 << (Copy_u8Pin)));
            break;
        case 2u:
            (((*(volatile uint8 *)0x35)) |= (1 << (Copy_u8Pin)));
            break;
        case 3u:
            (((*(volatile uint8 *)0x32)) |= (1 << (Copy_u8Pin)));
            break;
        }
    }
    else if (Copy_u8Value == 0u)
    {
        switch (Copy_u8Port)
        {
        case 0u:
            (((*(volatile uint8 *)0x3B)) &= ~(1 << (Copy_u8Pin)));
            break;
        case 1u:
            (((*(volatile uint8 *)0x38)) &= ~(1 << (Copy_u8Pin)));
            break;
        case 2u:
            (((*(volatile uint8 *)0x35)) &= ~(1 << (Copy_u8Pin)));
            break;
        case 3u:
            (((*(volatile uint8 *)0x32)) &= ~(1 << (Copy_u8Pin)));
            break;
        }
    }
    else
    {
        return E_NOK;
    }

    return E_OK;
}






STD_ReturnType GPIO_GetPinValue(uint8 Copy_u8Port, uint8 Copy_u8Pin, uint8 *Copy_pu8Value)
{
    if (Copy_u8Port > 3u || Copy_u8Pin > 7u || Copy_pu8Value == ((void *)0))
    {
        return E_NOK;
    }

    switch (Copy_u8Port)
    {
    case 0u:
        *Copy_pu8Value = ((((*(volatile uint8 *)0x39)) >> (Copy_u8Pin)) & 1);
        break;
    case 1u:
        *Copy_pu8Value = ((((*(volatile uint8 *)0x36)) >> (Copy_u8Pin)) & 1);
        break;
    case 2u:
        *Copy_pu8Value = ((((*(volatile uint8 *)0x33)) >> (Copy_u8Pin)) & 1);
        break;
    case 3u:
        *Copy_pu8Value = ((((*(volatile uint8 *)0x30)) >> (Copy_u8Pin)) & 1);
        break;
    }

    return E_OK;
}
# 199 "MCAL/GPIO/GPIO.c"
STD_ReturnType GPIO_SetPortDirection(uint8 Copy_u8Port, uint8 Copy_u8Direction)
{
    if (Copy_u8Port > 3u)
    {
        return E_NOK;
    }

    switch (Copy_u8Port)
    {
    case 0u:
        (*(volatile uint8 *)0x3A) = Copy_u8Direction;
        break;
    case 1u:
        (*(volatile uint8 *)0x37) = Copy_u8Direction;
        break;
    case 2u:
        (*(volatile uint8 *)0x34) = Copy_u8Direction;
        break;
    case 3u:
        (*(volatile uint8 *)0x31) = Copy_u8Direction;
        break;
    }

    return E_OK;
}





STD_ReturnType GPIO_SetPortValue(uint8 Copy_u8Port, uint8 Copy_u8Value)
{
    if (Copy_u8Port > 3u)
    {
        return E_NOK;
    }

    switch (Copy_u8Port)
    {
    case 0u:
        (*(volatile uint8 *)0x3B) = Copy_u8Value;
        break;
    case 1u:
        (*(volatile uint8 *)0x38) = Copy_u8Value;
        break;
    case 2u:
        (*(volatile uint8 *)0x35) = Copy_u8Value;
        break;
    case 3u:
        (*(volatile uint8 *)0x32) = Copy_u8Value;
        break;
    }

    return E_OK;
}





STD_ReturnType GPIO_GetPortValue(uint8 Copy_u8Port, uint8 *Copy_pu8Value)
{
    if (Copy_u8Port > 3u || Copy_pu8Value == ((void *)0))
    {
        return E_NOK;
    }

    switch (Copy_u8Port)
    {
    case 0u:
        *Copy_pu8Value = (*(volatile uint8 *)0x39);
        break;
    case 1u:
        *Copy_pu8Value = (*(volatile uint8 *)0x36);
        break;
    case 2u:
        *Copy_pu8Value = (*(volatile uint8 *)0x33);
        break;
    case 3u:
        *Copy_pu8Value = (*(volatile uint8 *)0x30);
        break;
    }

    return E_OK;
}






STD_ReturnType GPIO_TogglePinValue(uint8 Copy_u8Port, uint8 Copy_u8Pin)
{
    if (Copy_u8Port > 3u || Copy_u8Pin > 7u)
    {
        return E_NOK;
    }

    switch (Copy_u8Port)
    {
    case 0u:
        (*(volatile uint8 *)0x3B) ^= (1u << Copy_u8Pin);
        break;
    case 1u:
        (*(volatile uint8 *)0x38) ^= (1u << Copy_u8Pin);
        break;
    case 2u:
        (*(volatile uint8 *)0x35) ^= (1u << Copy_u8Pin);
        break;
    case 3u:
        (*(volatile uint8 *)0x32) ^= (1u << Copy_u8Pin);
        break;
    }

    return E_OK;
}
