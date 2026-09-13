/*
 * Author: Ahmed Ellamie
 * Email:  ahmed.ellamiee@gmail.com
 *
 * STUDENT TASK — INTERRUPT.c  (ATmega32 EXTI + global I-bit)
 * Implement every prototype from INTERRUPT_interface.h.
 */

#include "STD_TYPES.h"
#include "INTERRUPT_interface.h"
#include "INTERRUPT_private.h"
#include <avr/interrupt.h>

/*
 * INTERRUPT_EnableGlobal
 * 1. Set SREG I-bit (sei). Return E_OK.
 *
 * INTERRUPT_DisableGlobal
 * 1. Clear SREG I-bit (cli). Return E_OK.
 */
STD_ReturnType INTERRUPT_EnableGlobal(void)
{
    __asm__("sei");
    return E_OK;
}

STD_ReturnType INTERRUPT_DisableGlobal(void)
{
    __asm__("cli");
    return E_OK;
}

/*
 * EXTI_SetSense
 * 1. Reject an unknown source.
 * 2. INT0 : write ISC01:ISC00 from Copy_u8Sense (0..3).
 * 3. INT1 : write ISC11:ISC10 the same way.
 * 4. INT2 : only EXTI_FALLING_EDGE (ISC2=0) or EXTI_RISING_EDGE (ISC2=1).
 *    Return E_NOK for low-level / any-change on INT2.
 */

STD_ReturnType EXTI_SetSense(uint8 Copy_u8Int, uint8 Copy_u8Sense)
{
    STD_ReturnType Local_u8ErrorStatus = E_OK;

    switch (Copy_u8Int)
    {
    case EXTI_INT0:
        /* التأكد من أن قيمة الإثارة بين 0 و 3 */
        if (Copy_u8Sense <= EXTI_RISING_EDGE)
        {
            MCUCR &= ~(0x03 << 0);        /* مسح البتين ISC01 و ISC00 أولاً */
            MCUCR |= (Copy_u8Sense << 0); /* كتابة الوضع الجديد */
        }
        else
        {
            Local_u8ErrorStatus = E_NOK;
        }
        break;

    case EXTI_INT1:
        /* التأكد من أن قيمة الإثارة بين 0 و 3 */
        if (Copy_u8Sense <= EXTI_RISING_EDGE)
        {
            MCUCR &= ~(0x03 << 2);        /* مسح البتين ISC11 و ISC10 أولاً */
            MCUCR |= (Copy_u8Sense << 2); /* كتابة الوضع الجديد */
        }
        else
        {
            Local_u8ErrorStatus = E_NOK;
        }
        break;

    case EXTI_INT2:
        /* INT2 تقبل فقط Falling Edge أو Rising Edge */
        if (Copy_u8Sense == EXTI_FALLING_EDGE)
        {
            MCUCSR &= ~(1 << 6); /* وضع صفر في ISC2 */
        }
        else if (Copy_u8Sense == EXTI_RISING_EDGE)
        {
            MCUCSR |= (1 << 6); /* وضع واحد في ISC2 */
        }
        else
        {
            /* رفض Low level أو Any change لـ INT2 */
            Local_u8ErrorStatus = E_NOK;
        }
        break;

    default:
        /* رفض أي مصدر غير معروف */
        Local_u8ErrorStatus = E_NOK;
        break;
    }

    return Local_u8ErrorStatus;
}

/*
 * EXTI_ClearFlag
 * 1. Write 1 to INTF0 / INTF1 / INTF2 in GIFR (w1c).
 */

STD_ReturnType EXTI_ClearFlag(uint8 Copy_u8Int)
{
    STD_ReturnType Local_u8ErrorStatus = E_OK;

    switch (Copy_u8Int)
    {
    case EXTI_INT0:
        GIFR = (1 << GIFR_INTF0);
        break;
    case EXTI_INT1:
        GIFR = (1 << GIFR_INTF1);
        break;
    case EXTI_INT2:
        GIFR = (1 << GIFR_INTF2);
        break;
    default:
        Local_u8ErrorStatus = E_NOK;
        break;
    }

    return Local_u8ErrorStatus;
}

/*
 * EXTI_Enable
 * 1. Validate the source.
 * 2. Clear the stale flag first, then set INT0/INT1/INT2 in GICR.
 * 3. Order that always works: sense -> clear flag -> enable source -> sei().
 *
 * EXTI_Disable
 * 1. Clear the matching GICR bit.
 */

STD_ReturnType EXTI_Enable(uint8 Copy_u8Int)
{
    STD_ReturnType Local_u8ErrorStatus = E_OK;

    /* 1 & 2. مسح الفلاج القديم أولاً مع التحقق من المصدر */
    Local_u8ErrorStatus = EXTI_ClearFlag(Copy_u8Int);

    /* 3. تفعيل المقاطعة في GICR إذا كان المصدر صحيحاً */
    if (Local_u8ErrorStatus == E_OK)
    {
        switch (Copy_u8Int)
        {
        case EXTI_INT0:
            GICR |= (1 << GICR_INT0);
            break;
        case EXTI_INT1:
            GICR |= (1 << GICR_INT1);
            break;
        case EXTI_INT2:
            GICR |= (1 << GICR_INT2);
            break;
        default:
            Local_u8ErrorStatus = E_NOK;
            break;
        }
    }

    return Local_u8ErrorStatus;
}

STD_ReturnType EXTI_Disable(uint8 Copy_u8Int)
{
    STD_ReturnType Local_u8ErrorStatus = E_OK;

    switch (Copy_u8Int)
    {
    case EXTI_INT0:
        GICR &= ~(1 << GICR_INT0);
        break;
    case EXTI_INT1:
        GICR &= ~(1 << GICR_INT1);
        break;
    case EXTI_INT2:
        GICR &= ~(1 << GICR_INT2);
        break;
    default:
        Local_u8ErrorStatus = E_NOK;
        break;
    }

    return Local_u8ErrorStatus;
}

/* 1. ضَعْ هذا المتغير في أعلى ملف INTERRUPT.c */
static EXTI_CallbackType EXTI_pfCallBackArr[3] = {NULL, NULL, NULL};

/* 2. كود دالة EXTI_SetCallback في بضعة أسطر فقط */
STD_ReturnType EXTI_SetCallback(uint8 Copy_u8Int, EXTI_CallbackType Copy_pfCallback)
{
    if (Copy_pfCallback == NULL || Copy_u8Int > EXTI_INT2)
    {
        return E_NOK;
    }

    EXTI_pfCallBackArr[Copy_u8Int] = Copy_pfCallback;
    return E_OK;
}

ISR(INT0_vect)
{
    if (EXTI_pfCallBackArr[EXTI_INT0] != NULL)
    {
        EXTI_pfCallBackArr[EXTI_INT0]();
    }
}

ISR(INT1_vect)
{
    if (EXTI_pfCallBackArr[EXTI_INT1] != NULL)
    {
        EXTI_pfCallBackArr[EXTI_INT1]();
    }
}

ISR(INT2_vect)
{
    if (EXTI_pfCallBackArr[EXTI_INT2] != NULL)
    {
        EXTI_pfCallBackArr[EXTI_INT2]();
    }
}

/*
 * Application reminder (do not write this ISR here unless the lab asks):
 *   #include <avr/interrupt.h>
 *   ISR(INT0_vect) { set a volatile flag; do not call _delay_ms(); }
 */
