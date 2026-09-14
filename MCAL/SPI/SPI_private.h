#ifndef SPI_PRIVATE_H
#define SPI_PRIVATE_H


#include "../../LIB/STD_TYPES.h"

/* ---------------- 1. Hardware Registers ---------------- */
#define SPI_SPCR_REG    (*((volatile uint8*)0x2D))
#define SPI_SPSR_REG    (*((volatile uint8*)0x2E))
#define SPI_SPDR_REG    (*((volatile uint8*)0x2F))

/* ---------------- 2. Register Bit Definitions ---------------- */
/* SPCR Register Bits */
#define SPI_SPCR_SPR0   0u
#define SPI_SPCR_SPR1   1u
#define SPI_SPCR_CPHA   2u
#define SPI_SPCR_CPOL   3u
#define SPI_SPCR_MSTR   4u
#define SPI_SPCR_DORD   5u
#define SPI_SPCR_SPE    6u
#define SPI_SPCR_SPIE   7u

/* SPSR Register Bits */
#define SPI_SPSR_SPI2X  0u
#define SPI_SPSR_WCOL   6u
#define SPI_SPSR_SPIF   7u

/* ---------------- 3. Prescaler Definitions ---------------- */
#define SPI_PRESC_4     0u
#define SPI_PRESC_16    1u
#define SPI_PRESC_64    2u
#define SPI_PRESC_128   3u

#endif /* SPI_PRIVATE_H */