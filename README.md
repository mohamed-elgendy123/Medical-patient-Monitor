# Project 07 — Medical Patient Monitor

> Part of the **Embedded Systems Projects Book** — see the
> [book README](../README.md) for the shared platform baseline, layer rules and
> common rubric. Everything in this file is *in addition to* those rules.

---

> ## ⚠ TEACHING EXERCISE ONLY — NOT A MEDICAL DEVICE
>
> This project is a **simulation** built on a hobby simulator with
> potentiometers standing in for transducers. It has no clinical validation, no
> patient isolation, no certified sensors and no regulatory approval.
>
> **It must never be connected to a person, and its readings must never be used
> for any clinical decision.**
>
> A real patient monitor is a Class IIb device governed by IEC 60601-1,
> IEC 60601-1-8 (alarm systems) and IEC 62304 (medical device software
> lifecycle). This exercise *borrows the alarm-priority concepts* from
> IEC 60601-1-8 because they are excellent engineering, but building something
> that follows a standard's ideas is not the same as building something
> compliant with it. Your report must state this distinction explicitly.

---

## 1. Project Identity

| Field | Value |
|-------|-------|
| **Project code** | `PRJ-07-MONITOR` |
| **Team size** | 4 students |
| **Team Names** | 'Mohamed Elgendy'-'salma Ahmed'-'Ahmed Ali'-'Ahmed Elshakry' |
| **Build window** | Days 11 – 15 (Jul 26 – Jul 30, 2026) |
| **Demo & submission** | July 30, 2026 |
| **Dominant skill** | Three-tier alarm system, beat-interval measurement, trend buffers |
| **MCU** | ATmega32A @ 8 MHz |
| **Simulator** | SimulIDE 1.x |

---

## 2. Description

### In one sentence

**You are building a bedside patient monitor: it watches five vital signs and
raises an alarm when one of them goes out of range.**

### What the circuit looks like

| Vital sign | Where it comes from |
|------------|--------------------|
| Heart rate | A pulse train — you measure the gap between beats |
| Oxygen saturation (SpO₂) | Potentiometer on ADC0 |
| Body temperature | Potentiometer on ADC1 |
| Blood pressure | Potentiometer on ADC2 |
| Breathing rate | Potentiometer on ADC3 |

Outputs: three coloured alarm lamps, a speaker, an LCD, a serial link, and an
74HC595 driving an 8-LED alarm and vital status bar over SPI.

### The measurements are the easy part

Reading five analog channels is something you already did in week one. **The
project is the alarm system**, and there is a real reason for that.

### The one thing you actually have to get right: alarms people will still listen to

Imagine a monitor that beeps in exactly the same way for these two events:

- the finger clip fell off the patient, and
- the patient's heart has stopped.

Within a week, the nurses have learned that the beeping is usually nothing. They
stop reacting quickly. Then one day it is not nothing.

This has a name — **alarm fatigue** — and it kills people. It is one of the most
studied failures in medical devices. Which is why the international standard for
medical alarms (IEC 60601-1-8) says that alarms must come in **priority levels**,
and that each level must **look and sound different enough to tell apart across a
noisy room**.

You will implement three levels:

| Priority | Means | Lamp | Sound |
|----------|-------|------|-------|
| **High** | Act now | Red, flashing fast (1.4 – 2.8 Hz) | Burst of **10** beeps, repeated every 5 s |
| **Medium** | Act soon | Yellow, flashing slowly (0.4 – 0.8 Hz) | Burst of **3** beeps, repeated every 15 s |
| **Low** | Be aware | Cyan, steady | **1 – 2** beeps, once |

The counts and the rates are not decoration. They are how a nurse identifies the
priority without looking at the screen.

Four rules go with them, and each is tested:

- Alarms **latch** — they do not vanish just because the reading came back.
- Alarms can be **silenced for 120 seconds**, and then they come back.
- **No alarm can ever be turned off permanently.** No command, no key sequence,
  no configuration value. This is a hard requirement.
- An alarm that is ignored **escalates** to the next priority up.

And one that catches everybody: if a sensor is disconnected, the monitor must
show `---`, **not a number**. A monitor that invents a plausible reading from a
disconnected sensor is the most dangerous thing in this whole book.

### The second thing: remembering a trend inside 2 KB

You keep 60 recent samples of every vital in RAM so the LCD can draw a trend,
plus a squeezed-down 24-sample coarse history, also in RAM, at one sample per
10 minutes. The
chip has 2 KB of RAM in total, so you will have to decide carefully what is worth
keeping and what gets thrown away.

### The rest of it

- The **LCD** shows all five vitals and the highest active alarm.
- The **serial link** streams vitals and logs every alarm with a timestamp.
- The **74HC595** drives an 8-LED alarm and vital status bar over SPI.
> **Note on saving.** There is no non-volatile memory in this project — SimulIDE
> has no part that could provide it. Everything starts from its compiled-in
> default on each power-up, and anything tunable is tuned live over the serial
> console. See the book README, §4.

---

## 3. Objectives

1. Measure heart rate from beat-to-beat intervals and derive a variability
   metric from it.
2. Implement a three-tier alarm system with distinct visual and audible
   signatures.
3. Implement alarm latching, timed silencing and escalation.
4. Distinguish a *physiological* alarm from a *technical* alarm (sensor
   disconnected) and prove the monitor never confuses them.
5. Maintain circular trend buffers in RAM plus a compressed coarse history, and size both against the 2 KB budget.
6. Build a per-patient configuration profile with safe defaults.
7. Write, in the report, a clear-eyed account of why this is not a medical
   device.

---

## 4. Learning Outcomes

| ID | Outcome |
|----|---------|
| LO-1 | Measure a pulse interval with input capture and convert it to a rate with integer division |
| LO-2 | Compute a running standard-deviation-like metric in fixed point without `sqrt` |
| LO-3 | Design an alarm-priority scheme and explain why alarm fatigue is a safety hazard |
| LO-4 | Implement latch / silence / escalate behaviour and prove silence can never become permanent |
| LO-5 | Distinguish technical from physiological alarms and justify why technical alarms must not be silenceable to zero |
| LO-6 | Implement a circular trend buffer and a compression scheme that fits a 4-hour history into a few hundred bytes |
| LO-7 | Articulate the gap between "follows a standard's ideas" and "is compliant with a standard" |

---

## 5. Estimated Duration

| Phase | Hours | Course day |
|-------|:-----:|-----------|
| Requirements analysis & pin freeze | 3 | Day 11 |
| Alarm architecture & priority design | 5 | Day 11 |
| Analog vitals, LCD, indicators | 6 | Day 12 |
| Tick, input capture HR, alarm timing | 7 | Day 13 |
| Trends, 74HC595 profile, UART | 6 | Day 14 |
| Testing (alarm injection) | 5 | Day 15 |
| Documentation, report, video | 4 | Day 15 + evening |
| **Total** | **36 h** | |

---

## 6. Hardware Components

| # | Component | Qty | SimulIDE part | Purpose |
|---|-----------|:---:|---------------|---------|
| 1 | ATmega32A | 1 | `atmega32` | Controller |
| 2 | Potentiometer 10 kΩ | 4 | `Potentiometer` | SpO₂, temperature, NIBP, respiration |
| 3 | Variable clock | 1 | `Clock` | Heart-beat pulse train (0.5 – 4 Hz) |
| 4 | Switch (SPST) | 2 | `Switch` | Lead-off / probe-off simulation |
| 5 | Push button | 5 | `Push` | Silence, Menu, Up, Down, Standby |
| 6 | Push button | 1 | `Push` | Code-blue / manual alarm |
| 7 | LED (red) | 1 | `Led` | High-priority alarm |
| 8 | LED (yellow) | 1 | `Led` | Medium-priority alarm |
| 9 | LED (cyan / blue) | 1 | `Led` | Low-priority alarm |
| 10 | LED (green) | 1 | `Led` | Heartbeat indicator |
| 11 | Buzzer / speaker | 1 | `Buzzer` | Alarm tones |
| 12 | LED / relay | 1 | `Led` / `Relay` | Nurse-call output |
| 13 | 16×2 LCD + PCF8574 | 1 | `Lcd` + `I2CToParallel` | Vitals display |
| 14 | 74HC595 shift register | 1 | `74HC595` | 8-LED alarm / vital status bar |
| 15 | Serial terminal | 1 | `SerialPort` | Central-station link |

---

## 7. Pin Map

| Signal | Pin | Port bit | Direction | Notes |
|--------|-----|----------|-----------|-------|
| SpO₂ | 40 | `PA0` / ADC0 | Analog in | 0 – 1023 → 70 – 100 % |
| Body temperature | 39 | `PA1` / ADC1 | Analog in | 0 – 1023 → 30.0 – 45.0 °C |
| NIBP (systolic) | 38 | `PA2` / ADC2 | Analog in | 0 – 1023 → 50 – 250 mmHg |
| Respiration rate | 37 | `PA3` / ADC3 | Analog in | 0 – 1023 → 0 – 60 breaths/min |
| High-priority LED | 1 | `PB0` | Out | Red |
| Medium-priority LED | 2 | `PB1` | Out | Yellow |
| Low-priority LED | 3 | `PB2` | Out | Cyan |
| Heartbeat LED | 4 | `PB3` | Out | Flashes with each beat |
| 74HC595 `RCLK` | 5 | `PB4` | Out | Rising edge latches the shift register |
| SPI `MOSI` | 6 | `PB5` | Out | |
| SPI `MISO` | 7 | `PB6` | In | |
| SPI `SCK` | 8 | `PB7` | Out | |
| I2C `SCL` | 22 | `PC0` | Out | 4.7 kΩ pull-up |
| I2C `SDA` | 23 | `PC1` | Bidir | 4.7 kΩ pull-up |
| Silence button | 24 | `PC2` | In, pull-up | 120 s audio pause |
| Menu button | 25 | `PC3` | In, pull-up | Enter / exit limits menu |
| Up button | 26 | `PC4` | In, pull-up | |
| Down button | 27 | `PC5` | In, pull-up | |
| Standby button | 28 | `PC6` | In, pull-up | Monitoring on / off |
| CPU-load test pin | 29 | `PC7` | Out | Timing measurement |
| USART `RXD` | 14 | `PD0` | In | 9600 8N1 |
| USART `TXD` | 15 | `PD1` | Out | 9600 8N1 |
| Code-blue button | 16 | `PD2` / INT0 | In, pull-up | Manual high-priority alarm |
| Lead-off detect | 17 | `PD3` / INT1 | In, pull-up | **Technical alarm** source |
| Nurse-call output | 18 | `PD4` | Out | High = calling |
| Probe-off (SpO₂) | 19 | `PD5` | In, pull-up | Second technical alarm |
| Heart-beat pulse | 20 | `PD6` / `ICP1` | In | **Timer1 Input Capture** |
| Alarm speaker | 21 | `PD7` / OC2 | PWM out | Tone bursts |

> `PC2` – `PC6` carry the entire operator panel: **clear the `JTAGEN` fuse** or
> the Silence button will not work — which, in an alarm system, is the worst
> possible pin to lose.

---

## 8. Peripherals Used

| Peripheral | Configuration | Role |
|------------|---------------|------|
| **GPIO** | `PB0..PB3`, `PD4` out; panel in + pull-up | Indicators, nurse call, panel |
| **ADC** | Single conversion, prescaler 64, AVCC ref | 4 vital channels |
| **Timer0** | CTC, prescaler 1024, `OCR0 = 77` | 10 ms system tick |
| **Timer1** | Normal, prescaler 256, `ICIE1` + `TOIE1`, noise canceller on, rising edge | Beat-interval capture |
| **Timer2** | Fast PWM, OC2 | Alarm tones (different pitch per priority) |
| **INT0** | Falling edge | Code-blue button |
| **INT1** | Both edges (`ISC10 = 1`) | Lead-off detect, set and clear |
| **USART** | 9600 8N1, RX interrupt | Central-station link |
| **SPI** | Master, Mode 0, f/16 | 74HC595 shift register |
| **I2C (TWI)** | Master, 100 kHz | PCF8574 → LCD |

### Heart-rate maths

```
Timer1 prescaler 256 @ 8 MHz  →  31 250 Hz  →  1 tick = 32 µs

interval_ticks = ICR1(n) - ICR1(n-1)          (unsigned, wrap-safe)
HR (bpm)       = 1 875 000 / interval_ticks
```

Derivation: `bpm = 60 000 000 µs / interval_µs` and `interval_µs = ticks × 32`,
so `bpm = 60 000 000 / (32 × ticks) = 1 875 000 / ticks`.

| HR | Interval | Timer1 ticks | Fits 16-bit? |
|---:|---------:|-------------:|:------------:|
| 250 bpm | 240 ms | 7 500 | ✔ |
| 120 bpm | 500 ms | 15 625 | ✔ |
| 60 bpm | 1000 ms | 31 250 | ✔ |
| 40 bpm | 1500 ms | 46 875 | ✔ |
| 30 bpm | 2000 ms | 62 500 | ✔ (just) |
| < 28.6 bpm | > 2.097 s | > 65 535 | ✘ → **asystole** |

A capture interval that overflows the 16-bit timer means fewer than ~29 beats
per minute. Rather than extending the counter, treat a Timer1 overflow with no
capture as the **asystole detector** — that is clinically the right answer and
it is a nice example of a limitation becoming a feature. Document the reasoning.

### Heart-rate variability (fixed point, no `sqrt`)

Use the **mean absolute successive difference** instead of a standard deviation:

```c
/* over the last 8 intervals */
uint16_t hrv = 0;
for (i = 1; i < 8; i++)
    hrv += (uint16_t)ABS_DIFF(interval[i], interval[i-1]);
hrv /= 7;              /* mean absolute successive difference, in ticks */
```

Report it in milliseconds. A sudden jump indicates an irregular rhythm; a
collapse to zero indicates a perfectly regular signal generator, which is what
your simulator will produce until you modulate it.

---

## 9. Software Architecture

### 9.1 Layer view

```
┌───────────────────────────────────────────────────────────────────┐
│ APP                                                               │
│ ┌──────────┐ ┌────────────┐ ┌────────┐ ┌────────┐ ┌────────────┐  │
│ │monitor   │ │ alarm_mgr  │ │ trends │ │ menu   │ │  console   │  │
│ │  _fsm    │ │ (3 tiers)  │ │        │ │        │ │            │  │
│ └────┬─────┘ └─────┬──────┘ └───┬────┘ └───┬────┘ └─────┬──────┘  │
│      └─────────────┴──── scheduler (10 ms) ┴────────────┘         │
├───────────────────────────────────────────────────────────────────┤
│ HAL                                                               │
│  vitals.c  hr_capture.c  annunciator.c  lcd_i2c.c                 │
│  shiftreg.c  panel.c  nursecall.c                               │
├───────────────────────────────────────────────────────────────────┤
│ MCAL                                                              │
│  dio.c  adc.c  timer.c  icu.c  exti.c  usart.c  spi.c  i2c.c      │
├───────────────────────────────────────────────────────────────────┤
│ LIB    STD_TYPES.h  BIT_MATH.h  ring_buffer.c                     │
└───────────────────────────────────────────────────────────────────┘
```

### 9.2 The alarm manager

Every alarm condition is a row in a static table. `alarm_mgr.c` owns the whole
lifecycle: detect → latch → annunciate → silence → escalate → clear.

```c
typedef enum { PRI_NONE = 0, PRI_LOW, PRI_MEDIUM, PRI_HIGH } Priority_t;
typedef enum { CLASS_PHYSIO = 0, CLASS_TECHNICAL }           AlarmClass_t;

typedef struct {
    const char  *name;        /* "HR HIGH"                              */
    Priority_t   priority;
    AlarmClass_t klass;
    uint16_t     onDelayTicks;   /* confirm time before annunciating    */
    uint16_t     offDelayTicks;  /* confirm time before auto-clearing   */
    uint8_t      latching;       /* 1 = requires acknowledgement        */
} AlarmDef_t;

typedef struct {
    uint8_t  active   : 1;    /* condition currently true               */
    uint8_t  latched  : 1;    /* annunciated, awaiting acknowledgement  */
    uint8_t  silenced : 1;    /* audio paused                           */
    uint8_t  escalated: 1;    /* promoted after being ignored           */
    uint8_t  reserved : 4;
    uint16_t onTimer;
    uint16_t offTimer;
    uint16_t silenceTimer;    /* counts down from 120 s                 */
    uint16_t ageSeconds;      /* since first raised                     */
} AlarmState_t;
```

**Rules that define this project:**

1. The **highest active priority** drives the annunciator. A high-priority alarm
   is never masked by a low one.
2. Silence is **always temporary**. `silenceTimer` counts down from 120 s and
   the audio comes back. There is no "silence forever" — verify it in code
   review and in TC-27.
3. **Technical alarms cannot be silenced below medium priority.** If the SpO₂
   probe is off, the monitor is *not measuring* — that is more dangerous than a
   reading you can see is wrong.
4. A **medium-priority alarm ignored for 60 s escalates to high.** An escalated
   alarm cannot de-escalate while active.
5. Silencing one alarm does **not** silence a *new* alarm of equal or higher
   priority raised afterwards.

### 9.3 The alarm table

| # | Alarm | Class | Priority | On-delay | Latch | Condition |
|---|-------|-------|:--------:|:--------:|:-----:|-----------|
| A0 | `ASYSTOLE` | Physio | **High** | 4 s | Yes | No beat for 4 s |
| A1 | `HR HIGH` | Physio | High | 5 s | Yes | HR > `hrHigh` |
| A2 | `HR LOW` | Physio | High | 5 s | Yes | HR < `hrLow` |
| A3 | `SPO2 LOW` | Physio | **High** | 10 s | Yes | SpO₂ < `spo2Low` |
| A4 | `APNEA` | Physio | High | 20 s | Yes | Respiration = 0 for 20 s |
| A5 | `TEMP HIGH` | Physio | Medium | 30 s | Yes | Temp > `tempHigh` |
| A6 | `TEMP LOW` | Physio | Medium | 30 s | Yes | Temp < `tempLow` |
| A7 | `NIBP HIGH` | Physio | Medium | 5 s | Yes | Systolic > `nibpHigh` |
| A8 | `NIBP LOW` | Physio | **High** | 5 s | Yes | Systolic < `nibpLow` |
| A9 | `RESP HIGH` | Physio | Medium | 30 s | Yes | Resp > `respHigh` |
| A10 | `RESP LOW` | Physio | Medium | 30 s | Yes | Resp < `respLow` |
| A11 | `ARRHYTHMIA` | Physio | Medium | 10 s | Yes | HRV > `hrvLimit` |
| A12 | `LEAD OFF` | **Technical** | Medium | 1 s | Yes | `INT1` asserted |
| A13 | `PROBE OFF` | **Technical** | Medium | 1 s | Yes | `PD5` asserted |
| A14 | `SENSOR FAULT` | **Technical** | Medium | 5 s | Yes | Any ADC pinned at 0 / 1023 |
| A15 | `CODE BLUE` | Physio | **High** | 0 s | Yes | Manual button |
| A16 | `LOW BATTERY` | Technical | Low | 5 s | No | Simulated, bonus |

### 9.4 Annunciator signatures

`annunciator.c` translates the winning priority into light and sound.

| Priority | LED | Flash rate | Tone | Burst | Repeat |
|----------|-----|-----------|------|-------|--------|
| High | Red `PB0` | 2 Hz | 960 Hz | 10 pulses, 150 ms on / 100 ms off | Every 5 s |
| Medium | Yellow `PB1` | 0.6 Hz | 640 Hz | 3 pulses, 200 ms on / 150 ms off | Every 15 s |
| Low | Cyan `PB2` | Steady | 480 Hz | 2 pulses, 250 ms on / 200 ms off | Once |

The burst pattern is generated by a small state machine advanced from the 10 ms
tick — **not** by a chain of `_delay_ms()` calls.

### 9.5 Module responsibilities

| Module | Owns | Public API (suggested) |
|--------|------|------------------------|
| `monitor_fsm` | Monitoring state, standby, menu | `FSM_Init`, `FSM_Run`, `FSM_GetState` |
| `alarm_mgr` | Alarm table, latch, silence, escalate | `ALM_Evaluate`, `ALM_Silence`, `ALM_Ack`, `ALM_Highest`, `ALM_Mask` |
| `annunciator` | Light and sound patterns | `ANN_SetPriority`, `ANN_Tick`, `ANN_Mute` |
| `vitals` | ADC scaling, filtering, plausibility | `VIT_Update`, `VIT_Spo2`, `VIT_TempCx10`, `VIT_Nibp`, `VIT_Resp` |
| `hr_capture` | Beat intervals, HR, HRV, asystole | `HRC_OnCapture`, `HRC_OnOverflow`, `HRC_GetBpm`, `HRC_GetHrvMs` |
| `trends` | 60-sample fine ring + 24-sample coarse ring, both in RAM | `TRD_Sample`, `TRD_Get`, `TRD_Coarse` |
| `menu` | Limit editing on the LCD | `MNU_Enter`, `MNU_Key`, `MNU_Render` |
| `nursecall` | Relay output policy | `NRS_Update` |

### 9.6 Concurrency contract

- `ISR(TIMER1_CAPT_vect)` stores `ICR1`, computes the unsigned delta, pushes it
  into an 8-deep interval ring, sets a flag. **No division.**
- `ISR(TIMER1_OVF_vect)` increments a counter used only by the asystole
  detector.
- `ISR(INT0_vect)` sets the code-blue flag; `ISR(INT1_vect)` records the lead-off
  level on both edges.
- `ALM_Evaluate()` runs in one place, in the 100 ms task. Nothing else writes
  `AlarmState_t`.
- `ANN_Tick()` runs in the 10 ms task and is the only writer of the LEDs and the
  speaker.

---

## 10. Data Dictionary (required data)

### 10.1 Runtime vitals — `DD-01 Vitals_t`

```c
typedef struct {
    uint16_t hrBpm;            /* 0..250, 0 = no beat detected           */
    uint16_t hrvMs;            /* mean abs successive difference, ms     */
    uint8_t  spo2Pct;          /* 70..100                                */
    uint16_t tempCx10;         /* 300..450  (30.0..45.0 °C)              */
    uint8_t  nibpSys;          /* 50..250 mmHg                           */
    uint8_t  nibpDia;          /* derived, ~ 2/3 of systolic             */
    uint8_t  respBpm;          /* 0..60 breaths/min                      */
    uint8_t  perfusionPct;     /* bonus: pulse strength                  */
    uint8_t  leadOff    : 1;
    uint8_t  probeOff   : 1;
    uint8_t  beatFlag   : 1;   /* set for one tick on each beat          */
    uint8_t  reserved   : 5;
    uint32_t monitorSec;       /* seconds monitoring this patient        */
} Vitals_t;
```

### 10.2 Patient profile — `DD-02 PatientCfg_t`

```c
#define PAT_MAGIC   0x504Du      /* 'P','M'                              */
#define PAT_VERSION 0x01u

typedef struct {
    uint16_t magic;
    uint8_t  version;
    char     patientId[8];       /* ASCII, space padded, not NUL-term    */
    uint8_t  profile;            /* 0 = adult, 1 = paediatric, 2 = neonatal */
    uint16_t hrLow,   hrHigh;    /* adult defaults  50 / 120             */
    uint8_t  spo2Low;            /*                 90                   */
    uint16_t tempLowX10, tempHighX10; /*           350 / 380             */
    uint8_t  nibpLow,  nibpHigh; /*                 90 / 160             */
    uint8_t  respLow,  respHigh; /*                  8 / 30              */
    uint16_t hrvLimitMs;         /*                200                   */
    uint16_t silenceSec;         /* audio pause    120                   */
    uint16_t escalateSec;        /* medium → high   60                   */
    uint16_t trendHead;          /* coarse ring index                    */
    uint16_t alarmHead;          /* alarm log ring index                 */
    uint16_t admitCount;
    uint8_t  checksum;
} PatientCfg_t;                  /* 46 bytes                             */
```

### 10.3 Age-profile defaults — `DD-03`

Stored in flash; selecting a profile loads these into `PatientCfg_t`.

| Parameter | Adult | Paediatric | Neonatal |
|-----------|:-----:|:----------:|:--------:|
| `hrLow` / `hrHigh` | 50 / 120 | 70 / 150 | 100 / 190 |
| `spo2Low` | 90 | 92 | 88 |
| `tempLowX10` / `tempHighX10` | 350 / 380 | 355 / 380 | 360 / 375 |
| `nibpLow` / `nibpHigh` | 90 / 160 | 80 / 130 | 55 / 90 |
| `respLow` / `respHigh` | 8 / 30 | 15 / 40 | 25 / 60 |

Loading a profile is a single table copy. Adding a fourth profile must require
only a table row — same rule as Project 05's scenes.

### 10.4 Trend sample — `DD-04 TrendSample_t`

```c
/* RAM ring: 60 samples at 10 s = 10 minutes of history */
typedef struct {
    uint8_t  hr;              /* bpm, clipped to 250                     */
    uint8_t  spo2;            /* %                                       */
    uint8_t  tempX2Minus60;   /* (tempCx10 - 300) / 5, fits 0..30        */
    uint8_t  nibpSys;         /* mmHg                                    */
    uint8_t  resp;            /* breaths/min                             */
    uint8_t  alarmMask;       /* highest priority active at this sample  */
} TrendSample_t;              /* 6 bytes × 60 = 360 B RAM                */
```

The temperature compression is deliberate: 30.0 – 45.0 °C in 0.5 °C steps fits a
single byte with room to spare. Explain the trade-off (resolution lost vs. RAM
saved) in your report.

### 10.5 Alarm log record — `DD-05 AlarmRec_t`

```c
typedef struct {
    uint8_t  alarmId;         /* index into the alarm table              */
    uint8_t  priority;        /* at the time it was raised               */
    uint32_t timeSec;         /* monitorSec at raise                     */
    uint16_t durationSec;     /* how long it stayed active               */
    uint8_t  value;           /* the offending measurement               */
    uint8_t  flags;           /* bit0 silenced, bit1 escalated, bit2 ack */
} AlarmRec_t;                 /* 10 bytes                                */
```

### 10.6 Enumerations — `DD-06`

```c
typedef enum { MS_INIT = 0, MS_STANDBY, MS_MONITORING, MS_ALARM,
               MS_SILENCED, MS_MENU, MS_ADMIT }            MonState_t;

typedef enum { PROF_ADULT = 0, PROF_PAED, PROF_NEONATAL }  Profile_t;
```

### 10.7 Derived constants — `DD-07`

| Constant | Value | Meaning |
|----------|-------|---------|
| `TIMER1_TICK_US` | 32 | Prescaler 256 @ 8 MHz |
| `HR_NUM` | 1 875 000 | `bpm = HR_NUM / ticks` |
| `ASYSTOLE_TICKS` | 400 | 4 s with no beat |
| `HRV_WINDOW` | 8 | Intervals used for variability |
| `SILENCE_TICKS` | 12 000 | 120 s |
| `ESCALATE_TICKS` | 6 000 | 60 s |
| `TREND_PERIOD_TICKS` | 1 000 | 10 s per trend sample |
| `TREND_RAM_DEPTH` | 60 | 10 minutes |
| `TREND_COARSE_DEPTH` | 24 | 4 hours at 10 min per coarse sample |
| `HIGH_BURST_PULSES` | 10 | IEC-style high-priority burst |
| `MED_BURST_PULSES` | 3 | Medium |
| `LOW_BURST_PULSES` | 2 | Low |

---

## 11. System Specifications

### 11.1 Measurement ranges and accuracy

| Vital | Range | Resolution | Update rate | Accuracy target |
|-------|-------|:----------:|:-----------:|-----------------|
| HR | 30 – 250 bpm | 1 bpm | Per beat, published 2 Hz | ±2 bpm |
| HRV | 0 – 500 ms | 1 ms | 2 Hz | Indicative only |
| SpO₂ | 70 – 100 % | 1 % | 1 Hz | ±1 % |
| Temperature | 30.0 – 45.0 °C | 0.1 °C | 0.5 Hz | ±0.2 °C |
| NIBP systolic | 50 – 250 mmHg | 1 mmHg | On cuff cycle | ±3 mmHg |
| Respiration | 0 – 60 /min | 1 /min | 0.5 Hz | ±2 /min |

### 11.2 Adult alarm limits (defaults)

| Vital | Low limit | High limit | Low-side priority | High-side priority |
|-------|:---------:|:----------:|:-----------------:|:------------------:|
| HR | 50 | 120 | High | High |
| SpO₂ | 90 | — | **High** | — |
| Temperature | 35.0 °C | 38.0 °C | Medium | Medium |
| NIBP systolic | 90 | 160 | **High** | Medium |
| Respiration | 8 | 30 | Medium | Medium |

Note the asymmetry: low SpO₂ and low blood pressure are high priority, while
high temperature is medium. The priority reflects **how quickly it kills**, not
how far from normal it is. Explain this ordering in your report.

### 11.3 Alarm timing

| Behaviour | Value |
|-----------|-------|
| Silence duration | 120 s (configurable 60 – 300 s) |
| Escalation | Medium unacknowledged for 60 s → High |
| Auto-clear delay | 10 s of the condition being false |
| Latch | All alarms latch; acknowledgement required |
| Nurse call | Asserted while any high-priority alarm is latched and unacknowledged |

### 11.4 NIBP cuff cycle

The NIBP measurement is not continuous. A cycle takes 30 s:

```
INFLATE (5 s) → HOLD (2 s) → DEFLATE + measure (20 s) → RESULT (3 s)
```

- Automatic cycle every `nibpIntervalMin` minutes (default 15, range 1 – 60).
- Manual cycle on the `NIBP` command or a menu action.
- During a cycle the LCD shows `NIBP…` and a progress indicator.
- The previous result stays displayed with its age (`NIBP 120/80 (12m)`).
- Diastolic is modelled as `systolic × 2 / 3` — this is a crude simulation, and
  your report must say so.

---

## 12. Inputs & Outputs

### 12.1 Inputs

| ID | Name | Channel | Type | Sample rate |
|----|------|---------|------|-------------|
| IN-1 | SpO₂ | ADC0 | Analog | 1 Hz |
| IN-2 | Temperature | ADC1 | Analog | 0.5 Hz |
| IN-3 | NIBP | ADC2 | Analog | During cuff cycle |
| IN-4 | Respiration | ADC3 | Analog | 0.5 Hz |
| IN-5 | Heart beat | `PD6`/`ICP1` | Pulse interval | Every beat |
| IN-6 | Code blue | `PD2`/INT0 | Digital, edge | Interrupt |
| IN-7 | Lead off | `PD3`/INT1 | Digital, both edges | Interrupt |
| IN-8 | Probe off | `PD5` | Digital, polled | 20 Hz |
| IN-9 | Panel buttons | `PC2`…`PC6` | Digital, polled | 100 Hz |
| IN-10 | Console | USART RX | ASCII line | Interrupt |

### 12.2 Outputs

| ID | Name | Pin | Type | Meaning |
|----|------|-----|------|---------|
| OUT-1 | High alarm LED | `PB0` | Digital | Red, 2 Hz flash |
| OUT-2 | Medium alarm LED | `PB1` | Digital | Yellow, 0.6 Hz flash |
| OUT-3 | Low alarm LED | `PB2` | Digital | Cyan, steady |
| OUT-4 | Heartbeat LED | `PB3` | Digital | 50 ms flash per beat |
| OUT-5 | Alarm speaker | `PD7`/OC2 | PWM tone | Priority-specific bursts |
| OUT-6 | Nurse call | `PD4` | Digital | High = calling |
| OUT-7 | LCD | I2C | 16×2 text | Vitals and alarms |
| OUT-8 | Central station | USART TX | ASCII | 2 s frame + events |

---

## 13. Functional Requirements

### FR-01 — Heart-rate measurement

The system **shall** measure the beat-to-beat interval with Timer1 Input Capture
and publish HR at **2 Hz**.

**Acceptance criteria**
- `HR = 1 875 000 / interval_ticks`, integer division only.
- Accuracy ±2 bpm from 40 to 200 bpm against the injected frequency.
- The input noise canceller (`ICNC1`) is enabled; injected glitches produce no
  false beats.
- The published HR is a **median of the last 3 intervals**, so one dropped or
  doubled beat does not swing the display.
- No division in the capture ISR.

### FR-02 — Asystole detection

No capture for **4 s** **shall** raise the `ASYSTOLE` high-priority alarm.

**Acceptance criteria**
- Detected via the Timer1 overflow counter, not by polling elapsed time in a
  loop.
- HR displays `---`, not the last value — a stale number here is a safety defect.
- Annunciation starts within 4.2 s of the last beat.
- Resuming the pulse train clears the condition after the auto-clear delay.

### FR-03 — Heart-rate variability

The system **shall** compute the mean absolute successive difference over the
last 8 intervals and publish it in milliseconds at 2 Hz.

**Acceptance criteria**
- Fixed-point integer arithmetic; no `sqrt`, no `float`.
- A perfectly regular input gives HRV ≈ 0.
- Modulating the input period by ±20 % gives a clearly elevated HRV.
- HRV above `hrvLimitMs` for 10 s raises the `ARRHYTHMIA` medium alarm.

### FR-04 — Analog vital acquisition

The system **shall** sample SpO₂, temperature and respiration at the rates of
§11.1 with appropriate filtering.

**Acceptance criteria**
- Temperature uses a 16-sample moving average (a body temperature that jitters
  0.5 °C between refreshes is unusable).
- SpO₂ uses an 8-sample average.
- Scaling per §7 with `uint32_t` intermediates.
- Any channel pinned at 0 or 1023 for 5 s raises `SENSOR FAULT`.

### FR-05 — NIBP cuff cycle

The system **shall** run the 30 s cuff cycle of §11.4 automatically every
`nibpIntervalMin` and on demand.

**Acceptance criteria**
- The cycle is a state machine driven by the scheduler; no blocking.
- The LCD shows the phase and a progress indicator.
- The previous result remains visible with its age in minutes.
- A cycle can be aborted by the `NIBP STOP` command or the Menu button; the
  previous result is retained.
- Alarms A7/A8 evaluate only against a **fresh** result (age ≤ 2 × interval).

### FR-06 — Three-tier alarm annunciation

The annunciator **shall** produce the distinct signatures of §9.4 for each
priority.

**Acceptance criteria**
- Burst counts are exactly 10 / 3 / 2 pulses.
- Tones are distinguishable by ear and by frequency measurement.
- The LED flash rates match §9.4 within 10 %.
- The whole pattern is scheduler-driven; `grep` finds no `_delay_ms` in
  `annunciator.c`.

### FR-07 — Priority arbitration

When several alarms are active, the annunciator **shall** present the **highest**
priority.

**Acceptance criteria**
- A high alarm raised while a medium is annunciating switches the pattern within
  1 s.
- All active alarms appear in the LCD list and in the telemetry mask, even
  though only one drives the sound.
- Clearing the high alarm reverts the annunciator to the still-active medium one.

### FR-08 — Alarm latching and acknowledgement

Every alarm in §9.3 with `latching = 1` **shall** stay annunciated after its
condition clears, until acknowledged.

**Acceptance criteria**
- Acknowledgement is a Silence-button press when no alarm is active, or the
  `ACK <id>` command.
- Acknowledging an alarm whose condition is still true silences the audio but
  keeps the light and the latch.
- The LCD distinguishes an active alarm from a latched-but-cleared one.

### FR-09 — Alarm silencing (bounded)

Pressing Silence **shall** pause the audio for `silenceSec` (default 120 s).

**Acceptance criteria**
- The LCD shows the remaining silence time, counting down.
- The **visual** indication is never silenced — only the audio.
- The audio returns automatically when the timer expires if the alarm is still
  active.
- **There is no way to silence permanently.** Code inspection plus TC-27 must
  confirm that no command, key combination or configuration value disables the
  audio indefinitely.
- A *new* alarm of equal or higher priority raised during a silence period
  breaks the silence immediately.

### FR-10 — Technical-alarm handling

`LEAD OFF`, `PROBE OFF` and `SENSOR FAULT` **shall** be treated as technical
alarms.

**Acceptance criteria**
- The affected vital displays `---`, never a stale or invented value.
- Physiological alarms for that vital are **suspended** while its sensor is
  disconnected — a lead-off must not also fire an asystole alarm. This is the
  single most important behaviour in the project.
- A technical alarm cannot be silenced below medium priority.
- Reconnecting clears the technical alarm after the auto-clear delay and resumes
  the physiological checks.

### FR-11 — Escalation

A **medium** alarm that remains active and unacknowledged for `escalateSec`
(default 60 s) **shall** escalate to **high**.

**Acceptance criteria**
- The annunciator switches to the high-priority signature.
- `!EVT,ALARM,ESCALATE,<id>` is logged.
- An escalated alarm does **not** de-escalate while active, even if
  acknowledged.
- Acknowledging before the 60 s mark stops the escalation timer.

### FR-12 — Nurse call

The nurse-call output **shall** assert while any high-priority alarm is latched
and unacknowledged.

**Acceptance criteria**
- Asserted within 1 s of the alarm.
- Released within 1 s of acknowledgement or clearing.
- Not affected by audio silencing — silencing the room does not cancel the call.

### FR-13 — Trend buffers

The system **shall** maintain a 60-sample RAM trend at 10 s intervals and a
24-sample coarse history at 10 min intervals.

**Acceptance criteria**
- The RAM ring holds exactly 10 minutes and overwrites oldest-first.
- Each sample records the highest alarm priority active during that interval.
- The coarse history takes one sample every 10 min, covering 4 hours.
- `TREND?` dumps the fine ring; `HISTORY?` dumps the coarse ring.
- The compression of §10.4 is implemented and its accuracy documented.

### FR-14 — Patient admission and profiles

The `ADMIT` flow **shall** set a patient ID and an age profile, loading the
matching default limits.

**Acceptance criteria**
- Admitting clears the trend buffers, alarm log and monitor timer.
- The profile table is data-driven; adding a profile requires only a table row.
- Patient ID is 8 ASCII characters, settable from the console and the menu.
- `admitCount` increments on every admission.

### FR-15 — Alarm-limit menu

The Menu / Up / Down buttons **shall** allow every limit in §11.2 to be edited
on the LCD.

**Acceptance criteria**
- Each limit is range-checked; a low limit can never exceed its high limit.
- Changes take effect immediately and are re-validated on menu exit.
- The menu times out after 60 s and discards uncommitted changes.
- **Alarms remain fully active while the menu is open.** A monitor that stops
  alarming because someone is editing a setting is a defect.

### FR-16 — Standby

The Standby button **shall** toggle `MS_STANDBY`, suspending monitoring.

**Acceptance criteria**
- All physiological alarms are suspended; the LCD shows `STANDBY` with a large
  reminder and the elapsed standby time.
- A **reminder chirp every 60 s** while in standby — this must not be silenceable
  (a monitor silently left in standby is a classic incident).
- The technical alarms and the console remain active.
- Leaving standby restores monitoring with cleared alarm timers.

### FR-17 — LCD display

The LCD **shall** refresh every **250 ms**:

```
Line 1: HR 72  SpO2 98%
Line 2: T37.2 120/80 R16
```

**Acceptance criteria**
- On alarm, line 2 alternates every 1.5 s with `!!HR HIGH  132!!` (high) or
  `!TEMP HIGH 38.4!` (medium).
- During a silence, the banner shows `SIL 087` counting down.
- A disconnected sensor shows `---` for that vital.
- Only changed characters are rewritten.

### FR-18 — Central-station telemetry and console

The system **shall** transmit the frame of §18.1 every **2 s** and accept the
commands of §18.2.

**Acceptance criteria**
- 2 s cadence — faster than the general book default, because a central station
  needs it.
- Alarm events are transmitted immediately, not batched into the next frame.
- No command can disable the alarm system. `ALARM OFF` returns `ERR PROTECTED`.
- Parser robustness per the book standard.

---

## 14. Non-Functional Requirements

| ID | Requirement |
|----|-------------|
| **NFR-01** | Compiles with `avr-gcc -std=c99 -Wall -Wextra -Os`, zero warnings. |
| **NFR-02** | No blocking delay > 10 ms in the super-loop; `_delay_ms` only in `*_Init()`. |
| **NFR-03** | **No alarm can be permanently disabled** by any command, key sequence or configuration value. |
| **NFR-04** | A disconnected sensor never produces a numeric reading — `---` only. |
| **NFR-05** | Physiological alarms are suspended for a vital whose sensor is disconnected. |
| **NFR-06** | Alarm annunciation begins within 1 s of the confirm delay expiring. |
| **NFR-07** | No floating-point arithmetic; all vitals use scaled integers. |
| **NFR-08** | Age-profile defaults and the alarm table live in `PROGMEM`. |
| **NFR-09** | Layer rule respected; only `MCAL/*.c` touches registers. |
| **NFR-10** | ISRs ≤ 10 lines; no division in the capture ISR. |
| **NFR-11** | Only `alarm_mgr.c` writes `AlarmState_t`; only `annunciator.c` writes the LEDs and speaker. |
| **NFR-12** | Tick jitter ≤ ±1 ms; CPU load ≤ 60 %, measured on `PC7`. |
| **NFR-13** | `.data + .bss` ≤ 1 KB — note the 360 B trend ring is a large fraction of it, so budget carefully. |
| **NFR-14** | On reset the monitor enters `MS_INIT`, runs a 3 s self-test of all three alarm LEDs and the speaker, then resumes. |
| **NFR-15** | The alarm log and patient profile survive power loss. |
| **NFR-16** | **No dynamic memory.** `malloc`, `calloc`, `realloc`, `free`, `alloca` and variable-length arrays are banned. Every buffer, table, queue and log is a fixed-size array whose length is a `#define` in `config.h`. Prove it: `avr-nm main.elf \| grep -i malloc` must print nothing. |
| **NFR-17** | **No recursion.** No function may call itself, directly or through any chain of calls — the call graph must be acyclic. Every search, scan, parse and traversal is written as a loop. State your worst-case stack depth in the report. |

---

## 15. Operating Modes

| State | Physio alarms | Technical alarms | Display | Audio |
|-------|:-------------:|:----------------:|---------|-------|
| `MS_INIT` | Off | Off | Self-test | Test tone |
| `MS_STANDBY` | **Suspended** | Active | `STANDBY hh:mm` | 60 s reminder chirp |
| `MS_MONITORING` | Active | Active | Vitals | Silent |
| `MS_ALARM` | Active | Active | Vitals + banner | Priority pattern |
| `MS_SILENCED` | Active | Active | Vitals + `SIL nnn` | **Visual only** |
| `MS_MENU` | **Active** | Active | Menu | Priority pattern |
| `MS_ADMIT` | Suspended | Active | Admission form | Silent |

---

## 16. System Flow

```
   ┌──────────────┐
   │  Power ON    │
   └──────┬───────┘
          ▼
   ┌───────────────────────────────────────┐
   │ MCAL init: DIO, ADC, T0, T1(ICU), T2, │
   │ EXTI, USART, SPI, I2C                 │
   └──────┬────────────────────────────────┘
          ▼
   ┌───────────────────────────────────────┐
   │ SELF-TEST 3 s: all 3 alarm LEDs on,   │  ← required by NFR-14
   │ one tone burst, LCD banner            │
   └──────┬────────────────────────────────┘
          ▼
   ┌───────────────────────────────────────┐  invalid  ┌──────────────┐
   │ Load PatientCfg_t, verify checksum    ├──────────▶│ Adult profile│
   └──────┬────────────────────────────────┘           │ + log        │
          │ valid                                      └──────┬───────┘
          ▼◀─────────────────────────────────────────────────┘
   ┌───────────────────────────────────────┐
   │ MS_MONITORING, trend buffers cleared  │
   └──────┬────────────────────────────────┘
          ▼
╔════════════════════════════════════════════════════════════╗
║             SUPER-LOOP (dispatch on 10 ms tick)            ║
║                                                            ║
║   10 ms → panel, monitor FSM, ANN_Tick() (burst patterns)  ║
║   20 ms → probe-off poll, console line parse               ║
║   50 ms → heartbeat LED, silence/escalate countdowns       ║
║  100 ms → ALM_Evaluate()  ← the only alarm-state writer    ║
║  250 ms → LCD repaint                                      ║
║  500 ms → HR/HRV publish, SpO2, respiration                ║
║    1 s  → temperature, NIBP cycle step, nurse call         ║
║    2 s  → telemetry frame                                  ║
║   10 s  → RAM trend sample                                 ║
║   10 m  → coarse history sample                           ║
║  event  → alarm log append, profile save                   ║
╚════════════════════════════════════════════════════════════╝
```

---

## 17. State Machine

### 17.1 Diagram

```
                     ┌──────────────┐
        power on     │   MS_INIT    │  3 s self-test
       ─────────────▶│              │
                     └──────┬───────┘
                            ▼
        ┌──────────────────────────────────────────┐
   ┌───▶│            MS_MONITORING                 │◀──────┐
   │    └───┬──────────┬──────────┬────────────┬───┘       │
   │        │ STANDBY  │ alarm    │ MENU btn   │ ADMIT     │
   │        ▼          ▼          ▼            ▼           │
   │  ┌───────────┐ ┌────────┐ ┌─────────┐ ┌──────────┐   │
   │  │MS_STANDBY │ │MS_ALARM│ │ MS_MENU │ │ MS_ADMIT │   │
   │  │ 60 s chirp│ │ pattern│ │ alarms  │ │ new pt   │   │
   │  └─────┬─────┘ └───┬────┘ │ STILL   │ └────┬─────┘   │
   │        │           │      │ ACTIVE  │      │         │
   │        │ STANDBY   │      └────┬────┘      │ done    │
   │        └───────────┼───────────┴───────────┴─────────┘
   │                    │ SILENCE
   │                    ▼
   │            ┌───────────────┐
   │            │ MS_SILENCED   │  120 s max, visual continues
   │            └───────┬───────┘
   │      timer expired │ or new equal/higher alarm
   │                    ▼
   │               MS_ALARM
   │                    │ condition cleared && acknowledged
   └────────────────────┘
```

### 17.2 Transition table

| # | From | Event / guard | To | Actions |
|---|------|---------------|----|---------|
| T1 | `MS_INIT` | Self-test complete ∧ profile loaded | `MS_MONITORING` | Clear trends, log `!EVT,BOOT` |
| T2 | `MS_MONITORING` | Any alarm confirm timer expires | `MS_ALARM` | Latch, start annunciation, log |
| T3 | `MS_ALARM` | Silence pressed | `MS_SILENCED` | Start 120 s timer, mute audio only |
| T4 | `MS_SILENCED` | Timer expires ∧ alarm still active | `MS_ALARM` | Resume audio, log `!EVT,ALARM,UNSILENCE` |
| T5 | `MS_SILENCED` | New alarm ≥ current priority | `MS_ALARM` | **Break the silence immediately** |
| T6 | `MS_ALARM` ∨ `MS_SILENCED` | All conditions cleared ∧ acknowledged | `MS_MONITORING` | Clear latches, log durations |
| T7 | `MS_ALARM` | Medium active 60 s unacknowledged | `MS_ALARM` | Escalate to high, log |
| T8 | `MS_MONITORING` | Standby pressed | `MS_STANDBY` | Suspend physio alarms, start reminder |
| T9 | `MS_STANDBY` | Standby pressed | `MS_MONITORING` | Resume, reset confirm timers |
| T10 | any monitoring state | Menu pressed | `MS_MENU` | **Alarms keep running** |
| T11 | `MS_MENU` | Menu pressed ∨ 60 s timeout | previous state | Save or discard |
| T12 | `MS_MONITORING` | `ADMIT` command | `MS_ADMIT` | Suspend physio alarms |
| T13 | `MS_ADMIT` | Admission complete | `MS_MONITORING` | Load profile, clear trends, `admitCount++` |
| T14 | any | Code-blue button | `MS_ALARM` | Immediate high-priority alarm, no confirm delay |
| T15 | any | Lead-off / probe-off asserted | same | Technical alarm, suspend that vital's physio alarms |

---

## 18. UART Protocol

**Link:** 9600 8N1. Device sends `\r\n`; accepts `\r`, `\n`, `\r\n`.

### 18.1 Telemetry frame (every **2 s**)

```
$PM,ID=BED0012,HR=72,HV=38,SP=98,T=372,NS=120,ND=80,RR=16,AL=0000,PRI=0,ST=MON,SIL=0,UP=3600*57
```

| Field | Meaning | Units |
|-------|---------|-------|
| `ID` | Patient identifier | 8 chars |
| `HR` | Heart rate (`---` if none) | bpm |
| `HV` | HR variability | ms |
| `SP` | SpO₂ | % |
| `T` | Temperature ×10 | 0.1 °C |
| `NS` / `ND` | NIBP systolic / diastolic | mmHg |
| `RR` | Respiration | /min |
| `AL` | Active-alarm bitmask | 4 hex digits |
| `PRI` | Highest active priority | 0 – 3 |
| `ST` | `INIT`\|`STBY`\|`MON`\|`ALM`\|`SIL`\|`MENU`\|`ADM` | |
| `SIL` | Silence remaining | s |
| `UP` | Monitoring time | s |
| `*57` | XOR checksum between `$` and `*` | |

A vital with a disconnected sensor is transmitted as `---`, never as a number.

### 18.2 Command set

| Command | Response | Effect |
|---------|----------|--------|
| `STATUS` | telemetry frame | Immediate report |
| `VITALS?` | human-readable block | All vitals with units |
| `HR?` | `HR=72,HV=38` | |
| `ALARMS?` | one line per active/latched alarm | `ALM,id,name,pri,age,flags` |
| `ACK` | `OK` | Acknowledge all latched-and-cleared alarms |
| `ACK <id>` | `OK` / `ERR ARG` | Acknowledge one |
| `SILENCE` | `OK,120` | Start the bounded silence |
| `SILENCE?` | `SILENCE=87` | Remaining seconds |
| `ALARM OFF` | `ERR PROTECTED` | **Always refused** |
| `LIMITS?` | `LIM=50,120,90,350,380,90,160,8,30,200` | All limits in order |
| `SET HRLOW <n>` | `OK` / `ERR RANGE` | 20 – 200, must be < `HRHIGH` |
| `SET HRHIGH <n>` | `OK` / `ERR RANGE` | |
| `SET SPO2LOW <n>` | `OK` / `ERR RANGE` | 70 – 99 |
| `SET TEMPLOW <n>` | `OK` / `ERR RANGE` | ×10, 300 – 420 |
| `SET TEMPHIGH <n>` | `OK` / `ERR RANGE` | |
| `SET NIBPLOW <n>` | `OK` / `ERR RANGE` | 40 – 200 |
| `SET NIBPHIGH <n>` | `OK` / `ERR RANGE` | |
| `SET RESPLOW <n>` | `OK` / `ERR RANGE` | 2 – 50 |
| `SET RESPHIGH <n>` | `OK` / `ERR RANGE` | |
| `SET HRV <n>` | `OK` / `ERR RANGE` | 50 – 500 ms |
| `SET SILENCE <n>` | `OK` / `ERR RANGE` | 60 – 300 s |
| `PROFILE <ADULT\|PAED\|NEO>` | `OK` / `ERR ARG` | Load age defaults |
| `ADMIT <id>` | `OK` | New patient, clear trends |
| `STANDBY ON` / `OFF` | `OK` | |
| `NIBP` / `NIBP STOP` | `OK` | Start / abort a cuff cycle |
| `TREND?` | 60 CSV lines | RAM ring, oldest first |
| `HISTORY?` | 24 CSV lines | Coarse ring |
| `LOG?` | 16 lines | Alarm log |
| `CLRLOG` | `OK` | Erase the alarm log |
| `HELP` | command list | |

### 18.3 Asynchronous events

Alarm events are sent immediately, never batched.

```
!EVT,BOOT
!EVT,ADMIT,BED0012,ADULT
!EVT,ALARM,SET,1,HR HIGH,HIGH,132
!EVT,ALARM,SILENCE,120
!EVT,ALARM,UNSILENCE,1
!EVT,ALARM,ESCALATE,5,TEMP HIGH
!EVT,ALARM,ACK,1
!EVT,ALARM,CLR,1,DUR=145
!EVT,TECH,LEADOFF,SET
!EVT,TECH,LEADOFF,CLR
!EVT,ASYSTOLE
!EVT,CODEBLUE
!EVT,NURSECALL,ON
!EVT,STANDBY,ON
!EVT,STANDBY,REMINDER,300
!EVT,NIBP,RESULT,120,80
!EVT,PROFILE,PAED
```

---

## 19. Task Scheduling

| ID | Task | Period | Offset | Budget | Work |
|----|------|:------:|:------:|:------:|------|
| T-1 | `Task_Panel` | 10 ms | 0 | 150 µs | Buttons, debounce |
| T-2 | `Task_FSM` | 10 ms | 0 | 200 µs | Monitor `switch` |
| T-3 | `Task_Annunciate` | 10 ms | 0 | 150 µs | Burst pattern state machine |
| T-4 | `Task_Console` | 20 ms | 1 | 500 µs | Parse one line |
| T-5 | `Task_Timers` | 50 ms | 2 | 200 µs | Silence, escalate, heartbeat LED |
| T-6 | `Task_Alarms` | 100 ms | 3 | 700 µs | `ALM_Evaluate` |
| T-7 | `Task_LCD` | 250 ms | 5 | 4 ms | Repaint |
| T-8 | `Task_Fast vitals` | 500 ms | 4 | 800 µs | HR/HRV publish, SpO₂, respiration |
| T-9 | `Task_1Hz` | 1 s | 6 | 700 µs | Temperature, NIBP step, nurse call |
| T-10 | `Task_Report` | 2 s | 7 | 2 ms | Telemetry frame |
| T-11 | `Task_Trend` | 10 s | 8 | 300 µs | RAM trend sample |

**Ordering:** T-6 (alarm evaluation) must precede T-3's next pattern decision.
Because T-3 runs every tick and T-6 every 10 ticks, the worst-case latency from
condition to annunciation is 110 ms — well inside NFR-06's 1 s. Show this
calculation.

---

## 20. Testing Requirements

Alarm injection is the core of this test plan.

| ID | Test | Method | Pass criterion |
|----|------|--------|----------------|
| TC-01 | Self-test | Power on | 3 alarm LEDs and one tone burst, 3 s |
| TC-02 | Cold boot | Power on | Adult defaults, no crash |
| TC-03 | Live limit change | `SET HRHIGH 130`, drive HR to 135 | Alarm fires at the new limit |
| TC-04 | Corrupted profile | Flip a byte | Adult defaults loaded |
| TC-05 | HR @ 60 bpm | Inject 1 Hz | Reads 60 ±2 |
| TC-06 | HR @ 150 bpm | Inject 2.5 Hz | Reads 150 ±2 |
| TC-07 | HR @ 40 bpm | Inject 0.67 Hz | Reads 40 ±2 |
| TC-08 | Noise canceller | Add glitches to `ICP1` | No false beats |
| TC-09 | Median filter | Drop one beat | Displayed HR does not swing more than 10 bpm |
| TC-10 | **Asystole** | Stop the pulse train | Alarm within 4.2 s, HR shows `---` |
| TC-11 | Asystole recovery | Resume pulses | Clears after the auto-clear delay |
| TC-12 | HRV regular | Steady pulse train | HRV ≈ 0 |
| TC-13 | HRV irregular | Modulate the period ±20 % | HRV clearly elevated |
| TC-14 | Arrhythmia alarm | HRV above limit for 12 s | Medium alarm raised |
| TC-15 | SpO₂ scaling | Pot at 0 / 50 / 100 % | 70, 85 ±1, 100 % |
| TC-16 | Temperature damping | Swing the pot quickly | Display moves smoothly, no jitter |
| TC-17 | Respiration scaling | Pot sweep | 0 – 60 /min linear |
| TC-18 | NIBP cycle | Trigger `NIBP` | 30 s non-blocking cycle, phases shown |
| TC-19 | NIBP abort | `NIBP STOP` mid-cycle | Aborts, previous result retained |
| TC-20 | NIBP staleness | Wait past 2 intervals | Alarms suppressed on a stale reading |
| TC-21 | **High-priority pattern** | Force `HR HIGH` | 10-pulse burst every 5 s, red at 2 Hz |
| TC-22 | **Medium pattern** | Force `TEMP HIGH` | 3-pulse burst every 15 s, yellow at 0.6 Hz |
| TC-23 | **Low pattern** | Force a low alarm | 2 pulses once, cyan steady |
| TC-24 | Priority arbitration | Medium active, then raise high | Switches to high within 1 s |
| TC-25 | Priority revert | Clear the high alarm | Reverts to the medium pattern |
| TC-26 | Silence | Press Silence during an alarm | Audio muted 120 s, **light continues** |
| TC-27 | **Silence is bounded** | Wait out the 120 s | Audio returns automatically |
| TC-28 | **Silence not permanent** | Try every command and key combination | No path disables audio indefinitely |
| TC-29 | Silence broken by new alarm | Silence a medium, then raise a high | Audio resumes immediately |
| TC-30 | Latching | Raise then clear a condition | Alarm remains latched |
| TC-31 | Acknowledgement | ACK a cleared alarm | Latch clears |
| TC-32 | ACK while active | ACK an active alarm | Audio silenced, light and latch remain |
| TC-33 | **Escalation** | Leave a medium alarm 65 s | Escalates to high, logged |
| TC-34 | Escalation stopped | ACK at 30 s | No escalation |
| TC-35 | No de-escalation | ACK after escalating | Stays high while active |
| TC-36 | **Lead off** | Assert `INT1` | Technical alarm, HR shows `---` |
| TC-37 | **No false asystole** | Keep the lead off for 30 s | **No** asystole alarm — only `LEAD OFF` |
| TC-38 | Probe off | Assert `PD5` | Technical alarm, SpO₂ `---`, no `SPO2 LOW` |
| TC-39 | Technical not silenceable low | Silence a technical alarm | Remains at medium priority |
| TC-40 | Sensor fault | Pin ADC1 at 1023 for 6 s | `SENSOR FAULT`, temperature `---` |
| TC-41 | Reconnect | Clear lead-off | Physio alarms resume after the auto-clear delay |
| TC-42 | Code blue | Press the button | Immediate high alarm, no confirm delay |
| TC-43 | Nurse call | Raise a high alarm | Output asserts ≤ 1 s |
| TC-44 | Nurse call vs. silence | Silence the alarm | Nurse call **stays asserted** |
| TC-45 | Nurse call release | ACK the alarm | Releases ≤ 1 s |
| TC-46 | **Alarms during menu** | Open the menu, force an alarm | Alarm annunciates normally |
| TC-47 | Menu limits guard | `SET HRLOW 150` with `HRHIGH`=120 | `ERR RANGE` |
| TC-48 | Menu timeout | Open the menu, wait 65 s | Exits, uncommitted changes discarded |
| TC-49 | Standby suspends physio | Standby, force `HR HIGH` | No alarm |
| TC-50 | **Standby reminder** | Standby for 3 min | Chirp at 60, 120, 180 s; not silenceable |
| TC-51 | Standby technical | Standby, assert lead-off | Technical alarm still fires |
| TC-52 | Profile load | `PROFILE NEO` | Neonatal limits applied |
| TC-53 | Admit clears | `ADMIT BED0099` | Trends and log cleared, count incremented |
| TC-54 | RAM trend | Run 12 min, `TREND?` | 60 samples, oldest overwritten |
| TC-55 | Coarse history | Run 30 min, then `HISTORY?` | 3 records present, correctly spaced |
| TC-56 | Alarm log | Raise and clear 4 alarms, `LOG?` | 4 records with durations |
| TC-57 | `ALARM OFF` refused | Send it | `ERR PROTECTED` |
| TC-58 | Telemetry cadence | Capture 60 s | 30 frames ±1, checksums valid |
| TC-59 | Immediate events | Raise an alarm, watch the port | Event within 200 ms, not at the next frame |
| TC-60 | Console robustness | `FOO`, 40 chars, `SET HRLOW 500` | `ERR CMD`, `ERR LONG`, `ERR RANGE` |
| TC-61 | LCD flicker | Watch 60 s | No visible redraw |
| TC-62 | Tick jitter | Scope tick pin | 10 ms ±1 ms |
| TC-63 | CPU load | `PC7` duty | ≤ 60 % |
| TC-64 | RAM budget | `avr-size -C` | ≤ 1024 B including the 360 B trend ring |
| TC-65 | Soak | 20 min with alarms raised, silenced, escalated | No hang, no missed annunciation |
| TC-66 | **No heap linked** | `avr-nm main.elf \| grep -i malloc` | Prints nothing |
| TC-67 | **No recursion** | Inspect the call graph; state the deepest chain | Acyclic, depth stated in the report |

---

## 21. Bonus Features

Maximum **+20**; final score capped at 100.

| # | Feature | Marks | Requirement |
|---|---------|:-----:|-------------|
| B1 | Waveform strip on LCD | +10 | Custom characters render a scrolling pulse waveform on line 2 |
| B2 | Trend graph | +10 | 60-sample HR trend as a mini bar chart using custom characters |
| B3 | Early-warning score | +15 | Compute a NEWS-style aggregate score from HR, resp, temp, SpO₂ and NIBP; display and alarm on the score, with the scoring table documented and clearly labelled as a teaching model |
| B4 | True cooperative scheduler | +15 | Task table with period/offset/order, overrun counter over UART |
| B5 | Watchdog recovery | +10 | WDT 250 ms; alarm latches and the profile survive the reset; `MCUCSR` logged |
| B6 | Alarm-history statistics | +10 | Count and mean duration per alarm type, `STATS?` |
| B7 | Multi-bed simulation | +10 | Console `BED <n>` switches between 2 stored patient profiles |
| B8 | Distinct tone melodies | +5 | Full IEC-60601-1-8-style melodic patterns rather than plain pulses, with the pitch sequence documented |

---

## 22. Deliverables

| # | Item | Detail |
|---|------|--------|
| 1 | Source code | Layered per §9.1; single writers for alarm state and annunciation |
| 2 | `Simulation/monitor.sim1` | Runs unmodified; pulse rate and all vitals adjustable |
| 3 | `Docs/alarm_design.md` | Priority rationale (§11.2), silence/escalate policy, technical-vs-physiological argument |
| 4 | `Docs/limitations.md` | **Required.** Why this is not a medical device: no isolation, no validated sensors, no IEC 62304 lifecycle, no clinical testing, simulated NIBP. Be specific, not apologetic |
| 5 | `Docs/flowchart.png` | Matches §16 |
| 6 | `Docs/state_machine.png` | Matches §17 with the transition table |
| 7 | `Docs/test_report.md` | All 67 `TC` rows with evidence |
| 8 | Final report | 15 – 20 pages incl. HR maths and the trend-compression trade-off |
| 9 | Demo video | 5 – 10 min: all three priorities, silence expiry, escalation, lead-off suppressing asystole |
| 10 | Live defence | Any member, any file |

---

## 23. Evaluation Rubric

| Item | Marks | Full-mark criteria |
|------|:-----:|--------------------|
| GPIO | 5 | Panel and indicators correct; own DIO driver |
| ADC | 10 | Four vitals at four rates with appropriate filtering |
| Timer | 10 | Input capture HR accurate; 10 ms tick; burst patterns scheduler-driven |
| Interrupts | 5 | Capture, overflow, INT0/INT1 short and race-free |
| USART | 10 | 2 s frame, immediate events, protected parser |
| SPI | 10 | 74HC595 alarm/vital status bar correct: shift then latch, no flicker |
| I2C | 10 | LCD with vitals, banners and menu, flicker-free |
| Application logic | 20 | Three-tier alarms, latch/silence/escalate, technical suppression all correct |
| Architecture | 10 | Table-driven alarms and profiles; single writers; layer rule |
| Testing | 10 | 65 cases including TC-27, TC-33 and TC-37 |
| Documentation & demo | 10 | Alarm-design and limitations documents present and substantive |
| **Total** | **100** | Bonus up to +20, capped at 100 |

---

*Prepared by Ahmed Ellamie | ahmed.ellamiee@gmail.com*
??? ??????? ?? ????? ?????? ?????? ????? ????? ???????? ???????.
