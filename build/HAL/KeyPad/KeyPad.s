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
	push r9
	push r10
	push r11
	push r12
	push r13
	push r14
	push r15
	push r16
	push r17
	push r28
	push r29
	push __tmp_reg__
	in r28,__SP_L__
	in r29,__SP_H__
/* prologue: function */
/* frame size = 1 */
/* stack size = 12 */
.L__stack_usage = 12
	mov r11,r24
	movw r14,r22
	cpi r24,lo8(4)
	brlo .L5
.L7:
	ldi r24,lo8(1)
	ldi r25,0
.L4:
/* epilogue start */
	pop __tmp_reg__
	pop r29
	pop r28
	pop r17
	pop r16
	pop r15
	pop r14
	pop r13
	pop r12
	pop r11
	pop r10
	pop r9
	ret
.L5:
	or r22,r23
	breq .L7
	ldi r22,lo8(-16)
	call GPIO_SetPortDirection
	movw r12,r28
	ldi r24,-1
	sub r12,r24
	sbc r13,r24
	movw r22,r12
	mov r24,r11
	call GPIO_GetPortValue
	ldi r16,lo8(4)
	ldi r17,0
	mov r10,r12
	mov r9,r13
.L11:
	ldi r22,lo8(1)
	mov r0,r16
	rjmp 2f
	1:
	lsl r22
	2:
	dec r0
	brpl 1b
	com r22
	mov r24,r11
	call GPIO_SetPortValue
	mov r12,__zero_reg__
	mov r13,__zero_reg__
.L10:
	mov r22,r10
	mov r23,r9
	mov r24,r11
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
	rjmp .L8
	subi r16,lo8(-(-4))
	lsl r16
	lsl r16
	add r16,r12
	movw r30,r14
	st Z,r16
.L9:
	ldi r24,0
	ldi r25,0
	rjmp .L4
.L8:
	ldi r24,-1
	sub r12,r24
	sbc r13,r24
	ldi r24,4
	cp r12,r24
	cpc r13,__zero_reg__
	brne .L10
	subi r16,-1
	sbci r17,-1
	cpi r16,8
	cpc r17,__zero_reg__
	brne .L11
	ldi r24,lo8(-1)
	movw r30,r14
	st Z,r24
	rjmp .L9
	.size	KeyPad_GetPressedKey, .-KeyPad_GetPressedKey
	.ident	"GCC: (GNU) 16.1.0"
