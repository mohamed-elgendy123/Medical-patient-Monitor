# 0 "MCAL/I2C/I2C.c"
# 0 "<built-in>"
# 0 "<command-line>"
# 1 "MCAL/I2C/I2C.c"
# 9 "MCAL/I2C/I2C.c"
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
# 10 "MCAL/I2C/I2C.c" 2
# 1 "MCAL/I2C/I2C_interface.h" 1
# 32 "MCAL/I2C/I2C_interface.h"
STD_ReturnType I2C_InitMaster(uint32 Copy_u32SclHz);




STD_ReturnType I2C_SendStart(void);




STD_ReturnType I2C_SendRepeatedStart(void);




void I2C_SendStop(void);





STD_ReturnType I2C_SendSlaveAddressWithWrite(uint8 Copy_u8Address);
STD_ReturnType I2C_SendSlaveAddressWithRead(uint8 Copy_u8Address);




STD_ReturnType I2C_SendByte(uint8 Copy_u8Data);





STD_ReturnType I2C_ReceiveByte(uint8 *Copy_pu8Data, uint8 Copy_u8SendAck);
# 11 "MCAL/I2C/I2C.c" 2
# 1 "MCAL/I2C/I2C_private.h" 1
# 12 "MCAL/I2C/I2C.c" 2







STD_ReturnType I2C_InitMaster(uint32 Copy_u32SclHz){
    if (Copy_u32SclHz == 0 || (8000000UL / Copy_u32SclHz) < 16) {
        return E_NOK;
    }

    uint32 Local_u32Twbr = (((8000000UL) / (Copy_u32SclHz) - 16) / 2);
    if (Local_u32Twbr > 255) {
        return E_NOK;
    }

    (*(volatile uint8*)0x20) = (uint8)Local_u32Twbr;
    (*(volatile uint8*)0x21) &= ~0x03u;
    (*(volatile uint8*)0x56) = (1u << 2);

    return E_OK;
}






STD_ReturnType I2C_SendStart(void){
    do { uint32 Local_u32Timeout = 2000UL; (*(volatile uint8*)0x56) = (1u << 7) | (1u << 2) | ((1u << 5)); while ((((*(volatile uint8*)0x56) & (1u << 7)) == 0) && (--Local_u32Timeout > 0)) ; if (Local_u32Timeout == 0) return E_NOK; if (((*(volatile uint8*)0x21) & 0xF8u) != (0x08u)) return E_NOK; } while(0);
    return E_OK;
}





STD_ReturnType I2C_SendRepeatedStart(void){
    do { uint32 Local_u32Timeout = 2000UL; (*(volatile uint8*)0x56) = (1u << 7) | (1u << 2) | ((1u << 5)); while ((((*(volatile uint8*)0x56) & (1u << 7)) == 0) && (--Local_u32Timeout > 0)) ; if (Local_u32Timeout == 0) return E_NOK; if (((*(volatile uint8*)0x21) & 0xF8u) != (0x10u)) return E_NOK; } while(0);
    return E_OK;
}





void I2C_SendStop(void){
    uint32 Local_u32Timeout = 2000UL;
    (*(volatile uint8*)0x56) = (1u << 7) | (1u << 4) | (1u << 2);

    while (((*(volatile uint8*)0x56) & (1u << 4)) && (--Local_u32Timeout > 0)) ;
}
# 75 "MCAL/I2C/I2C.c"
STD_ReturnType I2C_SendSlaveAddressWithWrite(uint8 Copy_u8Address){
    if (Copy_u8Address > 0x7Fu) {
        return E_NOK;
    }

    (*(volatile uint8*)0x23) = (((Copy_u8Address) << 1) | 0);
    do { uint32 Local_u32Timeout = 2000UL; (*(volatile uint8*)0x56) = (1u << 7) | (1u << 2) | (0); while ((((*(volatile uint8*)0x56) & (1u << 7)) == 0) && (--Local_u32Timeout > 0)) ; if (Local_u32Timeout == 0) return E_NOK; if (((*(volatile uint8*)0x21) & 0xF8u) != (0x18u)) return E_NOK; } while(0);
    return E_OK;
}

STD_ReturnType I2C_SendSlaveAddressWithRead(uint8 Copy_u8Address){
    if (Copy_u8Address > 0x7Fu) {
        return E_NOK;
    }

    (*(volatile uint8*)0x23) = (((Copy_u8Address) << 1) | 1);
    do { uint32 Local_u32Timeout = 2000UL; (*(volatile uint8*)0x56) = (1u << 7) | (1u << 2) | (0); while ((((*(volatile uint8*)0x56) & (1u << 7)) == 0) && (--Local_u32Timeout > 0)) ; if (Local_u32Timeout == 0) return E_NOK; if (((*(volatile uint8*)0x21) & 0xF8u) != (0x40u)) return E_NOK; } while(0);
    return E_OK;
}





STD_ReturnType I2C_SendByte(uint8 Copy_u8Data){
    (*(volatile uint8*)0x23) = Copy_u8Data;
    do { uint32 Local_u32Timeout = 2000UL; (*(volatile uint8*)0x56) = (1u << 7) | (1u << 2) | (0); while ((((*(volatile uint8*)0x56) & (1u << 7)) == 0) && (--Local_u32Timeout > 0)) ; if (Local_u32Timeout == 0) return E_NOK; if (((*(volatile uint8*)0x21) & 0xF8u) != (0x28u)) return E_NOK; } while(0);
    return E_OK;
}
# 112 "MCAL/I2C/I2C.c"
STD_ReturnType I2C_ReceiveByte(uint8 *Copy_pu8Data, uint8 Copy_u8SendAck){
    if (Copy_pu8Data == ((void *)0)) {
        return E_NOK;
    }

    if (Copy_u8SendAck == 1u) {
        do { uint32 Local_u32Timeout = 2000UL; (*(volatile uint8*)0x56) = (1u << 7) | (1u << 2) | ((1u << 6)); while ((((*(volatile uint8*)0x56) & (1u << 7)) == 0) && (--Local_u32Timeout > 0)) ; if (Local_u32Timeout == 0) return E_NOK; if (((*(volatile uint8*)0x21) & 0xF8u) != (0x50u)) return E_NOK; } while(0);
    } else if (Copy_u8SendAck == 0u) {
        do { uint32 Local_u32Timeout = 2000UL; (*(volatile uint8*)0x56) = (1u << 7) | (1u << 2) | (0); while ((((*(volatile uint8*)0x56) & (1u << 7)) == 0) && (--Local_u32Timeout > 0)) ; if (Local_u32Timeout == 0) return E_NOK; if (((*(volatile uint8*)0x21) & 0xF8u) != (0x58u)) return E_NOK; } while(0);
    } else {
        return E_NOK;
    }

    *Copy_pu8Data = (*(volatile uint8*)0x23);
    return E_OK;
}
