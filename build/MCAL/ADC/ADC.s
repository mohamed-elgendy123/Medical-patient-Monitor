	.file	"ADC.c"
__SP_H__ = 0x3e
__SP_L__ = 0x3d
__SREG__ = 0x3f
__tmp_reg__ = 0
__zero_reg__ = 1
	.text
	.section	.text.ADC_Init,"ax",@progbits
.global	ADC_Init
	.type	ADC_Init, @function
ADC_Init:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	cpi r24,lo8(2)
	brlo .L2
	cpi r24,lo8(3)
	breq .L2
.L4:
	ldi r24,lo8(1)
	ldi r25,0
	ret
.L2:
	mov r25,r22
	subi r25,lo8(-(-1))
	cpi r25,lo8(7)
	brsh .L4
	swap r24
	lsl r24
	lsl r24
	andi r24,lo8(-64)
	out 0x7,r24
	ori r22,lo8(-128)
	out 0x6,r22
	ldi r24,0
	ldi r25,0
/* epilogue start */
	ret
	.size	ADC_Init, .-ADC_Init
	.section	.text.ADC_ReadChannel,"ax",@progbits
.global	ADC_ReadChannel
	.type	ADC_ReadChannel, @function
ADC_ReadChannel:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	cpi r24,lo8(8)
	brlo .L9
.L11:
	ldi r24,lo8(1)
	ldi r25,0
	ret
.L9:
	cpi r22,0
	cpc r23,r22
	breq .L11
	in r25,0x7
	andi r25,lo8(-32)
	or r25,r24
	out 0x7,r25
	sbi 0x6,6
.L12:
	sbis 0x6,4
	rjmp .L12
	sbi 0x6,4
	in r24,0x4
	in r18,0x5
	movw r30,r22
	st Z,r24
	std Z+1,r18
	ldi r24,0
	ldi r25,0
/* epilogue start */
	ret
	.size	ADC_ReadChannel, .-ADC_ReadChannel
	.section	.text.ADC_StartConversion,"ax",@progbits
.global	ADC_StartConversion
	.type	ADC_StartConversion, @function
ADC_StartConversion:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	cpi r24,lo8(8)
	brsh .L21
	in r25,0x7
	andi r25,lo8(-32)
	or r25,r24
	out 0x7,r25
	sbi 0x6,6
	ldi r24,0
	ldi r25,0
	ret
.L21:
	ldi r24,lo8(1)
	ldi r25,0
/* epilogue start */
	ret
	.size	ADC_StartConversion, .-ADC_StartConversion
	.section	.text.ADC_GetResult,"ax",@progbits
.global	ADC_GetResult
	.type	ADC_GetResult, @function
ADC_GetResult:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	sbiw r24,0
	brne .L23
.L25:
	ldi r24,lo8(1)
	ldi r25,0
	ret
.L23:
	sbis 0x6,4
	rjmp .L25
	sbi 0x6,4
	in r18,0x4
	in r20,0x5
	movw r30,r24
	st Z,r18
	std Z+1,r20
	ldi r24,0
	ldi r25,0
/* epilogue start */
	ret
	.size	ADC_GetResult, .-ADC_GetResult
	.section	.text.ADC_SetInterrupt,"ax",@progbits
.global	ADC_SetInterrupt
	.type	ADC_SetInterrupt, @function
ADC_SetInterrupt:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	cpi r24,lo8(1)
	brne .L30
	sbi 0x6,3
.L31:
	ldi r24,0
	ldi r25,0
	ret
.L30:
	brsh .L33
	cbi 0x6,3
	rjmp .L31
.L33:
	ldi r24,lo8(1)
	ldi r25,0
/* epilogue start */
	ret
	.size	ADC_SetInterrupt, .-ADC_SetInterrupt
	.ident	"GCC: (GNU) 16.1.0"
