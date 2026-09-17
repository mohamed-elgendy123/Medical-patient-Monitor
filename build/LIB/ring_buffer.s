	.file	"ring_buffer.c"
__SP_H__ = 0x3e
__SP_L__ = 0x3d
__SREG__ = 0x3f
__tmp_reg__ = 0
__zero_reg__ = 1
	.text
	.section	.text.RingBuffer_Init,"ax",@progbits
.global	RingBuffer_Init
	.type	RingBuffer_Init, @function
RingBuffer_Init:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	movw r30,r24
	or r24,r25
	breq .L1
	cp r22,__zero_reg__
	cpc r23,__zero_reg__
	breq .L1
	std Z+1,r23
	st Z,r22
	std Z+7,r21
	std Z+6,r20
	std Z+3,__zero_reg__
	std Z+2,__zero_reg__
	std Z+5,__zero_reg__
	std Z+4,__zero_reg__
	std Z+9,__zero_reg__
	std Z+8,__zero_reg__
.L1:
/* epilogue start */
	ret
	.size	RingBuffer_Init, .-RingBuffer_Init
	.section	.text.RingBuffer_IsFull,"ax",@progbits
.global	RingBuffer_IsFull
	.type	RingBuffer_IsFull, @function
RingBuffer_IsFull:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	movw r30,r24
	or r24,r25
	breq .L12
	ldi r24,lo8(1)
	ldd r20,Z+8
	ldd r21,Z+9
	ldd r18,Z+6
	ldd r19,Z+7
	cp r20,r18
	cpc r21,r19
	breq .L9
.L12:
	ldi r24,0
.L9:
/* epilogue start */
	ret
	.size	RingBuffer_IsFull, .-RingBuffer_IsFull
	.section	.text.RingBuffer_Push,"ax",@progbits
.global	RingBuffer_Push
	.type	RingBuffer_Push, @function
RingBuffer_Push:
	push r16
	push r17
	push r28
	push r29
/* prologue: function */
/* frame size = 0 */
/* stack size = 4 */
.L__stack_usage = 4
	sbiw r24,0
	breq .L16
	movw r16,r22
	movw r28,r24
	call RingBuffer_IsFull
	cpse r24,__zero_reg__
	rjmp .L16
	ldd r24,Y+2
	ldd r25,Y+3
	lsl r24
	rol r25
	ld r30,Y
	ldd r31,Y+1
	add r30,r24
	adc r31,r25
	std Z+1,r17
	st Z,r16
	ldd r24,Y+2
	ldd r25,Y+3
	adiw r24,1
	ldd r22,Y+6
	ldd r23,Y+7
	call __udivmodhi4
	std Y+3,r25
	std Y+2,r24
	ldd r24,Y+8
	ldd r25,Y+9
	adiw r24,1
	std Y+9,r25
	std Y+8,r24
	ldi r24,lo8(1)
.L13:
/* epilogue start */
	pop r29
	pop r28
	pop r17
	pop r16
	ret
.L16:
	ldi r24,0
	rjmp .L13
	.size	RingBuffer_Push, .-RingBuffer_Push
	.section	.text.RingBuffer_IsEmpty,"ax",@progbits
.global	RingBuffer_IsEmpty
	.type	RingBuffer_IsEmpty, @function
RingBuffer_IsEmpty:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	movw r30,r24
	ldi r24,lo8(1)
	sbiw r30,0
	breq .L17
	ldd r18,Z+8
	ldd r19,Z+9
	or r18,r19
	breq .L17
	ldi r24,0
	ret
.L17:
/* epilogue start */
	ret
	.size	RingBuffer_IsEmpty, .-RingBuffer_IsEmpty
	.section	.text.RingBuffer_Pop,"ax",@progbits
.global	RingBuffer_Pop
	.type	RingBuffer_Pop, @function
RingBuffer_Pop:
	push r16
	push r17
	push r28
	push r29
/* prologue: function */
/* frame size = 0 */
/* stack size = 4 */
.L__stack_usage = 4
	sbiw r24,0
	breq .L28
	cp r22,__zero_reg__
	cpc r23,__zero_reg__
	breq .L28
	movw r16,r22
	movw r28,r24
	call RingBuffer_IsEmpty
	cpse r24,__zero_reg__
	rjmp .L28
	ldd r24,Y+4
	ldd r25,Y+5
	lsl r24
	rol r25
	ld r30,Y
	ldd r31,Y+1
	add r30,r24
	adc r31,r25
	ld r24,Z
	ldd r25,Z+1
	movw r30,r16
	std Z+1,r25
	st Z,r24
	ldd r24,Y+4
	ldd r25,Y+5
	adiw r24,1
	ldd r22,Y+6
	ldd r23,Y+7
	call __udivmodhi4
	std Y+5,r25
	std Y+4,r24
	ldd r24,Y+8
	ldd r25,Y+9
	sbiw r24,1
	std Y+9,r25
	std Y+8,r24
	ldi r24,lo8(1)
.L24:
/* epilogue start */
	pop r29
	pop r28
	pop r17
	pop r16
	ret
.L28:
	ldi r24,0
	rjmp .L24
	.size	RingBuffer_Pop, .-RingBuffer_Pop
	.ident	"GCC: (GNU) 7.3.0"
