	.file	"main.c"
__SP_H__ = 0x3e
__SP_L__ = 0x3d
__SREG__ = 0x3f
__tmp_reg__ = 0
__zero_reg__ = 1
	.text
	.section	.text.startup.main,"ax",@progbits
.global	main
	.type	main, @function
main:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	ldi r20,lo8(1)
	ldi r22,lo8(7)
	ldi r24,lo8(2)
	call GPIO_SetPinDirection
	ldi r20,0
	ldi r22,lo8(7)
	ldi r24,lo8(2)
	call GPIO_SetPinValue
	call TIMER0_Init
	call HRC_Init
	call ShiftReg_voidInit
	call NurseCall_voidInit
	call ANN_Audio_Init
	call ANN_Visual_Init
	ldi r24,lo8(2)
	call ANN_Audio_SetPriority
	ldi r24,lo8(3)
	call ANN_Visual_SetPriority
	call NurseCall_voidEnable
	ldi r24,lo8(-1)
	call ShiftReg_voidWriteByte
	call INTERRUPT_EnableGlobal
	ldi r28,0
	ldi r29,0
.L3:
	call TIMER0_IsTickPending
	cp r24, __zero_reg__
	breq .L3
	call TIMER0_ClearTick
	adiw r28,1
	call ANN_Audio_Tick
	call ANN_Visual_Tick
	cpi r28,50
	cpc r29,__zero_reg__
	brne .L4
	call ANN_Audio_Mute
	rjmp .L3
.L4:
	cpi r28,44
	ldi r24,1
	cpc r29,r24
	brne .L3
	call INTERRUPT_DisableGlobal
	call ANN_Audio_Init
	call ANN_Visual_Init
	call NurseCall_voidDisable
	ldi r24,0
	call ShiftReg_voidWriteByte
	ldi r24,0
	call ANN_Audio_SetPriority
	ldi r24,0
	call ANN_Visual_SetPriority
	call NurseCall_voidDisable
	call HRC_ClearAsystole
	call TIMER0_ClearTick
	call INTERRUPT_EnableGlobal
.L11:
	ldi r28,0
	ldi r29,0
.L7:
	call TIMER0_IsTickPending
	cp r24, __zero_reg__
	breq .L7
	call TIMER0_ClearTick
	ldi r20,lo8(1)
	ldi r22,lo8(7)
	ldi r24,lo8(2)
	call GPIO_SetPinValue
	movw r24,r28
	ldi r22,lo8(50)
	ldi r23,0
	call __udivmodhi4
	sbiw r24,4
	brne .L8
	call HRC_Process
.L8:
	call ANN_Audio_Tick
	call ANN_Visual_Tick
	ldi r20,0
	ldi r22,lo8(7)
	ldi r24,lo8(2)
	call GPIO_SetPinValue
	adiw r28,1
	cpi r28,-24
	ldi r24,3
	cpc r29,r24
	brne .L7
	rjmp .L11
	.size	main, .-main
	.ident	"GCC: (GNU) 15.2.0"
