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
	ldi r22,lo8(6)
	ldi r24,lo8(1)
	jmp ADC_Init
	.size	Vitals_Init, .-Vitals_Init
	.section	.text.Vitals_Read,"ax",@progbits
.global	Vitals_Read
	.type	Vitals_Read, @function
Vitals_Read:
	push r14
	push r15
	push r16
	push r17
	push r28
	push r29
	rcall .
	push __tmp_reg__
	in r28,__SP_L__
	in r29,__SP_H__
/* prologue: function */
/* frame size = 3 */
/* stack size = 9 */
.L__stack_usage = 9
	movw r16,r24
	ldi r24,lo8(1)
	ldi r25,0
	cp r16,__zero_reg__
	cpc r17,__zero_reg__
	brne .+2
	rjmp .L2
	std Y+1,__zero_reg__
	std Y+2,__zero_reg__
	movw r14,r28
	ldi r24,-1
	sub r14,r24
	sbc r15,r24
	movw r22,r14
	ldi r24,0
	call ADC_ReadChannel
	std Y+3,r14
	or r24,r25
	brne .L4
	ldd r18,Y+1
	ldd r19,Y+2
	cp r18,__zero_reg__
	cpc r19,__zero_reg__
	breq .L5
	cpi r18,-1
	ldi r30,3
	cpc r19,r30
	breq .+2
	rjmp .L6
.L5:
	ldi r24,lo8(1)
	movw r30,r16
	std Z+9,r24
	std Z+10,__zero_reg__
.L4:
	ldd r22,Y+3
	mov r23,r15
	ldi r24,lo8(1)
	call ADC_ReadChannel
	or r24,r25
	brne .L7
	ldd r18,Y+1
	ldd r19,Y+2
	cp r18,__zero_reg__
	cpc r19,__zero_reg__
	breq .L8
	cpi r18,-1
	ldi r31,3
	cpc r19,r31
	brne .L9
.L8:
	ldi r24,lo8(1)
	movw r30,r16
	std Z+11,r24
	std Z+12,__zero_reg__
.L7:
	ldd r22,Y+3
	mov r23,r15
	ldi r24,lo8(2)
	call ADC_ReadChannel
	or r24,r25
	brne .L10
	ldd r18,Y+1
	ldd r19,Y+2
	cp r18,__zero_reg__
	cpc r19,__zero_reg__
	breq .L11
	cpi r18,-1
	ldi r31,3
	cpc r19,r31
	brne .L12
.L11:
	ldi r24,lo8(1)
	movw r30,r16
	std Z+13,r24
	std Z+14,__zero_reg__
.L10:
	ldd r22,Y+3
	mov r23,r15
	ldi r24,lo8(3)
	call ADC_ReadChannel
	or r24,r25
	brne .+2
	rjmp .L13
.L16:
	ldi r24,0
	ldi r25,0
.L2:
/* epilogue start */
	pop __tmp_reg__
	pop __tmp_reg__
	pop __tmp_reg__
	pop r29
	pop r28
	pop r17
	pop r16
	pop r15
	pop r14
	ret
.L6:
	movw r30,r16
	std Z+9,__zero_reg__
	std Z+10,__zero_reg__
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
	std Z+1,r18
	rjmp .L4
.L9:
	movw r30,r16
	std Z+11,__zero_reg__
	std Z+12,__zero_reg__
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
	std Z+2,r18
	std Z+3,r19
	rjmp .L7
.L12:
	movw r30,r16
	std Z+13,__zero_reg__
	std Z+14,__zero_reg__
	ldi r26,lo8(-56)
	ldi r27,0
	call __umulhisi3
	ldi r18,lo8(-1)
	ldi r19,lo8(3)
	ldi r20,0
	ldi r21,0
	call __udivmodsi4
	movw r24,r18
	adiw r24,50
	movw r30,r16
	std Z+4,r24
	std Z+5,r25
	lsl r24
	rol r25
	ldi r22,lo8(3)
	ldi r23,0
	call __udivmodhi4
	std Z+6,r22
	std Z+7,r23
	rjmp .L10
.L13:
	ldd r18,Y+1
	ldd r19,Y+2
	cp r18,__zero_reg__
	cpc r19,__zero_reg__
	breq .L14
	cpi r18,-1
	ldi r31,3
	cpc r19,r31
	brne .L15
.L14:
	ldi r24,lo8(1)
	movw r30,r16
	std Z+15,r24
	std Z+16,__zero_reg__
	rjmp .L16
.L15:
	movw r30,r16
	std Z+15,__zero_reg__
	std Z+16,__zero_reg__
	ldi r26,lo8(60)
	ldi r27,0
	call __umulhisi3
	ldi r18,lo8(-1)
	ldi r19,lo8(3)
	ldi r20,0
	ldi r21,0
	call __udivmodsi4
	movw r30,r16
	std Z+8,r18
	rjmp .L16
	.size	Vitals_Read, .-Vitals_Read
	.ident	"GCC: (GNU) 15.2.0"
