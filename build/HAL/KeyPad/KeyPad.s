	.file	"KeyPad.c"
__SP_H__ = 0x3e
__SP_L__ = 0x3d
__SREG__ = 0x3f
__tmp_reg__ = 0
__zero_reg__ = 1
	.text
	.section	.text.KeyPad_Init,"ax",@progbits
.global	KeyPad_Init
	.type	KeyPad_Init, @function
KeyPad_Init:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	cpi r24,lo8(4)
	brsh .L3
	ldi r22,lo8(-16)
	call GPIO_SetPortDirection
	ldi r24,0
	ldi r25,0
	ret
.L3:
	ldi r24,lo8(1)
	ldi r25,0
/* epilogue start */
	ret
	.size	KeyPad_Init, .-KeyPad_Init
	.section	.text.KeyPad_GetPressedKey,"ax",@progbits
.global	KeyPad_GetPressedKey
	.type	KeyPad_GetPressedKey, @function
KeyPad_GetPressedKey:
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
	in r28,__SP_L__
	in r29,__SP_H__
/* prologue: function */
/* frame size = 4 */
/* stack size = 12 */
.L__stack_usage = 12
	std Y+2,r24
	movw r14,r22
	cpi r24,lo8(4)
	brlo .+2
	rjmp .L11
	or r22,r23
	brne .+2
	rjmp .L11
	ldi r22,lo8(-16)
	call GPIO_SetPortDirection
	movw r12,r28
	ldi r24,-1
	sub r12,r24
	sbc r13,r24
	movw r22,r12
	ldd r24,Y+2
	call GPIO_GetPortValue
	ldi r16,lo8(4)
	ldi r17,0
	std Y+3,r12
	std Y+4,r13
.L8:
	ldi r22,lo8(1)
	mov r0,r16
	rjmp 2f
	1:
	lsl r22
	2:
	dec r0
	brpl 1b
	com r22
	ldd r24,Y+2
	call GPIO_SetPortValue
	mov r12,__zero_reg__
	mov r13,__zero_reg__
.L7:
	ldd r22,Y+3
	ldd r23,Y+4
	ldd r24,Y+2
	call GPIO_GetPortValue
	ldd r24,Y+1
	ldi r25,0
	mov r0,r12
	rjmp 2f
	1:
	asr r25
	ror r24
	2:
	dec r0
	brpl 1b
	sbrc r24,0
	rjmp .L6
	subi r16,lo8(-(-4))
	lsl r16
	lsl r16
	add r16,r12
.L9:
	movw r30,r14
	st Z,r16
	ldi r24,0
	ldi r25,0
.L4:
/* epilogue start */
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
.L6:
	ldi r31,-1
	sub r12,r31
	sbc r13,r31
	ldi r24,4
	cp r12,r24
	cpc r13,__zero_reg__
	brne .L7
	subi r16,-1
	sbci r17,-1
	cpi r16,8
	cpc r17,__zero_reg__
	brne .L8
	ldi r16,lo8(-1)
	rjmp .L9
.L11:
	ldi r24,lo8(1)
	ldi r25,0
	rjmp .L4
	.size	KeyPad_GetPressedKey, .-KeyPad_GetPressedKey
	.ident	"GCC: (GNU) 15.2.0"
