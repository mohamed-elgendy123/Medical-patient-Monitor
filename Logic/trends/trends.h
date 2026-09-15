#ifndef TRENDS_H
#define TRENDS_H

#include <stdint.h>

#define TREND_BUFFER_SIZE 60

typedef struct {
    uint16_t channels[4];
} TrendSample_t;

void Trends_Init(void);
void Task_Trend(void);
uint8_t Trends_GetCount(void);
void Trends_GetSampleLine(uint8_t index, char *dest);

#endif /* TRENDS_H */