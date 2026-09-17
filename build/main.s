	.file	"main.c"
__SP_H__ = 0x3e
__SP_L__ = 0x3d
__SREG__ = 0x3f
__tmp_reg__ = 0
__zero_reg__ = 1
	.text
<<<<<<< HEAD
<<<<<<< HEAD
	.section	.rodata.main.str1.1,"aMS",@progbits,1
.LC0:
	.string	"STANDBY MODE    "
.LC1:
	.string	"MONITORING OFF  "
.LC2:
	.string	"HR:--- SpO2:--- "
.LC3:
	.string	"HR:--- SpO2:100%%"
.LC4:
	.string	"HR:--- SpO2:%2u%% "
.LC5:
	.string	"HR:%3u SpO2:--- "
.LC6:
	.string	"HR:%3u SpO2:100%%"
.LC7:
	.string	"HR:%3u SpO2:%2u%% "
.LC8:
	.string	"!  ASYSTOLE   !"
.LC9:
	.string	"!  LEAD OFF   !"
.LC10:
	.string	"!  PROBE OFF  !"
.LC11:
	.string	"! HR CRIT HIGH !"
.LC12:
	.string	"! HR CRIT LOW  !"
.LC13:
	.string	"!SPO2 CRIT LOW !"
.LC14:
	.string	"!RR CRIT HIGH  !"
.LC15:
	.string	"! RR CRIT LOW  !"
.LC16:
	.string	"!  TEMP HIGH   !"
.LC17:
	.string	"!   TEMP LOW   !"
.LC18:
	.string	"!   BP HIGH    !"
.LC19:
	.string	"!    BP LOW    !"
.LC20:
	.string	"! HR HIGH WARN !"
.LC21:
	.string	"! HR LOW WARN  !"
.LC22:
	.string	"!SPO2 LOW WARN !"
.LC23:
	.string	" !ALARM BANNER! "
.LC24:
	.string	"T%2u.%u %3u/%2u R%2u"
=======
	.section	.rodata
.LC0:
	.word	160
	.byte	82
	.byte	18
	.word	370
	.word	120
	.word	80
	.byte	1
	.byte	1
>>>>>>> d9c22b66226e0b37b25c4d23605075309880d886
	.section	.text.startup.main,"ax",@progbits
.global	main
	.type	main, @function
main:
	in r28,__SP_L__
	in r29,__SP_H__
<<<<<<< HEAD
	sbiw r28,42
=======
	sbiw r28,14
>>>>>>> d9c22b66226e0b37b25c4d23605075309880d886
=======
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
	.section	.rodata.Send_Telemetry_Frame.str1.1,"aMS",@progbits,1
.LC0:
	.string	"PM,ID=BED0012,HR=%d,HV=%d,SP=%d,T=%d,NS=%d,ND=%d,RR=%d,AL=%04X,PRI=0,ST=MON,SIL=0,UP=3600"
.LC1:
	.string	"$%s*%02X\r\n"
	.section	.text.Send_Telemetry_Frame,"ax",@progbits
	.type	Send_Telemetry_Frame, @function
Send_Telemetry_Frame:
	push r8
	push r9
	push r10
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
	subi r28,-16
	sbc r29,__zero_reg__
>>>>>>> bc2a737000a66a64e11cd2e17089e177312200fa
	in __tmp_reg__,__SREG__
	cli
	out __SP_H__,r29
	out __SREG__,__tmp_reg__
	out __SP_L__,r28
/* prologue: function */
<<<<<<< HEAD
<<<<<<< HEAD
/* frame size = 42 */
/* stack size = 42 */
.L__stack_usage = 42
	in r24,0x34
	ori r24,lo8(-128)
	out 0x34,r24
	in r24,0x34
	ori r24,lo8(-128)
	out 0x34,r24
	in r24,0x14
	andi r24,lo8(-125)
	out 0x14,r24
	in r24,0x15
	ori r24,lo8(124)
	out 0x15,r24
	in r24,0x11
	andi r24,lo8(-41)
	out 0x11,r24
	in r24,0x12
	ori r24,lo8(40)
	out 0x12,r24
	cbi 0x11,6
	cbi 0x12,6
	in r24,0x1a
	andi r24,lo8(-16)
	out 0x1a,r24
	in r24,0x1b
	andi r24,lo8(-16)
	out 0x1b,r24
	in r24,0x17
	ori r24,lo8(15)
	out 0x17,r24
	in r24,0x18
	andi r24,lo8(-16)
	out 0x18,r24
	sbi 0x14,7
	cbi 0x15,7
=======
/* frame size = 240 */
/* stack size = 252 */
.L__stack_usage = 252
	ldi r24,0
	call PatientCfg_GetVital
	movw r8,r24
	ldi r24,lo8(1)
	call PatientCfg_GetVital
	movw r10,r24
	ldi r24,lo8(2)
	call PatientCfg_GetVital
	movw r12,r24
	ldi r24,lo8(3)
	call PatientCfg_GetVital
	movw r14,r24
	ldi r24,lo8(4)
	call PatientCfg_GetVital
	movw r16,r24
	call Alarm_GetActiveFlags
	cp r8,__zero_reg__
	cpc r9,__zero_reg__
	brne .+2
	rjmp .L44
	movw r26,r8
	adiw r26,2
	ld r18,X
	sbiw r26,2
	cp r18, __zero_reg__
	brne .+2
	rjmp .L45
	ld r18,X+
	ld r19,X
.L37:
	cp r10,__zero_reg__
	cpc r11,__zero_reg__
	brne .+2
	rjmp .L46
	movw r30,r10
	ldd r20,Z+2
	cp r20, __zero_reg__
	brne .+2
	rjmp .L47
	ld r20,Z
	ldd r21,Z+1
.L38:
	cp r12,__zero_reg__
	cpc r13,__zero_reg__
	brne .+2
	rjmp .L48
	movw r26,r12
	adiw r26,2
	ld r22,X
	sbiw r26,2
	cp r22, __zero_reg__
	brne .+2
	rjmp .L49
	ld r22,X+
	ld r23,X
.L39:
	cp r14,__zero_reg__
	cpc r15,__zero_reg__
	brne .+2
	rjmp .L51
	movw r26,r14
	adiw r26,2
	ld r30,X
	sbiw r26,2
	cp r30, __zero_reg__
	brne .+2
	rjmp .L51
	ld r26,X
	movw r30,r14
	ldd r27,Z+1
.L40:
	cp r16,__zero_reg__
	cpc r17,__zero_reg__
	brne .+2
	rjmp .L52
	movw r30,r16
	ldd r15,Z+2
	cp r15, __zero_reg__
	brne .+2
	rjmp .L53
	ld r15,Z
	ldd r17,Z+1
.L41:
	push r25
	push r24
	push r27
	push r26
	push __zero_reg__
	ldi r24,lo8(80)
	push r24
	push r17
	push r15
	push r23
	push r22
	push r21
	push r20
	push __zero_reg__
	ldi r24,lo8(38)
	push r24
	push r19
	push r18
	ldi r24,lo8(.LC0)
	ldi r25,hi8(.LC0)
	push r25
	push r24
	movw r16,r28
	subi r16,125
	sbci r17,-1
	push r17
	push r16
	call sprintf
	movw r30,r16
	in __tmp_reg__,__SREG__
	cli
	out __SP_H__,r29
	out __SREG__,__tmp_reg__
	out __SP_L__,r28
	ldi r24,0
	movw r18,r16
.L42:
	ld r25,Z
	cpse r25,__zero_reg__
	rjmp .L43
	push __zero_reg__
	push r24
	push r19
	push r18
	ldi r24,lo8(.LC1)
	ldi r25,hi8(.LC1)
	push r25
	push r24
	movw r16,r28
	subi r16,-1
	sbci r17,-1
	push r17
	push r16
	call sprintf
	movw r24,r16
	call UART_SendString
	in __tmp_reg__,__SREG__
	cli
	out __SP_H__,r29
	out __SREG__,__tmp_reg__
	out __SP_L__,r28
/* epilogue start */
	subi r28,16
	sbci r29,-1
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
	pop r10
	pop r9
	pop r8
	ret
.L44:
	ldi r18,0
.L45:
	ldi r19,0
	rjmp .L37
.L46:
	ldi r20,0
.L47:
	ldi r21,0
	rjmp .L38
.L48:
	ldi r22,0
.L49:
	ldi r23,0
	rjmp .L39
.L51:
	ldi r26,0
	ldi r27,0
	rjmp .L40
.L52:
	mov r15,__zero_reg__
.L53:
	ldi r17,0
	rjmp .L41
.L43:
	adiw r30,1
	eor r24,r25
	rjmp .L42
	.size	Send_Telemetry_Frame, .-Send_Telemetry_Frame
	.section	.rodata.main.str1.1,"aMS",@progbits,1
.LC2:
	.string	"=== SYSTEM SELF-TEST ===\r\n"
.LC3:
	.string	"PATIENT MONITOR "
.LC4:
	.string	"SELF-TEST...    "
.LC5:
	.string	"PATIENT MONITOR READY\r\n"
.LC6:
	.string	"OK\r\n"
	.section	.text.startup.main,"ax",@progbits
.global	main
	.type	main, @function
main:
	rcall .
	push __tmp_reg__
	in r28,__SP_L__
	in r29,__SP_H__
/* prologue: function */
/* frame size = 3 */
/* stack size = 3 */
.L__stack_usage = 3
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
>>>>>>> bc2a737000a66a64e11cd2e17089e177312200fa
	ldi r22,lo8(-96)
	ldi r23,lo8(-122)
	ldi r24,lo8(1)
	ldi r25,0
	call I2C_InitMaster
	call LCD_I2C_Init
	call LCD_I2C_Clear
	call LCD_I2C_BacklightOn
=======
/* frame size = 14 */
/* stack size = 14 */
.L__stack_usage = 14
	ldi r20,lo8(1)
	ldi r22,lo8(7)
	ldi r24,lo8(2)
<<<<<<< HEAD
	call GPIO_SetPinDirection
	ldi r20,0
	ldi r22,lo8(7)
	ldi r24,lo8(2)
	call GPIO_SetPinValue
>>>>>>> d9c22b66226e0b37b25c4d23605075309880d886
	call TIMER0_Init
	call HRC_Init
	call Vitals_Init
	call Panel_Init
	call PatientCfg_Init
	call Menu_Init
	call Alarm_Init
	call ANN_Audio_Init
	call ANN_Visual_Init
	call NurseCall_voidInit
	call ShiftReg_voidInit
	call INTERRUPT_EnableGlobal
<<<<<<< HEAD
	movw r14,r28
	ldi r24,-1
	sub r14,r24
	sbc r15,r24
	movw r16,r28
	subi r16,-22
	sbci r17,-1
.L2:
	call TIMER0_IsTickPending
	cpi r24,lo8(0)
	breq .L2
	call TIMER0_ClearTick
	sbi 0x15,7
	call TIMER1_IsCaptureReady
	cpse r24,__zero_reg__
	rjmp .L3
	call HRC_Process
.L4:
	call ANN_Audio_Tick
	call ANN_Visual_Tick
	lds r24,g_schedulerPhase
	lds r25,g_schedulerPhase+1
	sbrs r24,0
	rjmp .L5
	call Panel_Update
	ldi r24,0
	call Panel_IsPressed
	cpi r24,lo8(0)
	breq .L6
	call ANN_Audio_Mute
	call Alarm_Acknowledge
.L6:
	ldi r24,lo8(4)
	call Panel_IsPressed
	cpi r24,lo8(0)
	breq .L7
	call Menu_IsInDashboard
	cpse r24,__zero_reg__
	rjmp .L8
	call Menu_Init
	call LCD_I2C_Clear
.L9:
	sts g_lastLine0,__zero_reg__
	sts g_lastLine1,__zero_reg__
.L7:
	call Menu_Update
.L5:
	lds r24,g_schedulerPhase
	lds r25,g_schedulerPhase+1
=======
	ldi r16,0
	ldi r17,0
.L3:
	call TIMER0_IsTickPending
	cp r24, __zero_reg__
	breq .L3
	call TIMER0_ClearTick
	subi r16,-1
	sbci r17,-1
	call ANN_Audio_Tick
	call ANN_Visual_Tick
	cpi r16,50
	cpc r17,__zero_reg__
	brne .L4
	call ANN_Audio_Mute
	rjmp .L3
.L4:
	cpi r16,44
	ldi r24,1
	cpc r17,r24
	brne .L3
	call INTERRUPT_DisableGlobal
	call ANN_Audio_Init
	call ANN_Visual_Init
	call NurseCall_voidDisable
	ldi r24,0
	call ShiftReg_voidWriteByte
	ldi r24,0
	call ANN_Audio_SetPriority
	ldi r24,0
	call ANN_Visual_SetPriority
	call NurseCall_voidDisable
=======
	call ANN_Audio_SetPriority
	ldi r24,lo8(.LC2)
	ldi r25,hi8(.LC2)
	call UART_SendString
	ldi r22,0
	ldi r24,0
	call LCD_I2C_SetCursor
	ldi r24,lo8(.LC3)
	ldi r25,hi8(.LC3)
	call LCD_I2C_WriteString
	ldi r22,0
	ldi r24,lo8(1)
	call LCD_I2C_SetCursor
	ldi r24,lo8(.LC4)
	ldi r25,hi8(.LC4)
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
	ldi r18,lo8(319999)
	ldi r24,hi8(319999)
	ldi r25,hlo8(319999)
1:	subi r18,1
	sbci r24,0
	sbci r25,0
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
	ldi r24,lo8(.LC5)
	ldi r25,hi8(.LC5)
	call UART_SendString
	call INTERRUPT_EnableGlobal
>>>>>>> bc2a737000a66a64e11cd2e17089e177312200fa
	call HRC_ClearAsystole
	call TIMER0_ClearTick
	call INTERRUPT_EnableGlobal
.L19:
	ldi r16,0
	ldi r17,0
<<<<<<< HEAD
.L7:
	call TIMER0_IsTickPending
	cp r24, __zero_reg__
	breq .L7
	call TIMER0_ClearTick
=======
	movw r14,r28
	ldi r18,-1
	sub r14,r18
	sbc r15,r18
	ldi r24,lo8(5)
	mov r13,r24
.L55:
>>>>>>> bc2a737000a66a64e11cd2e17089e177312200fa
	ldi r20,lo8(1)
	ldi r22,lo8(7)
	ldi r24,lo8(2)
	call GPIO_SetPinValue
<<<<<<< HEAD
=======
	std Y+1,__zero_reg__
	movw r20,r14
	ldi r22,lo8(6)
	ldi r24,lo8(3)
	call GPIO_GetPinValue
	lds r24,s_u8PrevPD6.2
	std Y+2,r14
	std Y+3,r15
	cpse r24,__zero_reg__
	rjmp .L56
	ldd r24,Y+1
	cp r24, __zero_reg__
	breq .L56
	ldi r20,lo8(1)
	ldi r22,lo8(3)
	ldi r24,lo8(1)
	call GPIO_SetPinValue
	sts s_u8HbPulseTicks.1,r13
	ldi r24,lo8(1)
	sts g_u8HeartbeatActive,r24
	call HRC_ClearAsystole
	sts s_u16SilenceTicks.0,__zero_reg__
	sts s_u16SilenceTicks.0+1,__zero_reg__
.L56:
	ldd r24,Y+1
	sts s_u8PrevPD6.2,r24
	lds r24,s_u16SilenceTicks.0
	lds r25,s_u16SilenceTicks.0+1
	adiw r24,1
	sts s_u16SilenceTicks.0,r24
	sts s_u16SilenceTicks.0+1,r25
	cpi r24,-111
	sbci r25,1
	brlo .L57
	sts g_u8HeartbeatActive,__zero_reg__
.L57:
	lds r24,s_u8HbPulseTicks.1
	cp r24, __zero_reg__
	breq .L59
	subi r24,lo8(-(-1))
	sts s_u8HbPulseTicks.1,r24
	cpse r24,__zero_reg__
	rjmp .L59
	ldi r20,0
	ldi r22,lo8(3)
	ldi r24,lo8(1)
	call GPIO_SetPinValue
.L59:
	call TIMER1_IsCaptureReady
	cpse r24,__zero_reg__
	call ANN_Visual_TriggerHeartbeat
.L61:
	call HRC_Process
	call Panel_Update
	call Panel_HasEvent
	mov r12,r24
	sbrc r16,0
	call CONSOLE_Task
.L62:
>>>>>>> bc2a737000a66a64e11cd2e17089e177312200fa
	movw r24,r16
>>>>>>> d9c22b66226e0b37b25c4d23605075309880d886
	ldi r22,lo8(5)
	ldi r23,0
	call __udivmodhi4
<<<<<<< HEAD
	or r24,r25
	brne .L11
	lds r24,Heartbeat_Counter
<<<<<<< HEAD
	cpi r24,lo8(0)
	brne .+2
	rjmp .L12
	subi r24,lo8(-(-1))
	sts Heartbeat_Counter,r24
	sbi 0x18,3
.L11:
	lds r24,g_schedulerPhase
	lds r25,g_schedulerPhase+1
	ldi r22,lo8(10)
	ldi r23,0
	call __udivmodhi4
	sbiw r24,3
	brne .L13
	lds r24,g_standbyActive
	cpi r24,lo8(0)
	brne .+2
	rjmp .L14
	ldi r24,0
	call ANN_Audio_SetPriority
	ldi r24,0
	call ANN_Visual_SetPriority
	call NurseCall_voidDisable
.L13:
	lds r24,g_schedulerPhase
	lds r25,g_schedulerPhase+1
	ldi r22,lo8(10)
	ldi r23,0
	call __udivmodhi4
	sbiw r24,7
	brne .L17
	ldi r24,lo8(g_vitals)
	ldi r25,hi8(g_vitals)
	call Vitals_Read
	call Menu_IsInDashboard
	cpse r24,__zero_reg__
	rjmp .L18
	sts g_lastLine0,__zero_reg__
	sts g_lastLine1,__zero_reg__
.L17:
	cbi 0x15,7
	lds r24,g_schedulerPhase
	lds r25,g_schedulerPhase+1
	adiw r24,1
	sts g_schedulerPhase,r24
	sts g_schedulerPhase+1,r25
	cpi r24,-24
	sbci r25,3
	brsh .+2
	rjmp .L2
	sts g_schedulerPhase,__zero_reg__
	sts g_schedulerPhase+1,__zero_reg__
	rjmp .L2
.L3:
	call TIMER1_GetLastInterval
	movw r12,r24
	call HRC_Process
	or r12,r13
	brne .+2
	rjmp .L4
	ldi r24,lo8(3)
	sts Heartbeat_Counter,r24
	rjmp .L4
.L8:
	lds r24,g_standbyActive
	cpse r24,__zero_reg__
	rjmp .L10
	ldi r24,lo8(1)
	sts g_standbyActive,r24
	ldi r24,0
	call ANN_Audio_SetPriority
	ldi r24,0
	call ANN_Visual_SetPriority
	call NurseCall_voidDisable
	rjmp .L9
.L10:
	sts g_standbyActive,__zero_reg__
	rjmp .L9
.L12:
	cbi 0x18,3
	rjmp .L11
.L14:
	ldi r24,lo8(g_vitals)
	ldi r25,hi8(g_vitals)
	call Vitals_Read
	call HRC_GetBpm
	mov r13,r24
	mov r12,r25
	call HRC_IsAsystole
	cpi r24,lo8(0)
	breq .L15
	mov r12,__zero_reg__
	mov r13,__zero_reg__
.L15:
	std Y+1,r13
	std Y+2,r12
	lds r24,g_vitals+4
	std Y+3,r24
	lds r24,g_vitals+9
	std Y+4,r24
	lds r24,g_vitals+5
	lds r25,g_vitals+6
	std Y+5,r24
	std Y+6,r25
	lds r24,g_vitals+7
	std Y+7,r24
	std Y+8,__zero_reg__
	lds r24,g_vitals+8
	std Y+9,r24
	std Y+10,__zero_reg__
	clr r24
	sbic 0x10,3
	inc r24
	std Y+12,r24
	clr r24
	sbic 0x10,5
	inc r24
	std Y+11,r24
	movw r24,r14
	call Alarm_UpdateVitals
	call Alarm_Process
	call Panel_IsSilenceActive
	cpi r24,lo8(0)
	brne .+2
	rjmp .L13
	call ANN_Audio_Mute
	rjmp .L13
.L18:
	lds r13,g_standbyActive
	mov r10,r14
	mov r9,r15
	cp r13,__zero_reg__
	breq .L19
	ldi r22,lo8(.LC0)
	ldi r23,hi8(.LC0)
	movw r24,r16
	call strcpy
	ldi r22,lo8(.LC1)
	ldi r23,hi8(.LC1)
	movw r24,r14
.L88:
	call strcpy
.L20:
	movw r26,r16
	ldi r30,lo8(g_lastLine0)
	ldi r31,hi8(g_lastLine0)
/* #APP */
 ;  698 "C:/Users/amazon/AppData/Local/Microsoft/WinGet/Packages/ZakKemble.avr-gcc_Microsoft.Winget.Source_8wekyb3d8bbwe/avr-gcc-16.1.0-x64-windows/avr/include/string.h" 1
	call __strcmp ; [[len=call]]
 ;  0 "" 2
/* #NOAPP */
	or r24,r25
	breq .L46
	ldi r22,0
	ldi r24,0
	call LCD_I2C_SetCursor
	movw r24,r16
	call LCD_I2C_WriteString
	ldi r20,lo8(20)
	ldi r21,0
	movw r22,r16
	ldi r24,lo8(g_lastLine0)
	ldi r25,hi8(g_lastLine0)
	call strncpy
	sts g_lastLine0+20,__zero_reg__
.L46:
	movw r26,r14
	ldi r30,lo8(g_lastLine1)
	ldi r31,hi8(g_lastLine1)
/* #APP */
 ;  698 "C:/Users/amazon/AppData/Local/Microsoft/WinGet/Packages/ZakKemble.avr-gcc_Microsoft.Winget.Source_8wekyb3d8bbwe/avr-gcc-16.1.0-x64-windows/avr/include/string.h" 1
	call __strcmp ; [[len=call]]
 ;  0 "" 2
/* #NOAPP */
	or r24,r25
	brne .+2
	rjmp .L17
	ldi r22,0
	ldi r24,lo8(1)
	call LCD_I2C_SetCursor
	movw r24,r14
	call LCD_I2C_WriteString
	ldi r20,lo8(20)
	ldi r21,0
	movw r22,r14
	ldi r24,lo8(g_lastLine1)
	ldi r25,hi8(g_lastLine1)
	call strncpy
	sts g_lastLine1+20,__zero_reg__
	rjmp .L17
.L19:
=======
	ldi r20,0
	cp r24, __zero_reg__
	breq .L31
	subi r24,lo8(-(-1))
	sts Heartbeat_Counter,r24
	ldi r20,lo8(1)
.L31:
	ldi r22,lo8(3)
	ldi r24,lo8(1)
	call GPIO_SetPinValue
.L8:
=======
	sbiw r24,2
	breq .L63
	cp r12, __zero_reg__
	breq .L64
.L63:
	ldi r24,0
	call Panel_IsPressed
	cpse r24,__zero_reg__
	call Alarm_Acknowledge
.L65:
	ldi r24,lo8(4)
	call Panel_IsPressed
	cpse r24,__zero_reg__
	call Monitor_ToggleStandby
.L66:
	call Menu_IsInDashboard
	cp r24, __zero_reg__
	breq .L64
	ldi r24,lo8(2)
	call Panel_IsPressed
	ldi r24,lo8(3)
	call Panel_IsPressed
.L64:
>>>>>>> bc2a737000a66a64e11cd2e17089e177312200fa
	movw r24,r16
	ldi r22,lo8(10)
	ldi r23,0
	call __udivmodhi4
	sbiw r24,3
<<<<<<< HEAD
	brne .L10
	call Alarm_Process
.L10:
=======
	brne .L68
	call Alarm_Process
.L68:
	movw r24,r16
	ldi r22,lo8(25)
	ldi r23,0
	call __udivmodhi4
	sbiw r24,5
	breq .L69
	cp r12, __zero_reg__
	breq .L70
	lds r24,s_u8LcdCooldown.3
	cpse r24,__zero_reg__
	rjmp .L70
.L69:
	call Menu_Update
	sts s_u8LcdCooldown.3,r13
.L70:
	lds r24,s_u8LcdCooldown.3
	cp r24, __zero_reg__
	breq .L71
	subi r24,lo8(-(-1))
	sts s_u8LcdCooldown.3,r24
.L71:
>>>>>>> bc2a737000a66a64e11cd2e17089e177312200fa
	movw r24,r16
	ldi r22,lo8(50)
	ldi r23,0
	call __udivmodhi4
	sbiw r24,4
<<<<<<< HEAD
	brne .L11
	call TIMER1_IsCaptureReady
	cpse r24,__zero_reg__
	rjmp .L12
	call HRC_Process
.L13:
	call HRC_IsAsystole
	cp r24, __zero_reg__
	breq .L14
.L15:
	ldi r20,lo8(1)
.L32:
	ldi r22,0
	ldi r24,lo8(1)
	call GPIO_SetPinValue
.L11:
	movw r24,r16
	ldi r22,lo8(100)
	ldi r23,0
	call __udivmodhi4
	sbiw r24,6
	brne .L16
	ldi r24,lo8(12)
	ldi r30,lo8(.LC0)
	ldi r31,hi8(.LC0)
	movw r26,r28
	adiw r26,1
	0:
	ld r0,Z+
	st X+,r0
	dec r24
	brne 0b
	movw r24,r28
	adiw r24,1
	call Alarm_UpdateVitals
.L16:
=======
	brne .L72
	call Task_FastVitals
.L72:
	cpi r16,7
	cpc r17,__zero_reg__
	brne .L73
	std Y+1,__zero_reg__
	call UART_IsDataReady
	or r24,r25
	brne .L74
	ldd r24,Y+2
	ldd r25,Y+3
	call UART_ReceiveByte
	ldd r24,Y+1
	andi r24,lo8(-33)
	cpi r24,lo8(83)
	brne .L75
.L74:
	call Send_Telemetry_Frame
.L77:
	call Monitor_Run
>>>>>>> bc2a737000a66a64e11cd2e17089e177312200fa
	call ANN_Audio_Tick
	call ANN_Visual_Tick
	ldi r20,0
	ldi r22,lo8(7)
	ldi r24,lo8(2)
	call GPIO_SetPinValue
<<<<<<< HEAD
=======
	ldi r24,lo8(19999)
	ldi r25,hi8(19999)
1:	sbiw r24,1
	brne 1b
	rjmp .
	nop
>>>>>>> bc2a737000a66a64e11cd2e17089e177312200fa
	subi r16,-1
	sbci r17,-1
	cpi r16,-24
	ldi r25,3
	cpc r17,r25
	breq .+2
<<<<<<< HEAD
	rjmp .L7
	rjmp .L19
.L12:
	call TIMER1_GetLastInterval
	std Y+13,r24
	std Y+14,r25
	call HRC_Process
	ldd r24,Y+13
	ldd r25,Y+14
	or r24,r25
	breq .L13
	ldi r24,lo8(2)
	sts Heartbeat_Counter,r24
	rjmp .L13
.L14:
>>>>>>> d9c22b66226e0b37b25c4d23605075309880d886
	call HRC_GetBpm
	mov r12,r24
	mov r11,r25
	sbis 0x10,3
	rjmp .L51
	call HRC_IsAsystole
	ldi r25,lo8(1)
	cpse r24,__zero_reg__
	rjmp .L21
	ldi r25,0
.L21:
	in r24,0x10
	andi r24,lo8(32)
	cpi r25,lo8(0)
	brne .+2
	rjmp .L23
	cpse r24,__zero_reg__
	rjmp .L24
	ldi r22,lo8(.LC2)
	ldi r23,hi8(.LC2)
	movw r24,r16
	call strcpy
.L25:
	lds r24,s_lcdBannerPhase.0
	subi r24,lo8(-(1))
	cpi r24,lo8(20)
	brsh .L29
	mov r13,r24
.L29:
	sts s_lcdBannerPhase.0,r13
	call Alarm_GetActivePriority
	or r24,r25
<<<<<<< HEAD
	brne .+2
	rjmp .L30
	lds r24,s_lcdBannerPhase.0
	cpi r24,lo8(10)
	brsh .+2
	rjmp .L30
	call Alarm_GetActiveFlags
	sbrs r24,0
	rjmp .L31
	ldi r22,lo8(.LC8)
	ldi r23,hi8(.LC8)
.L89:
	mov r24,r10
	mov r25,r9
	rjmp .L88
.L51:
	ldi r25,lo8(1)
	rjmp .L21
.L24:
	lds r24,g_vitals+4
	cpi r24,lo8(100)
	brlo .L26
	ldi r24,lo8(.LC3)
	ldi r25,hi8(.LC3)
	push r25
	push r24
	push __zero_reg__
	ldi r24,lo8(21)
	push r24
	push r17
	push r16
	call snprintf
	pop __tmp_reg__
	pop __tmp_reg__
	pop __tmp_reg__
	pop __tmp_reg__
	pop __tmp_reg__
	pop __tmp_reg__
	rjmp .L25
.L26:
	push __zero_reg__
	push r24
	ldi r24,lo8(.LC4)
	ldi r25,hi8(.LC4)
.L90:
	push r25
	push r24
	push __zero_reg__
	ldi r24,lo8(21)
	push r24
	push r17
	push r16
	call snprintf
.L87:
	in __tmp_reg__,__SREG__
	cli
	out __SP_H__,r29
	out __SREG__,__tmp_reg__
	out __SP_L__,r28
	rjmp .L25
.L23:
	cpse r24,__zero_reg__
	rjmp .L27
	push r11
	push r12
	ldi r24,lo8(.LC5)
	ldi r25,hi8(.LC5)
	rjmp .L90
.L27:
	lds r24,g_vitals+4
	cpi r24,lo8(100)
	brlo .L28
	push r11
	push r12
	ldi r24,lo8(.LC6)
	ldi r25,hi8(.LC6)
	rjmp .L90
.L28:
	push __zero_reg__
	push r24
	push r11
	push r12
	ldi r24,lo8(.LC7)
	ldi r25,hi8(.LC7)
	push r25
	push r24
	push __zero_reg__
	ldi r24,lo8(21)
	push r24
	push r17
	push r16
	call snprintf
	rjmp .L87
.L31:
	ldi r22,lo8(.LC9)
	ldi r23,hi8(.LC9)
	sbrc r25,7
	rjmp .L89
	ldi r22,lo8(.LC10)
	ldi r23,hi8(.LC10)
	sbrc r25,6
	rjmp .L89
	ldi r22,lo8(.LC11)
	ldi r23,hi8(.LC11)
	sbrc r24,2
	rjmp .L89
	ldi r22,lo8(.LC12)
	ldi r23,hi8(.LC12)
	sbrc r24,3
	rjmp .L89
	ldi r22,lo8(.LC13)
	ldi r23,hi8(.LC13)
	sbrc r24,4
	rjmp .L89
	ldi r22,lo8(.LC14)
	ldi r23,hi8(.LC14)
	sbrc r24,5
	rjmp .L89
	ldi r22,lo8(.LC15)
	ldi r23,hi8(.LC15)
	sbrc r24,6
	rjmp .L89
	ldi r22,lo8(.LC16)
	ldi r23,hi8(.LC16)
	sbrc r25,2
	rjmp .L89
	ldi r22,lo8(.LC17)
	ldi r23,hi8(.LC17)
	sbrc r25,3
	rjmp .L89
	ldi r22,lo8(.LC18)
	ldi r23,hi8(.LC18)
	sbrc r25,4
	rjmp .L89
	ldi r22,lo8(.LC19)
	ldi r23,hi8(.LC19)
	sbrc r25,5
	rjmp .L89
	ldi r22,lo8(.LC20)
	ldi r23,hi8(.LC20)
	sbrc r24,7
	rjmp .L89
	ldi r22,lo8(.LC21)
	ldi r23,hi8(.LC21)
	sbrc r25,0
	rjmp .L89
	ldi r22,lo8(.LC22)
	ldi r23,hi8(.LC22)
	sbrc r25,1
	rjmp .L89
	ldi r22,lo8(.LC23)
	ldi r23,hi8(.LC23)
	rjmp .L89
.L30:
	lds r24,g_vitals+5
	lds r25,g_vitals+6
	ldi r22,lo8(10)
	ldi r23,0
	call __udivmodhi4
	lds r18,g_vitals+9
	push __zero_reg__
	push r18
	lds r18,g_vitals+8
	push __zero_reg__
	push r18
	lds r18,g_vitals+7
	push __zero_reg__
	push r18
	push r25
	push r24
	push r23
	push r22
	ldi r24,lo8(.LC24)
	ldi r25,hi8(.LC24)
	push r25
	push r24
	push __zero_reg__
	ldi r24,lo8(21)
	push r24
	push r15
	push r14
	call snprintf
	in __tmp_reg__,__SREG__
	cli
	out __SP_H__,r29
	out __SREG__,__tmp_reg__
	out __SP_L__,r28
	rjmp .L20
=======
	breq .L15
	ldi r20,0
	rjmp .L32
>>>>>>> d9c22b66226e0b37b25c4d23605075309880d886
=======
	rjmp .L55
	ldi r16,0
	ldi r17,0
	rjmp .L55
.L75:
	ldi r24,lo8(.LC6)
	ldi r25,hi8(.LC6)
	call UART_SendString
	rjmp .L77
.L73:
	cpi r16,8
	cpc r17,__zero_reg__
	brne .L77
	call Task_Trend
	rjmp .L77
>>>>>>> bc2a737000a66a64e11cd2e17089e177312200fa
	.size	main, .-main
	.section	.bss.s_lcdBannerPhase.0,"aw",@nobits
	.type	s_lcdBannerPhase.0, @object
	.size	s_lcdBannerPhase.0, 1
s_lcdBannerPhase.0:
	.zero	1
	.section	.bss.g_lastLine1,"aw",@nobits
	.type	g_lastLine1, @object
	.size	g_lastLine1, 21
g_lastLine1:
	.zero	21
	.section	.bss.g_lastLine0,"aw",@nobits
	.type	g_lastLine0, @object
	.size	g_lastLine0, 21
g_lastLine0:
	.zero	21
	.section	.bss.g_vitals,"aw",@nobits
	.type	g_vitals, @object
	.size	g_vitals, 24
g_vitals:
	.zero	24
	.section	.bss.g_standbyActive,"aw",@nobits
	.type	g_standbyActive, @object
	.size	g_standbyActive, 1
g_standbyActive:
	.zero	1
	.section	.bss.g_schedulerPhase,"aw",@nobits
	.type	g_schedulerPhase, @object
	.size	g_schedulerPhase, 2
g_schedulerPhase:
	.zero	2
	.section	.bss.Heartbeat_Counter,"aw",@nobits
	.type	Heartbeat_Counter, @object
	.size	Heartbeat_Counter, 1
Heartbeat_Counter:
	.zero	1
<<<<<<< HEAD
	.ident	"GCC: (GNU) 16.1.0"
=======
	.ident	"GCC: (GNU) 15.2.0"
>>>>>>> d9c22b66226e0b37b25c4d23605075309880d886
.global __do_copy_data
.global __do_clear_bss
