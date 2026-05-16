# ADR-0001: Use the built-in Meshtastic Serial Module (TEXTMSG mode)

- **Status:** Accepted
- **Date:** 2026-05-16

## Context

Goal is a bidirectional bridge between the PC-8201A's RS-232 port (via TELCOM) and a Meshtastic mesh. The PC-8201A speaks line-oriented ASCII over standard RS-232 (8N1 up to 19200 baud). The Meshtastic node has a free hardware UART (UART1 on the RAK4631 via the RAK19003 mini base).

There are several ways to get bytes from the UART onto the mesh:

1. Stock firmware's **Serial Module** in `TEXTMSG` mode — out of the box, no firmware build needed.
2. Stock firmware's **Serial Module** in `PROTO` mode — framed protobufs over UART. Requires the peer to speak `ToRadio` / `FromRadio`.
3. **Custom firmware module** — fork Meshtastic, add a C++ `MeshModule` subclass that parses our own protocol (e.g., `@nodeId hello` for DMs).
4. **External MCU bridge** — put a small microcontroller between the PC-8201A and the Meshtastic node, doing protocol translation in user-space.

## Decision

Use option 1: stock firmware, Serial Module, `TEXTMSG` mode.

## Alternatives Considered

### 1. Serial Module, TEXTMSG mode (chosen)

- **Pros:** Zero firmware work. Configurable from the iOS app. Maps cleanly to the TELCOM mental model (a line you type goes "out", lines come "in"). Survives Meshtastic firmware updates without us re-porting anything.
- **Cons:** Always broadcasts on the primary channel — no way to target a specific channel or DM a specific node from the UART byte stream. Inbound is unfiltered (any channel + DMs all dump to UART).

### 2. Serial Module, PROTO mode

- **Pros:** Full access to `ToRadio` / `FromRadio` — DMs, channel selection, position, telemetry, everything.
- **Cons:** The PC-8201A would need to build and parse length-prefixed protobufs (4-byte `0x94C3 LL LL` framing) in BASIC or M100 assembly. Wildly impractical on a Z80 with 16KB-ish of usable RAM. Defeats the "TELCOM as chat client" vibe.

### 3. Custom firmware module

- **Pros:** Could parse a thin protocol (e.g. leading `@nodeId` for DM, `#channel` prefix for channel select) and give the PC-8201A more of the mesh's capabilities without it needing to do anything complex.
- **Cons:** Fork maintenance burden. Have to rebase on Meshtastic firmware changes. Need a custom flash workflow per node. Overkill for a hobby bridge.

### 4. External MCU bridge

- **Pros:** Decouples the mesh node from the protocol logic; could in principle work with any Meshtastic device, including the WisMesh Tag (over USB CDC).
- **Cons:** Extra hardware, extra power draw, extra failure mode. The RAK4631 already has the UART we need; adding a Pi Pico in between is pure complication.

## Consequences

- Outbound: anything typed in TELCOM, broadcast on primary channel. We pick which channel is "primary" on this specific node to control routing.
- Inbound: every text message the node hears (broadcasts on any channel it has keys for + DMs to this node) prints to the screen. To keep the channel quiet, remove unused channels from this node.
- DMs *to* the PC-8201A work transparently (they're just text messages with `to=us`).
- DMs *from* the PC-8201A are not possible without revisiting this decision (probably toward option 3).
- Channel-tagged display (showing which channel a message came in on) would require option 3.
