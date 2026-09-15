	.file	"main.c"
__SP_H__ = 0x3e
__SP_L__ = 0x3d
__SREG__ = 0x3f
__tmp_reg__ = 0
__zero_reg__ = 1
	.text
	.section	.text.UART_init,"ax",@progbits
.global	UART_init
	.type	UART_init, @function
UART_init:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	out 0x20,__zero_reg__
	ldi r24,lo8(103)
	out 0x9,r24
	ldi r24,lo8(24)
	out 0xa,r24
	ldi r24,lo8(-122)
	out 0x20,r24
/* epilogue start */
	ret
	.size	UART_init, .-UART_init
	.section	.text.UART_sendChar,"ax",@progbits
.global	UART_sendChar
	.type	UART_sendChar, @function
UART_sendChar:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
.L3:
	sbis 0xb,5
	rjmp .L3
	out 0xc,r24
/* epilogue start */
	ret
	.size	UART_sendChar, .-UART_sendChar
	.section	.text.UART_sendString,"ax",@progbits
.global	UART_sendString
	.type	UART_sendString, @function
UART_sendString:
	push r28
	push r29
/* prologue: function */
/* frame size = 0 */
/* stack size = 2 */
.L__stack_usage = 2
	movw r28,r24
.L7:
	ld r24,Y
	cpse r24,__zero_reg__
	rjmp .L8
/* epilogue start */
	pop r29
	pop r28
	ret
.L8:
	adiw r28,1
	call UART_sendChar
	rjmp .L7
	.size	UART_sendString, .-UART_sendString
	.section	.text.UART_sendNumber,"ax",@progbits
.global	UART_sendNumber
	.type	UART_sendNumber, @function
UART_sendNumber:
	push r28
	push r29
	in r28,__SP_L__
	in r29,__SP_H__
	sbiw r28,10
	in __tmp_reg__,__SREG__
	cli
	out __SP_H__,r29
	out __SREG__,__tmp_reg__
	out __SP_L__,r28
/* prologue: function */
/* frame size = 10 */
/* stack size = 12 */
.L__stack_usage = 12
	ldi r20,lo8(10)
	movw r22,r28
	subi r22,-1
	sbci r23,-1
	call __itoa_ncheck
	movw r24,r28
	adiw r24,1
	call UART_sendString
/* epilogue start */
	adiw r28,10
	in __tmp_reg__,__SREG__
	cli
	out __SP_H__,r29
	out __SREG__,__tmp_reg__
	out __SP_L__,r28
	pop r29
	pop r28
	ret
	.size	UART_sendNumber, .-UART_sendNumber
	.section	.text.ADC_init,"ax",@progbits
.global	ADC_init
	.type	ADC_init, @function
ADC_init:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	ldi r24,lo8(64)
	out 0x7,r24
	ldi r24,lo8(-121)
	out 0x6,r24
/* epilogue start */
	ret
	.size	ADC_init, .-ADC_init
	.section	.text.ADC_read,"ax",@progbits
.global	ADC_read
	.type	ADC_read, @function
ADC_read:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	in r25,0x7
	andi r24,lo8(7)
	andi r25,lo8(-16)
	or r24,r25
	out 0x7,r24
	sbi 0x6,6
.L12:
	sbic 0x6,6
	rjmp .L12
	in r24,0x4
	in r25,0x4+1
/* epilogue start */
	ret
	.size	ADC_read, .-ADC_read
	.section	.rodata.main.str1.1,"aMS",@progbits,1
.LC0:
	.string	"--- Patient Vitals ---\r\n"
.LC1:
	.string	"Ch "
.LC2:
	.string	": "
.LC3:
	.string	"\r\n"
.LC4:
	.string	"\r\n--- Sending Trends CSV Data ---\r\n"
.LC5:
	.string	"--- End of Trends ---\r\n\r\n"
	.section	.text.startup.main,"ax",@progbits
.global	main
	.type	main, @function
main:
	in r28,__SP_L__
	in r29,__SP_H__
	sbiw r28,54
	in __tmp_reg__,__SREG__
	cli
	out __SP_H__,r29
	out __SREG__,__tmp_reg__
	out __SP_L__,r28
/* prologue: function */
/* frame size = 54 */
/* stack size = 54 */
.L__stack_usage = 54
	call UART_init
	call ADC_init
	call Trends_Init
	sbi 0x17,0
	mov r15,__zero_reg__
	movw r24,r28
	adiw r24,1
	std Y+51,r24
	std Y+52,r25
.L15:
	in r24,0x18
	ldi r18,lo8(1)
	eor r24,r18
	out 0x18,r24
	ldi r24,lo8(.LC0)
	ldi r25,hi8(.LC0)
	call UART_sendString
	ldi r16,0
	ldi r17,0
.L16:
	mov r24,r16
	call ADC_read
	std Y+53,r24
	std Y+54,r25
	ldi r24,lo8(.LC1)
	ldi r25,hi8(.LC1)
	call UART_sendString
	movw r24,r16
	call UART_sendNumber
	ldi r24,lo8(.LC2)
	ldi r25,hi8(.LC2)
	call UART_sendString
	ldd r24,Y+53
	ldd r25,Y+54
	call UART_sendNumber
	ldi r24,lo8(.LC3)
	ldi r25,hi8(.LC3)
	call UART_sendString
	subi r16,-1
	sbci r17,-1
	cpi r16,4
	cpc r17,__zero_reg__
	brne .L16
	ldi r24,lo8(.LC3)
	ldi r25,hi8(.LC3)
	call UART_sendString
	inc r15
	ldi r24,lo8(20)
	cpse r15,r24
	rjmp .L17
	call Task_Trend
	mov r15,__zero_reg__
.L17:
	ldi r25,lo8(1599999)
	ldi r18,hi8(1599999)
	ldi r24,hlo8(1599999)
1:	subi r25,1
	sbci r18,0
	sbci r24,0
	brne 1b
	rjmp .
	nop
	sbis 0xb,7
	rjmp .L15
	in r24,0xc
	andi r24,lo8(-33)
	cpi r24,lo8(84)
	breq .+2
	rjmp .L15
	ldi r24,lo8(.LC4)
	ldi r25,hi8(.LC4)
	call UART_sendString
	call Trends_GetCount
	mov r17,r24
	ldi r16,0
.L19:
	cpse r16,r17
	rjmp .L20
	ldi r24,lo8(.LC5)
	ldi r25,hi8(.LC5)
	call UART_sendString
	rjmp .L15
.L20:
	ldd r22,Y+51
	ldd r23,Y+52
	mov r24,r16
	call Trends_GetSampleLine
	ldd r24,Y+51
	ldd r25,Y+52
	call UART_sendString
	subi r16,lo8(-(1))
	rjmp .L19
	.size	main, .-main
	.ident	"GCC: (GNU) 15.2.0"
.global __do_copy_data
