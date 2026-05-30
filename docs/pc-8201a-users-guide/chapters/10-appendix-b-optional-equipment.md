# Appendix B: Optional Equipment Available for PC-8201

> Vision-OCR'd from NEC8201A-UsersGuide.pdf (image-only scan, source pages 191-202 / printed B-1..B-12), 2026-05-30.
> Figures/tables are transcribed per the project's per-figure-type policy; values flagged with TODO(tier-b) still need a human check against the scan.
> **Do not treat numeric/tabular values here as authoritative** — Tier B review pending.

## The Interface Connectors

<!-- OCR: unclear ("Ibe Interface Connectors") — reads as "The Interface Connectors" -->

### RS-232C — 25 pin D SUB

<!-- FIGURE B.1: RS-232C 25-pin D-SUB connector, pins 1/13/14/25 labeled — illustration, source page 191. TODO(tier-b): crop image from source. -->

<!-- FIGURE B.2: RS-232C pin assignments — source page 191 (target: table) -->

| Pin number | Signal name | Remarks |
|---|---|---|
| 1 | GND | Protective ground |
| 2 | TxD | Transmit data |
| 3 | RxD | Receive data |
| 4 | RTS | Request to send |
| 5 | CTS | Transmission authorized |
| 6 | DSR | Data set relay |
| 7 | GND | Signal ground |
| 8 | DCD | Data carrier detect |
| to | | |
| 20 | DTR | Data carrier ready |
| 22 | RD | Bell detect |
| 25 | - - - | |

<!-- TODO(tier-b): verify model numbers/specs against source page 191 -->

### SIO1 — 8 pin DuPont BERG modular jack

<!-- FIGURE B.3: SIO1 8-pin modular jack, pins 1 and 8 labeled — illustration, source page 192. TODO(tier-b): crop image from source. -->

<!-- FIGURE B.4: SIO1 pin assignments — source page 192 (target: table) -->

| Pin number | Signal name | Remarks |
|---|---|---|
| 1 | GND | Signal ground |
| 2 | TxD | Transmit data |
| 3 | RxR | Receive data |
| 4 | RTS | Request to receive |
| 5 | CTS | Transmission authorized |
| 6 | Vcc | +5 V |
| 7 | NC | Not connected |
| 8 | NC | Not connected |

<!-- TODO(tier-b): verify model numbers/specs against source page 192 -->

### SIO2 — 6 pin DuPont BERG modular jack

<!-- FIGURE B.5: SIO2 6-pin modular jack, pins 1 and 6 labeled — illustration, source page 193. TODO(tier-b): crop image from source. -->

<!-- FIGURE B.6: SIO2 pin assignments — source page 193 (target: table) -->

| Pin number | Signal name | Remarks |
|---|---|---|
| 1 | GND | Signal ground |
| 2 | TxD | Transmit data |
| 3 | RxR | Receive data |
| 4 | RTS | Request to receive |
| 5 | CTS | Transmission authorized |
| 6 | Vcc | +5 V |

<!-- TODO(tier-b): verify model numbers/specs against source page 193 -->

### CMT — 8 pin DIN plug

<!-- FIGURE B.7: CMT 8-pin DIN plug, pins 1-8 labeled — illustration, source page 194. TODO(tier-b): crop image from source. -->

<!-- FIGURE B.8: CMT pin assignments — source page 194 (target: table) -->

| Pin number | Signal name | Remarks |
|---|---|---|
| 1 | T x C | TTL level output |
| 2 | GND | Signal ground |
| 3 | GND | Electrical power ground |
| 4 | MIC | Output to a MIC |
| 5 | EAR | Input from EAR |
| 6 | REM1 | Remote terminal |
| 7 | REM2 | Remote terminal |
| 8 | Vcc | +5 V |

<!-- TODO(tier-b): verify model numbers/specs against source page 194 -->

### BCR — 9 pin D SUB

<!-- FIGURE B.9: BCR 9-pin D-SUB connector, pins 1/5/6/9 labeled — illustration, source page 195. TODO(tier-b): crop image from source. -->

<!-- FIGURE B.10: BCR pin assignments — source page 195 (target: table) -->

| Pin number | Signal name | Remarks |
|---|---|---|
| 1 | NC | Not connected |
| 2 | R x DB | Receive data |
| 3 | NC | Not connected |
| 4 | NC | Not connected |
| 5 | GND | Signal ground |
| 6 | NC | Not connected |
| 7 | GND | Signal ground |
| 8 | NC | Not connected |
| 9 | Vcc | +5 V |

<!-- TODO(tier-b): verify model numbers/specs against source page 195 -->

### Printer — 26 pin connector using a flat cable

<!-- FIGURE B.11: PRINTER 26-pin flat-cable connector, pins 1/2/25/26 labeled — illustration, source page 196. TODO(tier-b): crop image from source. -->

<!-- FIGURE B.12: Printer pin assignments — source page 196 (target: table) -->

| Pin number | Signal name | Remarks | Pin number | Signal name | Remarks |
|---|---|---|---|---|---|
| 1 | STROBE | WRITE strobe | 2 | GND | Signal ground |
| 3 | PD0 | Parallel data 0 | 4 | GND | Signal ground |
| 5 | PD1 | Parallel data 1 | 6 | GND | Signal ground |
| 7 | PD2 | Parallel data 2 | 8 | GND | Signal ground |
| 9 | PD3 | Parallel data 3 | 10 | GND | Signal ground |
| 11 | PD4 | Parallel data 4 | 12 | GND | Signal ground |
| 13 | PD5 | Parallel data 5 | 14 | GND | Signal ground |
| 15 | PD6 | Parallel data 6 | 16 | GND | Signal ground |
| 17 | PD7 | Parallel data 7 | 18 | GND | Signal ground |
| 19 | NC | | 20 | GND | Signal ground |
| 21 | BUSY | Printer busy | 22 | GND | Signal ground |
| 23 | NC | | 24 | GND | Signal ground |
| 25 | SLCT | Printer select | 26 | NC | |

<!-- TODO(tier-b): verify model numbers/specs against source page 196 -->

### System Slot

<!-- FIGURE B.13: SYSTEM SLOT connector, pins 1/2/47/48 labeled — illustration, source page 197. TODO(tier-b): crop image from source. -->

<!-- FIGURE B.14: System Slot pin assignments — source pages 197-199 (target: table) -->

| Pin number | Signal name | Remarks |
|---|---|---|
| 1 | VDD | +5 V |
| 2 | VDD | +5 V |
| 3 | AD0 | Address/Data 0 |
| 4 | AD4 | Address/Data 4 |
| 5 | AD1 | Address/Data 1 |
| 6 | AD5 | Address/Data 5 |
| 7 | AD2 | Address/Data 2 |
| 8 | AD6 | Address/Data 6 |
| 9 | AD3 | Address/Data 3 |
| 10 | AD7 | Address/Data 7 |
| 11 | NC | No Connection |
| 12 | NC | No Connection |
| 13 | A8 | Address 8 |
| 14 | A12 | Address 12 |
| 15 | A9 | Address 9 |
| 16 | A13 | Address 13 |
| 17 | A10 | Address 10 |
| 18 | A14 | Address 14 |
| 19 | A11 | Address 11 |
| 20 | A15 | Address 15 |
| 21 | A16 | No Connection |
| 22 | A18 | No Connection |
| 23 | A17 | No Connection |
| 24 | A19 | No Connection |
| 25 | NC | No Connection |
| 26 | NC | No Connection |
| 27 | RD | Read |
| 28 | WR | Write |
| 29 | IO/M | IO OR Memory |
| 30 | ALE | Address Latch Enable |
| 31 | HOLD | HOLD |
| 32 | HOLDA | HOLD Acknowledge |
| 33 | INTR | INTERRUPT |
| 34 | INTA | INTER Acknowledge |
| 35 | RESET | RESET |
| 36 | READY | READY |
| 37 | ROME | ROM Enable |
| 38 | E | Enable |
| 39 | BANK#3 | RAM Cassette Select signal |
| 40 | NC | No Connection |
| 41 | HADRD | High Address Disable |
| 42 | LADRD | Low Address Disable |
| 43 | CLK | Clock |
| 44 | POWER | RAM Protect signal |
| 45 | GND | Ground |
| 46 | GND | Ground |
| 47 | NC | No Connection |
| 48 | NC | No Connection |

<!-- TODO(tier-b): verify model numbers/specs against source pages 197-199 -->

## Audio Cassette-Related

<!-- FIGURE B.15: Audio cassette-related product listing — source page 200 (target: table) -->

| Model number | Item name | Function |
|---|---|---|
| PC-6082 | Data Recorder | Audio cassette tape recorder for use with a personal computer |
| PC-8281 | Data Recorder | Audio cassette tape recorder with automatic search function for use with a personal computer |

<!-- TODO(tier-b): verify model numbers/specs against source page 200 -->

— It is possible to use any commercially-marketed audio cassette recorder.

Please use the PC-8293 CMT cable that is packed with the PC-8201 when you purchase it to connect it to an audio cassette recorder. The PC-8093 can also be used.

<!-- OCR: unclear ("PC-8093") — possibly PC-8293; cross-check against source page 200 -->

The following items are new products to be included in the PC-8201 series.

<!-- FIGURE B.16: New products in the PC-8201 series — source pages 200-201 (target: table) -->

| Model number | Item name | Function |
|---|---|---|
| PC-8201-06 | RAM Expansion | The RAM can be expanded within the CPU by the addition of 8K byte increments |
| PC-8201-90 | Exclusive nickel-cadmium batteries | Nickel-cadmium batteries for use with the PC-8201 |
| PC-8206 | RAM Cartridge | Plugged into the PC-8201 System slot; contains 32K byte RAM |
| PC-8271-01 | AC Adapter | AC Adapter for running the PC-8201 off of 120 V AC |
| PC-8293 | CMT Cable | 80 cm long CMT cable for use with the PC-8201 |
| PC-8294 | Printer Cable | Printer cable for use with the PC-8201 |
| PC-8295-N | RS-232C cable | Normal connection |
| PC-8295-R | | Reverse connection |
| PC-8299-6 | SIO2 cable | 6 pin further expansion |
| PC-8299-8 | SIO1 cable | 8 pin further expansion |

<!-- TODO(tier-b): verify model numbers/specs against source pages 200-201 -->

## Printer related

<!-- FIGURE B.17: Printer-related product listing — source page 202 (target: table) -->

| Model number | Item name | Function |
|---|---|---|
| PC-6021 | 40 column thermal printer | 40 column thermal printer (The PC-8294 cable required for use is sold separately.) |
| PC-6022 | Color plotter printer | 4 color conversion color plotter printer with ball point pens; 40 or 80 column character printing |
| PC-8023A-C | Dot matrix | 80 column, dot matrix printer with graphics capability (PC-8294 cable is sold separately) |
| PC-8023-01 | Ink ribbon cartridge | Ink ribbon cartridge for use in the PC-8023-C |
| PC-8221 | Thermal dot matrix printer | 40 or 80 column thermal dot matrix printer with graphics capability (The printer cable is attached to this.) |

<!-- TODO(tier-b): verify model numbers/specs against source page 202 -->
