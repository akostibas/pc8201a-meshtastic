# Phase 2 — internal TTL UART tap (research notes)

Goal: wire the RAK4631 (3.3V) to the PC-8201A's serial *before* the RS-232
level shifters, so we never touch ±RS-232 levels or the DB-25. Tap the UART at
logic level, through a 5V↔3.3V shifter.

**Confidence note:** the PC-8201A and TRS-80 Model 100 are sibling
Kyocera-built designs sharing the same serial architecture (6402 UART + CMOS
inverter level shifting + MC14412 modem). Pin numbers come from the Model 100
schematic and the standard 6402 datasheet; PC-8201A's own tech-ref independently
confirms the same UART family, port map, and handshake latches. Items flagged
**[M100-derived]** are confirmed for the Model 100 and assumed to carry over;
verify on the actual board before cutting.

## 1. UART chip — confirmed for PC-8201A

- **Intersil/Harris CDP6402 / IM6402**, 40-pin DIP, board designator **U22**.
- Runs at **5V CMOS** (VDD pin 1). Driven by the 80C85.
- PC-8201A I/O ports: **data register 0xC8**, **command/status 0xD8**.

## 2. RS-232 drivers — NOT a MAX232/1488 charge-pump design

- Level shifting is done with a **CD4584 / 40H-series CMOS hex Schmitt-trigger
  inverter** plus discrete transistors (2SC2603 / 2SA1115), running between +5V
  and a negative rail **VEE**. Board designators **U30/U31** on the 8201A.
- **No onboard RS-232 charge-pump chip.** VEE comes from the machine's
  transformer-based switching DC-DC converter in the PSU section.
- **Correction to an earlier assumption:** the DB-25 lines are therefore roughly
  **±5 to ±8V**, *not* a true ±12V. (Still valid RS-232 — receivers accept down
  to ±3V — so the Phase 1 MAX3232 dongle is unaffected. But the machine is gentler
  than a true ±12V port.)

## 3. TTL tap points — the actual targets

On the 6402 (standard pinout), at 5V CMOS:

- **TX out of the machine: TRO (Transmit Register Output) = pin 25.** Tap here.
- **RX into the machine: RRI (Receive Register Input) = pin 20.** Drive this from
  the level shifter.

The 8201A routes RX through a **TC40H153 4:1 mux (U19)** and TX through a
**TC40H139 (U21)** — selecting RS-232 vs SIO1/SIO2 via SEL A/B from flip-flop
U12 — *before* the UART. Tapping directly at the 6402's TRO/RRI pins is
downstream of that mux, so it's the clean point regardless of mux state.

## 4. Handshake lines — separate from the UART, must be handled

The 6402 is **data-only — it has no modem-control pins.** CTS/DSR/DTR/RTS/CD are
driven by separate I/O latches:

- **Port 0xBA** outputs: **RTS = bit 7**, **DTR = bit 6**.
- **Port 0xD8** status reads: **CD = bit 0**, **Ring Indicate = bit 5**.

**Implication:** tapping TRO/RRI alone does *not* satisfy handshake. If TELCOM
checks CTS/DSR/CD before transmitting, either assert those input lines at logic
level, or set a TELCOM `STAT` word that ignores hardware flow control (the
"ignore" option in the stat string — verify the exact code on-machine). This is
the logic-level equivalent of the DB-25 loopback jumpers from Phase 1.

## 5. Sources

- [PC-8201A Technical Reference (NEC, 1984)](https://www.web8201.net/Files/LIBRARY_web8201/NEC8201A-TechRef.pdf)
- [PC-8201A RS-232 init / register map](https://www.web8201.net/PotentPortables/initrs.html)
- [PC-8201A RS-232 repair, Pt 1](https://www.classic-computers.org.nz/blog/2020-07-16-nec-pc8201a-rs232-repair.htm) · [Pt 2](https://www.classic-computers.org.nz/blog/2020-07-16-nec-pc8201a-rs232-repair-pt2.htm) — identifies U22, U19/U21 muxes, U30/U31 drivers
- [Errors in the 8201A service manual schematics](https://www.classic-computers.org.nz/blog/2010-02-22-errors-in-8201a-service-manual.htm) — use the NEC scan cautiously
- [TRS-80 Model 100 KiCad schematic](https://github.com/hzeller/trs80-100-schematic) — authoritative for IM6402 TRO=25/RRI=20, 4584 inverters, VEE rail [M100-derived]
- [M100 original schematic scan](https://archive.org/details/trs-80-model-100-main-pcb-schematic-from-tech-ref-manual)
- [TRS-80 Model 102 reference manual](https://electrickery.hosting.philpem.me.uk/comp/m200/doc/TRS-80_Model-102_reference-manual.pdf) — 6402 pin config + RS-232/modem interface
