# Working notes

Free-form notes as the build progresses. Roughly in build order.

## Phasing

- **Phase 0** — IP-network bridge into the mesh. Existing mesh: SenseCAP (REPEATER, roof) + WisMesh Tag (CLIENT, phone). Want a Raspberry Pi attached to a node so the mesh has a persistent, scriptable home-network endpoint (not just the phone).
- **Phase 1** — external RS-232 dongle on the DB-25. Proves the bridge end-to-end. No case mods, no risk to a rare 1983 machine.
- **Phase 2** — internal mount, switched-rail power tap, TTL UART tap, antenna egress. Only after Phase 1 works.

Most of the hardware-integration open questions below are **Phase 2 concerns** — flagged here so they're not forgotten, but no action needed until Phase 1 is done.

## Phase 0 — IP bridge options

The Pi needs to reach a Meshtastic node somehow. In rough order of effort:

1. **Pi BLE → SenseCAP on the roof.** Cheapest if range works. Raspberry Pi 4/5 BLE is ~10m line-of-sight indoors; the SenseCAP is outdoors at roof height. Almost certainly too far through walls/floor, but worth a quick test.
2. **Pi BLE → WisMesh Tag.** Defeats the purpose if the Tag is on the user's person. Only works if the Tag becomes a stationary node.
3. **Pi USB-serial → a co-located Meshtastic node.** Rock solid, but needs a node physically next to the Pi. Could repurpose an existing node or add a cheap dedicated one (Heltec V3 ~ $20).
4. **Pi + LoRa HAT running `meshtasticd`.** Pi becomes its own mesh node with native LAN/MQTT bridging. Most flexible, most setup, ~$30 hat. No BLE-range or co-location constraints.

Recommendation: try (1) first since it's free; fall back to (3) or (4) if BLE doesn't reach.

Once connected: Meshtastic supports MQTT natively — point it at a local broker (Mosquitto on the Pi) and every mesh message is a topic, easy to consume from anything else on the LAN.

## Phase 1 — antenna note

PCB antenna ships with the RAK4631 and is fine for the external-dongle phase. If/when we move inside the case (Phase 2) and the PCB antenna underperforms inside the shielding, the swap to u.FL + external SMA is mechanically easy.

## Risks flagged from a design review (deferred to Phase 2)

- **SRAM filesystem wipe on brownout.** The PC-8201A keeps user files in battery-backed SRAM. A LoRa TX current spike (120mA+) on a shared rail could droop the 5V regulator enough to corrupt RAM. Mitigation: tap *unregulated* battery voltage downstream of the power switch, run a dedicated buck-boost for the RAK — don't share the 8201A's own regulator. **Acceptable risk for this project** since we mostly care about TELCOM (in ROM), but worth testing power behavior before soldering anything to the mainboard.
- **UART bus contention.** The RS-232 line receiver (likely MC1489) actively drives the USART RX pin. Can't just T-splice the RAK's TX in — would need to cut the trace or lift the receiver pin to isolate. Revisit when we have a schematic + the board open.
- **TELCOM hardware handshake.** Bypassing the RS-232 drivers leaves CTS/DSR/CD floating at the USART; TELCOM may refuse to send unless we spoof those active.
- **Level shifter choice.** TXB0104's edge-rate accelerators are flaky with vintage-PCB parasitics. Prefer a 74HCT/AHCT buffer or BSS138 pair.
- **RFI into CPU/RAM.** +22dBm at 915MHz inside the chassis can induce currents in unshielded bus lines. Keep radio + coax as far from CPU/RAM as possible.
- **USB-C access post-close.** Vintage ABS standoffs are brittle — repeatedly opening to reflash will eventually crack the case. Route USB-C to an existing port cutout or panel-mount an extension during Phase 2 layout.

## Open questions

### Hardware integration (new — internal mount + power tap)

- Where on the PC-8201A's PCB are the 80C85 UART TX/RX pads (pre-RS-232 driver)? Need a service manual / schematic, or trace from the driver chip backwards.
- What driver chip does the 8201A use for the DB-25? (likely an MC1488/1489 pair or similar.) Confirms TTL side is on its inputs.
- UART logic level on the 8201A side — 5V CMOS expected, but confirm with a scope before wiring the RAK directly.
- Which internal rail is switched by the power button and has headroom for the RAK4631 (TX bursts can spike to ~120 mA on the SX1262)? Candidates: any 5V rail downstream of the switch, or the regulated CPU supply.
- If we tap a 5V rail, do we feed it to the RAK19003's 5V/USB input, or step it down and feed VBAT (3.3–4.2V)?
- Physical mounting location — option ROM bay? Under the keyboard? Behind the battery compartment?
- Antenna egress — u.FL pigtail to an external SMA mounted in an existing port cutout, or internal chip antenna behind a plastic panel?
- Will the metal RF shielding inside the case kill LoRa performance enough to force the antenna fully external?

### Software / config

- Confirm UART1 TX/RX pin labels on the RAK19003 mini base when it arrives.
- Verify which RAK4631 variant is in hand (4631 / 4631-R / 4631-C). Shouldn't matter for this project, but worth knowing.
- Most reliable baud rate for the PC-8201A's UART in practice (19200 is spec ceiling, but 4800/9600 is more commonly stable).

## Gotchas to remember

- **Antenna first.** Connect the LoRa antenna before powering on the RAK4631, or risk damaging the SX1262 power amp. Doubly important now that the RAK lives inside a closed case.
- **Voltage mismatch.** The 8201A's UART is 5V CMOS; the RAK4631 is 3.3V. RAK TX → 8201A RX may *just* meet Vih on a 5V CMOS input (~3.5V threshold), but don't rely on it — use a level shifter both directions.
- **No MAX3232 in this build.** We're skipping the RS-232 layer entirely by tapping pre-driver.
- **Power switch coupling.** The RAK must die when the laptop powers off. Tap downstream of the switch, not the raw battery bus, or the AAs will be drained by an idle-listening node.
- **Inrush at boot.** RAK4631 + radio init can pull a brief surge; check the 8201A's regulator can handle it without browning out the CPU.
- Meshtastic Serial module always broadcasts on the primary channel (index 0). No way to address a specific channel or DM from the byte stream without writing a custom firmware module.
- `override_console_serial_port` should stay off — the RAK4631 has a separate native USB CDC for the console, so UART1 is free for the Serial module. (USB access is gone once the case is closed, though — plan for OTA/BT config or leave a USB pigtail accessible.)

## TELCOM cheat sheet (PC-8201A)

- `STAT` from main menu sets line parameters, e.g. `STAT 48N1E` = 4800 baud, 8N1, full duplex.
- `Term` enters terminal mode.
- `F1` toggles half/full duplex on the fly.
