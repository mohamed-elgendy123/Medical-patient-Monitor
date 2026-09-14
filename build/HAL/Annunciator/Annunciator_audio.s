	.file	"Annunciator_audio.c"
__SP_H__ = 0x3e
__SP_L__ = 0x3d
__SREG__ = 0x3f
__tmp_reg__ = 0
__zero_reg__ = 1
	.text
	.section	.text.ANN_ResetPattern,"ax",@progbits
	.type	ANN_ResetPattern, @function
ANN_ResetPattern:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	sts Ann_Phase,__zero_reg__
	sts Ann_PulseCount,__zero_reg__
	sts Ann_PhaseTicks+1,__zero_reg__
	sts Ann_PhaseTicks,__zero_reg__
	sts Ann_CycleTicks+1,__zero_reg__
	sts Ann_CycleTicks,__zero_reg__
	lds r24,Ann_CurrentPriority
	cpi r24,lo8(3)
	brne .L2
	ldi r24,lo8(1)
.L5:
	jmp TIMER2_SetTone
.L2:
	lds r24,Ann_CurrentPriority
	cpi r24,lo8(2)
	breq .L5
	lds r24,Ann_CurrentPriority
	cpi r24,lo8(1)
	brne .L4
	ldi r24,lo8(3)
	rjmp .L5
.L4:
	ldi r24,lo8(3)
	sts Ann_Phase,r24
	ldi r24,0
	rjmp .L5
	.size	ANN_ResetPattern, .-ANN_ResetPattern
	.section	.text.ANN_Audio_Init,"ax",@progbits
.global	ANN_Audio_Init
	.type	ANN_Audio_Init, @function
ANN_Audio_Init:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	sts Ann_CurrentPriority,__zero_reg__
	ldi r24,lo8(3)
	sts Ann_Phase,r24
	sts Ann_PulseCount,__zero_reg__
	sts Ann_PhaseTicks+1,__zero_reg__
	sts Ann_PhaseTicks,__zero_reg__
	sts Ann_CycleTicks+1,__zero_reg__
	sts Ann_CycleTicks,__zero_reg__
	sts Ann_SilenceTicks+1,__zero_reg__
	sts Ann_SilenceTicks,__zero_reg__
	sts Ann_Muted,__zero_reg__
	call TIMER2_Init
	ldi r24,0
	jmp TIMER2_SetTone
	.size	ANN_Audio_Init, .-ANN_Audio_Init
	.section	.text.ANN_Audio_SetPriority,"ax",@progbits
.global	ANN_Audio_SetPriority
	.type	ANN_Audio_SetPriority, @function
ANN_Audio_SetPriority:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	cpi r24,lo8(4)
	brsh .L7
	lds r25,Ann_CurrentPriority
	cp r25,r24
	breq .L7
	sts Ann_CurrentPriority,r24
	sts Ann_Muted,__zero_reg__
	sts Ann_SilenceTicks+1,__zero_reg__
	sts Ann_SilenceTicks,__zero_reg__
	jmp ANN_ResetPattern
.L7:
/* epilogue start */
	ret
	.size	ANN_Audio_SetPriority, .-ANN_Audio_SetPriority
	.section	.text.ANN_Audio_Tick,"ax",@progbits
.global	ANN_Audio_Tick
	.type	ANN_Audio_Tick, @function
ANN_Audio_Tick:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	lds r24,Ann_Muted
	cpi r24,lo8(0)
	breq .L10
	lds r24,Ann_SilenceTicks
	lds r25,Ann_SilenceTicks+1
	or r24,r25
	breq .L11
	lds r24,Ann_SilenceTicks
	lds r25,Ann_SilenceTicks+1
	sbiw r24,1
	sts Ann_SilenceTicks+1,r25
	sts Ann_SilenceTicks,r24
.L11:
	lds r24,Ann_SilenceTicks
	lds r25,Ann_SilenceTicks+1
	or r24,r25
	breq .+2
	rjmp .L9
	sts Ann_Muted,__zero_reg__
.L37:
	jmp ANN_ResetPattern
.L10:
	lds r24,Ann_CurrentPriority
	cpse r24,__zero_reg__
	rjmp .L13
	call TIMER2_SetTone
	ldi r24,lo8(3)
	sts Ann_Phase,r24
	ret
.L13:
	lds r24,Ann_CurrentPriority
	cpi r24,lo8(3)
	breq .L23
	lds r24,Ann_CurrentPriority
	cpi r24,lo8(2)
	brne .L24
	ldi r24,lo8(-36)
	ldi r25,lo8(5)
	ldi r18,lo8(3)
	ldi r20,lo8(15)
	ldi r21,0
	ldi r22,lo8(20)
	ldi r23,0
.L14:
	lds r30,Ann_CycleTicks
	lds r31,Ann_CycleTicks+1
	adiw r30,1
	breq .L15
	lds r30,Ann_CycleTicks
	lds r31,Ann_CycleTicks+1
	adiw r30,1
	sts Ann_CycleTicks+1,r31
	sts Ann_CycleTicks,r30
.L15:
	lds r19,Ann_Phase
	cpse r19,__zero_reg__
	rjmp .L16
	lds r24,Ann_PhaseTicks
	lds r25,Ann_PhaseTicks+1
	adiw r24,1
	sts Ann_PhaseTicks+1,r25
	sts Ann_PhaseTicks,r24
	lds r24,Ann_PhaseTicks
	lds r25,Ann_PhaseTicks+1
	cp r24,r22
	cpc r25,r23
	brsh .+2
	rjmp .L9
	ldi r24,lo8(1)
.L39:
	sts Ann_Phase,r24
	sts Ann_PhaseTicks+1,__zero_reg__
	sts Ann_PhaseTicks,__zero_reg__
	rjmp .L22
.L23:
	ldi r24,lo8(-12)
	ldi r25,lo8(1)
	ldi r18,lo8(10)
	ldi r20,lo8(10)
	ldi r21,0
	ldi r22,lo8(15)
	ldi r23,0
	rjmp .L14
.L24:
	ldi r24,0
	ldi r25,0
	ldi r18,lo8(2)
	ldi r20,lo8(20)
	ldi r21,0
	ldi r22,lo8(25)
	ldi r23,0
	rjmp .L14
.L16:
	lds r19,Ann_Phase
	cpi r19,lo8(1)
	brne .L17
	lds r24,Ann_PhaseTicks
	lds r25,Ann_PhaseTicks+1
	adiw r24,1
	sts Ann_PhaseTicks+1,r25
	sts Ann_PhaseTicks,r24
	lds r24,Ann_PhaseTicks
	lds r25,Ann_PhaseTicks+1
	cp r24,r20
	cpc r25,r21
	brlo .L9
	lds r24,Ann_PulseCount
	subi r24,lo8(-(1))
	sts Ann_PulseCount,r24
	lds r24,Ann_PulseCount
	cp r24,r18
	brsh .L18
	sts Ann_Phase,__zero_reg__
	sts Ann_PhaseTicks+1,__zero_reg__
	sts Ann_PhaseTicks,__zero_reg__
	lds r24,Ann_CurrentPriority
	cpi r24,lo8(3)
	brne .L19
	ldi r24,lo8(1)
.L38:
	jmp TIMER2_SetTone
.L19:
	lds r24,Ann_CurrentPriority
	cpi r24,lo8(2)
	breq .L38
	lds r24,Ann_CurrentPriority
	cpi r24,lo8(1)
	brne .L9
	ldi r24,lo8(3)
	rjmp .L38
.L18:
	lds r24,Ann_CurrentPriority
	cpi r24,lo8(1)
	brne .L21
	ldi r24,lo8(3)
	sts Ann_Phase,r24
.L22:
	ldi r24,0
	rjmp .L38
.L21:
	ldi r24,lo8(2)
	rjmp .L39
.L17:
	lds r18,Ann_Phase
	cpi r18,lo8(2)
	brne .L22
	lds r18,Ann_CycleTicks
	lds r19,Ann_CycleTicks+1
	cp r18,r24
	cpc r19,r25
	brlo .+2
	rjmp .L37
.L9:
/* epilogue start */
	ret
	.size	ANN_Audio_Tick, .-ANN_Audio_Tick
	.section	.text.ANN_Audio_Mute,"ax",@progbits
.global	ANN_Audio_Mute
	.type	ANN_Audio_Mute, @function
ANN_Audio_Mute:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	ldi r24,lo8(1)
	sts Ann_Muted,r24
	ldi r24,lo8(-32)
	ldi r25,lo8(46)
	sts Ann_SilenceTicks+1,r25
	sts Ann_SilenceTicks,r24
	ldi r24,0
	jmp TIMER2_SetTone
	.size	ANN_Audio_Mute, .-ANN_Audio_Mute
	.section	.text.ANN_Audio_Unmute,"ax",@progbits
.global	ANN_Audio_Unmute
	.type	ANN_Audio_Unmute, @function
ANN_Audio_Unmute:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	sts Ann_Muted,__zero_reg__
	sts Ann_SilenceTicks+1,__zero_reg__
	sts Ann_SilenceTicks,__zero_reg__
	jmp ANN_ResetPattern
	.size	ANN_Audio_Unmute, .-ANN_Audio_Unmute
	.section	.bss.Ann_Muted,"aw",@nobits
	.type	Ann_Muted, @object
	.size	Ann_Muted, 1
Ann_Muted:
	.zero	1
	.section	.bss.Ann_SilenceTicks,"aw",@nobits
	.type	Ann_SilenceTicks, @object
	.size	Ann_SilenceTicks, 2
Ann_SilenceTicks:
	.zero	2
	.section	.bss.Ann_CycleTicks,"aw",@nobits
	.type	Ann_CycleTicks, @object
	.size	Ann_CycleTicks, 2
Ann_CycleTicks:
	.zero	2
	.section	.bss.Ann_PhaseTicks,"aw",@nobits
	.type	Ann_PhaseTicks, @object
	.size	Ann_PhaseTicks, 2
Ann_PhaseTicks:
	.zero	2
	.section	.bss.Ann_PulseCount,"aw",@nobits
	.type	Ann_PulseCount, @object
	.size	Ann_PulseCount, 1
Ann_PulseCount:
	.zero	1
	.section	.bss.Ann_Phase,"aw",@nobits
	.type	Ann_Phase, @object
	.size	Ann_Phase, 1
Ann_Phase:
	.zero	1
	.section	.bss.Ann_CurrentPriority,"aw",@nobits
	.type	Ann_CurrentPriority, @object
	.size	Ann_CurrentPriority, 1
Ann_CurrentPriority:
	.zero	1
	.ident	"GCC: (GNU) 16.1.0"
.global __do_clear_bss
