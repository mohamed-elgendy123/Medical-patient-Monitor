# 0 "LIB/ring_buffer.c"
# 0 "<built-in>"
# 0 "<command-line>"
# 1 "LIB/ring_buffer.c"
# 1 "LIB/ring_buffer.h" 1



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
# 5 "LIB/ring_buffer.h" 2


typedef struct {
    uint16 *buffer;
    uint16 head;
    uint16 tail;
    uint16 size;
    uint16 count;
} RingBuffer_t;


void RingBuffer_Init(RingBuffer_t *rb, uint16 *buffer_array, uint16 size);
uint8 RingBuffer_Push(RingBuffer_t *rb, uint16 data);
uint8 RingBuffer_Pop(RingBuffer_t *rb, uint16 *data);
uint8 RingBuffer_IsFull(const RingBuffer_t *rb);
uint8 RingBuffer_IsEmpty(const RingBuffer_t *rb);
# 2 "LIB/ring_buffer.c" 2

void RingBuffer_Init(RingBuffer_t *rb, uint16 *buffer_array, uint16 size)
{
    if (rb != ((void *)0) && buffer_array != ((void *)0))
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
    if (rb == ((void *)0) || RingBuffer_IsFull(rb))
    {
        return 0;
    }

    rb->buffer[rb->head] = data;
    rb->head = (rb->head + 1) % rb->size;
    rb->count++;

    return 1;
}

uint8 RingBuffer_Pop(RingBuffer_t *rb, uint16 *data)
{
    if (rb == ((void *)0) || data == ((void *)0) || RingBuffer_IsEmpty(rb))
    {
        return 0;
    }

    *data = rb->buffer[rb->tail];
    rb->tail = (rb->tail + 1) % rb->size;
    rb->count--;

    return 1;
}

uint8 RingBuffer_IsFull(const RingBuffer_t *rb)
{
    if (rb == ((void *)0)) return 0;
    return (rb->count == rb->size);
}

uint8 RingBuffer_IsEmpty(const RingBuffer_t *rb)
{
    if (rb == ((void *)0)) return 1;
    return (rb->count == 0);
}
