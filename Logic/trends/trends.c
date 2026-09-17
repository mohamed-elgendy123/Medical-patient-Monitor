
#include "ADC_interface.h"
#include "trends.h"
#include <stdio.h>


static uint16_t _adc_read(uint8_t channel) {
    uint16_t val = 0;
    ADC_ReadChannel(channel, (uint16*)&val); 
    return val;
}


static TrendSample_t trend_buffer[TREND_BUFFER_SIZE];
static uint8_t trend_head = 0;
static uint8_t trend_count = 0;

void Trends_Init(void) {
    trend_head = 0;
    trend_count = 0;
    for(int i = 0; i < TREND_BUFFER_SIZE; i++) {
        for(int c = 0; c < 4; c++) {
            trend_buffer[i].channels[c] = 0;
        }
    }
}

void Task_Trend(void) {
    trend_buffer[trend_head].channels[0] = _adc_read(0);
    trend_buffer[trend_head].channels[1] = _adc_read(1);
    trend_buffer[trend_head].channels[2] = _adc_read(2);
    trend_buffer[trend_head].channels[3] = _adc_read(3);

    trend_head = (trend_head + 1) % TREND_BUFFER_SIZE;
    if (trend_count < TREND_BUFFER_SIZE) {
        trend_count++;
    }
}

uint8_t Trends_GetCount(void) {
    return trend_count;
}

void Trends_GetSampleLine(uint8_t index, char *dest) {
    uint8_t start_index = (trend_count < TREND_BUFFER_SIZE) ? 0 : trend_head;
    uint8_t actual_idx = (start_index + index) % TREND_BUFFER_SIZE;

    sprintf(dest, "%u,%u,%u,%u\r\n",
        trend_buffer[actual_idx].channels[0],
        trend_buffer[actual_idx].channels[1],
        trend_buffer[actual_idx].channels[2],
        trend_buffer[actual_idx].channels[3]
    );
}