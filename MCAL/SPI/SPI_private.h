#ifndef SPI_PRIVATE_H
#define SPI_PRIVATE_H

#include "../../LIB/STD_TYPES.h"

/* ---------------- 1. Hardware Registers ---------------- */
#define SPI_SPCR_REG    (*((volatile uint8*)0x2D))
#define SPI_SPSR_REG    (*((volatile uint8*)0x2E))
#define SPI_SPDR_REG    (*((volatile uint8*)0x2F))

/* ---------------- 2. Register Bit Definitions ---------------- */
/* SPCR - SPI Control Register */
#define SPI_SPCR_SPR0   0u
#define SPI_SPCR_SPR1   1u
#define SPI_SPCR_CPHA   2u
#define SPI_SPCR_CPOL   3u
#define SPI_SPCR_MSTR   4u
#define SPI_SPCR_DORD   5u
#define SPI_SPCR_SPE    6u
#define SPI_SPCR_SPIE   7u

/* SPSR - SPI Status Register */
#define SPI_SPSR_SPI2X  0u
#define SPI_SPSR_WCOL   6u
#define SPI_SPSR_SPIF   7u

#endif /* SPI_PRIVATE_H */