	.file	"HR_Capture.c"
__SP_H__ = 0x3e
__SP_L__ = 0x3d
__SREG__ = 0x3f
__tmp_reg__ = 0
__zero_reg__ = 1
	.text
	.section	.text.HRC_Init,"ax",@progbits
.global	HRC_Init
	.type	HRC_Init, @function
HRC_Init:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	sts HRC_MedianIndex,__zero_reg__
	sts HRC_MedianCount,__zero_reg__
	sts HRC_IntervalIndex,__zero_reg__
	sts HRC_CurrentBpm+1,__zero_reg__
	sts HRC_CurrentBpm,__zero_reg__
	sts HRC_CurrentHrvMs+1,__zero_reg__
	sts HRC_CurrentHrvMs,__zero_reg__
	sts HRC_Asystole,__zero_reg__
	ldi r30,lo8(HRC_MedianIntervals)
	ldi r31,hi8(HRC_MedianIntervals)
	std Z+1,__zero_reg__
	st Z,__zero_reg__
	std Z+3,__zero_reg__
	std Z+2,__zero_reg__
	std Z+5,__zero_reg__
	std Z+4,__zero_reg__
	ldi r30,lo8(HRC_Intervals)
	ldi r31,hi8(HRC_Intervals)
	std Z+1,__zero_reg__
	st Z,__zero_reg__
	std Z+3,__zero_reg__
	std Z+2,__zero_reg__
	std Z+5,__zero_reg__
	std Z+4,__zero_reg__
	std Z+7,__zero_reg__
	std Z+6,__zero_reg__
	std Z+9,__zero_reg__
	std Z+8,__zero_reg__
	std Z+11,__zero_reg__
	std Z+10,__zero_reg__
	std Z+13,__zero_reg__
	std Z+12,__zero_reg__
	std Z+15,__zero_reg__
	std Z+14,__zero_reg__
	jmp TIMER1_Init
	.size	HRC_Init, .-HRC_Init
	.section	.text.HRC_OnCapture,"ax",@progbits
.global	HRC_OnCapture
	.type	HRC_OnCapture, @function
HRC_OnCapture:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	sbiw r24,0
	breq .L2
	lds r30,HRC_MedianIndex
	ldi r31,0
	lsl r30
	rol r31
	subi r30,lo8(-(HRC_MedianIntervals))
	sbci r31,hi8(-(HRC_MedianIntervals))
	std Z+1,r25
	st Z,r24
	lds r18,HRC_MedianIndex
	subi r18,lo8(-(1))
	sts HRC_MedianIndex,r18
	lds r18,HRC_MedianIndex
	cpi r18,lo8(3)
	brlo .L4
	sts HRC_MedianIndex,__zero_reg__
.L4:
	lds r18,HRC_MedianCount
	cpi r18,lo8(3)
	brsh .L5
	lds r18,HRC_MedianCount
	subi r18,lo8(-(1))
	sts HRC_MedianCount,r18
.L5:
	lds r30,HRC_IntervalIndex
	ldi r31,0
	lsl r30
	rol r31
	subi r30,lo8(-(HRC_Intervals))
	sbci r31,hi8(-(HRC_Intervals))
	std Z+1,r25
	st Z,r24
	lds r24,HRC_IntervalIndex
	subi r24,lo8(-(1))
	sts HRC_IntervalIndex,r24
	lds r24,HRC_IntervalIndex
	cpi r24,lo8(8)
	brlo .L6
	sts HRC_IntervalIndex,__zero_reg__
.L6:
	sts HRC_Asystole,__zero_reg__
.L2:
/* epilogue start */
	ret
	.size	HRC_OnCapture, .-HRC_OnCapture
	.section	.text.HRC_OnOverflow,"ax",@progbits
.global	HRC_OnOverflow
	.type	HRC_OnOverflow, @function
HRC_OnOverflow:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	call TIMER1_IsAsystole
	tst r24
	breq .L10
	ldi r24,lo8(1)
	sts HRC_Asystole,r24
	sts HRC_CurrentBpm+1,__zero_reg__
	sts HRC_CurrentBpm,__zero_reg__
.L10:
/* epilogue start */
	ret
	.size	HRC_OnOverflow, .-HRC_OnOverflow
	.section	.text.HRC_GetBpm,"ax",@progbits
.global	HRC_GetBpm
	.type	HRC_GetBpm, @function
HRC_GetBpm:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	lds r24,HRC_CurrentBpm
	lds r25,HRC_CurrentBpm+1
/* epilogue start */
	ret
	.size	HRC_GetBpm, .-HRC_GetBpm
	.section	.text.HRC_GetHrvMs,"ax",@progbits
.global	HRC_GetHrvMs
	.type	HRC_GetHrvMs, @function
HRC_GetHrvMs:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	lds r24,HRC_CurrentHrvMs
	lds r25,HRC_CurrentHrvMs+1
/* epilogue start */
	ret
	.size	HRC_GetHrvMs, .-HRC_GetHrvMs
	.section	.text.HRC_IsAsystole,"ax",@progbits
.global	HRC_IsAsystole
	.type	HRC_IsAsystole, @function
HRC_IsAsystole:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	call TIMER1_IsAsystole
	cpse r24,__zero_reg__
	rjmp .L20
	lds r25,HRC_Asystole
	ldi r24,lo8(1)
	cpse r25,__zero_reg__
	rjmp .L17
	ldi r24,0
	ret
.L20:
	ldi r24,lo8(1)
.L17:
/* epilogue start */
	ret
	.size	HRC_IsAsystole, .-HRC_IsAsystole
	.section	.text.HRC_Process,"ax",@progbits
.global	HRC_Process
	.type	HRC_Process, @function
HRC_Process:
	push r28
	push r29
/* prologue: function */
/* frame size = 0 */
/* stack size = 2 */
.L__stack_usage = 2
	call TIMER1_IsAsystole
	tst r24
	breq .L22
	ldi r24,lo8(1)
	sts HRC_Asystole,r24
.L54:
	sts HRC_CurrentBpm+1,__zero_reg__
	sts HRC_CurrentBpm,__zero_reg__
	sts HRC_CurrentHrvMs+1,__zero_reg__
	sts HRC_CurrentHrvMs,__zero_reg__
	sts HRC_MedianCount,__zero_reg__
.L21:
/* epilogue start */
	pop r29
	pop r28
	ret
.L22:
	call TIMER1_IsCaptureReady
	tst r24
	breq .L24
	call TIMER1_GetLastInterval
	sbiw r24,0
	breq .L25
	call HRC_OnCapture
.L25:
	call TIMER1_ClearCaptureFlag
.L24:
	call HRC_IsAsystole
	cpse r24,__zero_reg__
	rjmp .L54
	lds r24,HRC_MedianCount
	tst r24
	brne .+2
	rjmp .L39
	lds r24,HRC_MedianCount
	cpi r24,lo8(1)
	breq .+2
	rjmp .L28
	lds r18,HRC_MedianIntervals
	lds r19,HRC_MedianIntervals+1
.L29:
	cp r18,__zero_reg__
	cpc r19,__zero_reg__
	breq .L27
	ldi r21,0
	ldi r20,0
	ldi r22,lo8(56)
	ldi r23,lo8(-100)
	ldi r24,lo8(28)
	ldi r25,0
	call __udivmodsi4
	movw r26,r20
	movw r24,r18
	sbiw r24,30
	sbc r26,__zero_reg__
	sbc r27,__zero_reg__
	cpi r24,-35
	cpc r25,__zero_reg__
	cpc r26,__zero_reg__
	cpc r27,__zero_reg__
	brlo .+2
	rjmp .L39
.L27:
	sts HRC_CurrentBpm+1,r19
	sts HRC_CurrentBpm,r18
	ldi r18,lo8(1)
	ldi r19,0
	ldi r20,0
	ldi r21,0
	movw r22,r20
.L37:
	movw r30,r18
	lsl r30
	rol r31
	subi r30,lo8(-(HRC_Intervals))
	sbci r31,hi8(-(HRC_Intervals))
	ld r24,Z
	ldd r25,Z+1
	or r24,r25
	brne .+2
	rjmp .L41
	movw r26,r18
	lsl r26
	rol r27
	subi r26,lo8(-(HRC_Intervals-2))
	sbci r27,hi8(-(HRC_Intervals-2))
	ld r24,X+
	ld r25,X
	sbiw r26,1
	or r24,r25
	brne .+2
	rjmp .L41
	ld r28,Z
	ldd r29,Z+1
	ld r24,X+
	ld r25,X
	sbiw r26,1
	cp r28,r24
	cpc r29,r25
	brsh .+2
	rjmp .L35
	ld r24,Z
	ldd r25,Z+1
	ld r30,X+
	ld r31,X
.L53:
	sub r24,r30
	sbc r25,r31
	add r20,r24
	adc r21,r25
	adc r22,__zero_reg__
	adc r23,__zero_reg__
	subi r18,-1
	sbci r19,-1
	cpi r18,8
	cpc r19,__zero_reg__
	brne .L37
	movw r24,r22
	movw r22,r20
	ldi r18,lo8(7)
	ldi r19,0
	ldi r20,0
	ldi r21,0
	call __udivmodsi4
	movw r24,r20
	movw r22,r18
	ldi r18,5
	1:
	lsl r22
	rol r23
	rol r24
	rol r25
	dec r18
	brne 1b
	ldi r18,lo8(-24)
	ldi r19,lo8(3)
	ldi r20,0
	ldi r21,0
	call __udivmodsi4
	cp r18,__zero_reg__
	cpc r19,__zero_reg__
	ldi r24,1
	cpc r20,r24
	cpc r21,__zero_reg__
	brsh .L42
.L34:
	sts HRC_CurrentHrvMs+1,r19
	sts HRC_CurrentHrvMs,r18
	rjmp .L21
.L28:
	lds r24,HRC_MedianCount
	cpi r24,lo8(2)
	brne .L30
	lds r18,HRC_MedianIntervals+2
	lds r19,HRC_MedianIntervals+2+1
	rjmp .L29
.L30:
	lds r20,HRC_MedianIntervals
	lds r21,HRC_MedianIntervals+1
	lds r24,HRC_MedianIntervals+2
	lds r25,HRC_MedianIntervals+2+1
	lds r18,HRC_MedianIntervals+4
	lds r19,HRC_MedianIntervals+4+1
	cp r24,r20
	cpc r25,r21
	brsh .L31
	mov r23,r20
	mov r22,r21
	movw r20,r24
	mov r24,r23
	mov r25,r22
.L31:
	cp r24,r18
	cpc r25,r19
	brsh .L32
	movw r18,r24
.L32:
	cp r18,r20
	cpc r19,r21
	brlo .+2
	rjmp .L29
	movw r18,r20
	rjmp .L29
.L39:
	ldi r19,0
	ldi r18,0
	rjmp .L27
.L35:
	ld r24,X+
	ld r25,X
	ld __tmp_reg__,Z+
	ld r31,Z
	mov r30,__tmp_reg__
	rjmp .L53
.L41:
	ldi r19,0
	ldi r18,0
	rjmp .L34
.L42:
	ldi r18,lo8(-1)
	ldi r19,lo8(-1)
	rjmp .L34
	.size	HRC_Process, .-HRC_Process
	.section	.text.HRC_ClearAsystole,"ax",@progbits
.global	HRC_ClearAsystole
	.type	HRC_ClearAsystole, @function
HRC_ClearAsystole:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	sts HRC_Asystole,__zero_reg__
	jmp TIMER1_ClearAsystole
	.size	HRC_ClearAsystole, .-HRC_ClearAsystole
	.section	.bss.HRC_Asystole,"aw",@nobits
	.type	HRC_Asystole, @object
	.size	HRC_Asystole, 1
HRC_Asystole:
	.zero	1
	.section	.bss.HRC_CurrentHrvMs,"aw",@nobits
	.type	HRC_CurrentHrvMs, @object
	.size	HRC_CurrentHrvMs, 2
HRC_CurrentHrvMs:
	.zero	2
	.section	.bss.HRC_CurrentBpm,"aw",@nobits
	.type	HRC_CurrentBpm, @object
	.size	HRC_CurrentBpm, 2
HRC_CurrentBpm:
	.zero	2
	.section	.bss.HRC_IntervalIndex,"aw",@nobits
	.type	HRC_IntervalIndex, @object
	.size	HRC_IntervalIndex, 1
HRC_IntervalIndex:
	.zero	1
	.section	.bss.HRC_MedianCount,"aw",@nobits
	.type	HRC_MedianCount, @object
	.size	HRC_MedianCount, 1
HRC_MedianCount:
	.zero	1
	.section	.bss.HRC_MedianIndex,"aw",@nobits
	.type	HRC_MedianIndex, @object
	.size	HRC_MedianIndex, 1
HRC_MedianIndex:
	.zero	1
	.section	.bss.HRC_Intervals,"aw",@nobits
	.type	HRC_Intervals, @object
	.size	HRC_Intervals, 16
HRC_Intervals:
	.zero	16
	.section	.bss.HRC_MedianIntervals,"aw",@nobits
	.type	HRC_MedianIntervals, @object
	.size	HRC_MedianIntervals, 6
HRC_MedianIntervals:
	.zero	6
	.ident	"GCC: (GNU) 7.3.0"
.global __do_clear_bss
