# Chapter 4: Peripheral Devices

> Vision-OCR'd from NEC8201A-UsersGuide.pdf (image-only scan, source pages 46-51 / printed 4-1..4-6), 2026-05-30.
> Figures/tables are transcribed per the project's per-figure-type policy; values flagged with TODO(tier-b) still need a human check against the scan.
> **Do not treat numeric/tabular values here as authoritative** — Tier B review pending.

## Overview

The peripheral devices available for use with the PC-8201 are described in this chapter. These devices greatly enhance the capabilities of the PC-8201.

## Interfaces

The RS-232C Interface allows the PC-8201 to be utilized as a terminal. Through a telephone modem, the PC-8201 can communicate with:

- A large computer (host computer)

- Other PC-8201 computers

- Most letter quality (daisy wheel) printers

Options available when the RS-232C interface is used with the PC-8201 in the TELCOM mode are:

| Option | Setting |
|---|---|
| BAUD RATE | 75 to 19200 |
| PARITY | Odd, Even, or None |
| STOP BIT | Single or Double |
| DUPLEX | Half or Full |

## Data Recorder

The Data Recorder is used for the purpose of saving BASIC programs or TEXT data files on cassette tape. The (PC-6082), (PC-8281), or any other cassette recorder may be used with the PC-8201 computer. The information to be saved on tape is sent to the recorder as audio signals. This stored data can then be reused at a later time.

The cassette recorder you choose to use with the PC-8201 should have the following basic features:

- EARPHONE jack
- REM (REMOTE) jack
- MIC (MICROPHONE) jack
- CAPSTAN head drive

The PC-8201 power switch should be OFF prior to connecting the recorder. The (PC-8293) cable is used to connect the recorder to the PC-8201.

1. Insert the three plugs of the cable into the appropriate jacks on the recorder:

<!-- FIGURE 4.1: cable plugs (RED, BLACK, WHITE) inserted into recorder jacks (CMT IN/Red, AUX, REMOTE/Black, CMT OUT/White) alongside PC-8201 — source page 47 (target: image) -->
<!-- FIGURE 4.1: cable plug-to-jack connection drawing — illustration, source page 47. TODO(tier-b): crop image from source. -->

> **NOTE:** Insert the RED plug into the jack labeled CMT IN (microphone jack), the BLACK plug into the jack labeled RMT (remote jack), and the WHITE plug into the jack labeled CMT OUT (earphone jack).

2. Plug the other end of the cable into the recorder connector socket on the rear of the PC-8201. Make sure that the notch on the end of the round connector is facing up:

<!-- FIGURE 4.2: round DIN connector with notch facing up — source page 48 (target: image) -->
<!-- FIGURE 4.2: round connector showing notch — illustration, source page 48. TODO(tier-b): crop image from source. -->

3. Plug the recorder into a wall outlet if not using battery power.

Adjust the volume using the LOAD LEVEL control (or the VOLUME control.) Start at a midway point, which is "5" on the Data Recorder. The PC-8201 will not be able to identify the signals being sent by the recorder if this adjustment is not correct.

With ordinary cassette recorders it is necessary to experiment with different volume levels until the computer is able to pick up the signals. You can leave the volume control at the same setting once you have determined what level is best for your equipment.

During the loading of information from the recorder to the PC-8201, the LOAD (Play) button is depressed. When information is saved (recorded) on cassette tape the LOAD (Play) and SAVE (Record) buttons are depressed simultaneously. Since the recorder is set up to be activated by remote control, the tape will not revolve until the computer activates the recorder.

> **NOTE:** You should be aware that standard cassette tapes have a blank leader section of tape at the beginning. You should always forward the tape slightly to get the magnetic portion into position for use.

### Care of Cassette Tapes

The best quality high-bias cassette tape available will give the best results. Inferior quality tapes could lead to loss of information being stored on the tapes. Follow manufacturer's recommendations for care, temperature, and storage of cassette tapes. Additional recommendations:

<!-- FIGURE 4.3: handling cassette by plastic case — illustration, source page 49. TODO(tier-b): crop image from source. -->

1. Never touch the magnetic surface of the tape. Always handle the tape by the plastic case.

<!-- FIGURE 4.4: inserting tape into recorder magnetic-surface-forward — illustration, source page 49. TODO(tier-b): crop image from source. -->

2. Always insert the tape into the recorder with the magnetic surface facing the front of the unit. Gently place the tape into the Cassette Tape Housing. Never force it in.

<!-- FIGURE 4.5: tightening loose tape with a pencil in the play reel — illustration, source page 49. TODO(tier-b): crop image from source. -->

3. The tape should be tightly wound in the cassette package at all times. If it should become unraveled or loosened, gently place a pencil into the play reel (not the take up reel) and slowly tighten the tape by turning the pencil clockwise.

<!-- FIGURE 4.6: cassette write-protect punch tabs (Side A tab location) — illustration, source page 49. TODO(tier-b): crop image from source. -->

4. Tapes should be "write protected" if you want to protect particular information stored on tape from having new information written over it. To do this, the punch tabs are removed as illustrated. Be careful not to crack the case while removing the tabs. The punch tab protecting Side A of the tape is on the right when Side A is facing up. To later save new information on a write protected tape you simply cover the write protect tab area with a strong piece of cellophane tape. The tape is then functional for input or output.

<!-- FIGURE 4.7: cleaning tape heads and capstan with a cotton swab (labels: HEAD, HEAD, CAPSTAN, COTTON SWAB) — illustration, source page 50. TODO(tier-b): crop image from source. -->

5. The tape heads of the recorder should be cleaned periodically for optimum performance. A head cleaning tape may be used for this purpose.

If you do not use a head cleaning tape place a cotton swab saturated with alcohol (common rubbing alcohol) against the heads and capstan and gently clean the surface. Use another cotton swab to dry the surfaces. Wait 5 minutes for the surfaces to dry thoroughly before inserting a tape.

## Printer

The PC-8201 has a built-in parallel interface which allows you to connect a wide variety of commercially available parallel printers.

NECHE offers several printers including:

- PC-8023-C — 80 column dot matrix printer which features graphics capability, bi-directional printing, and multiple character fonts

- PC-6021 — 40 column thermal printer

- PC-8221 — Thermal printer which was designed for the PC-8201's features and compact size

> **REFERENCE:** Please refer to the Owner's Manual for your particular printer for complete installation instructions.

## Bar Code Reader (BCR)

A Bar Code Reader can be connected to the PC-8201 personal computer for the purpose of inputting specific data very quickly. The Bar Code Reader has a light wand that is passed over a bar code. The data read by the Bar Code Reader is passed into the PC-8201.

> **REFERENCE:** See instructions provided with the optional Bar Code Reader for details for use.

## Modem

An optional modem may be connected to the PC-8201 for communication through a telephone line. A variety of modems, each with different capabilities, are available.

> **REFERENCE:** Instructions provided with individual modems should be read thoroughly before installation.
