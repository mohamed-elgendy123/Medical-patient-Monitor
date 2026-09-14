	.file	"SevenSegment.c"
__SP_H__ = 0x3e
__SP_L__ = 0x3d
__SREG__ = 0x3f
__tmp_reg__ = 0
__zero_reg__ = 1
	.text
	.section	.text.SevenSegment_Init,"ax",@progbits
.global	SevenSegment_Init
	.type	SevenSegment_Init, @function
SevenSegment_Init:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	cpi r24,lo8(4)
	brsh .L3
	ldi r22,lo8(-1)
	call GPIO_SetPortDirection
	ldi r24,0
	ldi r25,0
	ret
.L3:
	ldi r24,lo8(1)
	ldi r25,0
/* epilogue start */
	ret
	.size	SevenSegment_Init, .-SevenSegment_Init
	.section	.rodata.SevenSegment_Display.str1.1,"aMS",@progbits,1
.LC0:
	.base64	"PwZbT2ZtfQd/bwA="
	.section	.text.SevenSegment_Display,"ax",@progbits
.global	SevenSegment_Display
	.type	SevenSegment_Display, @function
SevenSegment_Display:
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
	cpi r22,lo8(10)
	brsh .L6
	ldi r25,lo8(10)
	ldi r30,lo8(.LC0)
	ldi r31,hi8(.LC0)
	movw r18,r28
	subi r18,-1
	sbci r19,-1
	movw r26,r18
	0:
	ld r0,Z+
	st X+,r0
	dec r25
	brne 0b
	add r18,r22
	adc r19,__zero_reg__
	movw r30,r18
	ld r22,Z
	call GPIO_SetPortValue
	ldi r24,0
	ldi r25,0
.L4:
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
.L6:
	ldi r24,lo8(1)
	ldi r25,0
	rjmp .L4
	.size	SevenSegment_Display, .-SevenSegment_Display
	.ident	"GCC: (GNU) 16.1.0"
.global __do_copy_data
