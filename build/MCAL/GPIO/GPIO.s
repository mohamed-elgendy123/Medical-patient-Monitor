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
	cpi r20,lo8(3)
	brlo .+2
	rjmp .L17
	ldi r18,lo8(1)
	ldi r19,0
	movw r30,r18
	rjmp 2f
	1:
	lsl r30
	2:
	dec r22
	brpl 1b
	mov r22,r30
	cpi r20,lo8(1)
	brsh .L3
	com r22
	cpi r24,lo8(2)
	breq .L4
	cpi r24,lo8(3)
	breq .L5
	cpi r24,lo8(1)
	breq .L6
	in r24,0x1a
	and r24,r22
	out 0x1a,r24
	in r24,0x1b
	and r24,r22
.L19:
	out 0x1b,r24
	rjmp .L7
.L6:
	in r24,0x17
	and r24,r22
	out 0x17,r24
	in r24,0x18
	and r24,r22
.L21:
	out 0x18,r24
.L7:
	ldi r24,0
	ldi r25,0
	ret
.L4:
	in r24,0x14
	and r24,r22
	out 0x14,r24
	in r24,0x15
	and r24,r22
.L18:
	out 0x15,r24
	rjmp .L7
.L5:
	in r24,0x11
	and r24,r22
	out 0x11,r24
	in r24,0x12
	and r24,r22
.L20:
	out 0x12,r24
	rjmp .L7
.L3:
	brne .L8
	cpi r24,lo8(2)
	breq .L9
	cpi r24,lo8(3)
	breq .L10
	cpi r24,lo8(1)
	breq .L11
	in r24,0x1a
	or r24,r30
	out 0x1a,r24
	rjmp .L7
.L11:
	in r24,0x17
	or r24,r30
	out 0x17,r24
	rjmp .L7
.L9:
	in r24,0x14
	or r24,r30
	out 0x14,r24
	rjmp .L7
.L10:
	in r24,0x11
	or r24,r30
	out 0x11,r24
	rjmp .L7
.L8:
	mov r25,r30
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
	or r24,r30
	rjmp .L19
.L14:
	in r24,0x17
	and r24,r25
	out 0x17,r24
	in r24,0x18
	or r24,r30
	rjmp .L21
.L12:
	in r24,0x14
	and r24,r25
	out 0x14,r24
	in r24,0x15
	or r24,r30
	rjmp .L18
.L13:
	in r24,0x11
	and r24,r25
	out 0x11,r24
	in r24,0x12
	or r24,r30
	rjmp .L20
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
	cpi r20,lo8(2)
	brsh .L34
	ldi r18,lo8(1)
	ldi r19,0
	movw r30,r18
	rjmp 2f
	1:
	lsl r30
	2:
	dec r22
	brpl 1b
	mov r22,r30
	cpi r20,lo8(1)
	brne .L24
	cpi r24,lo8(2)
	breq .L25
	cpi r24,lo8(3)
	breq .L26
	cpi r24,lo8(1)
	breq .L27
	in r24,0x1b
	or r24,r30
.L37:
	out 0x1b,r24
	rjmp .L28
.L27:
	in r24,0x18
	or r24,r30
.L36:
	out 0x18,r24
	rjmp .L28
.L25:
	in r24,0x15
	or r24,r30
.L35:
	out 0x15,r24
.L28:
	ldi r24,0
	ldi r25,0
	ret
.L26:
	in r24,0x12
	or r24,r30
.L38:
	out 0x12,r24
	rjmp .L28
.L24:
	com r22
	cpi r24,lo8(2)
	breq .L29
	cpi r24,lo8(3)
	breq .L30
	cpi r24,lo8(1)
	breq .L31
	in r24,0x1b
	and r24,r22
	rjmp .L37
.L31:
	in r24,0x18
	and r24,r22
	rjmp .L36
.L29:
	in r24,0x15
	and r24,r22
	rjmp .L35
.L30:
	in r24,0x12
	and r24,r22
	rjmp .L38
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
	lsr r25
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
	.section	.text.GPIO_TogglePinValue,"ax",@progbits
.global	GPIO_TogglePinValue
	.type	GPIO_TogglePinValue, @function
GPIO_TogglePinValue:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	cpi r24,lo8(4)
	brsh .L56
	cpi r22,lo8(8)
	brsh .L56
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
	breq .L51
	cpi r24,lo8(3)
	breq .L52
	cpi r24,lo8(1)
	breq .L53
	in r24,0x1b
	eor r24,r20
	out 0x1b,r24
.L54:
	ldi r24,0
	ldi r25,0
	ret
.L53:
	in r24,0x18
	eor r24,r20
	out 0x18,r24
	rjmp .L54
.L51:
	in r24,0x15
	eor r24,r20
	out 0x15,r24
	rjmp .L54
.L52:
	in r24,0x12
	eor r24,r20
	out 0x12,r24
	rjmp .L54
.L56:
	ldi r24,lo8(1)
	ldi r25,0
/* epilogue start */
	ret
	.size	GPIO_TogglePinValue, .-GPIO_TogglePinValue
	.section	.text.GPIO_SetPortDirection,"ax",@progbits
.global	GPIO_SetPortDirection
	.type	GPIO_SetPortDirection, @function
GPIO_SetPortDirection:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	cpi r24,lo8(4)
	brsh .L63
	cpi r24,lo8(2)
	breq .L59
	cpi r24,lo8(3)
	breq .L60
	cpi r24,lo8(1)
	breq .L61
	out 0x1a,r22
.L62:
	ldi r24,0
	ldi r25,0
	ret
.L61:
	out 0x17,r22
	rjmp .L62
.L59:
	out 0x14,r22
	rjmp .L62
.L60:
	out 0x11,r22
	rjmp .L62
.L63:
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
	brsh .L70
	cpi r24,lo8(2)
	breq .L66
	cpi r24,lo8(3)
	breq .L67
	cpi r24,lo8(1)
	breq .L68
	out 0x1b,r22
.L69:
	ldi r24,0
	ldi r25,0
	ret
.L68:
	out 0x18,r22
	rjmp .L69
.L66:
	out 0x15,r22
	rjmp .L69
.L67:
	out 0x12,r22
	rjmp .L69
.L70:
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
	brsh .L78
	sbiw r30,0
	breq .L78
	cpi r24,lo8(2)
	breq .L73
	cpi r24,lo8(3)
	breq .L74
	cpi r24,lo8(1)
	breq .L75
	in r24,0x19
.L79:
	st Z,r24
	ldi r24,0
	ldi r25,0
	ret
.L75:
	in r24,0x16
	rjmp .L79
.L73:
	in r24,0x13
	rjmp .L79
.L74:
	in r24,0x10
	rjmp .L79
.L78:
	ldi r24,lo8(1)
	ldi r25,0
/* epilogue start */
	ret
	.size	GPIO_GetPortValue, .-GPIO_GetPortValue
	.ident	"GCC: (GNU) 15.2.0"
