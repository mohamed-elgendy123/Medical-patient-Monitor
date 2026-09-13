	.file	"main.c"
__SP_H__ = 0x3e
__SP_L__ = 0x3d
__SREG__ = 0x3f
__tmp_reg__ = 0
__zero_reg__ = 1
	.text
	.section	.text.INT0_Handler,"ax",@progbits
.global	INT0_Handler
	.type	INT0_Handler, @function
INT0_Handler:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	ldi r22,lo8(6)
	ldi r24,0
	jmp GPIO_TogglePinValue
	.size	INT0_Handler, .-INT0_Handler
	.section	.text.startup.main,"ax",@progbits
.global	main
	.type	main, @function
main:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	ldi r20,lo8(1)
	ldi r22,lo8(5)
	ldi r24,0
	call GPIO_SetPinDirection
	ldi r20,lo8(1)
	ldi r22,lo8(6)
	ldi r24,0
	call GPIO_SetPinDirection
	ldi r20,0
	ldi r22,lo8(2)
	ldi r24,lo8(3)
	call GPIO_SetPinDirection
	call TIMER0_Init
	ldi r22,lo8(gs(INT0_Handler))
	ldi r23,hi8(gs(INT0_Handler))
	ldi r24,0
	call EXTI_SetCallback
	ldi r22,lo8(1)
	ldi r24,0
	call EXTI_SetSense
	ldi r24,0
	call EXTI_Enable
	call INTERRUPT_EnableGlobal
.L3:
	ldi r22,lo8(5)
	ldi r24,0
	call GPIO_TogglePinValue
	ldi r24,lo8(-24)
	ldi r25,lo8(3)
	call TIMER0_DelayMS
	rjmp .L3
	.size	main, .-main
	.ident	"GCC: (GNU) 15.2.0"
