	.file	"GPIO.c"
__SP_H__ = 0x3e
__SP_L__ = 0x3d
__SREG__ = 0x3f
__tmp_reg__ = 0
__zero_reg__ = 1
	.text
	.section	.text.GPIO_DisableJtag,"ax",@progbits
.global	GPIO_DisableJtag
	.type	GPIO_DisableJtag, @function
GPIO_DisableJtag:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	in r24,0x34
	ori r24,lo8(-128)
	out 0x34,r24
	in r24,0x34
	ori r24,lo8(-128)
	out 0x34,r24
/* epilogue start */
	ret
	.size	GPIO_DisableJtag, .-GPIO_DisableJtag
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
	rjmp .L3
	cpi r22,lo8(8)
	brlo .+2
	rjmp .L3
	cpi r20,lo8(3)
	brlo .+2
	rjmp .L3
	ldi r18,lo8(1)
	rjmp 2f
	1:
	lsl r18
	2:
	dec r22
	brpl 1b
	mov r22,r18
	cpi r20,lo8(1)
	brsh .L4
	com r22
	cpi r24,lo8(2)
	breq .L5
	cpi r24,lo8(3)
	breq .L6
	cpi r24,lo8(1)
	breq .L7
	in r24,0x1a
	and r24,r22
	out 0x1a,r24
	in r24,0x1b
	and r24,r22
.L18:
	out 0x1b,r24
	rjmp .L8
.L7:
	in r24,0x17
	and r24,r22
	out 0x17,r24
	in r24,0x18
	and r24,r22
.L19:
	out 0x18,r24
	rjmp .L8
.L5:
	in r24,0x14
	and r24,r22
	out 0x14,r24
	in r24,0x15
	and r24,r22
.L20:
	out 0x15,r24
	rjmp .L8
.L6:
	in r24,0x11
	and r24,r22
	out 0x11,r24
	in r24,0x12
	and r24,r22
.L17:
	out 0x12,r24
	rjmp .L8
.L4:
	brne .L9
	cpi r24,lo8(2)
	breq .L10
	cpi r24,lo8(3)
	breq .L11
	cpi r24,lo8(1)
	breq .L12
	in r24,0x1a
	or r24,r18
	out 0x1a,r24
.L8:
	ldi r24,0
	ldi r25,0
	ret
.L12:
	in r24,0x17
	or r24,r18
	out 0x17,r24
	rjmp .L8
.L10:
	in r24,0x14
	or r24,r18
	out 0x14,r24
	rjmp .L8
.L11:
	in r24,0x11
	or r24,r18
	out 0x11,r24
	rjmp .L8
.L9:
	mov r25,r18
	com r25
	cpi r24,lo8(2)
	breq .L14
	cpi r24,lo8(3)
	breq .L15
	cpi r24,lo8(1)
	breq .L16
	in r24,0x1a
	and r24,r25
	out 0x1a,r24
	in r24,0x1b
	or r24,r18
	rjmp .L18
.L16:
	in r24,0x17
	and r24,r25
	out 0x17,r24
	in r24,0x18
	or r24,r18
	rjmp .L19
.L14:
	in r24,0x14
	and r24,r25
	out 0x14,r24
	in r24,0x15
	or r24,r18
	rjmp .L20
.L15:
	in r24,0x11
	and r24,r25
	out 0x11,r24
	in r24,0x12
	or r24,r18
	rjmp .L17
.L3:
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
	brsh .L22
	cpi r22,lo8(8)
	brsh .L22
	cpi r20,lo8(2)
	brsh .L22
	ldi r18,lo8(1)
	rjmp 2f
	1:
	lsl r18
	2:
	dec r22
	brpl 1b
	mov r22,r18
	cpi r20,lo8(1)
	brne .L23
	cpi r24,lo8(2)
	breq .L24
	cpi r24,lo8(3)
	breq .L25
	cpi r24,lo8(1)
	breq .L26
	in r24,0x1b
	or r24,r18
.L32:
	out 0x1b,r24
.L27:
	ldi r24,0
	ldi r25,0
	ret
.L26:
	in r24,0x18
	or r24,r18
.L33:
	out 0x18,r24
	rjmp .L27
.L24:
	in r24,0x15
	or r24,r18
.L34:
	out 0x15,r24
	rjmp .L27
.L25:
	in r24,0x12
	or r24,r18
.L35:
	out 0x12,r24
	rjmp .L27
.L23:
	com r22
	cpi r24,lo8(2)
	breq .L28
	cpi r24,lo8(3)
	breq .L29
	cpi r24,lo8(1)
	breq .L30
	in r24,0x1b
	and r24,r22
	rjmp .L32
.L30:
	in r24,0x18
	and r24,r22
	rjmp .L33
.L28:
	in r24,0x15
	and r24,r22
	rjmp .L34
.L29:
	in r24,0x12
	and r24,r22
	rjmp .L35
.L22:
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
	brsh .L37
	cpi r22,lo8(8)
	brsh .L37
	sbiw r30,0
	breq .L37
	cpi r24,lo8(2)
	breq .L38
	cpi r24,lo8(3)
	breq .L39
	cpi r24,lo8(1)
	breq .L40
	in r24,0x19
.L47:
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
.L40:
	in r24,0x16
	rjmp .L47
.L38:
	in r24,0x13
	rjmp .L47
.L39:
	in r24,0x10
	rjmp .L47
.L37:
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
	brsh .L49
	cpi r22,lo8(8)
	brsh .L49
	ldi r18,lo8(1)
	rjmp 2f
	1:
	lsl r18
	2:
	dec r22
	brpl 1b
	cpi r24,lo8(2)
	breq .L50
	cpi r24,lo8(3)
	breq .L51
	cpi r24,lo8(1)
	breq .L52
	in r24,0x1b
	eor r24,r18
	out 0x1b,r24
.L54:
	ldi r24,0
	ldi r25,0
	ret
.L52:
	in r24,0x18
	eor r24,r18
	out 0x18,r24
	rjmp .L54
.L50:
	in r24,0x15
	eor r24,r18
	out 0x15,r24
	rjmp .L54
.L51:
	in r24,0x12
	eor r24,r18
	out 0x12,r24
	rjmp .L54
.L49:
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
	brsh .L61
	cpi r24,lo8(2)
	breq .L57
	cpi r24,lo8(3)
	breq .L58
	cpi r24,lo8(1)
	breq .L59
	out 0x1a,r22
.L60:
	ldi r24,0
	ldi r25,0
	ret
.L59:
	out 0x17,r22
	rjmp .L60
.L57:
	out 0x14,r22
	rjmp .L60
.L58:
	out 0x11,r22
	rjmp .L60
.L61:
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
	brsh .L68
	cpi r24,lo8(2)
	breq .L64
	cpi r24,lo8(3)
	breq .L65
	cpi r24,lo8(1)
	breq .L66
	out 0x1b,r22
.L67:
	ldi r24,0
	ldi r25,0
	ret
.L66:
	out 0x18,r22
	rjmp .L67
.L64:
	out 0x15,r22
	rjmp .L67
.L65:
	out 0x12,r22
	rjmp .L67
.L68:
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
	breq .L71
	cpi r24,lo8(3)
	breq .L72
	cpi r24,lo8(1)
	breq .L73
	in r24,0x19
.L80:
	st Z,r24
	ldi r24,0
	ldi r25,0
	ret
.L73:
	in r24,0x16
	rjmp .L80
.L71:
	in r24,0x13
	rjmp .L80
.L72:
	in r24,0x10
	rjmp .L80
.L70:
	ldi r24,lo8(1)
	ldi r25,0
/* epilogue start */
	ret
	.size	GPIO_GetPortValue, .-GPIO_GetPortValue
	.ident	"GCC: (GNU) 16.1.0"
