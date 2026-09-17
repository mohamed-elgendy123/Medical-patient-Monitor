	.file	"main.c"
__SP_H__ = 0x3e
__SP_L__ = 0x3d
__SREG__ = 0x3f
__tmp_reg__ = 0
__zero_reg__ = 1
	.text
	.section	.text.Task_FastVitals,"ax",@progbits
	.type	Task_FastVitals, @function
Task_FastVitals:
	push r11
	push r12
	push r13
	push r14
	push r15
	push r16
	push r17
	push r28
	push r29
	in r28,__SP_L__
	in r29,__SP_H__
	sbiw r28,40
	in __tmp_reg__,__SREG__
	cli
	out __SP_H__,r29
	out __SREG__,__tmp_reg__
	out __SP_L__,r28
/* prologue: function */
/* frame size = 40 */
/* stack size = 49 */
.L__stack_usage = 49
	movw r16,r28
	subi r16,-1
	sbci r17,-1
	ldi r24,lo8(24)
	movw r30,r16
	0:
	st Z+,__zero_reg__
	dec r24
	brne 0b
	ldi r24,lo8(1)
	std Y+40,r24
	std Y+39,r24
	std Y+38,r24
	movw r20,r28
	subi r20,-40
	sbci r21,-1
	ldi r22,lo8(3)
	ldi r24,lo8(3)
	call GPIO_GetPinValue
	movw r20,r28
	subi r20,-39
	sbci r21,-1
	ldi r22,lo8(5)
	ldi r24,lo8(3)
	call GPIO_GetPinValue
	movw r20,r28
	subi r20,-38
	sbci r21,-1
	ldi r22,lo8(2)
	ldi r24,lo8(3)
	call GPIO_GetPinValue
	ldd r12,Y+40
	ldd r13,Y+39
	ldd r11,Y+38
	movw r24,r16
	call Vitals_Read
	movw r16,r24
	or r24,r25
	breq .+2
	rjmp .L1
	clr r15
	inc r15
	cpse r12,__zero_reg__
	rjmp .L3
	mov r15,__zero_reg__
.L3:
	clr r14
	inc r14
	cpse r13,__zero_reg__
	rjmp .L4
	mov r14,__zero_reg__
.L4:
	clr r13
	inc r13
	cpse r11,__zero_reg__
	mov r13,__zero_reg__
.L5:
	cp r12, __zero_reg__
	breq .L7
	lds r24,g_u8HeartbeatActive
	cp r24, __zero_reg__
	breq .L7
	call HRC_IsAsystole
	cpse r24,__zero_reg__
	rjmp .L7
	call HRC_GetBpm
	movw r16,r24
.L7:
	ldi r24,0
	call PatientCfg_GetVital
	movw r30,r24
	or r24,r25
	breq .L9
	st Z,r16
	std Z+1,r17
	ldi r25,lo8(1)
	cp r16,__zero_reg__
	cpc r17,__zero_reg__
	brne .L10
	ldi r25,0
.L10:
	and r25,r15
	std Z+2,r25
.L9:
	ldi r24,lo8(1)
	call PatientCfg_GetVital
	sbiw r24,0
	breq .L11
	ldd r18,Y+5
	movw r30,r24
	st Z,r18
	std Z+1,__zero_reg__
	std Z+2,r14
.L11:
	ldi r24,lo8(2)
	call PatientCfg_GetVital
	sbiw r24,0
	breq .L12
	ldd r18,Y+6
	ldd r19,Y+7
	movw r30,r24
	st Z,r18
	std Z+1,r19
	ldi r18,lo8(1)
	std Z+2,r18
.L12:
	ldi r24,lo8(3)
	call PatientCfg_GetVital
	sbiw r24,0
	breq .L13
	ldd r18,Y+10
	movw r30,r24
	st Z,r18
	std Z+1,__zero_reg__
	ldi r18,lo8(1)
	std Z+2,r18
.L13:
	ldi r24,lo8(4)
	call PatientCfg_GetVital
	sbiw r24,0
	breq .L14
	ldd r18,Y+8
	movw r30,r24
	st Z,r18
	std Z+1,__zero_reg__
	ldi r18,lo8(1)
	std Z+2,r18
.L14:
	call PatientCfg_EvalAlarms
	std Y+25,r16
	std Y+26,r17
	ldd r24,Y+5
	std Y+27,r24
	ldd r24,Y+10
	std Y+28,r24
	ldd r24,Y+6
	ldd r25,Y+7
	std Y+29,r24
	std Y+30,r25
	ldd r24,Y+8
	std Y+31,r24
	std Y+32,__zero_reg__
	ldd r24,Y+9
	std Y+33,r24
	std Y+34,__zero_reg__
	std Y+35,r14
	std Y+36,r15
	std Y+37,r13
	movw r24,r28
	adiw r24,25
	call Alarm_UpdateVitals
.L1:
/* epilogue start */
	adiw r28,40
	in __tmp_reg__,__SREG__
	cli
	out __SP_H__,r29
	out __SREG__,__tmp_reg__
	out __SP_L__,r28
	pop r29
	pop r28
	pop r17
	pop r16
	pop r15
	pop r14
	pop r13
	pop r12
	pop r11
	ret
	.size	Task_FastVitals, .-Task_FastVitals
	.section	.rodata.main.str1.1,"aMS",@progbits,1
.LC0:
	.string	"=== SYSTEM SELF-TEST ===\r\n"
.LC1:
	.string	"PATIENT MONITOR "
.LC2:
	.string	"SELF-TEST...    "
.LC3:
	.string	"PATIENT MONITOR READY\r\n"
.LC4:
	.string	"!DAT,%d,%d,%d.%d,%d,%d,0x%04X\r\n"
	.section	.text.startup.main,"ax",@progbits
.global	main
	.type	main, @function
main:
	in r28,__SP_L__
	in r29,__SP_H__
	subi r28,64
	sbc r29,__zero_reg__
	in __tmp_reg__,__SREG__
	cli
	out __SP_H__,r29
	out __SREG__,__tmp_reg__
	out __SP_L__,r28
/* prologue: function */
/* frame size = 64 */
/* stack size = 64 */
.L__stack_usage = 64
	ldi r20,lo8(1)
	ldi r22,lo8(7)
	ldi r24,lo8(2)
	call GPIO_SetPinDirection
	ldi r20,0
	ldi r22,lo8(7)
	ldi r24,lo8(2)
	call GPIO_SetPinValue
	ldi r20,lo8(1)
	ldi r22,lo8(7)
	ldi r24,lo8(3)
	call GPIO_SetPinDirection
	ldi r20,lo8(2)
	ldi r22,lo8(2)
	ldi r24,lo8(3)
	call GPIO_SetPinDirection
	ldi r20,lo8(2)
	ldi r22,lo8(3)
	ldi r24,lo8(3)
	call GPIO_SetPinDirection
	ldi r20,lo8(2)
	ldi r22,lo8(5)
	ldi r24,lo8(3)
	call GPIO_SetPinDirection
	ldi r20,0
	ldi r22,lo8(6)
	ldi r24,lo8(3)
	call GPIO_SetPinDirection
	call TIMER0_Init
	call HRC_Init
	call Vitals_Init
	call ShiftReg_voidInit
	call NurseCall_voidInit
	call ANN_Audio_Init
	call ANN_Visual_Init
	call Panel_Init
	call PatientCfg_Init
	call Monitor_Init
	call CONSOLE_Init
	call Trends_Init
	ldi r22,lo8(-96)
	ldi r23,lo8(-122)
	ldi r24,lo8(1)
	ldi r25,0
	call I2C_InitMaster
	call LCD_I2C_Init
	call Menu_Init
	ldi r22,lo8(-128)
	ldi r23,lo8(37)
	ldi r24,0
	ldi r25,0
	call UART_Init
	ldi r20,lo8(1)
	ldi r22,0
	ldi r24,lo8(1)
	call GPIO_SetPinValue
	ldi r20,lo8(1)
	ldi r22,lo8(1)
	ldi r24,lo8(1)
	call GPIO_SetPinValue
	ldi r20,lo8(1)
	ldi r22,lo8(2)
	ldi r24,lo8(1)
	call GPIO_SetPinValue
	ldi r20,lo8(1)
	ldi r22,lo8(3)
	ldi r24,lo8(1)
	call GPIO_SetPinValue
	call NurseCall_voidEnable
	ldi r24,lo8(-1)
	call ShiftReg_voidWriteByte
	ldi r24,lo8(2)
	call ANN_Audio_SetPriority
	ldi r24,lo8(.LC0)
	ldi r25,hi8(.LC0)
	call UART_SendString
	ldi r22,0
	ldi r24,0
	call LCD_I2C_SetCursor
	ldi r24,lo8(.LC1)
	ldi r25,hi8(.LC1)
	call LCD_I2C_WriteString
	ldi r22,0
	ldi r24,lo8(1)
	call LCD_I2C_SetCursor
	ldi r24,lo8(.LC2)
	ldi r25,hi8(.LC2)
	call LCD_I2C_WriteString
	ldi r18,lo8(159999)
	ldi r24,hi8(159999)
	ldi r25,hlo8(159999)
1:	subi r18,1
	sbci r24,0
	sbci r25,0
	brne 1b
	rjmp .
	nop
	call ANN_Audio_Mute
	ldi r26,lo8(319999)
	ldi r27,hi8(319999)
	ldi r18,hlo8(319999)
1:	subi r26,1
	sbci r27,0
	sbci r18,0
	brne 1b
	rjmp .
	nop
	ldi r20,0
	ldi r22,0
	ldi r24,lo8(1)
	call GPIO_SetPinValue
	ldi r20,0
	ldi r22,lo8(1)
	ldi r24,lo8(1)
	call GPIO_SetPinValue
	ldi r20,0
	ldi r22,lo8(2)
	ldi r24,lo8(1)
	call GPIO_SetPinValue
	ldi r20,0
	ldi r22,lo8(3)
	ldi r24,lo8(1)
	call GPIO_SetPinValue
	call NurseCall_voidDisable
	ldi r24,0
	call ShiftReg_voidWriteByte
	call ANN_Audio_Init
	call ANN_Visual_Init
	call HRC_ClearAsystole
	call LCD_I2C_Clear
	ldi r24,lo8(.LC3)
	ldi r25,hi8(.LC3)
	call UART_SendString
	call INTERRUPT_EnableGlobal
	call HRC_ClearAsystole
	call TIMER0_ClearTick
	ldi r24,lo8(-1)
	out 0x38,r24
	call Task_FastVitals
	call Alarm_Process
	call Menu_Update
	ldi r16,0
	ldi r17,0
	movw r4,r28
	ldi r24,-1
	sub r4,r24
	sbc r5,r24
	ldi r24,lo8(5)
	mov r3,r24
.L37:
	ldi r20,lo8(1)
	ldi r22,lo8(7)
	ldi r24,lo8(2)
	call GPIO_SetPinValue
	std Y+1,__zero_reg__
	movw r20,r4
	ldi r22,lo8(6)
	ldi r24,lo8(3)
	call GPIO_GetPinValue
	lds r24,s_u8PrevPD6.2
	cpse r24,__zero_reg__
	rjmp .L38
	ldd r24,Y+1
	cp r24, __zero_reg__
	breq .L38
	ldi r20,lo8(1)
	ldi r22,lo8(3)
	ldi r24,lo8(1)
	call GPIO_SetPinValue
	sts s_u8HbPulseTicks.1,r3
	ldi r24,lo8(1)
	sts g_u8HeartbeatActive,r24
	call HRC_ClearAsystole
	sts s_u16SilenceTicks.0,__zero_reg__
	sts s_u16SilenceTicks.0+1,__zero_reg__
.L38:
	ldd r24,Y+1
	sts s_u8PrevPD6.2,r24
	lds r24,s_u16SilenceTicks.0
	lds r25,s_u16SilenceTicks.0+1
	adiw r24,1
	sts s_u16SilenceTicks.0,r24
	sts s_u16SilenceTicks.0+1,r25
	cpi r24,-111
	sbci r25,1
	brlo .L39
	sts g_u8HeartbeatActive,__zero_reg__
.L39:
	lds r24,s_u8HbPulseTicks.1
	cp r24, __zero_reg__
	breq .L41
	subi r24,lo8(-(-1))
	sts s_u8HbPulseTicks.1,r24
	cpse r24,__zero_reg__
	rjmp .L41
	ldi r20,0
	ldi r22,lo8(3)
	ldi r24,lo8(1)
	call GPIO_SetPinValue
.L41:
	call TIMER1_IsCaptureReady
	cpse r24,__zero_reg__
	call ANN_Visual_TriggerHeartbeat
.L43:
	call HRC_Process
	call Panel_Update
	call Panel_HasEvent
	mov r15,r24
	sbrc r16,0
	call CONSOLE_Task
.L44:
	movw r24,r16
	ldi r22,lo8(5)
	ldi r23,0
	call __udivmodhi4
	sbiw r24,2
	breq .L45
	cp r15, __zero_reg__
	breq .L46
.L45:
	ldi r24,0
	call Panel_IsPressed
	cpse r24,__zero_reg__
	call Alarm_Acknowledge
.L47:
	ldi r24,lo8(4)
	call Panel_IsPressed
	cpse r24,__zero_reg__
	call Monitor_ToggleStandby
.L48:
	call Menu_IsInDashboard
	cp r24, __zero_reg__
	breq .L46
	ldi r24,lo8(2)
	call Panel_IsPressed
	ldi r24,lo8(3)
	call Panel_IsPressed
.L46:
	movw r24,r16
	ldi r22,lo8(10)
	ldi r23,0
	call __udivmodhi4
	sbiw r24,3
	brne .L50
	call Alarm_Process
.L50:
	movw r24,r16
	ldi r22,lo8(25)
	ldi r23,0
	call __udivmodhi4
	sbiw r24,5
	breq .L51
	cp r15, __zero_reg__
	breq .L52
	lds r24,s_u8LcdCooldown.3
	cpse r24,__zero_reg__
	rjmp .L52
.L51:
	call Menu_Update
	sts s_u8LcdCooldown.3,r3
.L52:
	lds r24,s_u8LcdCooldown.3
	cp r24, __zero_reg__
	breq .L53
	subi r24,lo8(-(-1))
	sts s_u8LcdCooldown.3,r24
.L53:
	movw r24,r16
	ldi r22,lo8(50)
	ldi r23,0
	call __udivmodhi4
	sbiw r24,4
	brne .L54
	call Task_FastVitals
.L54:
	movw r24,r16
	ldi r22,lo8(-56)
	ldi r23,0
	call __udivmodhi4
	sbiw r24,7
	breq .+2
	rjmp .L55
	ldi r24,0
	call PatientCfg_GetVital
	movw r10,r24
	ldi r24,lo8(1)
	call PatientCfg_GetVital
	movw r12,r24
	ldi r24,lo8(2)
	call PatientCfg_GetVital
	movw r8,r24
	ldi r24,lo8(3)
	call PatientCfg_GetVital
	movw r14,r24
	ldi r24,lo8(4)
	call PatientCfg_GetVital
	movw r6,r24
	call Alarm_GetActiveFlags
	movw r30,r24
	cp r10,__zero_reg__
	cpc r11,__zero_reg__
	brne .+2
	rjmp .L66
	movw r26,r10
	adiw r26,2
	ld r24,X
	sbiw r26,2
	cp r24, __zero_reg__
	brne .+2
	rjmp .L66
	ld r18,X+
	ld r19,X
.L56:
	cp r12,__zero_reg__
	cpc r13,__zero_reg__
	brne .+2
	rjmp .L68
	movw r26,r12
	adiw r26,2
	ld r24,X
	sbiw r26,2
	cp r24, __zero_reg__
	brne .+2
	rjmp .L68
	ld r20,X+
	ld r13,X
.L57:
	cp r8,__zero_reg__
	cpc r9,__zero_reg__
	brne .+2
	rjmp .L70
	movw r26,r8
	adiw r26,2
	ld r24,X
	sbiw r26,2
	cp r24, __zero_reg__
	brne .+2
	rjmp .L70
	ld r24,X+
	ld r25,X+
.L58:
	cp r14,__zero_reg__
	cpc r15,__zero_reg__
	brne .+2
	rjmp .L72
	movw r26,r14
	adiw r26,2
	ld r21,X
	sbiw r26,2
	cp r21, __zero_reg__
	brne .+2
	rjmp .L72
	ld r12,X+
	ld r15,X
.L59:
	cp r6,__zero_reg__
	cpc r7,__zero_reg__
	brne .+2
	rjmp .L74
	movw r26,r6
	adiw r26,2
	ld r21,X
	sbiw r26,2
	cp r21, __zero_reg__
	brne .+2
	rjmp .L74
	ld r14,X+
	ld r11,X
.L60:
	ldi r22,lo8(10)
	ldi r23,0
	call __divmodhi4
	push r31
	push r30
	push r11
	push r14
	push r15
	push r12
	movw r30,r24
	sbrs r25,7
	rjmp .L61
	neg r31
	neg r30
	sbc r31,__zero_reg__
.L61:
	push r31
	push r30
	push r23
	push r22
	push r13
	push r20
	push r19
	push r18
	ldi r24,lo8(.LC4)
	ldi r25,hi8(.LC4)
	push r25
	push r24
	push r5
	push r4
	call sprintf
	movw r24,r4
	call UART_SendString
	in __tmp_reg__,__SREG__
	cli
	out __SP_H__,r29
	out __SREG__,__tmp_reg__
	out __SP_L__,r28
.L55:
	cpi r16,8
	cpc r17,__zero_reg__
	brne .L62
	call Task_Trend
.L62:
	call Monitor_Run
	call ANN_Audio_Tick
	call ANN_Visual_Tick
	ldi r20,0
	ldi r22,lo8(7)
	ldi r24,lo8(2)
	call GPIO_SetPinValue
	ldi r26,lo8(19999)
	ldi r27,hi8(19999)
1:	sbiw r26,1
	brne 1b
	rjmp .
	nop
	subi r16,-1
	sbci r17,-1
	cpi r16,-24
	ldi r27,3
	cpc r17,r27
	breq .+2
	rjmp .L37
	ldi r16,0
	ldi r17,0
	rjmp .L37
.L66:
	ldi r18,0
	ldi r19,0
	rjmp .L56
.L68:
	ldi r20,0
	mov r13,__zero_reg__
	rjmp .L57
.L70:
	ldi r24,0
	ldi r25,0
	rjmp .L58
.L72:
	mov r12,__zero_reg__
	mov r15,__zero_reg__
	rjmp .L59
.L74:
	mov r14,__zero_reg__
	mov r11,__zero_reg__
	rjmp .L60
	.size	main, .-main
	.section	.bss.s_u16SilenceTicks.0,"aw",@nobits
	.type	s_u16SilenceTicks.0, @object
	.size	s_u16SilenceTicks.0, 2
s_u16SilenceTicks.0:
	.zero	2
	.section	.bss.s_u8HbPulseTicks.1,"aw",@nobits
	.type	s_u8HbPulseTicks.1, @object
	.size	s_u8HbPulseTicks.1, 1
s_u8HbPulseTicks.1:
	.zero	1
	.section	.bss.s_u8PrevPD6.2,"aw",@nobits
	.type	s_u8PrevPD6.2, @object
	.size	s_u8PrevPD6.2, 1
s_u8PrevPD6.2:
	.zero	1
	.section	.bss.s_u8LcdCooldown.3,"aw",@nobits
	.type	s_u8LcdCooldown.3, @object
	.size	s_u8LcdCooldown.3, 1
s_u8LcdCooldown.3:
	.zero	1
	.section	.bss.g_u8HeartbeatActive,"aw",@nobits
	.type	g_u8HeartbeatActive, @object
	.size	g_u8HeartbeatActive, 1
g_u8HeartbeatActive:
	.zero	1
	.ident	"GCC: (GNU) 15.2.0"
.global __do_copy_data
.global __do_clear_bss
