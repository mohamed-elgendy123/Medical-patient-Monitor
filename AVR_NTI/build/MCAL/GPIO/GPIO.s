	.file	"GPIO.c"
__SP_H__ = 0x3e
__SP_L__ = 0x3d
__SREG__ = 0x3f
__tmp_reg__ = 0
__zero_reg__ = 1
	.text
	.section	.text.GPIO_SetPinDirection,"ax",@progbits
.global	GPIO_SetPinDirection
	.type	GPIO_SetPinDirection, @function
GPIO_SetPinDirection:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	cpi r24,lo8(4)
	brlo .+2
	rjmp .L17
	cpi r22,lo8(8)
	brlo .+2
	rjmp .L17
	cpi r20,lo8(1)
	breq .L3
	cpi r20,lo8(2)
	brne .+2
	rjmp .L4
	cpse r20,__zero_reg__
	rjmp .L17
	ldi r18,lo8(1)
	rjmp 2f
	1:
	lsl r18
	2:
	dec r22
	brpl 1b
	com r18
	cpi r24,lo8(2)
	breq .L5
	cpi r24,lo8(3)
	breq .L6
	cpi r24,lo8(1)
	breq .L7
	in r24,0x1a
	and r24,r18
	out 0x1a,r24
	in r24,0x1b
	and r24,r18
.L18:
	out 0x1b,r24
.L8:
	ldi r24,0
	ldi r25,0
	ret
.L7:
	in r24,0x17
	and r24,r18
	out 0x17,r24
	in r24,0x18
	and r24,r18
.L21:
	out 0x18,r24
	rjmp .L8
.L5:
	in r24,0x14
	and r24,r18
	out 0x14,r24
	in r24,0x15
	and r24,r18
.L20:
	out 0x15,r24
	rjmp .L8
.L6:
	in r24,0x11
	and r24,r18
	out 0x11,r24
	in r24,0x12
	and r24,r18
.L19:
	out 0x12,r24
	rjmp .L8
.L3:
	ldi r18,lo8(1)
	ldi r19,0
	movw r20,r18
	rjmp 2f
	1:
	lsl r20
	2:
	dec r22
	brpl 1b
	cpi r24,lo8(2)
	breq .L9
	cpi r24,lo8(3)
	breq .L10
	cpi r24,lo8(1)
	breq .L11
	in r24,0x1a
	or r24,r20
	out 0x1a,r24
	rjmp .L8
.L11:
	in r24,0x17
	or r24,r20
	out 0x17,r24
	rjmp .L8
.L9:
	in r24,0x14
	or r24,r20
	out 0x14,r24
	rjmp .L8
.L10:
	in r24,0x11
	or r24,r20
	out 0x11,r24
	rjmp .L8
.L4:
	ldi r18,lo8(1)
	ldi r19,0
	movw r20,r18
	rjmp 2f
	1:
	lsl r20
	2:
	dec r22
	brpl 1b
	mov r25,r20
	com r25
	cpi r24,lo8(2)
	breq .L12
	cpi r24,lo8(3)
	breq .L13
	cpi r24,lo8(1)
	breq .L14
	in r24,0x1a
	and r24,r25
	out 0x1a,r24
	in r24,0x1b
	or r24,r20
	rjmp .L18
.L14:
	in r24,0x17
	and r24,r25
	out 0x17,r24
	in r24,0x18
	or r24,r20
	rjmp .L21
.L12:
	in r24,0x14
	and r24,r25
	out 0x14,r24
	in r24,0x15
	or r24,r20
	rjmp .L20
.L13:
	in r24,0x11
	and r24,r25
	out 0x11,r24
	in r24,0x12
	or r24,r20
	rjmp .L19
.L17:
	ldi r24,lo8(1)
	ldi r25,0
/* epilogue start */
	ret
	.size	GPIO_SetPinDirection, .-GPIO_SetPinDirection
	.section	.text.GPIO_SetPinValue,"ax",@progbits
.global	GPIO_SetPinValue
	.type	GPIO_SetPinValue, @function
GPIO_SetPinValue:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	cpi r24,lo8(4)
	brsh .L34
	cpi r22,lo8(8)
	brsh .L34
	cpi r20,lo8(1)
	brne .L24
	ldi r18,lo8(1)
	ldi r19,0
	movw r20,r18
	rjmp 2f
	1:
	lsl r20
	2:
	dec r22
	brpl 1b
	cpi r24,lo8(2)
	breq .L25
	cpi r24,lo8(3)
	breq .L26
	cpi r24,lo8(1)
	breq .L27
	in r24,0x1b
	or r24,r20
.L35:
	out 0x1b,r24
.L28:
	ldi r24,0
	ldi r25,0
	ret
.L27:
	in r24,0x18
	or r24,r20
.L37:
	out 0x18,r24
	rjmp .L28
.L25:
	in r24,0x15
	or r24,r20
.L38:
	out 0x15,r24
	rjmp .L28
.L26:
	in r24,0x12
	or r24,r20
.L36:
	out 0x12,r24
	rjmp .L28
.L24:
	brsh .L34
	ldi r18,lo8(1)
	rjmp 2f
	1:
	lsl r18
	2:
	dec r22
	brpl 1b
	com r18
	cpi r24,lo8(2)
	breq .L29
	cpi r24,lo8(3)
	breq .L30
	cpi r24,lo8(1)
	breq .L31
	in r24,0x1b
	and r24,r18
	rjmp .L35
.L31:
	in r24,0x18
	and r24,r18
	rjmp .L37
.L29:
	in r24,0x15
	and r24,r18
	rjmp .L38
.L30:
	in r24,0x12
	and r24,r18
	rjmp .L36
.L34:
	ldi r24,lo8(1)
	ldi r25,0
/* epilogue start */
	ret
	.size	GPIO_SetPinValue, .-GPIO_SetPinValue
	.section	.text.GPIO_GetPinValue,"ax",@progbits
.global	GPIO_GetPinValue
	.type	GPIO_GetPinValue, @function
GPIO_GetPinValue:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	movw r30,r20
	cpi r24,lo8(4)
	brsh .L47
	cpi r22,lo8(8)
	brsh .L47
	sbiw r30,0
	breq .L47
	cpi r24,lo8(2)
	breq .L41
	cpi r24,lo8(3)
	breq .L42
	cpi r24,lo8(1)
	breq .L43
	in r24,0x19
.L48:
	ldi r25,0
	rjmp 2f
	1:
	asr r25
	ror r24
	2:
	dec r22
	brpl 1b
	andi r24,lo8(1)
	st Z,r24
	ldi r24,0
	ldi r25,0
	ret
.L43:
	in r24,0x16
	rjmp .L48
.L41:
	in r24,0x13
	rjmp .L48
.L42:
	in r24,0x10
	rjmp .L48
.L47:
	ldi r24,lo8(1)
	ldi r25,0
/* epilogue start */
	ret
	.size	GPIO_GetPinValue, .-GPIO_GetPinValue
	.section	.text.GPIO_SetPortDirection,"ax",@progbits
.global	GPIO_SetPortDirection
	.type	GPIO_SetPortDirection, @function
GPIO_SetPortDirection:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	cpi r24,lo8(4)
	brsh .L55
	cpi r24,lo8(2)
	breq .L51
	cpi r24,lo8(3)
	breq .L52
	cpi r24,lo8(1)
	breq .L53
	out 0x1a,r22
.L54:
	ldi r24,0
	ldi r25,0
	ret
.L53:
	out 0x17,r22
	rjmp .L54
.L51:
	out 0x14,r22
	rjmp .L54
.L52:
	out 0x11,r22
	rjmp .L54
.L55:
	ldi r24,lo8(1)
	ldi r25,0
/* epilogue start */
	ret
	.size	GPIO_SetPortDirection, .-GPIO_SetPortDirection
	.section	.text.GPIO_SetPortValue,"ax",@progbits
.global	GPIO_SetPortValue
	.type	GPIO_SetPortValue, @function
GPIO_SetPortValue:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	cpi r24,lo8(4)
	brsh .L62
	cpi r24,lo8(2)
	breq .L58
	cpi r24,lo8(3)
	breq .L59
	cpi r24,lo8(1)
	breq .L60
	out 0x1b,r22
.L61:
	ldi r24,0
	ldi r25,0
	ret
.L60:
	out 0x18,r22
	rjmp .L61
.L58:
	out 0x15,r22
	rjmp .L61
.L59:
	out 0x12,r22
	rjmp .L61
.L62:
	ldi r24,lo8(1)
	ldi r25,0
/* epilogue start */
	ret
	.size	GPIO_SetPortValue, .-GPIO_SetPortValue
	.section	.text.GPIO_GetPortValue,"ax",@progbits
.global	GPIO_GetPortValue
	.type	GPIO_GetPortValue, @function
GPIO_GetPortValue:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	movw r30,r22
	cpi r24,lo8(4)
	brsh .L70
	sbiw r30,0
	breq .L70
	cpi r24,lo8(2)
	breq .L65
	cpi r24,lo8(3)
	breq .L66
	cpi r24,lo8(1)
	breq .L67
	in r24,0x19
.L71:
	st Z,r24
	ldi r24,0
	ldi r25,0
	ret
.L67:
	in r24,0x16
	rjmp .L71
.L65:
	in r24,0x13
	rjmp .L71
.L66:
	in r24,0x10
	rjmp .L71
.L70:
	ldi r24,lo8(1)
	ldi r25,0
/* epilogue start */
	ret
	.size	GPIO_GetPortValue, .-GPIO_GetPortValue
	.section	.text.GPIO_TogglePinValue,"ax",@progbits
.global	GPIO_TogglePinValue
	.type	GPIO_TogglePinValue, @function
GPIO_TogglePinValue:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	cpi r24,lo8(4)
	brsh .L79
	cpi r22,lo8(8)
	brsh .L79
	ldi r18,lo8(1)
	ldi r19,0
	movw r20,r18
	rjmp 2f
	1:
	lsl r20
	2:
	dec r22
	brpl 1b
	cpi r24,lo8(2)
	breq .L74
	cpi r24,lo8(3)
	breq .L75
	cpi r24,lo8(1)
	breq .L76
	in r24,0x1b
	eor r24,r20
	out 0x1b,r24
.L77:
	ldi r24,0
	ldi r25,0
	ret
.L76:
	in r24,0x18
	eor r24,r20
	out 0x18,r24
	rjmp .L77
.L74:
	in r24,0x15
	eor r24,r20
	out 0x15,r24
	rjmp .L77
.L75:
	in r24,0x12
	eor r24,r20
	out 0x12,r24
	rjmp .L77
.L79:
	ldi r24,lo8(1)
	ldi r25,0
/* epilogue start */
	ret
	.size	GPIO_TogglePinValue, .-GPIO_TogglePinValue
	.ident	"GCC: (GNU) 15.2.0"
