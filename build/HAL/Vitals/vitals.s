	.file	"vitals.c"
__SP_H__ = 0x3e
__SP_L__ = 0x3d
__SREG__ = 0x3f
__tmp_reg__ = 0
__zero_reg__ = 1
	.text
	.section	.text.Vitals_Init,"ax",@progbits
.global	Vitals_Init
	.type	Vitals_Init, @function
Vitals_Init:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	in r24,0x1a
	andi r24,lo8(-16)
	out 0x1a,r24
	in r24,0x1b
	andi r24,lo8(-16)
	out 0x1b,r24
	in r24,0x11
	andi r24,lo8(-41)
	out 0x11,r24
	in r24,0x12
	ori r24,lo8(40)
	out 0x12,r24
	ldi r22,lo8(6)
	ldi r24,lo8(1)
	jmp ADC_Init
	.size	Vitals_Init, .-Vitals_Init
	.section	.text.Vitals_Read,"ax",@progbits
.global	Vitals_Read
	.type	Vitals_Read, @function
Vitals_Read:
	push r11
	push r12
	push r13
	push r14
	push r15
	push r16
	push r17
	push r28
	push r29
	rcall .
	in r28,__SP_L__
	in r29,__SP_H__
/* prologue: function */
/* frame size = 2 */
/* stack size = 11 */
.L__stack_usage = 11
	movw r16,r24
	std Y+1,__zero_reg__
	std Y+2,__zero_reg__
	ldi r24,lo8(1)
	mov r14,r24
	mov r15,__zero_reg__
	cpi r16,0
	cpc r17,r16
	brne .+2
	rjmp .L2
	in r25,0x10
	in r15,0x10
	bst r15,5
	clr r15
	bld r15,5
	movw r30,r16
	ldd r24,Z+11
	sbrc r25,3
	rjmp .L4
	ori r24,lo8(1<<0)
	std Z+11,r24
	ldi r24,0
	ldi r25,0
.L5:
	movw r30,r16
	st Z,r24
	std Z+1,r25
	ldi r24,lo8(1)
	ldi r25,lo8(1)
	sbrc r15,5
	eor r24,r25
	mov r15,r24
	ldd r24,Z+11
	bst r15,0
	bld r24,1
	std Z+11,r24
	movw r12,r28
	ldi r24,-1
	sub r12,r24
	sbc r13,r24
	movw r22,r12
	ldi r24,0
	call ADC_ReadChannel
	movw r14,r24
	mov r11,r12
	or r24,r25
	brne .L6
	movw r30,r16
	ldd r24,Z+11
	sbrs r24,1
	rjmp .L7
	std Z+4,__zero_reg__
.L6:
	ldi r20,lo8(1)
	mov r14,r20
	mov r15,__zero_reg__
.L8:
	movw r30,r16
	std Z+16,r14
	std Z+17,r15
	mov r22,r11
	mov r23,r13
	ldi r24,lo8(1)
	call ADC_ReadChannel
	movw r14,r24
	or r24,r25
	breq .+2
	rjmp .L13
	ldd r18,Y+1
	ldd r19,Y+2
	ldi r26,lo8(-106)
	ldi r27,0
	call __umulhisi3
	ldi r18,lo8(-1)
	ldi r19,lo8(3)
	ldi r20,0
	ldi r21,0
	call __udivmodsi4
	subi r18,-44
	sbci r19,-2
	movw r30,r16
	std Z+5,r18
	std Z+6,r19
.L9:
	movw r30,r16
	std Z+18,r14
	std Z+19,r15
	mov r22,r11
	mov r23,r13
	ldi r24,lo8(2)
	call ADC_ReadChannel
	movw r14,r24
	or r24,r25
	breq .+2
	rjmp .L14
	ldd r18,Y+1
	ldd r19,Y+2
	ldi r26,lo8(-56)
	ldi r27,0
	call __umulhisi3
	ldi r18,lo8(-1)
	ldi r19,lo8(3)
	ldi r20,0
	ldi r21,0
	call __udivmodsi4
	subi r18,lo8(-(50))
	movw r30,r16
	std Z+7,r18
	mov r24,r18
	ldi r25,0
	lsl r24
	rol r25
	ldi r22,lo8(3)
	ldi r23,0
	call __udivmodhi4
	std Z+8,r22
.L10:
	movw r30,r16
	std Z+20,r14
	std Z+21,r15
	mov r22,r11
	mov r23,r13
	ldi r24,lo8(3)
	call ADC_ReadChannel
	movw r14,r24
	or r24,r25
	brne .L11
	ldd r18,Y+1
	ldd r19,Y+2
	ldi r26,lo8(60)
	ldi r27,0
	call __umulhisi3
	ldi r18,lo8(-1)
	ldi r19,lo8(3)
	ldi r20,0
	ldi r21,0
	call __udivmodsi4
	movw r30,r16
	std Z+9,r18
	std Z+22,__zero_reg__
	std Z+23,__zero_reg__
.L2:
	movw r24,r14
/* epilogue start */
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
	pop r11
	ret
.L4:
	andi r24,lo8(~(1<<0))
	std Z+11,r24
	call HRC_GetBpm
	rjmp .L5
.L7:
	ldd r18,Y+1
	ldd r19,Y+2
	ldi r26,lo8(30)
	ldi r27,0
	call __umulhisi3
	ldi r18,lo8(-1)
	ldi r19,lo8(3)
	ldi r20,0
	ldi r21,0
	call __udivmodsi4
	subi r18,lo8(-(70))
	movw r30,r16
	std Z+4,r18
	rjmp .L8
.L13:
	ldi r19,lo8(1)
	mov r14,r19
	mov r15,__zero_reg__
	rjmp .L9
.L14:
	ldi r25,lo8(1)
	mov r14,r25
	mov r15,__zero_reg__
	rjmp .L10
.L11:
	ldi r24,lo8(1)
	movw r30,r16
	std Z+22,r24
	std Z+23,__zero_reg__
	mov r14,__zero_reg__
	mov r15,__zero_reg__
	rjmp .L2
	.size	Vitals_Read, .-Vitals_Read
	.ident	"GCC: (GNU) 16.1.0"
