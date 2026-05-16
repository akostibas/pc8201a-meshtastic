# pc8201a-meshtastic

Bridging an NEC PC-8201A (1983 Kyocera-built laptop, sibling to the TRS-80 Model 100) to a [Meshtastic](https://meshtastic.org) LoRa mesh, so its built-in TELCOM terminal can send and receive messages over the mesh.

## Goal

Treat the mesh as a serial peer. From TELCOM on the PC-8201A: type a line, it broadcasts to the mesh's primary channel. Inbound mesh text (broadcasts on any channel the node has keys for, plus DMs to this node) prints to the screen.

## Build phases

0. **Phase 0 — IP-network bridge to the mesh.** Existing mesh is two nodes: Seeed SenseCAP on the roof (REPEATER), RAK WisMesh Tag paired to phone (CLIENT). For this project we want a Raspberry Pi acting as a persistent IP-side bridge to the mesh, so messages can land somewhere scriptable (MQTT, log files, future home automation hooks) instead of only on the phone. Open question: can a Pi sit within BLE range of the SenseCAP on the roof, or close enough to a node for USB-serial, or do we add a LoRa HAT and make the Pi its own mesh node?
1. **Phase 1 — External RS-232 dongle.** RAK4631 + MAX3232 + null-modem in a small enclosure, plugged into the PC-8201A's DB-25. Goal: prove the Meshtastic Serial Module ↔ TELCOM bridge actually works end-to-end before committing to any irreversible case mods.
2. **Phase 2 — Internal mount.** Move the RAK inside the case once Phase 1 is working: switched-rail power tap, TTL UART tap pre-RS-232 driver, antenna egress strategy. See `docs/README.md` for the open hardware questions that need answers before we cut anything.

The hardware table below describes the **Phase 2** target. For Phase 1, swap "internal mount" for "external dongle" and ignore the level shifter / power tap rows — those become MAX3232 + USB power instead.

## Hardware (Phase 2 target)

The RAK lives **inside the PC-8201A case**, powered from the laptop's own switched rail and wired directly to the CPU-side UART before the RS-232 driver. No MAX3232, no null-modem cable, no external DB-25 use.

| Part | Role |
|---|---|
| NEC PC-8201A | The terminal. Internally, the 80C85's UART runs at TTL levels before a driver kicks it out to the DB-25 at ±12V. We tap the TTL side. TELCOM still drives it at 8N1 up to 19200 baud. |
| RAK4631 (nRF52840 + SX1262) | Meshtastic core. Same MCU family as the WisMesh Tag, but with broken-out pins. Mounted inside the case. |
| RAK19003 WisBlock Mini base | Carrier board; exposes UART1 on a 2.54mm header. |
| Level shifter (5V ↔ 3.3V) | Likely needed: the 8201A is a 5V CMOS design, the RAK4631 UART is 3.3V. Bidirectional translator (TXB0104) or a BSS138-style pair on the two UART lines. |
| Power tap | A switched, regulated internal rail on the PC-8201A — RAK only runs when the laptop is on. Voltage / current headroom TBD by probing; may need a small buck or LDO to feed the RAK's VBAT input. |
| LoRa antenna | **Attach before powering on** or the SX1262 PA can be damaged. Needs a route out of the metal-shielded case (u.FL pigtail to an external SMA, or a chip antenna behind a non-shielded panel). |

## How it works (Meshtastic side)

Meshtastic ships a built-in **Serial Module** in firmware. Enabled via config (iOS/Android app or `meshtastic` CLI), it claims UART1 and bridges raw bytes to/from the mesh.

Relevant `SerialConfig` fields:

- `enabled` — on
- `mode` — `TEXTMSG` (line-oriented text in/out as mesh text messages)
- `baud` — match TELCOM's setting on the PC-8201A
- `rxd` / `txd` — leave at defaults; firmware knows the RAK4631's UART1 pins
- `echo` — optional, but nice for TELCOM so you see what you typed
- `timeout` — ms to wait before flushing a partial line to the mesh (default 250)

There is **no channel-selection field**. Outbound serial → always broadcast on the primary channel (index 0). Inbound → all received text messages (any channel + DMs) hit the UART. Plan accordingly.

## Status

Pre-build. WisBlock Mini base board on the way. RAK4631 in hand. Next step is the Phase 1 external dongle — proves the serial bridge before any case mods.

## Notes

See [`docs/`](docs/) for working notes and gotchas, [`docs/adr/`](docs/adr/) for decision records.
