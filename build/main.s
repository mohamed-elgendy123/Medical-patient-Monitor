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
	ldi r22,0
	ldi r24,lo8(1)
	call GPIO_SetPinDirection
	ldi r20,lo8(1)
	ldi r22,lo8(1)
	ldi r24,lo8(1)
	call GPIO_SetPinDirection
	ldi r20,lo8(1)
	ldi r22,lo8(2)
	ldi r24,lo8(1)
	call GPIO_SetPinDirection
	ldi r20,lo8(1)
	ldi r22,lo8(3)
	ldi r24,lo8(1)
	call GPIO_SetPinDirection
	ldi r20,lo8(1)
	ldi r22,lo8(7)
	ldi r24,lo8(2)
	call GPIO_SetPinDirection
	ldi r20,0
	ldi r22,lo8(6)
	ldi r24,lo8(3)
	call GPIO_SetPinDirection
	ldi r20,0
	ldi r22,lo8(7)
	ldi r24,lo8(2)
	call GPIO_SetPinValue
	call TIMER0_Init
	call HRC_Init
	call ANN_Audio_Init
	ldi r20,lo8(1)
	ldi r22,0
	ldi r24,lo8(1)
	call GPIO_SetPinValue
	ldi r20,lo8(1)
	ldi r22,lo8(1)
	ldi r24,lo8(1)
	call GPIO_SetPinValue
	ldi r20,lo8(1)
	ldi r22,lo8(2)
	ldi r24,lo8(1)
	call GPIO_SetPinValue
	ldi r24,lo8(2)
	call ANN_Audio_SetPriority
	call INTERRUPT_EnableGlobal
	ldi r28,0
	ldi r29,0
.L3:
	call TIMER0_IsTickPending
	cpi r24,lo8(0)
	breq .L3
	call TIMER0_ClearTick
	adiw r28,1
	call ANN_Audio_Tick
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
	ldi r20,0
	ldi r22,0
	ldi r24,lo8(1)
	call GPIO_SetPinValue
	ldi r20,0
	ldi r22,lo8(1)
	ldi r24,lo8(1)
	call GPIO_SetPinValue
	ldi r20,0
	ldi r22,lo8(2)
	ldi r24,lo8(1)
	call GPIO_SetPinValue
	call ANN_Audio_Init
	ldi r24,0
	call ANN_Audio_SetPriority
	call HRC_ClearAsystole
	call TIMER0_ClearTick
	call INTERRUPT_EnableGlobal
.L17:
	ldi r28,0
	ldi r29,0
.L7:
	call TIMER0_IsTickPending
	cpi r24,lo8(0)
	breq .L7
	call TIMER0_ClearTick
	ldi r20,lo8(1)
	ldi r22,lo8(7)
	ldi r24,lo8(2)
	call GPIO_SetPinValue
	movw r24,r28
	ldi r22,lo8(5)
	ldi r23,0
	call __udivmodhi4
	sbiw r24,2
	brne .L8
	lds r24,Heartbeat_Counter
	ldi r20,0
	cpi r24,lo8(0)
	breq .L34
	subi r24,lo8(-(-1))
	sts Heartbeat_Counter,r24
	ldi r20,lo8(1)
.L34:
	ldi r22,lo8(3)
	ldi r24,lo8(1)
	call GPIO_SetPinValue
.L8:
	movw r24,r28
	ldi r22,lo8(50)
	ldi r23,0
	call __udivmodhi4
	sbiw r24,4
	brne .L10
	call TIMER1_IsCaptureReady
	cpse r24,__zero_reg__
	rjmp .L11
	call HRC_Process
.L12:
	call HRC_IsAsystole
	cpi r24,lo8(0)
	breq .L13
.L14:
	ldi r20,lo8(1)
.L35:
	ldi r22,0
	ldi r24,lo8(1)
	call GPIO_SetPinValue
.L10:
	call ANN_Audio_Tick
	ldi r20,0
	ldi r22,lo8(7)
	ldi r24,lo8(2)
	call GPIO_SetPinValue
	adiw r28,1
	cpi r28,-24
	ldi r24,3
	cpc r29,r24
	breq .+2
	rjmp .L7
	rjmp .L17
.L11:
	call TIMER1_GetLastInterval
	movw r16,r24
	call HRC_Process
	movw r24,r16
	or r24,r25
	breq .L12
	ldi r24,lo8(2)
	sts Heartbeat_Counter,r24
	rjmp .L12
.L13:
	call HRC_GetBpm
	or r24,r25
	breq .L14
	ldi r20,0
	rjmp .L35
	.size	main, .-main
	.section	.bss.Heartbeat_Counter,"aw",@nobits
	.type	Heartbeat_Counter, @object
	.size	Heartbeat_Counter, 1
Heartbeat_Counter:
	.zero	1
	.ident	"GCC: (GNU) 16.1.0"
.global __do_clear_bss
