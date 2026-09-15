#ifndef TRENDS_H
#define TRENDS_H

#include <stdint.h>

#define TREND_BUFFER_SIZE 60

// هيكل يجمع قراءات الـ 4 قنوات معاً في عينة واحدة
typedef struct {
    uint16_t channels[4];
} TrendSample_t;

// دوال الواجهة للـ Trends
void Trends_Init(void);
void Task_Trend(void);
uint8_t Trends_GetCount(void);
void Trends_GetSampleLine(uint8_t index, char *dest);

#endif /* TRENDS_H */