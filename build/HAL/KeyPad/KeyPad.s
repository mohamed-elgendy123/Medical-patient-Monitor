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
	ldi r25,0
	ldi r24,0
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
	push r7
	push r8
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
	push __zero_reg__
	in r28,__SP_L__
	in r29,__SP_H__
/* prologue: function */
/* frame size = 1 */
/* stack size = 14 */
.L__stack_usage = 14
	cpi r24,lo8(4)
	brlo .+2
	rjmp .L10
	cp r22,__zero_reg__
	cpc r23,__zero_reg__
	brne .+2
	rjmp .L10
	movw r14,r22
	mov r17,r24
	ldi r22,lo8(-16)
	call GPIO_SetPortDirection
	movw r22,r28
	subi r22,-1
	sbci r23,-1
	mov r24,r17
	call GPIO_GetPortValue
	ldi r24,lo8(4)
	mov r12,r24
	mov r13,__zero_reg__
	clr r8
	inc r8
	mov r9,__zero_reg__
.L8:
	ldi r16,lo8(-4)
	add r16,r12
	movw r22,r8
	mov r0,r12
	rjmp 2f
	1:
	lsl r22
	2:
	dec r0
	brpl 1b
	com r22
	mov r24,r17
	call GPIO_SetPortValue
	mov r11,__zero_reg__
	mov r10,__zero_reg__
.L7:
	movw r22,r28
	subi r22,-1
	sbci r23,-1
	mov r24,r17
	call GPIO_GetPortValue
	ldd r24,Y+1
	ldi r25,0
	mov r0,r10
	rjmp 2f
	1:
	asr r25
	ror r24
	2:
	dec r0
	brpl 1b
	sbrc r24,0
	rjmp .L6
	lsl r16
	lsl r16
	add r16,r10
	movw r30,r14
	st Z,r16
.L13:
	ldi r25,0
	ldi r24,0
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
	pop r8
	pop r7
	ret
.L6:
	ldi r31,-1
	sub r10,r31
	sbc r11,r31
	ldi r24,4
	cp r10,r24
	cpc r11,__zero_reg__
	brne .L7
	ldi r30,-1
	sub r12,r30
	sbc r13,r30
	ldi r31,8
	cp r12,r31
	cpc r13,__zero_reg__
	breq .+2
	rjmp .L8
	ldi r24,lo8(-1)
	movw r30,r14
	st Z,r24
	rjmp .L13
.L10:
	ldi r24,lo8(1)
	ldi r25,0
	rjmp .L4
	.size	KeyPad_GetPressedKey, .-KeyPad_GetPressedKey
	.ident	"GCC: (GNU) 7.3.0"
