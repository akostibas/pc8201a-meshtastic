# Working notes

Free-form notes as the build progresses. Roughly in build order.

## Open questions

- Confirm UART1 TX/RX pin labels on the RAK19003 mini base when it arrives.
- Verify which RAK4631 variant is in hand (4631 / 4631-R / 4631-C). Shouldn't matter for this project, but worth knowing.
- Most reliable baud rate for the PC-8201A's RS-232 in practice (19200 is spec ceiling, but 4800/9600 is more commonly stable).

## Gotchas to remember

- **Antenna first.** Connect the LoRa antenna before powering on the RAK4631, or risk damaging the SX1262 power amp.
- **3.3V MAX3232, not 5V MAX232.** The RAK4631 UART is 3.3V TTL.
- **Null-modem crossover** between MAX3232 and the PC-8201A — TX↔RX, GND↔GND. (RTS/CTS only if we wire flow control.)
- Meshtastic Serial module always broadcasts on the primary channel (index 0). No way to address a specific channel or DM from the byte stream without writing a custom firmware module.
- `override_console_serial_port` should stay off — the RAK4631 has a separate native USB CDC for the console, so UART1 is free for the Serial module.

## TELCOM cheat sheet (PC-8201A)

- `STAT` from main menu sets line parameters, e.g. `STAT 48N1E` = 4800 baud, 8N1, full duplex.
- `Term` enters terminal mode.
- `F1` toggles half/full duplex on the fly.
