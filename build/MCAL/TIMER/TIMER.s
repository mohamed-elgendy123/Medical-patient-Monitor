	.file	"TIMER.c"
__SP_H__ = 0x3e
__SP_L__ = 0x3d
__SREG__ = 0x3f
__tmp_reg__ = 0
__zero_reg__ = 1
	.text
	.section	.text.TIMER0_Init,"ax",@progbits
.global	TIMER0_Init
	.type	TIMER0_Init, @function
TIMER0_Init:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	out 0x33,__zero_reg__
	out 0x32,__zero_reg__
	ldi r24,lo8(77)
	out 0x3c,r24
	in r24,0x33
	ori r24,lo8(8)
	out 0x33,r24
	in r24,0x33
	ori r24,lo8(4)
	out 0x33,r24
	in r24,0x33
	ori r24,lo8(1)
	out 0x33,r24
	in r24,0x39
	ori r24,lo8(2)
	out 0x39,r24
/* epilogue start */
	ret
	.size	TIMER0_Init, .-TIMER0_Init
	.section	.text.TIMER0_SetCallback,"ax",@progbits
.global	TIMER0_SetCallback
	.type	TIMER0_SetCallback, @function
TIMER0_SetCallback:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	sbiw r24,0
	breq .L3
	sts Timer0_Callback+1,r25
	sts Timer0_Callback,r24
	ret
.L3:
	sts Timer0_Callback+1,__zero_reg__
	sts Timer0_Callback,__zero_reg__
/* epilogue start */
	ret
	.size	TIMER0_SetCallback, .-TIMER0_SetCallback
	.section	.text.TIMER0_IsTickPending,"ax",@progbits
.global	TIMER0_IsTickPending
	.type	TIMER0_IsTickPending, @function
TIMER0_IsTickPending:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	lds r25,Timer0_TickPending
	ldi r24,lo8(1)
	cpse r25,__zero_reg__
	rjmp .L6
	ldi r24,0
.L6:
/* epilogue start */
	ret
	.size	TIMER0_IsTickPending, .-TIMER0_IsTickPending
	.section	.text.TIMER0_ClearTick,"ax",@progbits
.global	TIMER0_ClearTick
	.type	TIMER0_ClearTick, @function
TIMER0_ClearTick:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	sts Timer0_TickPending,__zero_reg__
/* epilogue start */
	ret
	.size	TIMER0_ClearTick, .-TIMER0_ClearTick
	.section	.text.TIMER1_Init,"ax",@progbits
.global	TIMER1_Init
	.type	TIMER1_Init, @function
TIMER1_Init:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	out 0x2f,__zero_reg__
	out 0x2e,__zero_reg__
	in r24,0x2e
	ori r24,lo8(-128)
	out 0x2e,r24
	in r24,0x2e
	ori r24,lo8(64)
	out 0x2e,r24
	in r24,0x2e
	ori r24,lo8(4)
	out 0x2e,r24
	in r24,0x39
	ori r24,lo8(32)
	out 0x39,r24
	in r24,0x39
	ori r24,lo8(4)
	out 0x39,r24
	ldi r24,0
	ldi r25,0
.L9:
	movw r30,r24
	lsl r30
	rol r31
	subi r30,lo8(-(Timer1_Intervals))
	sbci r31,hi8(-(Timer1_Intervals))
	std Z+1,__zero_reg__
	st Z,__zero_reg__
	adiw r24,1
	cpi r24,8
	cpc r25,__zero_reg__
	brne .L9
	sts Timer1_LastCapture+1,__zero_reg__
	sts Timer1_LastCapture,__zero_reg__
	sts Timer1_RingIndex,__zero_reg__
	sts Timer1_CaptureReady,__zero_reg__
	sts Timer1_Asystole,__zero_reg__
	sts Timer1_OverflowCount+1,__zero_reg__
	sts Timer1_OverflowCount,__zero_reg__
/* epilogue start */
	ret
	.size	TIMER1_Init, .-TIMER1_Init
	.section	.text.TIMER1_IsCaptureReady,"ax",@progbits
.global	TIMER1_IsCaptureReady
	.type	TIMER1_IsCaptureReady, @function
TIMER1_IsCaptureReady:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	lds r25,Timer1_CaptureReady
	ldi r24,lo8(1)
	cpi r25,lo8(1)
	breq .L13
	ldi r24,0
.L13:
/* epilogue start */
	ret
	.size	TIMER1_IsCaptureReady, .-TIMER1_IsCaptureReady
	.section	.text.TIMER1_ClearCaptureFlag,"ax",@progbits
.global	TIMER1_ClearCaptureFlag
	.type	TIMER1_ClearCaptureFlag, @function
TIMER1_ClearCaptureFlag:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	sts Timer1_CaptureReady,__zero_reg__
/* epilogue start */
	ret
	.size	TIMER1_ClearCaptureFlag, .-TIMER1_ClearCaptureFlag
	.section	.text.TIMER1_GetInterval,"ax",@progbits
.global	TIMER1_GetInterval
	.type	TIMER1_GetInterval, @function
TIMER1_GetInterval:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	cpi r24,lo8(8)
	brsh .L20
	mov r30,r24
	ldi r31,0
	lsl r30
	rol r31
	subi r30,lo8(-(Timer1_Intervals))
	sbci r31,hi8(-(Timer1_Intervals))
	ld r24,Z
	ldd r25,Z+1
	ret
.L20:
	ldi r24,0
	ldi r25,0
/* epilogue start */
	ret
	.size	TIMER1_GetInterval, .-TIMER1_GetInterval
	.section	.text.TIMER1_IsAsystole,"ax",@progbits
.global	TIMER1_IsAsystole
	.type	TIMER1_IsAsystole, @function
TIMER1_IsAsystole:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	lds r25,Timer1_Asystole
	ldi r24,lo8(1)
	cpse r25,__zero_reg__
	rjmp .L22
	ldi r24,0
.L22:
/* epilogue start */
	ret
	.size	TIMER1_IsAsystole, .-TIMER1_IsAsystole
	.section	.text.TIMER1_ClearAsystole,"ax",@progbits
.global	TIMER1_ClearAsystole
	.type	TIMER1_ClearAsystole, @function
TIMER1_ClearAsystole:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	sts Timer1_Asystole,__zero_reg__
	sts Timer1_OverflowCount+1,__zero_reg__
	sts Timer1_OverflowCount,__zero_reg__
/* epilogue start */
	ret
	.size	TIMER1_ClearAsystole, .-TIMER1_ClearAsystole
	.section	.text.TIMER2_SetTone,"ax",@progbits
.global	TIMER2_SetTone
	.type	TIMER2_SetTone, @function
TIMER2_SetTone:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	in r25,0x25
	andi r25,lo8(-5)
	out 0x25,r25
	in r25,0x25
	andi r25,lo8(-3)
	out 0x25,r25
	in r25,0x25
	andi r25,lo8(-2)
	out 0x25,r25
	cpi r24,lo8(1)
	brne .L25
	ldi r24,lo8(-127)
	out 0x23,r24
	in r24,0x25
	ori r24,lo8(2)
	out 0x25,r24
	in r24,0x25
	ori r24,lo8(1)
.L29:
	out 0x25,r24
	ret
.L25:
	cpi r24,lo8(2)
	brne .L27
	ldi r24,lo8(97)
.L30:
	out 0x23,r24
	in r24,0x25
	ori r24,lo8(4)
	rjmp .L29
.L27:
	cpi r24,lo8(3)
	brne .L28
	ldi r24,lo8(-127)
	rjmp .L30
.L28:
	out 0x23,__zero_reg__
/* epilogue start */
	ret
	.size	TIMER2_SetTone, .-TIMER2_SetTone
	.section	.text.TIMER2_Init,"ax",@progbits
.global	TIMER2_Init
	.type	TIMER2_Init, @function
TIMER2_Init:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	sbi 0x11,7
	out 0x25,__zero_reg__
	out 0x24,__zero_reg__
	in r24,0x25
	ori r24,lo8(8)
	out 0x25,r24
	in r24,0x25
	ori r24,lo8(16)
	out 0x25,r24
	ldi r24,0
	jmp TIMER2_SetTone
	.size	TIMER2_Init, .-TIMER2_Init
	.section	.text.__vector_10,"ax",@progbits
.global	__vector_10
	.type	__vector_10, @function
__vector_10:
	push r1
	push r0
	in r0,__SREG__
	push r0
	clr __zero_reg__
	push r18
	push r19
	push r20
	push r21
	push r22
	push r23
	push r24
	push r25
	push r26
	push r27
	push r30
	push r31
/* prologue: Signal */
/* frame size = 0 */
/* stack size = 15 */
.L__stack_usage = 15
	lds r24,Timer0_Ticks
	lds r25,Timer0_Ticks+1
	lds r26,Timer0_Ticks+2
	lds r27,Timer0_Ticks+3
	adiw r24,1
	adc r26,__zero_reg__
	adc r27,__zero_reg__
	sts Timer0_Ticks,r24
	sts Timer0_Ticks+1,r25
	sts Timer0_Ticks+2,r26
	sts Timer0_Ticks+3,r27
	ldi r24,lo8(1)
	sts Timer0_TickPending,r24
	lds r24,Timer0_Callback
	lds r25,Timer0_Callback+1
	or r24,r25
	breq .L32
	lds r30,Timer0_Callback
	lds r31,Timer0_Callback+1
	icall
.L32:
/* epilogue start */
	pop r31
	pop r30
	pop r27
	pop r26
	pop r25
	pop r24
	pop r23
	pop r22
	pop r21
	pop r20
	pop r19
	pop r18
	pop r0
	out __SREG__,r0
	pop r0
	pop r1
	reti
	.size	__vector_10, .-__vector_10
	.section	.text.__vector_6,"ax",@progbits
.global	__vector_6
	.type	__vector_6, @function
__vector_6:
	__gcc_isr 1
	push r19
	push r20
	push r21
	push r24
	push r25
	push r30
	push r31
/* prologue: Signal */
/* frame size = 0 */
/* stack size = 7...11 */
.L__stack_usage = 7 + __gcc_isr.n_pushed
	in r24,0x26
	in r25,0x26+1
	lds r18,Timer1_LastCapture
	lds r19,Timer1_LastCapture+1
	lds r30,Timer1_RingIndex
	ldi r31,0
	movw r20,r24
	sub r20,r18
	sbc r21,r19
	movw r18,r20
	lsl r30
	rol r31
	subi r30,lo8(-(Timer1_Intervals))
	sbci r31,hi8(-(Timer1_Intervals))
	std Z+1,r19
	st Z,r18
	sts Timer1_LastCapture+1,r25
	sts Timer1_LastCapture,r24
	lds r24,Timer1_RingIndex
	subi r24,lo8(-(1))
	andi r24,lo8(7)
	sts Timer1_RingIndex,r24
	ldi r24,lo8(1)
	sts Timer1_CaptureReady,r24
	sts Timer1_OverflowCount+1,__zero_reg__
	sts Timer1_OverflowCount,__zero_reg__
	sts Timer1_Asystole,__zero_reg__
/* epilogue start */
	pop r31
	pop r30
	pop r25
	pop r24
	pop r21
	pop r20
	pop r19
	__gcc_isr 2
	reti
	__gcc_isr 0,r18
	.size	__vector_6, .-__vector_6
	.section	.text.__vector_9,"ax",@progbits
.global	__vector_9
	.type	__vector_9, @function
__vector_9:
	__gcc_isr 1
	push r25
/* prologue: Signal */
/* frame size = 0 */
/* stack size = 1...5 */
.L__stack_usage = 1 + __gcc_isr.n_pushed
	lds r24,Timer1_OverflowCount
	lds r25,Timer1_OverflowCount+1
	adiw r24,1
	sts Timer1_OverflowCount+1,r25
	sts Timer1_OverflowCount,r24
	lds r24,Timer1_OverflowCount
	lds r25,Timer1_OverflowCount+1
	cpi r24,2
	cpc r25,__zero_reg__
	brlo .L39
	ldi r24,lo8(1)
	sts Timer1_Asystole,r24
.L39:
/* epilogue start */
	pop r25
	__gcc_isr 2
	reti
	__gcc_isr 0,r24
	.size	__vector_9, .-__vector_9
	.section	.bss.Timer1_OverflowCount,"aw",@nobits
	.type	Timer1_OverflowCount, @object
	.size	Timer1_OverflowCount, 2
Timer1_OverflowCount:
	.zero	2
	.section	.bss.Timer1_Asystole,"aw",@nobits
	.type	Timer1_Asystole, @object
	.size	Timer1_Asystole, 1
Timer1_Asystole:
	.zero	1
	.section	.bss.Timer1_CaptureReady,"aw",@nobits
	.type	Timer1_CaptureReady, @object
	.size	Timer1_CaptureReady, 1
Timer1_CaptureReady:
	.zero	1
	.section	.bss.Timer1_RingIndex,"aw",@nobits
	.type	Timer1_RingIndex, @object
	.size	Timer1_RingIndex, 1
Timer1_RingIndex:
	.zero	1
	.section	.bss.Timer1_LastCapture,"aw",@nobits
	.type	Timer1_LastCapture, @object
	.size	Timer1_LastCapture, 2
Timer1_LastCapture:
	.zero	2
	.section	.bss.Timer1_Intervals,"aw",@nobits
	.type	Timer1_Intervals, @object
	.size	Timer1_Intervals, 16
Timer1_Intervals:
	.zero	16
	.section	.bss.Timer0_TickPending,"aw",@nobits
	.type	Timer0_TickPending, @object
	.size	Timer0_TickPending, 1
Timer0_TickPending:
	.zero	1
	.section	.bss.Timer0_Callback,"aw",@nobits
	.type	Timer0_Callback, @object
	.size	Timer0_Callback, 2
Timer0_Callback:
	.zero	2
	.section	.bss.Timer0_Ticks,"aw",@nobits
	.type	Timer0_Ticks, @object
	.size	Timer0_Ticks, 4
Timer0_Ticks:
	.zero	4
	.ident	"GCC: (GNU) 16.1.0"
.global __do_clear_bss
