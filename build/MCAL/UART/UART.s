	.file	"UART.c"
__SP_H__ = 0x3e
__SP_L__ = 0x3d
__SREG__ = 0x3f
__tmp_reg__ = 0
__zero_reg__ = 1
	.text
	.section	.text.UART_Init,"ax",@progbits
.global	UART_Init
	.type	UART_Init, @function
UART_Init:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	sbiw r24,0
	sbci r23,hi8(0)
	sbci r22,lo8(0)
	breq .L3
	movw r18,r22
	movw r20,r24
	andi r21,15
	ori r21,16
	1:
	lsl r18
	rol r19
	rol r20
	rol r21
	brcc 1b
	ldi r22,0
	ldi r23,lo8(18)
	ldi r24,lo8(122)
	ldi r25,0
	call __udivmodsi4
	subi r18,1
	sbci r19,0
	out 0x20,r19
	out 0x9,r18
	ldi r24,lo8(-122)
	out 0x20,r24
	ldi r24,lo8(24)
	out 0xa,r24
	ldi r24,0
	ldi r25,0
	ret
.L3:
	ldi r24,lo8(1)
	ldi r25,0
/* epilogue start */
	ret
	.size	UART_Init, .-UART_Init
	.section	.text.UART_SendByte,"ax",@progbits
.global	UART_SendByte
	.type	UART_SendByte, @function
UART_SendByte:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
.L5:
	sbis 0xb,5
	rjmp .L5
	out 0xc,r24
	ldi r24,0
	ldi r25,0
/* epilogue start */
	ret
	.size	UART_SendByte, .-UART_SendByte
	.section	.text.UART_ReceiveByte,"ax",@progbits
.global	UART_ReceiveByte
	.type	UART_ReceiveByte, @function
UART_ReceiveByte:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	sbiw r24,0
	breq .L11
.L10:
	sbis 0xb,7
	rjmp .L10
	in r18,0xc
	movw r30,r24
	st Z,r18
	ldi r24,0
	ldi r25,0
	ret
.L11:
	ldi r24,lo8(1)
	ldi r25,0
/* epilogue start */
	ret
	.size	UART_ReceiveByte, .-UART_ReceiveByte
	.section	.text.UART_SendString,"ax",@progbits
.global	UART_SendString
	.type	UART_SendString, @function
UART_SendString:
	push r28
	push r29
/* prologue: function */
/* frame size = 0 */
/* stack size = 2 */
.L__stack_usage = 2
	movw r28,r24
	or r24,r25
	brne .L15
	ldi r24,lo8(1)
	ldi r25,0
	rjmp .L13
.L16:
	adiw r28,1
	call UART_SendByte
.L15:
	ld r24,Y
	cpse r24,__zero_reg__
	rjmp .L16
	ldi r24,0
	ldi r25,0
.L13:
/* epilogue start */
	pop r29
	pop r28
	ret
	.size	UART_SendString, .-UART_SendString
	.section	.text.UART_IsDataReady,"ax",@progbits
.global	UART_IsDataReady
	.type	UART_IsDataReady, @function
UART_IsDataReady:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	in r24,0xb
	lsl r24
	sbc r25,r25
	com r25
	bst r25,7
	clr r24
	bld r24,0
	ldi r25,0
/* epilogue start */
	ret
	.size	UART_IsDataReady, .-UART_IsDataReady
	.section	.text.UART_SetRxInterrupt,"ax",@progbits
.global	UART_SetRxInterrupt
	.type	UART_SetRxInterrupt, @function
UART_SetRxInterrupt:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	cpi r24,lo8(1)
	brne .L20
	sbi 0xa,7
.L21:
	ldi r24,0
	ldi r25,0
/* epilogue start */
	ret
.L20:
	cbi 0xa,7
	rjmp .L21
	.size	UART_SetRxInterrupt, .-UART_SetRxInterrupt
	.section	.text.UART_SetTxInterrupt,"ax",@progbits
.global	UART_SetTxInterrupt
	.type	UART_SetTxInterrupt, @function
UART_SetTxInterrupt:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	cpi r24,lo8(1)
	brne .L23
	sbi 0xa,5
.L24:
	ldi r24,0
	ldi r25,0
/* epilogue start */
	ret
.L23:
	cbi 0xa,5
	rjmp .L24
	.size	UART_SetTxInterrupt, .-UART_SetTxInterrupt
	.ident	"GCC: (GNU) 16.1.0"
