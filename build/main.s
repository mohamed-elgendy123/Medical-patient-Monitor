	.file	"main.c"
__SP_H__ = 0x3e
__SP_L__ = 0x3d
__SREG__ = 0x3f
__tmp_reg__ = 0
__zero_reg__ = 1
	.text
	.section	.rodata
.LC0:
	.word	160
	.byte	82
	.byte	18
	.word	370
	.word	120
	.word	80
	.byte	1
	.byte	1
	.section	.text.startup.main,"ax",@progbits
.global	main
	.type	main, @function
main:
	in r28,__SP_L__
	in r29,__SP_H__
	sbiw r28,14
	in __tmp_reg__,__SREG__
	cli
	out __SP_H__,r29
	out __SREG__,__tmp_reg__
	out __SP_L__,r28
/* prologue: function */
/* frame size = 14 */
/* stack size = 14 */
.L__stack_usage = 14
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
	ldi r16,0
	ldi r17,0
.L3:
	call TIMER0_IsTickPending
	cp r24, __zero_reg__
	breq .L3
	call TIMER0_ClearTick
	subi r16,-1
	sbci r17,-1
	call ANN_Audio_Tick
	call ANN_Visual_Tick
	cpi r16,50
	cpc r17,__zero_reg__
	brne .L4
	call ANN_Audio_Mute
	rjmp .L3
.L4:
	cpi r16,44
	ldi r24,1
	cpc r17,r24
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
.L19:
	ldi r16,0
	ldi r17,0
.L7:
	call TIMER0_IsTickPending
	cp r24, __zero_reg__
	breq .L7
	call TIMER0_ClearTick
	ldi r20,lo8(1)
	ldi r22,lo8(7)
	ldi r24,lo8(2)
	call GPIO_SetPinValue
	movw r24,r16
	ldi r22,lo8(5)
	ldi r23,0
	call __udivmodhi4
	sbiw r24,2
	brne .L8
	lds r24,Heartbeat_Counter
	ldi r20,0
	cp r24, __zero_reg__
	breq .L31
	subi r24,lo8(-(-1))
	sts Heartbeat_Counter,r24
	ldi r20,lo8(1)
.L31:
	ldi r22,lo8(3)
	ldi r24,lo8(1)
	call GPIO_SetPinValue
.L8:
	movw r24,r16
	ldi r22,lo8(10)
	ldi r23,0
	call __udivmodhi4
	sbiw r24,3
	brne .L10
	call Alarm_Process
.L10:
	movw r24,r16
	ldi r22,lo8(50)
	ldi r23,0
	call __udivmodhi4
	sbiw r24,4
	brne .L11
	call TIMER1_IsCaptureReady
	cpse r24,__zero_reg__
	rjmp .L12
	call HRC_Process
.L13:
	call HRC_IsAsystole
	cp r24, __zero_reg__
	breq .L14
.L15:
	ldi r20,lo8(1)
.L32:
	ldi r22,0
	ldi r24,lo8(1)
	call GPIO_SetPinValue
.L11:
	movw r24,r16
	ldi r22,lo8(100)
	ldi r23,0
	call __udivmodhi4
	sbiw r24,6
	brne .L16
	ldi r24,lo8(12)
	ldi r30,lo8(.LC0)
	ldi r31,hi8(.LC0)
	movw r26,r28
	adiw r26,1
	0:
	ld r0,Z+
	st X+,r0
	dec r24
	brne 0b
	movw r24,r28
	adiw r24,1
	call Alarm_UpdateVitals
.L16:
	call ANN_Audio_Tick
	call ANN_Visual_Tick
	ldi r20,0
	ldi r22,lo8(7)
	ldi r24,lo8(2)
	call GPIO_SetPinValue
	subi r16,-1
	sbci r17,-1
	cpi r16,-24
	ldi r25,3
	cpc r17,r25
	breq .+2
	rjmp .L7
	rjmp .L19
.L12:
	call TIMER1_GetLastInterval
	std Y+13,r24
	std Y+14,r25
	call HRC_Process
	ldd r24,Y+13
	ldd r25,Y+14
	or r24,r25
	breq .L13
	ldi r24,lo8(2)
	sts Heartbeat_Counter,r24
	rjmp .L13
.L14:
	call HRC_GetBpm
	or r24,r25
	breq .L15
	ldi r20,0
	rjmp .L32
	.size	main, .-main
	.section	.bss.Heartbeat_Counter,"aw",@nobits
	.type	Heartbeat_Counter, @object
	.size	Heartbeat_Counter, 1
Heartbeat_Counter:
	.zero	1
	.ident	"GCC: (GNU) 15.2.0"
.global __do_copy_data
.global __do_clear_bss
