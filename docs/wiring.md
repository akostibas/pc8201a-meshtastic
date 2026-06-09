# Wiring diagrams & pinouts

Practical wiring for the three connection scenarios, in build order. This is a
*working* doc — verify every pin against the real hardware (and the local
manuals) before soldering. See [`phase2-internal-uart-tap.md`](phase2-internal-uart-tap.md)
for the internal-tap research this builds on.

**Confidence:** the DB-25 pinout below is the standard RS-232 DTE assignment,
cross-checked against web8201/classic-computers. The local manual's pin-by-pin
connector table is still pending Tier-B OCR (appendix C currently has only the
function block diagram), so meter-verify pins 2/3/7 before trusting them.

---

## Reference pinouts

### NEC PC-8201A RS-232C port — DB-25 **female**, wired as **DTE**

Directions are from the 8201A's point of view.

| Pin | Signal | Dir | Notes |
|----:|--------|-----|-------|
| 1 | FG | — | Frame / protective ground (chassis) |
| 2 | TXD | out | Data **out** of the 8201A |
| 3 | RXD | in | Data **in** to the 8201A |
| 4 | RTS | out | Asserted on init (port `0xBA` bit 7) |
| 5 | CTS | in | |
| 6 | DSR | in | |
| 7 | SG | — | Signal ground (the reference — always wire this) |
| 8 | DCD | in | Read via status port `0xD8` bit 0 |
| 20 | DTR | out | Asserted on init (port `0xBA` bit 6) |
| 22 | RI | in | "Bell detect" |

### RAK19003 WisBlock Mini base — UART header (3.3V CMOS)

| Pad | Signal | Notes |
|-----|--------|-------|
| VDD | +3.3V | Board logic rail (also a 3.3V source for the shifter/MAX3232) |
| GND | Ground | |
| TX0 | UART TX | **Out** of the RAK |
| RX0 | UART RX | **In** to the RAK |
| BOOT, SCL, SDA | — | Unused here |

> **Verify:** confirm the Meshtastic Serial Module's `txd`/`rxd` defaults map to
> these `TX0`/`RX0` pads on the RAK4631 before relying on them.

### MAX3232 breakout (Adafruit RS232 Pal) — 2 channels, we use channel 1

Pin names are the same label on both sides; the header they're on tells you which domain.

| Logic side (3.3V/5V) | RS-232 side |
|----------------------|-------------|
| `VIN` (match logic level), `GND` | — |
| `T1` (logic in → drives RS-232 out) | `T1` (RS-232 out) |
| `R1` (logic out ← from RS-232 in) | `R1` (RS-232 in) |

---

## Scenario A — Bench-test the 8201A against a Mac (List 1)

No soldering. The **null-modem cable does the crossover and gender change**, and
the FTDI adapter asserts DTR/RTS into the 8201A's CTS/DSR/DCD.

```
[Mac USB] ── FTDI USB↔RS-232 (DB-9 male) ── NULL-MODEM cable (DB9F→DB25M) ── [8201A DB-25 female]
```

- Open the port at **19200 8N1** (`screen /dev/tty.usbserial-XXXX 19200`).
- On the 8201A: TELCOM → `STAT 9N81NN` → `TERM`. (See STAT decode below.)
- **Cable must be null-modem (crossover)**, not a straight "AT modem" cable.

---

## Scenario B — Phase 1 external dongle (RAK ↔ MAX3232 ↔ DB-25)

The crossover (TX→RX) is done *in your wiring* of the MAX3232 RS-232 pins to the
DB-25. No null-modem cable needed — you're building the connection yourself.

```
RAK (3.3V TTL)     RS232 Pal logic side   RS232 Pal RS-232 side   8201A DB-25 female
─────────────      ────────────────────   ─────────────────────   ──────────────────
VDD ────────────►  VIN
GND ────────────►  GND  ──────────────────────────────────────►  7  SG
TX0 ────────────►  T1 (logic)             T1 (RS-232) ─────────►  3  RXD  (into 8201A)
RX0 ◄────────────  R1 (logic)             R1 (RS-232) ◄─────────  2  TXD  (out of 8201A)
```

**Data wiring (the 3 that matter):**

| From | To | Why |
|------|----|-----|
| RAK `TX0` → RS232 Pal logic `T1`; RS-232 `T1` → DB-25 **pin 3** | 8201A RXD | RAK talks → 8201A listens |
| DB-25 **pin 2** → RS232 Pal RS-232 `R1`; logic `R1` → RAK `RX0` | 8201A TXD | 8201A talks → RAK listens |
| RAK `GND` ↔ RS232 Pal `GND` ↔ DB-25 **pin 7** | common ground | mandatory reference |

**Handshake — try 3-wire first.** TELCOM has *no hardware flow-control option*
(only XON/XOFF via `STAT`), so pins 4/5/6/8/20 may not gate transmission at all.
Wire TX/RX/GND only and test. **If TELCOM refuses to send**, add loopback jumpers
**on the DB-25 plug** so it sees its own outputs asserted:

```
4 ── 5            (RTS → CTS)
20 ─┬─ 6          (DTR → DSR)
    └─ 8          (DTR → DCD)
22  (RI) — leave open
```

---

## Scenario C — Phase 2 internal TTL tap (RAK ↔ level shifter ↔ 6402)

No MAX3232, no DB-25, no RS-232. Tap the 6402 UART (U22) directly at logic level,
through a **5V↔3.3V level shifter**. Pin numbers are M100-derived — **verify on
the board before cutting** (see [`phase2-internal-uart-tap.md`](phase2-internal-uart-tap.md)).

```
RAK (3.3V)        Level shifter (5V↔3.3V)        8201A 6402 UART (U22, 5V CMOS)
──────────        ───────────────────────        ──────────────────────────────
3.3V ──────────►  LV ref
GND  ──────────►  GND ──────────────────────────► 8201A GND
TX0  ──────────►  LV1 ──► HV1 ───────────────────► RRI  pin 20  (RX into machine)
RX0  ◄──────────  LV2 ◄── HV2 ◄───────────────────  TRO  pin 25  (TX out of machine)
                  HV ref ◄─────────────────────────  +5V rail (switched, downstream of power button)
```

- **Shifter:** **Adafruit #757 — 4-channel BSS138 bidirectional logic level
  converter** (~$3.95). BSS138-based (not the TXB0104, whose edge-rate
  accelerators misbehave with vintage-PCB parasitics). Critically, each channel
  **clamps the low side to its 3.3V rail**, so the 8201A's 5V UART-out can't push
  5V into the non-5V-tolerant nRF52840 — a bare 74AHCT125 buffer would *not*
  protect the RAK here. Open-drain/10K-pullup edges are a non-issue at 19200.
  Wire **HV = 8201A 5V**, **LV = RAK 3.3V (VDD)**; only 2 of the 4 channels are
  used (TX, RX), leaving a spare pair for a handshake line if needed.
- **Tap is downstream of the input muxes** (U19/U21), so it's clean regardless of
  RS-232/SIO mux state.
- **Handshake** here lives on separate latches (ports `0xBA` / `0xD8`), not the
  6402 — assert at logic level or rely on the `STAT` flow-control settings.
- **Power tap** is the open risk (brownout → SRAM wipe). Tap a *switched* rail so
  the RAK dies with the laptop; probe headroom before soldering.

---

## TELCOM `STAT` decode (the value to use)

Format is `STAT CPBSXS` (`docs/pc-8201a-users-guide/chapters/08-telcom.md`):

| Field | Meaning | Our value |
|-------|---------|-----------|
| C | Baud — `9` = 19200 | `9` |
| P | Parity — `N` none | `N` |
| B | Word length — `8` bits | `8` |
| S | Stop bits — `1` | `1` |
| X | XON/XOFF — `N` = off | `N` |
| S | SI/SO — `N` = off | `N` |

→ **`STAT 9N81NN`** = 19200 8N1, no software flow control. Matches the RAK Serial
Module config (19200, TEXTMSG). We set `X=N` because the Meshtastic Serial bridge
won't honor XON/XOFF — leaving it on risks the 8201A injecting CTRL-S/Q into the
mesh stream. (Cold-start default is `STAT 8171XS` = 9600 7-bit, XON/XOFF on.)

---

## Cross-cutting gotchas

- **Antenna first.** Attach the LoRa antenna before powering the RAK or you can
  cook the SX1262 PA.
- **Common ground is mandatory** in every scenario — pin 7, not pin 1.
- **±6V is valid RS-232.** Both the FTDI adapter (±6V) and the 8201A (~±5–8V via
  CMOS inverters) are gentle but in-spec; receivers accept down to ±3V.
