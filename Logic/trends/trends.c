#include "trends.h"
#include <stdio.h>

// دالة خارجية لقراءة الـ ADC أو الحصول على الـ Vitals الحالية (تأكد من مطابقتها للدالة الفعلية لديك)
extern uint16_t ADC_Read(uint8_t channel);

// تعريف الـ Ring Buffer الخاص بالـ Trends (بمصفوفة تراكيب تسع 60 عينة)
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

/* 
 * تُستدعى بواسطة الـ Scheduler كل 10 ثواني (Task_Trend)
 * تأخذ قراءات الـ 4 قنوات وتخزنهم في الـ Ring Buffer دورياً
 */
void Task_Trend(void) {
    trend_buffer[trend_head].channels[0] = ADC_Read(0);
    trend_buffer[trend_head].channels[1] = ADC_Read(1);
    trend_buffer[trend_head].channels[2] = ADC_Read(2);
    trend_buffer[trend_head].channels[3] = ADC_Read(3);

    // تحريك مؤشر الـ Head والدوران بشكل دائرى (Circular)
    trend_head = (trend_head + 1) % TREND_BUFFER_SIZE;
    
    // زيادة الـ count حتى يصل إلى الحجم الأقصى (60)
    if (trend_count < TREND_BUFFER_SIZE) {
        trend_count++;
    }
}

uint8_t Trends_GetCount(void) {
    return trend_count;
}

/*
 * تجهيز السطر بصيغة CSV مرتب من الأقدم للأحدث لأمر TREND?
 * الـ index يتراوح من 0 إلى (trend_count - 1)
 */
void Trends_GetSampleLine(uint8_t index, char *dest) {
    // إذا لم يكتمل المخزن بعد، نبدأ من الصفر. وإذا امتلى، أقدم عينة تكون بعد الـ head مباشرة.
    uint8_t start_index = (trend_count < TREND_BUFFER_SIZE) ? 0 : trend_head;
    uint8_t actual_idx = (start_index + index) % TREND_BUFFER_SIZE;

    sprintf(dest, "%u,%u,%u,%u\r\n",
        trend_buffer[actual_idx].channels[0],
        trend_buffer[actual_idx].channels[1],
        trend_buffer[actual_idx].channels[2],
        trend_buffer[actual_idx].channels[3]
    );
}