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
 ;  34 "MCAL/INTERRUPT/INTERRUPT.c" 1
	sei ; [[len=1]]
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
 ;  39 "MCAL/INTERRUPT/INTERRUPT.c" 1
	cli ; [[len=1]]
 ;  0 "" 2
/* #NOAPP */
	ldi r24,0
	ldi r25,0
/* epilogue start */
	ret
	.size	INTERRUPT_DisableGlobal, .-INTERRUPT_DisableGlobal
	.section	.text.EXTI_ClearFlag,"ax",@progbits
.global	EXTI_ClearFlag
	.type	EXTI_ClearFlag, @function
EXTI_ClearFlag:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	cpi r24,lo8(3)
	brsh .L8
	cpi r24,lo8(1)
	breq .L5
	cpi r24,lo8(2)
	breq .L6
	ldi r24,lo8(64)
.L9:
	out 0x3a,r24
	ldi r24,0
	ldi r25,0
	ret
.L5:
	ldi r24,lo8(-128)
	rjmp .L9
.L6:
	ldi r24,lo8(32)
	rjmp .L9
.L8:
	ldi r24,lo8(1)
	ldi r25,0
/* epilogue start */
	ret
	.size	EXTI_ClearFlag, .-EXTI_ClearFlag
	.section	.text.EXTI_SetSense,"ax",@progbits
.global	EXTI_SetSense
	.type	EXTI_SetSense, @function
EXTI_SetSense:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	cpi r24,lo8(3)
	brlo .L11
.L13:
	ldi r24,lo8(1)
	ldi r25,0
	ret
.L11:
	cpi r22,lo8(4)
	brsh .L13
	cpi r24,lo8(1)
	breq .L14
	cpi r24,lo8(2)
	breq .L15
	in r25,0x35
	andi r25,lo8(-4)
	or r25,r22
	out 0x35,r25
.L16:
	call EXTI_ClearFlag
	ldi r24,0
	ldi r25,0
/* epilogue start */
	ret
.L14:
	in r25,0x35
	andi r25,lo8(-13)
	lsl r22
	lsl r22
	or r22,r25
	out 0x35,r22
	rjmp .L16
.L15:
	cpi r22,lo8(2)
	brne .L17
	in r25,0x34
	andi r25,lo8(-65)
.L18:
	out 0x34,r25
	rjmp .L16
.L17:
	cpi r22,lo8(3)
	brne .L13
	in r25,0x34
	ori r25,lo8(64)
	rjmp .L18
	.size	EXTI_SetSense, .-EXTI_SetSense
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
	ldi r24,lo8(1)
	ldi r25,0
	cpi r28,lo8(3)
	brsh .L19
	mov r24,r28
	call EXTI_ClearFlag
	in r24,0x3b
	cpi r28,lo8(1)
	breq .L21
	cpi r28,lo8(2)
	breq .L22
	ori r24,lo8(64)
.L25:
	out 0x3b,r24
	ldi r24,0
	ldi r25,0
.L19:
/* epilogue start */
	pop r28
	ret
.L21:
	ori r24,lo8(-128)
	rjmp .L25
.L22:
	ori r24,lo8(32)
	rjmp .L25
	.size	EXTI_Enable, .-EXTI_Enable
	.section	.text.EXTI_Disable,"ax",@progbits
.global	EXTI_Disable
	.type	EXTI_Disable, @function
EXTI_Disable:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	cpi r24,lo8(3)
	brsh .L31
	cpi r24,lo8(1)
	breq .L28
	cpi r24,lo8(2)
	breq .L29
	in r24,0x3b
	andi r24,lo8(-65)
.L32:
	out 0x3b,r24
	ldi r24,0
	ldi r25,0
	ret
.L28:
	in r24,0x3b
	andi r24,lo8(127)
	rjmp .L32
.L29:
	in r24,0x3b
	andi r24,lo8(-33)
	rjmp .L32
.L31:
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
	cpi r24,lo8(3)
	brlo .L34
.L36:
	ldi r24,lo8(1)
	ldi r25,0
	ret
.L34:
	cpi r22,0
	cpc r23,r22
	breq .L36
	mov r30,r24
	ldi r31,0
	lsl r30
	rol r31
	subi r30,lo8(-(callback))
	sbci r31,hi8(-(callback))
	std Z+1,r23
	st Z,r22
	ldi r24,0
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
	lds r24,callback
	lds r25,callback+1
	or r24,r25
	breq .L41
	lds r30,callback
	lds r31,callback+1
	icall
.L41:
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
	lds r24,callback+2
	lds r25,callback+2+1
	or r24,r25
	breq .L47
	lds r30,callback+2
	lds r31,callback+2+1
	icall
.L47:
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
	lds r24,callback+4
	lds r25,callback+4+1
	or r24,r25
	breq .L53
	lds r30,callback+4
	lds r31,callback+4+1
	icall
.L53:
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
	.section	.bss.callback,"aw",@nobits
	.type	callback, @object
	.size	callback, 6
callback:
	.zero	6
	.ident	"GCC: (GNU) 16.1.0"
.global __do_clear_bss
