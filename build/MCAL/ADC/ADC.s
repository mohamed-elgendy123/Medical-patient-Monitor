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
	cpi r24,lo8(1)
	breq .L2
.L4:
	ldi r24,lo8(1)
	ldi r25,0
	ret
.L2:
	cpi r22,lo8(6)
	brne .L4
	ldi r24,lo8(64)
	out 0x7,r24
	ldi r24,lo8(-122)
	out 0x6,r24
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
	brsh .L6
	cpi r22,0
	cpc r23,r22
	brne .L7
.L6:
	ldi r24,lo8(1)
	ldi r25,0
	ret
.L7:
	in r25,0x7
	andi r25,lo8(-32)
	or r25,r24
	out 0x7,r25
	ldi r24,lo8(26)
1:	dec r24
	brne 1b
	rjmp .
	sbi 0x6,4
	sbi 0x6,6
	ldi r24,lo8(80)
	ldi r25,lo8(-61)
	ldi r26,0
	ldi r27,0
.L9:
	sbic 0x6,4
	rjmp .L10
	sbiw r26,0
	sbci r25,hi8(0)
	sbci r24,lo8(0)
	breq .L6
	sbiw r24,1
	sbci r26,0
	sbci r27,0
	rjmp .L9
.L10:
	or r24,r25
	or r24,r26
	or r24,r27
	breq .L6
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
	brsh .L18
	in r25,0x7
	andi r25,lo8(-32)
	or r25,r24
	out 0x7,r25
	sbi 0x6,6
	ldi r24,0
	ldi r25,0
	ret
.L18:
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
	brne .L20
.L22:
	ldi r24,lo8(1)
	ldi r25,0
	ret
.L20:
	sbis 0x6,4
	rjmp .L22
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
	brne .L27
	sbi 0x6,3
.L28:
	ldi r24,0
	ldi r25,0
	ret
.L27:
	brsh .L30
	cbi 0x6,3
	rjmp .L28
.L30:
	ldi r24,lo8(1)
	ldi r25,0
/* epilogue start */
	ret
	.size	ADC_SetInterrupt, .-ADC_SetInterrupt
	.ident	"GCC: (GNU) 16.1.0"
