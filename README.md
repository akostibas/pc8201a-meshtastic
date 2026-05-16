# pc8201a-meshtastic

Bridging an NEC PC-8201A (1983 Kyocera-built laptop, sibling to the TRS-80 Model 100) to a [Meshtastic](https://meshtastic.org) LoRa mesh, so its built-in TELCOM terminal can send and receive messages over the mesh.

## Goal

Treat the mesh as a serial peer. From TELCOM on the PC-8201A: type a line, it broadcasts to the mesh's primary channel. Inbound mesh text (broadcasts on any channel the node has keys for, plus DMs to this node) prints to the screen.

## Hardware

| Part | Role |
|---|---|
| NEC PC-8201A | The terminal. RS-232 DB-25, ±12V, 8N1 up to 19200 baud via TELCOM. |
| RAK4631 (nRF52840 + SX1262) | Meshtastic core. Same MCU family as the WisMesh Tag, but with broken-out pins. |
| RAK19003 WisBlock Mini base | Carrier board; exposes UART1 on a 2.54mm header. |
| MAX3232 (3.3V variant) | TTL ↔ RS-232 level shifter. |
| Null-modem wiring | TX↔RX, GND↔GND between MAX3232 RS-232 side and PC-8201A. |
| LoRa antenna | **Attach before powering on** or the SX1262 PA can be damaged. |

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

Pre-build. WisBlock Mini base board on the way. RAK4631 in hand.

## Notes

See [`docs/`](docs/) for working notes and gotchas, [`docs/adr/`](docs/adr/) for decision records.
