/*
 * Author: Ahmed Ellamie
 * Email:  ahmed.ellamiee@gmail.com
 *
 * STUDENT TASK — I2C.c  (ATmega32 TWI master)
 * Implement every prototype from I2C_interface.h.
 */

#include "STD_TYPES.h"
#include "I2C_interface.h"
#include "I2C_private.h"

#ifndef F_CPU
#define F_CPU 8000000UL
#endif
#include <util/delay.h>

/*
 * I2C_InitMaster
 * 1. Reject SCL == 0.
 * 2. TWBR = ((F_CPU / Copy_u32SclHz) - 16) / 2.  TWSR prescaler bits = 00.
 * 3. TWCR = (1 << TWEN). Do not send START here.
 */
STD_ReturnType I2C_InitMaster(uint32 Copy_u32SclHz){
    if (Copy_u32SclHz == 0 || (F_CPU / Copy_u32SclHz) < 16) {
        return E_NOK;
    }

    uint32 Local_u32Twbr = TWBR_VALUE(F_CPU, Copy_u32SclHz);
    if (Local_u32Twbr > 255) {
        return E_NOK;
    }

    /* Enable pull-ups on PC0 (SCL) and PC1 (SDA) */
    (*(volatile uint8*)0x35) |= (1u << 0) | (1u << 1);

    TWBR_REG = (uint8)Local_u32Twbr;
    TWSR_REG &= ~TWSR_PRESCALER_MASK; /* prescaler = 1 (TWPS1:0 = 00) */
    TWCR_REG = (1u << TWEN);

    return E_OK;
}

/*
 * I2C_SendStart
 * 1. TWCR = TWINT | TWSTA | TWEN.
 * 2. Wait for TWINT. Accept 0x08 (START) or 0x10 (REP START).
 */
STD_ReturnType I2C_SendStart(void){
    uint32 Local_u32Timeout = I2C_TIMEOUT;
    TWCR_REG = (1u << TWINT) | (1u << TWEN) | (1u << TWSTA);
    while (((TWCR_REG & (1u << TWINT)) == 0) && (--Local_u32Timeout > 0)) ;
    if (Local_u32Timeout == 0) return E_NOK;
    uint8 status = TWSR_REG & TWSR_STATUS_MASK;
    if (status != I2C_START_ACK && status != I2C_REP_START_ACK) {
        return E_NOK;
    }
    return E_OK;
}

/*
 * I2C_SendRepeatedStart
 * 1. Same as START. Accept 0x10 or 0x08 (due to SimulIDE simulator quirks).
 */
STD_ReturnType I2C_SendRepeatedStart(void){
    uint32 Local_u32Timeout = I2C_TIMEOUT;
    TWCR_REG = (1u << TWINT) | (1u << TWEN) | (1u << TWSTA);
    while (((TWCR_REG & (1u << TWINT)) == 0) && (--Local_u32Timeout > 0)) ;
    if (Local_u32Timeout == 0) return E_NOK;
    uint8 status = TWSR_REG & TWSR_STATUS_MASK;
    if (status != I2C_START_ACK && status != I2C_REP_START_ACK) {
        return E_NOK;
    }
    return E_OK;
}

/*
 * I2C_SendStop
 * 1. TWCR = TWINT | TWSTO | TWEN. No status check.
 */
void I2C_SendStop(void){
    TWCR_REG = (1u << TWINT) | (1u << TWSTO) | (1u << TWEN);
    _delay_us(50);
}

/*
 * I2C_SendSlaveAddressWithWrite
 * 1. TWDR = (Copy_u8Address << 1) | 0.
 * 2. TWCR = TWINT | TWEN. Expect I2C_SLA_W_ACK (0x18).
 *
 * I2C_SendSlaveAddressWithRead
 * 1. TWDR = (Copy_u8Address << 1) | 1.
 * 2. Expect I2C_SLA_R_ACK (0x40).
 */
STD_ReturnType I2C_SendSlaveAddressWithWrite(uint8 Copy_u8Address){
    if (Copy_u8Address > 0x7Fu) {
        return E_NOK;
    }

    TWDR_REG = SLA_W(Copy_u8Address);
    MASTER_STEP(0, I2C_SLA_W_ACK);
    return E_OK;
}

STD_ReturnType I2C_SendSlaveAddressWithRead(uint8 Copy_u8Address){
    if (Copy_u8Address > 0x7Fu) {
        return E_NOK;
    }

    TWDR_REG = SLA_R(Copy_u8Address);
    MASTER_STEP(0, I2C_SLA_R_ACK);
    return E_OK;
}

/*
 * I2C_SendByte
 * 1. TWDR = Copy_u8Data. TWCR = TWINT | TWEN. Expect I2C_DATA_TX_ACK (0x28).
 */
STD_ReturnType I2C_SendByte(uint8 Copy_u8Data){
    TWDR_REG = Copy_u8Data;
    MASTER_STEP(0, I2C_DATA_TX_ACK);
    return E_OK;
}

/*
 * I2C_ReceiveByte
 * 1. Reject a NULL pointer.
 * 2. If Copy_u8SendAck == I2C_ACK: TWCR = TWINT | TWEA | TWEN, expect 0x50.
 *    If I2C_NACK:                 TWCR = TWINT | TWEN,        expect 0x58.
 * 3. *Copy_pu8Data = TWDR.
 */
STD_ReturnType I2C_ReceiveByte(uint8 *Copy_pu8Data, uint8 Copy_u8SendAck){
    if (Copy_pu8Data == NULL) {
        return E_NOK;
    }

    if (Copy_u8SendAck == I2C_ACK) {
        MASTER_STEP((1u << TWEA), I2C_DATA_RX_ACK);
    } else if (Copy_u8SendAck == I2C_NACK) {
        MASTER_STEP(0, I2C_DATA_RX_NACK);
    } else {
        return E_NOK;
    }

    *Copy_pu8Data = TWDR_REG;
    return E_OK;
}
/*
 * Typical 24Cxx write: START -> SLA+W -> word address -> data -> STOP
 * Typical 24Cxx read : START -> SLA+W -> word address -> REP START -> SLA+R -> data+NACK -> STOP
 */
