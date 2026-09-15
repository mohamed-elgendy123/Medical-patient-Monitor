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
	rjmp .L2
	cpi r22,lo8(8)
	brlo .+2
	rjmp .L2
	cpi r20,lo8(3)
	brlo .+2
	rjmp .L2
	ldi r18,lo8(1)
	rjmp 2f
	1:
	lsl r18
	2:
	dec r22
	brpl 1b
	mov r22,r18
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
.L17:
	out 0x1b,r24
	rjmp .L7
.L6:
	in r24,0x17
	and r24,r22
	out 0x17,r24
	in r24,0x18
	and r24,r22
.L18:
	out 0x18,r24
	rjmp .L7
.L4:
	in r24,0x14
	and r24,r22
	out 0x14,r24
	in r24,0x15
	and r24,r22
.L19:
	out 0x15,r24
	rjmp .L7
.L5:
	in r24,0x11
	and r24,r22
	out 0x11,r24
	in r24,0x12
	and r24,r22
.L16:
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
	or r24,r18
	out 0x1a,r24
.L7:
	ldi r24,0
	ldi r25,0
	ret
.L11:
	in r24,0x17
	or r24,r18
	out 0x17,r24
	rjmp .L7
.L9:
	in r24,0x14
	or r24,r18
	out 0x14,r24
	rjmp .L7
.L10:
	in r24,0x11
	or r24,r18
	out 0x11,r24
	rjmp .L7
.L8:
	mov r25,r18
	com r25
	cpi r24,lo8(2)
	breq .L13
	cpi r24,lo8(3)
	breq .L14
	cpi r24,lo8(1)
	breq .L15
	in r24,0x1a
	and r24,r25
	out 0x1a,r24
	in r24,0x1b
	or r24,r18
	rjmp .L17
.L15:
	in r24,0x17
	and r24,r25
	out 0x17,r24
	in r24,0x18
	or r24,r18
	rjmp .L18
.L13:
	in r24,0x14
	and r24,r25
	out 0x14,r24
	in r24,0x15
	or r24,r18
	rjmp .L19
.L14:
	in r24,0x11
	and r24,r25
	out 0x11,r24
	in r24,0x12
	or r24,r18
	rjmp .L16
.L2:
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
	brsh .L21
	cpi r22,lo8(8)
	brsh .L21
	cpi r20,lo8(2)
	brsh .L21
	ldi r18,lo8(1)
	rjmp 2f
	1:
	lsl r18
	2:
	dec r22
	brpl 1b
	mov r22,r18
	cpi r20,lo8(1)
	brne .L22
	cpi r24,lo8(2)
	breq .L23
	cpi r24,lo8(3)
	breq .L24
	cpi r24,lo8(1)
	breq .L25
	in r24,0x1b
	or r24,r18
.L31:
	out 0x1b,r24
.L26:
	ldi r24,0
	ldi r25,0
	ret
.L25:
	in r24,0x18
	or r24,r18
.L32:
	out 0x18,r24
	rjmp .L26
.L23:
	in r24,0x15
	or r24,r18
.L33:
	out 0x15,r24
	rjmp .L26
.L24:
	in r24,0x12
	or r24,r18
.L34:
	out 0x12,r24
	rjmp .L26
.L22:
	com r22
	cpi r24,lo8(2)
	breq .L27
	cpi r24,lo8(3)
	breq .L28
	cpi r24,lo8(1)
	breq .L29
	in r24,0x1b
	and r24,r22
	rjmp .L31
.L29:
	in r24,0x18
	and r24,r22
	rjmp .L32
.L27:
	in r24,0x15
	and r24,r22
	rjmp .L33
.L28:
	in r24,0x12
	and r24,r22
	rjmp .L34
.L21:
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
	brsh .L36
	cpi r22,lo8(8)
	brsh .L36
	sbiw r30,0
	breq .L36
	cpi r24,lo8(2)
	breq .L37
	cpi r24,lo8(3)
	breq .L38
	cpi r24,lo8(1)
	breq .L39
	in r24,0x19
.L46:
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
.L39:
	in r24,0x16
	rjmp .L46
.L37:
	in r24,0x13
	rjmp .L46
.L38:
	in r24,0x10
	rjmp .L46
.L36:
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
	brsh .L48
	cpi r22,lo8(8)
	brsh .L48
	ldi r18,lo8(1)
	rjmp 2f
	1:
	lsl r18
	2:
	dec r22
	brpl 1b
	cpi r24,lo8(2)
	breq .L49
	cpi r24,lo8(3)
	breq .L50
	cpi r24,lo8(1)
	breq .L51
	in r24,0x1b
	eor r24,r18
	out 0x1b,r24
.L53:
	ldi r24,0
	ldi r25,0
	ret
.L51:
	in r24,0x18
	eor r24,r18
	out 0x18,r24
	rjmp .L53
.L49:
	in r24,0x15
	eor r24,r18
	out 0x15,r24
	rjmp .L53
.L50:
	in r24,0x12
	eor r24,r18
	out 0x12,r24
	rjmp .L53
.L48:
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
	brsh .L60
	cpi r24,lo8(2)
	breq .L56
	cpi r24,lo8(3)
	breq .L57
	cpi r24,lo8(1)
	breq .L58
	out 0x1a,r22
.L59:
	ldi r24,0
	ldi r25,0
	ret
.L58:
	out 0x17,r22
	rjmp .L59
.L56:
	out 0x14,r22
	rjmp .L59
.L57:
	out 0x11,r22
	rjmp .L59
.L60:
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
	brsh .L67
	cpi r24,lo8(2)
	breq .L63
	cpi r24,lo8(3)
	breq .L64
	cpi r24,lo8(1)
	breq .L65
	out 0x1b,r22
.L66:
	ldi r24,0
	ldi r25,0
	ret
.L65:
	out 0x18,r22
	rjmp .L66
.L63:
	out 0x15,r22
	rjmp .L66
.L64:
	out 0x12,r22
	rjmp .L66
.L67:
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
	brsh .L69
	sbiw r30,0
	breq .L69
	cpi r24,lo8(2)
	breq .L70
	cpi r24,lo8(3)
	breq .L71
	cpi r24,lo8(1)
	breq .L72
	in r24,0x19
.L79:
	st Z,r24
	ldi r24,0
	ldi r25,0
	ret
.L72:
	in r24,0x16
	rjmp .L79
.L70:
	in r24,0x13
	rjmp .L79
.L71:
	in r24,0x10
	rjmp .L79
.L69:
	ldi r24,lo8(1)
	ldi r25,0
/* epilogue start */
	ret
	.size	GPIO_GetPortValue, .-GPIO_GetPortValue
	.ident	"GCC: (GNU) 16.1.0"
