	.file	"SPI.c"
__SP_H__ = 0x3e
__SP_L__ = 0x3d
__SREG__ = 0x3f
__tmp_reg__ = 0
__zero_reg__ = 1
	.text
	.section	.text.SPI_InitMaster,"ax",@progbits
.global	SPI_InitMaster
	.type	SPI_InitMaster, @function
SPI_InitMaster:
	push r28
/* prologue: function */
/* frame size = 0 */
/* stack size = 1 */
.L__stack_usage = 1
	mov r28,r24
	ldi r24,lo8(1)
	ldi r25,0
	cpi r28,lo8(4)
	brsh .L1
	ldi r20,lo8(1)
	ldi r22,lo8(4)
	ldi r24,lo8(1)
	call GPIO_SetPinDirection
	ldi r20,lo8(1)
	ldi r22,lo8(5)
	ldi r24,lo8(1)
	call GPIO_SetPinDirection
	ldi r20,0
	ldi r22,lo8(6)
	ldi r24,lo8(1)
	call GPIO_SetPinDirection
	ldi r20,lo8(1)
	ldi r22,lo8(7)
	ldi r24,lo8(1)
	call GPIO_SetPinDirection
	ldi r20,0
	ldi r22,lo8(4)
	ldi r24,lo8(1)
	call GPIO_SetPinValue
	ori r28,lo8(80)
	out 0xd,r28
	ldi r24,0
	ldi r25,0
.L1:
/* epilogue start */
	pop r28
	ret
	.size	SPI_InitMaster, .-SPI_InitMaster
	.section	.text.SPI_TransceiveByte,"ax",@progbits
.global	SPI_TransceiveByte
	.type	SPI_TransceiveByte, @function
SPI_TransceiveByte:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	out 0xf,r24
.L5:
	sbis 0xe,7
	rjmp .L5
	in r24,0xf
/* epilogue start */
	ret
	.size	SPI_TransceiveByte, .-SPI_TransceiveByte
	.section	.text.SPI_Transceive,"ax",@progbits
.global	SPI_Transceive
	.type	SPI_Transceive, @function
SPI_Transceive:
	push r28
	push r29
/* prologue: function */
/* frame size = 0 */
/* stack size = 2 */
.L__stack_usage = 2
	movw r28,r22
	sbiw r28,0
	breq .L9
	call SPI_TransceiveByte
	st Y,r24
	ldi r24,0
	ldi r25,0
.L7:
/* epilogue start */
	pop r29
	pop r28
	ret
.L9:
	ldi r24,lo8(1)
	ldi r25,0
	rjmp .L7
	.size	SPI_Transceive, .-SPI_Transceive
	.section	.text.SPI_SelectSlave,"ax",@progbits
.global	SPI_SelectSlave
	.type	SPI_SelectSlave, @function
SPI_SelectSlave:
	push r28
	push r29
/* prologue: function */
/* frame size = 0 */
/* stack size = 2 */
.L__stack_usage = 2
	mov r28,r24
	mov r29,r22
	ldi r20,lo8(1)
	call GPIO_SetPinDirection
	ldi r20,0
	mov r22,r29
	mov r24,r28
	call GPIO_SetPinValue
	ldi r24,0
	ldi r25,0
/* epilogue start */
	pop r29
	pop r28
	ret
	.size	SPI_SelectSlave, .-SPI_SelectSlave
	.section	.text.SPI_ReleaseSlave,"ax",@progbits
.global	SPI_ReleaseSlave
	.type	SPI_ReleaseSlave, @function
SPI_ReleaseSlave:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	ldi r20,lo8(1)
	call GPIO_SetPinValue
	ldi r24,0
	ldi r25,0
/* epilogue start */
	ret
	.size	SPI_ReleaseSlave, .-SPI_ReleaseSlave
	.ident	"GCC: (GNU) 16.1.0"
