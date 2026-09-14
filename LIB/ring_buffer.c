#include "ring_buffer.h"

void RingBuffer_Init(RingBuffer_t *rb, uint16 *buffer_array, uint16 size)
{
    if (rb != NULL && buffer_array != NULL)
    {
        rb->buffer = buffer_array;
        rb->size = size;
        rb->head = 0;
        rb->tail = 0;
        rb->count = 0;
    }
}

uint8 RingBuffer_Push(RingBuffer_t *rb, uint16 data)
{
    if (rb == NULL || RingBuffer_IsFull(rb))
    {
        return 0; /* Failed: Buffer Full or NULL */
    }

    rb->buffer[rb->head] = data;
    rb->head = (rb->head + 1) % rb->size;
    rb->count++;

    return 1; /* Success */
}

uint8 RingBuffer_Pop(RingBuffer_t *rb, uint16 *data)
{
    if (rb == NULL || data == NULL || RingBuffer_IsEmpty(rb))
    {
        return 0; /* Failed: Buffer Empty or NULL */
    }

    *data = rb->buffer[rb->tail];
    rb->tail = (rb->tail + 1) % rb->size;
    rb->count--;

    return 1; /* Success */
}

uint8 RingBuffer_IsFull(const RingBuffer_t *rb)
{
    if (rb == NULL) return 0;
    return (rb->count == rb->size);
}

uint8 RingBuffer_IsEmpty(const RingBuffer_t *rb)
{
    if (rb == NULL) return 1;
    return (rb->count == 0);
}