	.file	"I2C.c"
__SP_H__ = 0x3e
__SP_L__ = 0x3d
__SREG__ = 0x3f
__tmp_reg__ = 0
__zero_reg__ = 1
	.text
	.section	.text.I2C_InitMaster,"ax",@progbits
.global	I2C_InitMaster
	.type	I2C_InitMaster, @function
I2C_InitMaster:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	movw r18,r22
	movw r20,r24
	cpi r18,0
	cpc r19,r18
	cpc r20,r18
	cpc r21,r18
	brne .L2
.L4:
	ldi r24,lo8(1)
	ldi r25,0
	ret
.L2:
	ldi r22,0
	ldi r23,lo8(18)
	ldi r24,lo8(122)
	ldi r25,0
	call __udivmodsi4
	movw r24,r18
	movw r26,r20
	cpi r24,16
	cpc r25,__zero_reg__
	cpc r26,__zero_reg__
	cpc r27,__zero_reg__
	brlo .L4
	lsr r27
	ror r26
	ror r25
	ror r24
	sbiw r24,8
	sbci r26,0
	sbci r27,0
	sbiw r26,0
	cpc r25,__zero_reg__
	brne .L4
	out 0,r24
	in r24,0x1
	andi r24,lo8(-4)
	out 0x1,r24
	ldi r24,lo8(4)
	out 0x36,r24
	ldi r24,0
	ldi r25,0
/* epilogue start */
	ret
	.size	I2C_InitMaster, .-I2C_InitMaster
	.section	.text.I2C_SendStart,"ax",@progbits
.global	I2C_SendStart
	.type	I2C_SendStart, @function
I2C_SendStart:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	ldi r24,lo8(-92)
	out 0x36,r24
	ldi r24,lo8(80)
	ldi r25,lo8(-61)
	ldi r26,0
	ldi r27,0
.L9:
	in __tmp_reg__,0x36
	sbrc __tmp_reg__,7
	rjmp .L8
	sbiw r24,1
	sbci r26,0
	sbci r27,0
	brne .L9
	ldi r24,lo8(1)
.L10:
	ldi r25,0
/* epilogue start */
	ret
.L8:
	in r25,0x1
	andi r25,lo8(-8)
	ldi r24,lo8(1)
	cpi r25,lo8(8)
	brne .L10
	ldi r24,0
	rjmp .L10
	.size	I2C_SendStart, .-I2C_SendStart
	.section	.text.I2C_SendRepeatedStart,"ax",@progbits
.global	I2C_SendRepeatedStart
	.type	I2C_SendRepeatedStart, @function
I2C_SendRepeatedStart:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	ldi r24,lo8(-92)
	out 0x36,r24
	ldi r24,lo8(80)
	ldi r25,lo8(-61)
	ldi r26,0
	ldi r27,0
.L16:
	in __tmp_reg__,0x36
	sbrc __tmp_reg__,7
	rjmp .L15
	sbiw r24,1
	sbci r26,0
	sbci r27,0
	brne .L16
	ldi r24,lo8(1)
.L17:
	ldi r25,0
/* epilogue start */
	ret
.L15:
	in r25,0x1
	andi r25,lo8(-8)
	ldi r24,lo8(1)
	cpi r25,lo8(16)
	brne .L17
	ldi r24,0
	rjmp .L17
	.size	I2C_SendRepeatedStart, .-I2C_SendRepeatedStart
	.section	.text.I2C_SendStop,"ax",@progbits
.global	I2C_SendStop
	.type	I2C_SendStop, @function
I2C_SendStop:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	ldi r24,lo8(-108)
	out 0x36,r24
	ldi r24,0
	ldi r25,0
.L23:
	in __tmp_reg__,0x36
	sbrs __tmp_reg__,4
	rjmp .L21
	adiw r24,1
	cpi r24,80
	ldi r18,-61
	cpc r25,r18
	brne .L23
.L21:
/* epilogue start */
	ret
	.size	I2C_SendStop, .-I2C_SendStop
	.section	.text.I2C_SendSlaveAddressWithWrite,"ax",@progbits
.global	I2C_SendSlaveAddressWithWrite
	.type	I2C_SendSlaveAddressWithWrite, @function
I2C_SendSlaveAddressWithWrite:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	sbrs r24,7
	rjmp .L30
.L34:
	ldi r24,lo8(1)
.L35:
	ldi r25,0
/* epilogue start */
	ret
.L30:
	lsl r24
	out 0x3,r24
	ldi r24,lo8(-124)
	out 0x36,r24
	ldi r24,lo8(80)
	ldi r25,lo8(-61)
	ldi r26,0
	ldi r27,0
.L33:
	in __tmp_reg__,0x36
	sbrc __tmp_reg__,7
	rjmp .L32
	sbiw r24,1
	sbci r26,0
	sbci r27,0
	brne .L33
	rjmp .L34
.L32:
	in r25,0x1
	andi r25,lo8(-8)
	ldi r24,lo8(1)
	cpi r25,lo8(24)
	brne .L35
	ldi r24,0
	rjmp .L35
	.size	I2C_SendSlaveAddressWithWrite, .-I2C_SendSlaveAddressWithWrite
	.section	.text.I2C_SendSlaveAddressWithRead,"ax",@progbits
.global	I2C_SendSlaveAddressWithRead
	.type	I2C_SendSlaveAddressWithRead, @function
I2C_SendSlaveAddressWithRead:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	sbrs r24,7
	rjmp .L39
.L43:
	ldi r24,lo8(1)
.L44:
	ldi r25,0
/* epilogue start */
	ret
.L39:
	lsl r24
	ori r24,lo8(1)
	out 0x3,r24
	ldi r24,lo8(-124)
	out 0x36,r24
	ldi r24,lo8(80)
	ldi r25,lo8(-61)
	ldi r26,0
	ldi r27,0
.L42:
	in __tmp_reg__,0x36
	sbrc __tmp_reg__,7
	rjmp .L41
	sbiw r24,1
	sbci r26,0
	sbci r27,0
	brne .L42
	rjmp .L43
.L41:
	in r25,0x1
	andi r25,lo8(-8)
	ldi r24,lo8(1)
	cpi r25,lo8(64)
	brne .L44
	ldi r24,0
	rjmp .L44
	.size	I2C_SendSlaveAddressWithRead, .-I2C_SendSlaveAddressWithRead
	.section	.text.I2C_SendByte,"ax",@progbits
.global	I2C_SendByte
	.type	I2C_SendByte, @function
I2C_SendByte:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	out 0x3,r24
	ldi r24,lo8(-124)
	out 0x36,r24
	ldi r24,lo8(80)
	ldi r25,lo8(-61)
	ldi r26,0
	ldi r27,0
.L49:
	in __tmp_reg__,0x36
	sbrc __tmp_reg__,7
	rjmp .L48
	sbiw r24,1
	sbci r26,0
	sbci r27,0
	brne .L49
	ldi r24,lo8(1)
.L50:
	ldi r25,0
/* epilogue start */
	ret
.L48:
	in r25,0x1
	andi r25,lo8(-8)
	ldi r24,lo8(1)
	cpi r25,lo8(40)
	brne .L50
	ldi r24,0
	rjmp .L50
	.size	I2C_SendByte, .-I2C_SendByte
	.section	.text.I2C_ReceiveByte,"ax",@progbits
.global	I2C_ReceiveByte
	.type	I2C_ReceiveByte, @function
I2C_ReceiveByte:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	movw r30,r24
	or r24,r25
	breq .L55
	cpi r22,lo8(1)
	brne .L56
	ldi r24,lo8(-60)
	out 0x36,r24
	ldi r20,lo8(80)
	ldi r21,lo8(-61)
	ldi r22,0
	ldi r23,0
.L58:
	in __tmp_reg__,0x36
	sbrc __tmp_reg__,7
	rjmp .L57
	subi r20,1
	sbci r21,0
	sbci r22,0
	sbci r23,0
	brne .L58
.L55:
	ldi r24,lo8(1)
	ldi r25,0
/* epilogue start */
	ret
.L56:
	brsh .L55
	ldi r24,lo8(-124)
	out 0x36,r24
	ldi r20,lo8(80)
	ldi r21,lo8(-61)
	ldi r22,0
	ldi r23,0
.L61:
	in __tmp_reg__,0x36
	sbrc __tmp_reg__,7
	rjmp .L60
	subi r20,1
	sbci r21,0
	sbci r22,0
	sbci r23,0
	brne .L61
	rjmp .L55
.L57:
	in r25,0x1
	andi r25,lo8(-8)
	cpi r25,lo8(80)
.L72:
	brne .L55
	in r24,0x3
	st Z,r24
	ldi r24,0
	ldi r25,0
	ret
.L60:
	in r25,0x1
	andi r25,lo8(-8)
	cpi r25,lo8(88)
	rjmp .L72
	.size	I2C_ReceiveByte, .-I2C_ReceiveByte
	.ident	"GCC: (GNU) 16.1.0"
