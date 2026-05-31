# Appendix A: Specifications

> Vision-OCR'd from NEC8201A-UsersGuide.pdf (image-only scan, source pages 183-190 / printed A-1..A-8), 2026-05-30.
> Figures/tables are transcribed per the project's per-figure-type policy; all spec values Tier-B verified against source pages 183-190 (2026-05-30).

## Hardware of PC-8201

| Item | Specification |
|---|---|
| Principal dimensions | 300 mm length |
| | 215 mm width |
| | 35 mm front height |
| | 61 mm rear height |
| Weight | 1.7 kg |
| CPU | 80C85 |
| Clock | 2.4 MHz |
| ROM | 32K (standard) |
| | 32K (optional, connects at the IC socket) |
| RAM | 16K (standard) |
| | 16K (optional, connects at the IC socket) |
| | 32K (optional, connects at the IC socket) |
| | 32K (optional, connects with the RAM cartridge) |
| | 32K (standard) |
| | 32K (optional, connects at the IC socket) |
| Keyboard | 67 keys |
| | 5 function keys, and 5 more using the SHIFT key |
| | 4 cursor movement keys |
| | 58 additional keys |

— RAM conversion is possible at every 32K.

### LCD

| Item | Specification |
|---|---|
| Effective display area | 191.2 mm length |
| | 50.4 mm width |
| Resolution | 240 x 62 dots |
| Dot size | 0.73 x 0.73 mm |
| Dot pitch | 0.8 mm |
| Display characters | 40 characters per line x 8 lines |
| | Reverse display possible by means of escape sequence |

## Electrical Power Section

### Battery Case

| Item | Specification |
|---|---|
| Cells | 4 alkali-manganese cells (3 AM-3 standard) |
| | Non-rechargeable |
| | Batteries can be exchanged |
| External dimensions | 70 mm width |
| | 80.5 mm depth |
| | 19 mm thickness |
| Length of operation | AM-3 — Up to 18 hours (during constant use at normal temperatures) |
| | SUM-3 — Up to 6 hours (during constant use at normal temperatures) |
| Range | DC 6 V 600 mA |

### Batteries for Emergency Operation

| Item | Specification |
|---|---|
| Battery | 50 mA/h 3.6 V Ni-Cd batteries installed within the PC-8201 |
| Charging | Trickle-chargeable from whatever batteries are used as the electrical power source for the basic unit |
| Discharge prevention | A battery discharge prevention switch is included |
| Emergency operation battery backup time limit | Up to 7 days (with 64K RAM at normal temperatures) |
| | Up to 26 days (with 16K RAM at normal temperatures) |

### Power Off

- Manual power-off by means of the electrical power switch
- Controllable by means of a POWER command in BASIC
- Automatic power shutoff when no key has been input after 10 minutes (this possible input period can be varied between 1 minute and 25 minutes)

### Low Voltage Display LED

- The LED will light up when the electrical power decreases below a standard value.

### Changing batteries

- After the basic PC-8201 unit has become inoperable
  - With 7 days (with 64K RAM)
  - With 26 days (with 16K RAM)

## Operating Conditions

| Item | Specification |
|---|---|
| Temperature | 0 °C to 35 °C (32° to 110°F) |
| Relative Humidity | 20% to 80%, noncondensing |

## Interface

### RS-232C

| Item | Specification |
|---|---|
| Connector | DSUB 25 pin |
| Data length | 6, 7, 8 bits |
| Parity | None, Odd, Even |
| Stop bits | 1, 2 bits |
| Baud rates | 75 |
| | 110 |
| | 300 |
| | 600 |
| | 1200 |
| | 2400 |
| | 4800 |
| | 9600 |
| | 19200 |

### SIO2

| Item | Specification |
|---|---|
| Connector | 6 pin DuPont BERG modular jack or equivalent |
| Transmission distance | 3 m Min. |
| Data length | 8 bits |
| Baud rate | 19200 |
| Parity | None |
| Stop bits | 1, 2 bits |

### SIO1

| Item | Specification |
|---|---|
| Connector | 8 pin DuPont BERG modular jack or equivalent |
| Transmission distance | 3 m Min. |
| Data length | 8 bits |
| Baud rate | 19200 |
| Parity | None |
| Stop bits | 1, 2 bits |

### CMT

| Item | Specification |
|---|---|
| Connector | 8 pin DIN plug |
| Transmission distance | 1.5 m Min. |
| Baud rate | 600 |
| File format | N-BASIC compatible |
| Output level | MIC level |

### Printer

| Item | Specification |
|---|---|
| Printer | Standard Centronics specifications |

### Bar-code Reader

| Item | Specification |
|---|---|
| Bar-code Reader | 9 pin DSUB connector (Recommended model: HEDN-3000/3050) |

### System slot

- Used for plugging in RAM cartridge.

## Optional Accessories

### Nickel-cadmium battery cartridge PC-8201-90

| Item | Specification |
|---|---|
| Capacity | 500 mA/h |
| Charging | Rechargeable by AC adapter or floppy disk interface |
| | Passage to the PC-8201 basic unit from the unit's electrical power source |
| Duration of retention of charge | Up to 48 hours |
| Batteries | Batteries not exchangeable |
| External dimensions | 70 mm length |
| | 80.5 mm width |
| | 19 mm thickness |

### 32K byte RAM Cartridge PC-8206

| Item | Specification |
|---|---|
| Contents | 32K bytes |
| RAM packs | 8K byte RAM packs (4 separate packs contained within) |
| Backup power | Lithium battery included as backup power |
| Duration of backup power | Up to 6 months (at normal temperatures) |
| Write protect | Write protect switch included |
| Battery exchange | Battery exchange can be conducted (so that the contents on the RAM cartridge will not be erased) when the AC adapter designed for and used with the basic PC-8201 unit is plugged into the jack on the side of the PC-8206 RAM cartridge. (Use only the AC adapter) |
| External dimensions | 100.5 mm length |
| | 85 mm width |
| | 16 mm height |

### AC Adapter

| Item | Specification |
|---|---|
| Standard output | 8.5 V 100 mA |
| No-load output | 11 V |
| Input voltage, frequency | 120 V +− 10% |
| | 50/60 Hz |
