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
	sts HRC_IntervalIndex,__zero_reg__
	sts HRC_CurrentBpm+1,__zero_reg__
	sts HRC_CurrentBpm,__zero_reg__
	sts HRC_CurrentHrvMs+1,__zero_reg__
	sts HRC_CurrentHrvMs,__zero_reg__
	sts HRC_Asystole,__zero_reg__
	sts HRC_MedianIntervals+1,__zero_reg__
	sts HRC_MedianIntervals,__zero_reg__
	sts HRC_MedianIntervals+2+1,__zero_reg__
	sts HRC_MedianIntervals+2,__zero_reg__
	sts HRC_MedianIntervals+4+1,__zero_reg__
	sts HRC_MedianIntervals+4,__zero_reg__
	ldi r24,0
	ldi r25,0
.L2:
	movw r30,r24
	lsl r30
	rol r31
	subi r30,lo8(-(HRC_Intervals))
	sbci r31,hi8(-(HRC_Intervals))
	std Z+1,__zero_reg__
	st Z,__zero_reg__
	adiw r24,1
	cpi r24,8
	cpc r25,__zero_reg__
	brne .L2
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
	breq .L5
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
	brlo .L7
	sts HRC_MedianIndex,__zero_reg__
.L7:
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
	brlo .L8
	sts HRC_IntervalIndex,__zero_reg__
.L8:
	sts HRC_Asystole,__zero_reg__
.L5:
/* epilogue start */
	ret
	.size	HRC_OnCapture, .-HRC_OnCapture
	.section	.text.HRC_Process,"ax",@progbits
.global	HRC_Process
	.type	HRC_Process, @function
HRC_Process:
	push r12
	push r13
	push r14
	push r15
	push r16
	push r17
	push r28
	push r29
	rcall .
	rcall .
	rcall .
	in r28,__SP_L__
	in r29,__SP_H__
/* prologue: function */
/* frame size = 6 */
/* stack size = 14 */
.L__stack_usage = 14
	call TIMER1_IsAsystole
	cpse r24,__zero_reg__
	rjmp .L14
	lds r16,HRC_Asystole
	cpi r16,lo8(0)
	breq .L15
.L14:
	sts HRC_CurrentBpm+1,__zero_reg__
	sts HRC_CurrentBpm,__zero_reg__
	sts HRC_CurrentHrvMs+1,__zero_reg__
	sts HRC_CurrentHrvMs,__zero_reg__
	ldi r24,lo8(1)
	sts HRC_Asystole,r24
.L13:
/* epilogue start */
	pop __tmp_reg__
	pop __tmp_reg__
	pop __tmp_reg__
	pop __tmp_reg__
	pop __tmp_reg__
	pop __tmp_reg__
	pop r29
	pop r28
	pop r17
	pop r16
	pop r15
	pop r14
	pop r13
	pop r12
	ret
.L15:
	call TIMER1_IsCaptureReady
	cpi r24,lo8(0)
	breq .L17
	call TIMER1_GetCaptureCount
	mov r17,r24
	call TIMER1_GetCaptureWriteIndex
	mov r15,r24
	sub r24,r17
	mov r17,r24
.L18:
	cpse r15,r17
	rjmp .L19
	call TIMER1_ClearCaptureFlag
.L17:
	movw r12,r28
	ldi r24,-1
	sub r12,r24
	sbc r13,r24
	ldi r30,0
	ldi r31,0
	movw r18,r30
.L21:
	movw r26,r30
	lsl r26
	rol r27
	subi r26,lo8(-(HRC_MedianIntervals))
	sbci r27,hi8(-(HRC_MedianIntervals))
	ld r14,X+
	ld r15,X+
	movw r26,r12
	st X+,r14
	st X+,r15
	movw r12,r26
	cp r14,__zero_reg__
	cpc r15,r14
	breq .L32
	lds r24,HRC_MedianIndex
	ldi r25,0
	adiw r24,2
	ldi r22,lo8(3)
	ldi r23,0
	call __udivmodhi4
	cp r24,r30
	cpc r25,r31
	brne .L20
	movw r18,r14
	rjmp .L20
.L19:
	mov r24,r17
	andi r24,lo8(7)
	call TIMER1_GetInterval
	call HRC_OnCapture
	subi r17,lo8(-(1))
	rjmp .L18
.L32:
	ldi r16,lo8(1)
.L20:
	adiw r30,1
	cpi r30,3
	cpc r31,__zero_reg__
	brne .L21
	cpi r18,0
	cpc r19,r18
	breq .L22
	cpi r16,lo8(0)
	brne .+2
	rjmp .L23
.L27:
	ldi r20,0
	ldi r21,0
	ldi r22,lo8(56)
	ldi r23,lo8(-100)
	ldi r24,lo8(28)
	ldi r25,0
	call __udivmodsi4
	movw r24,r18
	sbiw r24,30
	cpi r24,-35
	sbci r25,0
	brlo .L22
	ldi r18,0
	ldi r19,0
.L22:
	sts HRC_CurrentBpm+1,r19
	sts HRC_CurrentBpm,r18
	ldi r20,0
	ldi r21,0
	movw r12,r20
	movw r14,r12
.L31:
	movw r30,r20
	subi r20,-1
	sbci r21,-1
	movw r26,r20
	lsl r26
	rol r27
	subi r26,lo8(-(HRC_Intervals))
	sbci r27,hi8(-(HRC_Intervals))
	ld r18,X+
	ld r19,X+
	sbiw r26,2
	cpi r18,0
	cpc r19,r18
	breq .L28
	lsl r30
	rol r31
	subi r30,lo8(-(HRC_Intervals))
	sbci r31,hi8(-(HRC_Intervals))
	ld r18,Z
	ldd r19,Z+1
	cpi r18,0
	cpc r19,r18
	breq .L28
	ld r18,X+
	ld r19,X+
	sbiw r26,2
	ld r24,Z
	ldd r25,Z+1
	cp r18,r24
	cpc r19,r25
	brsh .+2
	rjmp .L29
	ld r24,X+
	ld r25,X+
	ld r18,Z
	ldd r19,Z+1
.L57:
	sub r24,r18
	sbc r25,r19
	add r12,r24
	adc r13,r25
	adc r14,__zero_reg__
	adc r15,__zero_reg__
	cpi r20,7
	cpc r21,__zero_reg__
	brne .L31
	movw r22,r12
	movw r24,r14
	ldi r18,lo8(7)
	ldi r19,0
	ldi r20,0
	ldi r21,0
	call __udivmodsi4
	andi r21,7
	ori r21,8
	1:
	lsl r18
	rol r19
	rol r20
	rol r21
	brcc 1b
	movw r22,r18
	movw r24,r20
	cpi r24,-24
	ldi r18,3
	cpc r25,r18
	brsh .L36
	ldi r18,lo8(-24)
	ldi r19,lo8(3)
	ldi r20,0
	ldi r21,0
	call __udivmodsi4
.L28:
	sts HRC_CurrentHrvMs+1,r19
	sts HRC_CurrentHrvMs,r18
	rjmp .L13
.L23:
	ldd r20,Y+1
	ldd r21,Y+2
	ldd r24,Y+3
	ldd r25,Y+4
	cp r24,r20
	cpc r25,r21
	brlo .L25
	mov r19,r20
	mov r18,r21
	movw r20,r24
	mov r24,r19
	mov r25,r18
.L25:
	ldd r18,Y+5
	ldd r19,Y+6
	cp r20,r18
	cpc r21,r19
	brsh .L26
	movw r18,r20
.L26:
	cp r18,r24
	cpc r19,r25
	brlo .+2
	rjmp .L27
	movw r18,r24
	rjmp .L27
.L29:
	ld r24,Z
	ldd r25,Z+1
	ld r18,X+
	ld r19,X+
	rjmp .L57
.L36:
	ldi r18,lo8(-1)
	ldi r19,lo8(-1)
	rjmp .L28
	.size	HRC_Process, .-HRC_Process
	.section	.text.HRC_OnOverflow,"ax",@progbits
.global	HRC_OnOverflow
	.type	HRC_OnOverflow, @function
HRC_OnOverflow:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	call TIMER1_IsAsystole
	cpi r24,lo8(0)
	breq .L58
	ldi r24,lo8(1)
	sts HRC_Asystole,r24
	sts HRC_CurrentBpm+1,__zero_reg__
	sts HRC_CurrentBpm,__zero_reg__
.L58:
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
	rjmp .L68
	lds r25,HRC_Asystole
	ldi r24,lo8(1)
	cpse r25,__zero_reg__
	rjmp .L65
	ldi r24,0
	ret
.L68:
	ldi r24,lo8(1)
.L65:
/* epilogue start */
	ret
	.size	HRC_IsAsystole, .-HRC_IsAsystole
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
	.ident	"GCC: (GNU) 16.1.0"
.global __do_clear_bss
