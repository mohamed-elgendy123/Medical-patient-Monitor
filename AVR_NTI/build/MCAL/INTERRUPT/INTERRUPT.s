	.file	"INTERRUPT.c"
__SP_H__ = 0x3e
__SP_L__ = 0x3d
__SREG__ = 0x3f
__tmp_reg__ = 0
__zero_reg__ = 1
	.text
	.section	.text.INTERRUPT_EnableGlobal,"ax",@progbits
.global	INTERRUPT_EnableGlobal
	.type	INTERRUPT_EnableGlobal, @function
INTERRUPT_EnableGlobal:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
/* #APP */
 ;  23 "MCAL/INTERRUPT/INTERRUPT.c" 1
	sei
 ;  0 "" 2
/* #NOAPP */
	ldi r24,0
	ldi r25,0
/* epilogue start */
	ret
	.size	INTERRUPT_EnableGlobal, .-INTERRUPT_EnableGlobal
	.section	.text.INTERRUPT_DisableGlobal,"ax",@progbits
.global	INTERRUPT_DisableGlobal
	.type	INTERRUPT_DisableGlobal, @function
INTERRUPT_DisableGlobal:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
/* #APP */
 ;  29 "MCAL/INTERRUPT/INTERRUPT.c" 1
	cli
 ;  0 "" 2
/* #NOAPP */
	ldi r24,0
	ldi r25,0
/* epilogue start */
	ret
	.size	INTERRUPT_DisableGlobal, .-INTERRUPT_DisableGlobal
	.section	.text.EXTI_SetSense,"ax",@progbits
.global	EXTI_SetSense
	.type	EXTI_SetSense, @function
EXTI_SetSense:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	cpi r24,lo8(1)
	breq .L4
	cpi r24,lo8(2)
	breq .L5
	cpse r24,__zero_reg__
	rjmp .L12
	cpi r22,lo8(4)
	brsh .L12
	in r24,0x35
	andi r24,lo8(-4)
	out 0x35,r24
	in r24,0x35
	or r24,r22
	out 0x35,r24
.L7:
	ldi r24,0
	ldi r25,0
	ret
.L4:
	cpi r22,lo8(4)
	brsh .L12
	in r24,0x35
	andi r24,lo8(-13)
	out 0x35,r24
	in r24,0x35
	lsl r22
	lsl r22
	or r22,r24
	out 0x35,r22
	rjmp .L7
.L5:
	cpi r22,lo8(2)
	brne .L8
	in r24,0x34
	andi r24,lo8(-65)
.L13:
	out 0x34,r24
	rjmp .L7
.L8:
	cpi r22,lo8(3)
	brne .L12
	in r24,0x34
	ori r24,lo8(64)
	rjmp .L13
.L12:
	ldi r24,lo8(1)
	ldi r25,0
/* epilogue start */
	ret
	.size	EXTI_SetSense, .-EXTI_SetSense
	.section	.text.EXTI_ClearFlag,"ax",@progbits
.global	EXTI_ClearFlag
	.type	EXTI_ClearFlag, @function
EXTI_ClearFlag:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	cpi r24,lo8(1)
	breq .L15
	cpi r24,lo8(2)
	breq .L16
	cpse r24,__zero_reg__
	rjmp .L19
	ldi r24,lo8(64)
.L20:
	out 0x3a,r24
	ldi r24,0
	ldi r25,0
	ret
.L15:
	ldi r24,lo8(-128)
	rjmp .L20
.L16:
	ldi r24,lo8(32)
	rjmp .L20
.L19:
	ldi r24,lo8(1)
	ldi r25,0
/* epilogue start */
	ret
	.size	EXTI_ClearFlag, .-EXTI_ClearFlag
	.section	.text.EXTI_Enable,"ax",@progbits
.global	EXTI_Enable
	.type	EXTI_Enable, @function
EXTI_Enable:
	push r28
/* prologue: function */
/* frame size = 0 */
/* stack size = 1 */
.L__stack_usage = 1
	mov r28,r24
	call EXTI_ClearFlag
	sbiw r24,0
	brne .L21
	cpi r28,lo8(1)
	breq .L23
	cpi r28,lo8(2)
	breq .L24
	cpse r28,__zero_reg__
	rjmp .L26
	in r18,0x3b
	ori r18,lo8(64)
.L27:
	out 0x3b,r18
.L21:
/* epilogue start */
	pop r28
	ret
.L23:
	in r18,0x3b
	ori r18,lo8(-128)
	rjmp .L27
.L24:
	in r18,0x3b
	ori r18,lo8(32)
	rjmp .L27
.L26:
	ldi r24,lo8(1)
	ldi r25,0
	rjmp .L21
	.size	EXTI_Enable, .-EXTI_Enable
	.section	.text.EXTI_Disable,"ax",@progbits
.global	EXTI_Disable
	.type	EXTI_Disable, @function
EXTI_Disable:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	cpi r24,lo8(1)
	breq .L29
	cpi r24,lo8(2)
	breq .L30
	cpse r24,__zero_reg__
	rjmp .L33
	in r24,0x3b
	andi r24,lo8(-65)
.L34:
	out 0x3b,r24
	ldi r24,0
	ldi r25,0
	ret
.L29:
	in r24,0x3b
	andi r24,lo8(127)
	rjmp .L34
.L30:
	in r24,0x3b
	andi r24,lo8(-33)
	rjmp .L34
.L33:
	ldi r24,lo8(1)
	ldi r25,0
/* epilogue start */
	ret
	.size	EXTI_Disable, .-EXTI_Disable
	.section	.text.EXTI_SetCallback,"ax",@progbits
.global	EXTI_SetCallback
	.type	EXTI_SetCallback, @function
EXTI_SetCallback:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	cp r22,__zero_reg__
	cpc r23,__zero_reg__
	breq .L38
	cpi r24,lo8(3)
	brsh .L38
	mov r30,r24
	ldi r31,0
	lsl r30
	rol r31
	subi r30,lo8(-(EXTI_pfCallBackArr))
	sbci r31,hi8(-(EXTI_pfCallBackArr))
	st Z,r22
	std Z+1,r23
	ldi r24,0
	ldi r25,0
	ret
.L38:
	ldi r24,lo8(1)
	ldi r25,0
/* epilogue start */
	ret
	.size	EXTI_SetCallback, .-EXTI_SetCallback
	.section	.text.__vector_1,"ax",@progbits
.global	__vector_1
	.type	__vector_1, @function
__vector_1:
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
	lds r30,EXTI_pfCallBackArr
	lds r31,EXTI_pfCallBackArr+1
	sbiw r30,0
	breq .L39
	icall
.L39:
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
	.size	__vector_1, .-__vector_1
	.section	.text.__vector_2,"ax",@progbits
.global	__vector_2
	.type	__vector_2, @function
__vector_2:
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
	lds r30,EXTI_pfCallBackArr+2
	lds r31,EXTI_pfCallBackArr+3
	sbiw r30,0
	breq .L44
	icall
.L44:
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
	.size	__vector_2, .-__vector_2
	.section	.text.__vector_3,"ax",@progbits
.global	__vector_3
	.type	__vector_3, @function
__vector_3:
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
	lds r30,EXTI_pfCallBackArr+4
	lds r31,EXTI_pfCallBackArr+5
	sbiw r30,0
	breq .L49
	icall
.L49:
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
	.size	__vector_3, .-__vector_3
	.section	.bss.EXTI_pfCallBackArr,"aw",@nobits
	.type	EXTI_pfCallBackArr, @object
	.size	EXTI_pfCallBackArr, 6
EXTI_pfCallBackArr:
	.zero	6
	.ident	"GCC: (GNU) 15.2.0"
.global __do_clear_bss
