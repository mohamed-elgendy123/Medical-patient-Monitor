#ifndef RING_BUFFER_H
#define RING_BUFFER_H

#include "STD_TYPES.h"

/* Ring Buffer Structure */
typedef struct {
    uint16 *buffer;
    uint16 head;
    uint16 tail;
    uint16 size;
    uint16 count;
} RingBuffer_t;

/* Function Prototypes */
void RingBuffer_Init(RingBuffer_t *rb, uint16 *buffer_array, uint16 size);
uint8 RingBuffer_Push(RingBuffer_t *rb, uint16 data);
uint8 RingBuffer_Pop(RingBuffer_t *rb, uint16 *data);
uint8 RingBuffer_IsFull(const RingBuffer_t *rb);
uint8 RingBuffer_IsEmpty(const RingBuffer_t *rb);

#endif /* RING_BUFFER_H */