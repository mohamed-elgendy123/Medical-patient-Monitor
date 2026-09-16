# 0 "HAL/Vitals/vitals.c"
# 0 "<built-in>"
# 0 "<command-line>"
# 1 "HAL/Vitals/vitals.c"
# 1 "C:/Users/amazon/AppData/Local/Microsoft/WinGet/Packages/ZakKemble.avr-gcc_Microsoft.Winget.Source_8wekyb3d8bbwe/avr-gcc-16.1.0-x64-windows/avr/include/avr/io.h" 1 3
# 93 "C:/Users/amazon/AppData/Local/Microsoft/WinGet/Packages/ZakKemble.avr-gcc_Microsoft.Winget.Source_8wekyb3d8bbwe/avr-gcc-16.1.0-x64-windows/avr/include/avr/io.h" 3
# 1 "C:/Users/amazon/AppData/Local/Microsoft/WinGet/Packages/ZakKemble.avr-gcc_Microsoft.Winget.Source_8wekyb3d8bbwe/avr-gcc-16.1.0-x64-windows/avr/include/avr/sfr_defs.h" 1 3
# 124 "C:/Users/amazon/AppData/Local/Microsoft/WinGet/Packages/ZakKemble.avr-gcc_Microsoft.Winget.Source_8wekyb3d8bbwe/avr-gcc-16.1.0-x64-windows/avr/include/avr/sfr_defs.h" 3
# 1 "C:/Users/amazon/AppData/Local/Microsoft/WinGet/Packages/ZakKemble.avr-gcc_Microsoft.Winget.Source_8wekyb3d8bbwe/avr-gcc-16.1.0-x64-windows/avr/include/inttypes.h" 1 3
# 35 "C:/Users/amazon/AppData/Local/Microsoft/WinGet/Packages/ZakKemble.avr-gcc_Microsoft.Winget.Source_8wekyb3d8bbwe/avr-gcc-16.1.0-x64-windows/avr/include/inttypes.h" 3
# 1 "C:/Users/amazon/AppData/Local/Microsoft/WinGet/Packages/ZakKemble.avr-gcc_Microsoft.Winget.Source_8wekyb3d8bbwe/avr-gcc-16.1.0-x64-windows/lib/gcc/avr/16.1.0/include/stdint.h" 1 3
# 9 "C:/Users/amazon/AppData/Local/Microsoft/WinGet/Packages/ZakKemble.avr-gcc_Microsoft.Winget.Source_8wekyb3d8bbwe/avr-gcc-16.1.0-x64-windows/lib/gcc/avr/16.1.0/include/stdint.h" 3
#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wpedantic"
# 1 "C:/Users/amazon/AppData/Local/Microsoft/WinGet/Packages/ZakKemble.avr-gcc_Microsoft.Winget.Source_8wekyb3d8bbwe/avr-gcc-16.1.0-x64-windows/avr/include/stdint.h" 1 3
# 135 "C:/Users/amazon/AppData/Local/Microsoft/WinGet/Packages/ZakKemble.avr-gcc_Microsoft.Winget.Source_8wekyb3d8bbwe/avr-gcc-16.1.0-x64-windows/avr/include/stdint.h" 3
typedef signed char int8_t;
typedef unsigned char uint8_t;



typedef int int16_t;
typedef unsigned int uint16_t;
typedef long int int32_t;
typedef long unsigned int uint32_t;
typedef long long int int64_t;
typedef long long unsigned int uint64_t;
# 157 "C:/Users/amazon/AppData/Local/Microsoft/WinGet/Packages/ZakKemble.avr-gcc_Microsoft.Winget.Source_8wekyb3d8bbwe/avr-gcc-16.1.0-x64-windows/avr/include/stdint.h" 3
__extension__ typedef __int24 int24_t;
__extension__ typedef __uint24 uint24_t;
typedef int24_t int_least24_t;
typedef uint24_t uint_least24_t;
typedef int24_t int_fast24_t;
typedef uint24_t uint_fast24_t;
# 179 "C:/Users/amazon/AppData/Local/Microsoft/WinGet/Packages/ZakKemble.avr-gcc_Microsoft.Winget.Source_8wekyb3d8bbwe/avr-gcc-16.1.0-x64-windows/avr/include/stdint.h" 3
typedef int16_t intptr_t;



typedef uint16_t uintptr_t;




typedef int_least24_t intptr24_t;




typedef uint_least24_t uintptr24_t;
# 204 "C:/Users/amazon/AppData/Local/Microsoft/WinGet/Packages/ZakKemble.avr-gcc_Microsoft.Winget.Source_8wekyb3d8bbwe/avr-gcc-16.1.0-x64-windows/avr/include/stdint.h" 3
typedef int8_t int_least8_t;



typedef uint8_t uint_least8_t;



typedef int16_t int_least16_t;



typedef uint16_t uint_least16_t;
# 232 "C:/Users/amazon/AppData/Local/Microsoft/WinGet/Packages/ZakKemble.avr-gcc_Microsoft.Winget.Source_8wekyb3d8bbwe/avr-gcc-16.1.0-x64-windows/avr/include/stdint.h" 3
typedef int32_t int_least32_t;



typedef uint32_t uint_least32_t;






typedef int64_t int_least64_t;





typedef uint64_t uint_least64_t;
# 263 "C:/Users/amazon/AppData/Local/Microsoft/WinGet/Packages/ZakKemble.avr-gcc_Microsoft.Winget.Source_8wekyb3d8bbwe/avr-gcc-16.1.0-x64-windows/avr/include/stdint.h" 3
typedef int8_t int_fast8_t;



typedef uint8_t uint_fast8_t;



typedef int16_t int_fast16_t;



typedef uint16_t uint_fast16_t;
# 291 "C:/Users/amazon/AppData/Local/Microsoft/WinGet/Packages/ZakKemble.avr-gcc_Microsoft.Winget.Source_8wekyb3d8bbwe/avr-gcc-16.1.0-x64-windows/avr/include/stdint.h" 3
typedef int32_t int_fast32_t;



typedef uint32_t uint_fast32_t;






typedef int64_t int_fast64_t;





typedef uint64_t uint_fast64_t;
# 329 "C:/Users/amazon/AppData/Local/Microsoft/WinGet/Packages/ZakKemble.avr-gcc_Microsoft.Winget.Source_8wekyb3d8bbwe/avr-gcc-16.1.0-x64-windows/avr/include/stdint.h" 3
typedef int64_t intmax_t;



typedef uint64_t uintmax_t;
# 12 "C:/Users/amazon/AppData/Local/Microsoft/WinGet/Packages/ZakKemble.avr-gcc_Microsoft.Winget.Source_8wekyb3d8bbwe/avr-gcc-16.1.0-x64-windows/lib/gcc/avr/16.1.0/include/stdint.h" 2 3
#pragma GCC diagnostic pop
# 36 "C:/Users/amazon/AppData/Local/Microsoft/WinGet/Packages/ZakKemble.avr-gcc_Microsoft.Winget.Source_8wekyb3d8bbwe/avr-gcc-16.1.0-x64-windows/avr/include/inttypes.h" 2 3
# 1 "C:/Users/amazon/AppData/Local/Microsoft/WinGet/Packages/ZakKemble.avr-gcc_Microsoft.Winget.Source_8wekyb3d8bbwe/avr-gcc-16.1.0-x64-windows/avr/include/bits/attribs.h" 1 3
# 37 "C:/Users/amazon/AppData/Local/Microsoft/WinGet/Packages/ZakKemble.avr-gcc_Microsoft.Winget.Source_8wekyb3d8bbwe/avr-gcc-16.1.0-x64-windows/avr/include/inttypes.h" 2 3
# 77 "C:/Users/amazon/AppData/Local/Microsoft/WinGet/Packages/ZakKemble.avr-gcc_Microsoft.Winget.Source_8wekyb3d8bbwe/avr-gcc-16.1.0-x64-windows/avr/include/inttypes.h" 3
typedef int32_t int_farptr_t;





typedef uint32_t uint_farptr_t;
# 125 "C:/Users/amazon/AppData/Local/Microsoft/WinGet/Packages/ZakKemble.avr-gcc_Microsoft.Winget.Source_8wekyb3d8bbwe/avr-gcc-16.1.0-x64-windows/avr/include/avr/sfr_defs.h" 2 3
# 94 "C:/Users/amazon/AppData/Local/Microsoft/WinGet/Packages/ZakKemble.avr-gcc_Microsoft.Winget.Source_8wekyb3d8bbwe/avr-gcc-16.1.0-x64-windows/avr/include/avr/io.h" 2 3
# 233 "C:/Users/amazon/AppData/Local/Microsoft/WinGet/Packages/ZakKemble.avr-gcc_Microsoft.Winget.Source_8wekyb3d8bbwe/avr-gcc-16.1.0-x64-windows/avr/include/avr/io.h" 3
# 1 "C:/Users/amazon/AppData/Local/Microsoft/WinGet/Packages/ZakKemble.avr-gcc_Microsoft.Winget.Source_8wekyb3d8bbwe/avr-gcc-16.1.0-x64-windows/avr/include/avr/iom32.h" 1 3
# 718 "C:/Users/amazon/AppData/Local/Microsoft/WinGet/Packages/ZakKemble.avr-gcc_Microsoft.Winget.Source_8wekyb3d8bbwe/avr-gcc-16.1.0-x64-windows/avr/include/avr/iom32.h" 3
       
# 719 "C:/Users/amazon/AppData/Local/Microsoft/WinGet/Packages/ZakKemble.avr-gcc_Microsoft.Winget.Source_8wekyb3d8bbwe/avr-gcc-16.1.0-x64-windows/avr/include/avr/iom32.h" 3

       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
# 234 "C:/Users/amazon/AppData/Local/Microsoft/WinGet/Packages/ZakKemble.avr-gcc_Microsoft.Winget.Source_8wekyb3d8bbwe/avr-gcc-16.1.0-x64-windows/avr/include/avr/io.h" 2 3
# 723 "C:/Users/amazon/AppData/Local/Microsoft/WinGet/Packages/ZakKemble.avr-gcc_Microsoft.Winget.Source_8wekyb3d8bbwe/avr-gcc-16.1.0-x64-windows/avr/include/avr/io.h" 3
# 1 "C:/Users/amazon/AppData/Local/Microsoft/WinGet/Packages/ZakKemble.avr-gcc_Microsoft.Winget.Source_8wekyb3d8bbwe/avr-gcc-16.1.0-x64-windows/avr/include/avr/portpins.h" 1 3
# 724 "C:/Users/amazon/AppData/Local/Microsoft/WinGet/Packages/ZakKemble.avr-gcc_Microsoft.Winget.Source_8wekyb3d8bbwe/avr-gcc-16.1.0-x64-windows/avr/include/avr/io.h" 2 3

# 1 "C:/Users/amazon/AppData/Local/Microsoft/WinGet/Packages/ZakKemble.avr-gcc_Microsoft.Winget.Source_8wekyb3d8bbwe/avr-gcc-16.1.0-x64-windows/avr/include/avr/common.h" 1 3
# 726 "C:/Users/amazon/AppData/Local/Microsoft/WinGet/Packages/ZakKemble.avr-gcc_Microsoft.Winget.Source_8wekyb3d8bbwe/avr-gcc-16.1.0-x64-windows/avr/include/avr/io.h" 2 3



# 1 "C:/Users/amazon/AppData/Local/Microsoft/WinGet/Packages/ZakKemble.avr-gcc_Microsoft.Winget.Source_8wekyb3d8bbwe/avr-gcc-16.1.0-x64-windows/avr/include/avr/version.h" 1 3
# 730 "C:/Users/amazon/AppData/Local/Microsoft/WinGet/Packages/ZakKemble.avr-gcc_Microsoft.Winget.Source_8wekyb3d8bbwe/avr-gcc-16.1.0-x64-windows/avr/include/avr/io.h" 2 3







# 1 "C:/Users/amazon/AppData/Local/Microsoft/WinGet/Packages/ZakKemble.avr-gcc_Microsoft.Winget.Source_8wekyb3d8bbwe/avr-gcc-16.1.0-x64-windows/avr/include/avr/fuse.h" 1 3
# 257 "C:/Users/amazon/AppData/Local/Microsoft/WinGet/Packages/ZakKemble.avr-gcc_Microsoft.Winget.Source_8wekyb3d8bbwe/avr-gcc-16.1.0-x64-windows/avr/include/avr/fuse.h" 3
typedef struct
{
    uint8_t low;
    uint8_t high;
} __fuse_t;
# 738 "C:/Users/amazon/AppData/Local/Microsoft/WinGet/Packages/ZakKemble.avr-gcc_Microsoft.Winget.Source_8wekyb3d8bbwe/avr-gcc-16.1.0-x64-windows/avr/include/avr/io.h" 2 3


# 1 "C:/Users/amazon/AppData/Local/Microsoft/WinGet/Packages/ZakKemble.avr-gcc_Microsoft.Winget.Source_8wekyb3d8bbwe/avr-gcc-16.1.0-x64-windows/avr/include/avr/lock.h" 1 3
# 741 "C:/Users/amazon/AppData/Local/Microsoft/WinGet/Packages/ZakKemble.avr-gcc_Microsoft.Winget.Source_8wekyb3d8bbwe/avr-gcc-16.1.0-x64-windows/avr/include/avr/io.h" 2 3
# 2 "HAL/Vitals/vitals.c" 2
# 1 "LIB/STD_TYPES.h" 1
# 13 "LIB/STD_TYPES.h"

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
# 3 "HAL/Vitals/vitals.c" 2
# 1 "MCAL/ADC/ADC_interface.h" 1
# 46 "MCAL/ADC/ADC_interface.h"
STD_ReturnType ADC_Init(uint8 Copy_u8Ref, uint8 Copy_u8Prescaler);





STD_ReturnType ADC_ReadChannel(uint8 Copy_u8Channel, uint16 *Copy_pu16Reading);




STD_ReturnType ADC_StartConversion(uint8 Copy_u8Channel);





STD_ReturnType ADC_GetResult(uint16 *Copy_pu16Reading);





STD_ReturnType ADC_SetInterrupt(uint8 Copy_u8State);
# 4 "HAL/Vitals/vitals.c" 2
# 1 "MCAL/GPIO/GPIO_interface.h" 1
# 15 "MCAL/GPIO/GPIO_interface.h"
void GPIO_DisableJtag(void);
# 45 "MCAL/GPIO/GPIO_interface.h"
STD_ReturnType GPIO_SetPinDirection(uint8 Copy_u8Port, uint8 Copy_u8Pin, uint8 Copy_u8Direction);




STD_ReturnType GPIO_SetPinValue(uint8 Copy_u8Port, uint8 Copy_u8Pin, uint8 Copy_u8Value);




STD_ReturnType GPIO_GetPinValue(uint8 Copy_u8Port, uint8 Copy_u8Pin, uint8 *Copy_pu8Value);




STD_ReturnType GPIO_TogglePinValue(uint8 Copy_u8Port, uint8 Copy_u8Pin);




STD_ReturnType GPIO_SetPortDirection(uint8 Copy_u8Port, uint8 Copy_u8Direction);




STD_ReturnType GPIO_SetPortValue(uint8 Copy_u8Port, uint8 Copy_u8Value);




STD_ReturnType GPIO_GetPortValue(uint8 Copy_u8Port, uint8 *Copy_pu8Value);
# 5 "HAL/Vitals/vitals.c" 2
# 1 "HAL/Vitals/vitals_interface.h" 1






typedef enum {
    VITALS_OK = 0,
    VITALS_SENSOR_FAULT
} Vitals_StatusType;


typedef struct {
    uint16 hrBpm;
    uint16 hrvMs;
    uint8 spo2Pct;
    uint16 tempCx10;
    uint8 nibpSys;
    uint8 nibpDia;
    uint8 respBpm;
    uint8 perfusionPct;


    uint8 leadOff : 1;
    uint8 probeOff : 1;
    uint8 beatFlag : 1;
    uint8 reserved : 5;

    uint32 monitorSec;


    Vitals_StatusType spo2Status;
    Vitals_StatusType tempStatus;
    Vitals_StatusType bpStatus;
    Vitals_StatusType respStatus;
} Vitals_t;


STD_ReturnType Vitals_Init(void);
STD_ReturnType Vitals_Read(Vitals_t *Copy_pstrVitals);
# 6 "HAL/Vitals/vitals.c" 2
# 1 "HAL/HR_Capture/HR_Capture_interface.h" 1



# 1 "./LIB/STD_TYPES.h" 1
# 5 "HAL/HR_Capture/HR_Capture_interface.h" 2
# 20 "HAL/HR_Capture/HR_Capture_interface.h"
void HRC_Init(void);
void HRC_Process(void);
void HRC_OnCapture(uint16 Copy_u16IntervalTicks);
void HRC_OnOverflow(void);
uint16 HRC_GetBpm(void);
uint16 HRC_GetHrvMs(void);
uint8 HRC_IsAsystole(void);
void HRC_ClearAsystole(void);
# 7 "HAL/Vitals/vitals.c" 2

STD_ReturnType Vitals_Init(void)
{

    
# 11 "HAL/Vitals/vitals.c" 3
   (*(volatile uint8_t *)((0x1A) + 0x20)) 
# 11 "HAL/Vitals/vitals.c"
        &= ~0x0Fu;
    
# 12 "HAL/Vitals/vitals.c" 3
   (*(volatile uint8_t *)((0x1B) + 0x20)) 
# 12 "HAL/Vitals/vitals.c"
         &= ~0x0Fu;


    
# 15 "HAL/Vitals/vitals.c" 3
   (*(volatile uint8_t *)((0x11) + 0x20)) 
# 15 "HAL/Vitals/vitals.c"
        &= ~((1u << 3) | (1u << 5));
    
# 16 "HAL/Vitals/vitals.c" 3
   (*(volatile uint8_t *)((0x12) + 0x20)) 
# 16 "HAL/Vitals/vitals.c"
         |= ((1u << 3) | (1u << 5));

    return ADC_Init(1u, 6u);
}

STD_ReturnType Vitals_Read(Vitals_t *Copy_pstrVitals)
{
    uint8 Local_u8LeadPin = 1u;
    uint8 Local_u8ProbePin = 1u;
    uint16 Local_u16RawAdc = 0;

    if (Copy_pstrVitals == ((void *)0))
    {
        return E_NOK;
    }







    Local_u8LeadPin = (
# 38 "HAL/Vitals/vitals.c" 3
                      (*(volatile uint8_t *)((0x10) + 0x20)) 
# 38 "HAL/Vitals/vitals.c"
                           & (1u << 
# 38 "HAL/Vitals/vitals.c" 3
                                    3
# 38 "HAL/Vitals/vitals.c"
                                       )) ? 1u : 0u;
    Local_u8ProbePin = (
# 39 "HAL/Vitals/vitals.c" 3
                       (*(volatile uint8_t *)((0x10) + 0x20)) 
# 39 "HAL/Vitals/vitals.c"
                            & (1u << 
# 39 "HAL/Vitals/vitals.c" 3
                                     5
# 39 "HAL/Vitals/vitals.c"
                                        )) ? 1u : 0u;

    if (Local_u8LeadPin == 0u)
    {
        Copy_pstrVitals->leadOff = 1U;
        Copy_pstrVitals->hrBpm = 0U;
    }
    else
    {
        Copy_pstrVitals->leadOff = 0U;
        Copy_pstrVitals->hrBpm = HRC_GetBpm();
    }

    if (Local_u8ProbePin == 0u)
    {
        Copy_pstrVitals->probeOff = 1U;
    }
    else
    {
        Copy_pstrVitals->probeOff = 0U;
    }






    if (ADC_ReadChannel(0u, &Local_u16RawAdc) == E_OK)
    {
        if (Copy_pstrVitals->probeOff == 1U)
        {
            Copy_pstrVitals->spo2Pct = 0U;
            Copy_pstrVitals->spo2Status = VITALS_SENSOR_FAULT;
        }
        else
        {
            Copy_pstrVitals->spo2Pct = (uint8)(70U + ((uint32)Local_u16RawAdc * 30U) / 1023U);
            Copy_pstrVitals->spo2Status = VITALS_OK;
        }
    }
    else
    {
        Copy_pstrVitals->spo2Status = VITALS_SENSOR_FAULT;
    }


    if (ADC_ReadChannel(1u, &Local_u16RawAdc) == E_OK)
    {
        Copy_pstrVitals->tempCx10 = (uint16)(300U + ((uint32)Local_u16RawAdc * 150U) / 1023U);
        Copy_pstrVitals->tempStatus = VITALS_OK;
    }
    else
    {
        Copy_pstrVitals->tempStatus = VITALS_SENSOR_FAULT;
    }


    if (ADC_ReadChannel(2u, &Local_u16RawAdc) == E_OK)
    {
        Copy_pstrVitals->nibpSys = (uint8)(50U + ((uint32)Local_u16RawAdc * 200U) / 1023U);
        Copy_pstrVitals->nibpDia = (uint8)((Copy_pstrVitals->nibpSys * 2U) / 3U);
        Copy_pstrVitals->bpStatus = VITALS_OK;
    }
    else
    {
        Copy_pstrVitals->bpStatus = VITALS_SENSOR_FAULT;
    }


    if (ADC_ReadChannel(3u, &Local_u16RawAdc) == E_OK)
    {
        Copy_pstrVitals->respBpm = (uint8)(((uint32)Local_u16RawAdc * 60U) / 1023U);
        Copy_pstrVitals->respStatus = VITALS_OK;
    }
    else
    {
        Copy_pstrVitals->respStatus = VITALS_SENSOR_FAULT;
    }

    return E_OK;
}
