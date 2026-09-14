# Project 07: Medical Patient Monitor (`PRJ-07-MONITOR`)
## Team Work Breakdown by MCAL Peripheral (`TIMER`, `SPI`, `I2C`, `USART`)

- **Template Baseline:** `AVR_NTI` by Eng. Ahmed Ellamie
- **Target MCU:** ATmega32A @ 8 MHz (SimulIDE 1.x)
- **Team Size:** 4 Students
- **Core Assignment Rule:** Each student owns exactly **ONE** primary MCAL communication/timing driver:
  1. **Student 1 &rarr; `TIMER`** (Timer0, Timer1, Timer2)
  2. **Student 2 &rarr; `SPI`**
  3. **Student 3 &rarr; `I2C`**
  4. **Student 4 &rarr; `USART`**

---

## 1. Executive Allocation Matrix

```
┌────────────────────────────────────────────────────────────────────────────────────────┐
│ Student 1                Student 2                 Student 3            Student 4      │
│ [TIMER Lead]             [SPI Lead]                [I2C Lead]           [USART Lead]   │
├────────────────────────────────────────────────────────────────────────────────────────┤
│ MCAL:                    MCAL:                     MCAL:                MCAL:          │
│ • TIMER (T0, T1, T2)     • SPI                     • I2C (TWI)          • UART         │
│                          • EXTI (INT0 Code Blue)                        • ADC (PA0-PA3)│
├────────────────────────────────────────────────────────────────────────────────────────┤
│ HAL:                     HAL:                      HAL:                 HAL:           │
│ • HR_Capture             • ShiftReg (74HC595)      • LCD_I2C (PCF8574)  • Vitals       │
│ • Annunciator (Audio)    • Annunciator (LEDs)      • Panel (PC2-PC6)                   │
│                          • NurseCall (PD4)                                             │
├────────────────────────────────────────────────────────────────────────────────────────┤
│ Logic:                   Logic:                    Logic:               Logic:         │
│ • Scheduler (10ms tick)  • alarm_mgr (17 alarms)   • menu               • trends       │
│                          • monitor_fsm             • patient_cfg        • console      │
└────────────────────────────────────────────────────────────────────────────────────────┘
```

---

## 2. Detailed Student Responsibilities

---

### Student 1:(mohamed elgendy) The `TIMER` Lead (Timing, Beat Math & Audio Tones)

#### 1. MCAL Driver Owned: `MCAL/TIMER/`
* **Timer0 (System Heartbeat):**
  - Implement 10 ms CTC mode (`WGM01=1, WGM00=0`, Prescaler 1024, `OCR0=77`).
  - Enable `TIMER0_COMP_vect` interrupt to drive the non-blocking system scheduler in `main.c`.
* **Timer1 (Input Capture Unit - ICU on PD6):**
  - Configure 16-bit Timer1 with prescaler 256 @ 8 MHz (32 &mu;s/tick).
  - Implement `TIMER1_CAPT_vect` to capture pulse timestamps (`ICR1(n) - ICR1(n-1)`).
  - Implement `TIMER1_OVF_vect` to detect asystole (> 4.0 seconds without beat).
* **Timer2 (Audio PWM on PD7 / OC2):**
  - Configure Timer2 in Fast PWM mode with selectable audio pitch:
    - High Priority Tone: **960 Hz**
    - Medium Priority Tone: **640 Hz**
    - Low Priority Tone: **480 Hz**

#### 2. HAL & Logic Modules:
* **`HAL/HR_Capture/`:**
  - Heart Rate calculation: `HR (bpm) = 1,875,000 / interval_ticks` (integer division).
  - Heart Rate Variability (HRV): Mean absolute successive difference over 8 beats without `sqrt()`.
  - Asystole detector flag.
* **`HAL/Annunciator/` (Audio Part):**
  - Generates the non-blocking tone burst intervals:
    - High: 10 beeps (150ms on / 100ms off) repeated every 5 s.
    - Medium: 3 beeps (200ms on / 150ms off) repeated every 15 s.
    - Low: 2 beeps once.
* **`main.c` Scheduler:** Owns the 10 ms cooperative task dispatcher.

#### Files Owned:
- `MCAL/TIMER/TIMER.c` & `TIMER_interface.h` & `TIMER_private.h`
- `HAL/HR_Capture/HR_Capture.c` & `HR_Capture_interface.h`
- `HAL/Annunciator/Annunciator_audio.c`

---

### Student 2:(salma Ahmed) The `SPI` Lead (Visual Annunciation, Status Bar & Alarm Engine)

#### 1. MCAL Driver Owned: `MCAL/SPI/`
* **Master SPI Driver:**
  - Implement `SPI_InitMaster` (Mode 0, f/16, MOSI `PB5`, SCK `PB7`, Master Enable `MSTR`).
  - Implement `SPI_TransceiveByte` (transmit byte and wait for `SPIF` flag).
  - Control Shift Register Latch pulse (`RCLK`) on `PB4`.
* **Interrupts:**
  - Register `EXTI_INT0` callback for manual **Code Blue** button (`PD2`).

#### 2. HAL & Logic Modules:
* **`HAL/ShiftReg/` (74HC595 8-LED Bar):**
  - Serial-to-parallel shift register driver: updates the 8-LED vital status bar over SPI.
* **`HAL/Annunciator/` (Visual Part) & `HAL/NurseCall/`:**
  - Drives visual LEDs via `MCAL/GPIO/`:
    - High: Red LED (`PB0`) flashing at 2 Hz.
    - Medium: Yellow LED (`PB1`) flashing at 0.6 Hz.
    - Low: Cyan LED (`PB2`) steady ON.
    - Heartbeat: Green LED (`PB3`) 50 ms flash on each beat.
  - Nurse-Call relay output (`PD4`): Asserted high on unacknowledged High-priority alarm.
  - Silence behavior: Shuts off audio tone, but **LEDs must continue flashing**.
* **`Logic/alarm_mgr.c` & `Logic/monitor_fsm.c`:**
  - Owns the 17-alarm definition table (`A0` to `A16`).
  - Latching, 120s Silence timer, and 60s Medium &rarr; High escalation.
  - System FSM: `MS_INIT` (3s self-test), `MS_STANDBY`, `MS_MONITORING`, `MS_ALARM`, `MS_SILENCED`.

#### Files Owned:
- `MCAL/SPI/SPI.c` & `SPI_interface.h` & `SPI_private.h`
- `HAL/ShiftReg/ShiftReg.c` & `ShiftReg_interface.h`
- `HAL/Annunciator/Annunciator_visual.c` & `Annunciator_interface.h`
- `HAL/NurseCall/NurseCall.c` & `NurseCall_interface.h`
- `Logic/alarm_mgr.c` & `alarm_mgr.h`
- `Logic/monitor_fsm.c` & `monitor_fsm.h`

---

### Student 3:(Ahmed Ali) The `I2C` Lead (Bedside LCD, Control Panel & Settings Menu)

#### 1. MCAL Driver Owned: `MCAL/I2C/`
* **Master TWI Driver (`PC0` SCL, `PC1` SDA):**
  - Implement `I2C_InitMaster(100000UL)` (100 kHz standard clock).
  - Implement `I2C_SendStart`, `I2C_SendRepeatedStart`, `I2C_SendStop`.
  - Implement `I2C_SendSlaveAddressWithWrite` & `I2C_SendByte`.

#### 2. HAL & Logic Modules:
* **`HAL/LCD_I2C/` (16×2 Character Display):**
  - HD44780 LCD driver interfacing through the PCF8574 I2C I/O expander.
  - Live Dashboard view: displays all 5 vitals and the highest active alarm banner.
  - Fault handling: if a sensor is disconnected, display `---` (never invent numbers).
* **`HAL/Panel/` (Operator Buttons):**
  - 10 ms software debouncer for inputs on `PC2..PC6`:
    - `PC2`: Silence (120s audio pause)
    - `PC3`: Menu (enter/exit limits tuning)
    - `PC4`: Up
    - `PC5`: Down
    - `PC6`: Standby (toggle monitoring)
* **`Logic/menu.c` & `Logic/patient_cfg.c`:**
  - Interactive limits menu to view/tune thresholds on the LCD.
  - Age-profile presets stored in Flash/`PROGMEM` (Adult, Paediatric, Neonatal).

#### Files Owned:
- `MCAL/I2C/I2C.c` & `I2C_interface.h` & `I2C_private.h`
- `HAL/LCD_I2C/LCD_I2C.c` & `LCD_I2C_interface.h`
- `HAL/Panel/Panel.c` & `Panel_interface.h`
- `Logic/menu.c` & `menu.h`
- `Logic/patient_cfg.c` & `patient_cfg.h`

---

### Student 4:(Ahmed Elshakry) The `USART` Lead (Telemetry, Data Logging & Analog Vitals)

#### 1. MCAL Driver Owned: `MCAL/UART/` (+ `MCAL/ADC/`)
* **USART Serial Driver (`PD0` RXD, `PD1` TXD):**
  - Implement `UART_Init(9600)` (9600 Baud, 8 data bits, no parity, 1 stop bit).
  - Implement `UART_SendByte`, `UART_SendString`, `UART_ReceiveByte`, `UART_IsDataReady`.
  - Enable RX complete interrupt for remote console commands.
* **ADC Driver (`PA0`..`PA3`):**
  - Verify and finish `MCAL/ADC/ADC.c` (Prescaler 64, AVCC reference).
  - Set up `EXTI_INT1` (`PD3`) for Lead-off detection & `PD5` for SpO2 Probe-off.

#### 2. HAL & Logic Modules:
* **`HAL/Vitals/`:**
  - Multi-channel ADC acquisition:
    - `ADC0` (PA0): SpO2 (0..1023 &rarr; 70..100 %)
    - `ADC1` (PA1): Body Temp (0..1023 &rarr; 30.0..45.0 °C, stored as Cx10: 300..450)
    - `ADC2` (PA2): NIBP Systolic (0..1023 &rarr; 50..250 mmHg; Diastolic ~ 2/3 systolic)
    - `ADC3` (PA3): Respiration Rate (0..1023 &rarr; 0..60 breaths/min)
  - Plausibility & Fault: If ADC is pinned at 0 or 1023 &rarr; raise `SENSOR FAULT` and invalidate reading.
* **`Logic/trends.c` (2 KB RAM Trend Buffers):**
  - Circular buffer implementation:
    - Fine Ring: 60 samples @ 10s interval = 10 minutes history (360 bytes).
    - Coarse Ring: 24 samples @ 10min interval = 4 hours history (squeezed).
* **`Logic/console.c` (Central Station Link):**
  - Streams live periodic CSV/JSON telemetry over UART.
  - Logs timestamped alarm events (`ALARM RAISED`, `SILENCED`, `ESCALATED`, `CLEARED`).

#### Files Owned:
- `MCAL/UART/UART.c` & `UART_interface.h` & `UART_private.h`
- `MCAL/ADC/ADC.c` & `ADC_interface.h`
- `HAL/Vitals/Vitals.c` & `Vitals_interface.h`
- `Logic/trends.c` & `trends.h`
- `Logic/console.c` & `console.h`

---

## 3. Workload Balance Verification

| Student | Assigned MCAL Core | Total Hardware / Low-Level | High-Level Application Logic | Total Effort |
| :---: | :--- | :--- | :--- | :---: |
| **Student 1** | **`TIMER`** (T0, T1, T2) | Timer0 CTC, Timer1 ICU, Timer2 PWM | HR & HRV Math, 10ms Scheduler | **25%** |
| **Student 2** | **`SPI`** | SPI Master, 74HC595, PB0-PB3 LEDs | 17-Alarm Table, Latching, Escalation, FSM | **25%** |
| **Student 3** | **`I2C`** | I2C Master (TWI), PCF8574 LCD, Panel Buttons | LCD Dashboard, Menu FSM, Age Profiles | **25%** |
| **Student 4** | **`USART`** (+ ADC) | UART 9600 8N1, ADC 4 Channels, EXTI1 | Vitals Scaling, RAM Trends, Telemetry Logger | **25%** |

---


## 4. Final Repository Tree (After Project Completion)

```text
Medical-patient-Monitor/
├── Makefile                                /* Shared - Build automation from AVR_NTI */
├── main.c                                  /* Student 1 - Cooperative scheduler & super-loop */
├── README.md                               /* Project requirements & specification */
├── TEAM_WORK_DIVISION.md                   /* Team organization & task tracking */
│
├── LIB/                                    /* Shared Common Library */
│   ├── STD_TYPES.h                         /* Standard data types (uint8, uint16, etc.) */
│   ├── MATH.h                              /* Bitwise manipulation macros */
│   ├── ring_buffer.h                       /* Circular buffer header */
│   └── ring_buffer.c                       /* Circular buffer implementation */
│
├── MCAL/                                   /* Microcontroller Abstraction Layer */
│   ├── GPIO/                               /* Existing in AVR_NTI */
│   │   ├── GPIO.c
│   │   ├── GPIO_interface.h
│   │   └── GPIO_private.h
│   │
│   ├── INTERRUPT/                          /* Existing in AVR_NTI */
│   │   ├── INTERRUPT.c
│   │   ├── INTERRUPT_interface.h
│   │   └── INTERRUPT_private.h
│   │
│   ├── TIMER/                              /* [STUDENT 1] */
│   │   ├── TIMER.c                         /* Timer0 CTC (10ms tick), Timer1 ICU, Timer2 PWM */
│   │   ├── TIMER_interface.h
│   │   └── TIMER_private.h
│   │
│   ├── SPI/                                /* [STUDENT 2] */
│   │   ├── SPI.c                           /* Master Mode 0, f/16 SPI driver */
│   │   ├── SPI_interface.h
│   │   └── SPI_private.h
│   │
│   ├── I2C/                                /* [STUDENT 3] */
│   │   ├── I2C.c                           /* Master TWI driver at 100 kHz */
│   │   ├── I2C_interface.h
│   │   └── I2C_private.h
│   │
│   ├── UART/                               /* [STUDENT 4] */
│   │   ├── UART.c                          /* 9600 Baud 8N1 serial driver */
│   │   ├── UART_interface.h
│   │   └── UART_private.h
│   │
│   └── ADC/                                /* [STUDENT 4] */
│       ├── ADC.c                           /* 10-bit single conversion (channels 0..3) */
│       ├── ADC_interface.h
│       └── ADC_private.h
│
├── HAL/                                    /* Hardware Abstraction Layer */
│   ├── HR_Capture/                         /* [STUDENT 1] */
│   │   ├── HR_Capture.c                    /* Heart rate calculation, HRV, asystole flag */
│   │   └── HR_Capture_interface.h
│   │
│   ├── Annunciator/                        /* [STUDENT 1: Audio] & [STUDENT 2: Visual] */
│   │   ├── Annunciator.c                   /* Tone bursts, LED flash rates, audio mute */
│   │   └── Annunciator_interface.h
│   │
│   ├── ShiftReg/                           /* [STUDENT 2] */
│   │   ├── ShiftReg.c                      /* 74HC595 8-LED vital status bar over SPI */
│   │   └── ShiftReg_interface.h
│   │
│   ├── NurseCall/                          /* [STUDENT 2] */
│   │   ├── NurseCall.c                     /* PD4 Nurse call relay actuator */
│   │   └── NurseCall_interface.h
│   │
│   ├── LCD_I2C/                            /* [STUDENT 3] */
│   │   ├── LCD_I2C.c                       /* 16x2 LCD via PCF8574 over I2C */
│   │   └── LCD_I2C_interface.h
│   │
│   ├── Panel/                              /* [STUDENT 3] */
│   │   ├── Panel.c                         /* 10ms button debouncer for PC2..PC6 */
│   │   └── Panel_interface.h
│   │
│   └── Vitals/                             /* [STUDENT 4] */
│       ├── Vitals.c                        /* ADC scaling for SpO2, Temp, NIBP, Resp & faults */
│       └── Vitals_interface.h
│
└── Logic/                                  /* Application Layer */
    ├── alarm_mgr.c                         /* [STUDENT 2] 17 alarms table, latch, silence, escalate */
    ├── alarm_mgr.h                         /* [STUDENT 2] */
    ├── monitor_fsm.c                       /* [STUDENT 2] Top-level system state machine */
    ├── monitor_fsm.h                       /* [STUDENT 2] */
    ├── menu.c                              /* [STUDENT 3] Limits menu navigation */
    ├── menu.h                              /* [STUDENT 3] */
    ├── patient_cfg.c                       /* [STUDENT 3] Flash age profiles (Adult, Paediatric, Neonatal) */
    ├── patient_cfg.h                       /* [STUDENT 3] */
    ├── trends.c                            /* [STUDENT 4] RAM circular trend buffers (fine + coarse) */
    ├── trends.h                            /* [STUDENT 4] */
    ├── console.c                           /* [STUDENT 4] UART telemetry streaming & alarm event logs */
    └── console.h                           /* [STUDENT 4] */
```
