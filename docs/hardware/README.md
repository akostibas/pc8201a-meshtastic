# Hardware photos — NEC PC-8201A internals

Reference photos taken during disassembly for Phase 2 planning (internal UART tap).

## main-board.jpeg — main PCB (IMG_9711)

The main logic board with the lid open, shot from above.

**Visible regions:**
- **Bottom strip** — bank of RAM ICs (U26–U28 area and equivalents), soldered flat
- **Center/upper-center** — main logic: CPU (80C85), ROM, and support ICs including the **6402 UART (U22)** — the target for the Phase 2 TTL tap (TRO pin 25 = TX out, RRI pin 20 = RX in)
- **Upper-left** — blue piezo buzzer; DB-25 female port on the left edge
- **Upper-right** — power section (large capacitors, red/black power wires); ribbon cable to keyboard/display
- **Right edge** — ribbon cable connector going to the keyboard panel board

**Phase 2 relevance:** U22 is **positively identified** — visible in the center of the board, marked **RCA Z / CDP6402CE / 541** (40-pin DIP). This is the tap target. The wiring doc calls out TRO (pin 25 = TX out of machine → level shifter → RAK RX0) and RRI (pin 20 = RX into machine → level shifter → RAK TX0). Cross-reference with `docs/phase2-internal-uart-tap.md`.

## keyboard-panel-rear.jpeg — keyboard panel, rear (IMG_9712)

Shot of the keyboard assembly from the rear with the lid removed.

**Visible regions:**
- **Top daughterboard** — small green PCB with ~8 large square ICs (RAM expansion, likely 43256-family); ribbon cable connects to main board on left
- **Lower PCB** — keyboard matrix, solder side; characteristic grid of solder joints and trace routing

**Phase 2 relevance:** Possible interior mounting location for the RAK19003. The space above/beside the keyboard matrix (between the two boards) may offer a mounting pocket — assess clearance and RF path when the unit is in hand.
