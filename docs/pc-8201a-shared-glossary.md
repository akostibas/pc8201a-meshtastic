# PC-8201A Shared OCR Glossary

Canonical spellings, casing, and notation for terms that recur across all three
NEC PC-8201A manuals (Technical Reference, User's Guide, BASIC Reference).

**Purpose:** when OCR is ambiguous — `0` vs `O`, `8` vs `B`, `l` vs `1`, `S` vs
`5` inside a reserved word, opcode, or address — check this table and how the
*other* titles render the same term before guessing. All three OCR agents append
here; keep entries alphabetical within each section. Cite the source on new
entries: `term — TITLE p.N`.

See [docs/ocr-workflow.md](ocr-workflow.md) for the full two-tier pipeline and
per-figure-type output policy.

## Notation (identical across all titles — enforced by `bin/normalize-hex.sh`)

| Kind | Canonical form | Example | Notes |
|---|---|---|---|
| Hexadecimal | `^X` prefix (caret) | `^XFFFF`, `^X8000` | The manual prints a caret. Not `FFFFH`, not `0xFFFF`, not `'X`. Fold on extraction. |
| Binary | `^B` prefix (caret) | `^B11000000` | 8-bit groups where the source shows a byte. |
| Decimal | bare | `19200` | No sigil. |

> **Note:** the already-completed tech-ref chapters use an older apostrophe
> form (`'X`/`'B`) — that was a misread of the source caret. They'll be
> reconciled to `^X`/`^B` later (tracked in a GitHub audit issue); do not copy
> the apostrophe form into new work. New titles use the caret from the start.

## Hardware / parts

| Term | Canonical | Seen in |
|---|---|---|
| CPU | `80C85` | Tech-ref (CMOS 8085) |
| Programmable I/O / timer | `8155` (variant `8155S`) | Tech-ref |
| LCD column driver | `HD44102B` | Tech-ref |
| LCD common driver | `HD44023B` | Tech-ref |
| CPU (confirmed) | `80C85` | User's Guide App A (independent agreement w/ Tech-ref) |
| Optoelectronic / display part | `HEDN-3000` / `HEDN-3050` | User's Guide App A |

## Abbreviations (cross-title)

| Abbrev | Expansion | Seen in |
|---|---|---|
| IPL | Initial Program Loader | User's Guide Ch2 |
| Warm Start / Cold Start | (boot modes — Warm preserves RAM, Cold clears) | User's Guide Ch2 |
| BCR | Bar-Code Reader (rear-panel connector) | User's Guide Ch2 |
| SI / SO | Shift In / Shift Out | User's Guide Ch8 (TELCOM) |
| XON / XOFF | flow control | User's Guide Ch8 |
| Half Duplex / Full Duplex | (transmission modes) | User's Guide Ch8 |
| `CAS:` / `COM:` | device names — cassette / RS-232C | User's Guide Ch8 |
| `.BA` / `.DO` / `.CO` | file types — BASIC program / ASCII text / machine-language | User's Guide; BASIC-ref |
| IPL Command File / `SETIPL` / `CLRIPL` | auto-run-on-boot file mechanism | User's Guide Ch2 |
| `GRPH` | graphics-symbols key | User's Guide Ch3 |

### App B connector signals (active-low marked with overbar in source)

| Signal | Meaning | Seen in |
|---|---|---|
| `AD0`–`AD7` | multiplexed address/data bus | User's Guide App B |
| `ALE` | address latch enable | User's Guide App B |
| `HOLDA` | hold acknowledge | User's Guide App B |
| `ROME` | ROM enable (active-low) | User's Guide App B |
| `HADRD` / `LADRD` | high / low address read | User's Guide App B |
| `BANK#3` | RAM-cassette select (active-low) | User's Guide App B |
| `VDD` / `Vcc` | supply rails | User's Guide App B |
| DuPont BERG modular jack / DIN plug | connector types | User's Guide App B |

## Memory map (authoritative source: BASIC-ref Appendix B)

| Address | Meaning | Seen in |
|---|---|---|
| `^X0000` | ROM start / bottom of address space | Tech-ref ch.2; BASIC-ref APX B (System ROM base) |
| `^X7FFF` | System ROM end (32767) | Tech-ref ch.2; BASIC-ref APX B |
| `^X8000` | RAM start / bank boundary (32768) | Tech-ref ch.2; BASIC-ref APX B; base of BASIC program file (.BA) |
| `^XFFFF` | top of address space (65535) | Tech-ref ch.2; BASIC-ref APX B (top of Work area) |
| `^XF380` (≈62336) | base of Work area | BASIC-ref APX B (decimal in source; hex inferred — pending Tier B) |

<!-- TODO(tier-b): BASIC-ref APX B (source p279) memory-map diagram mixes hex
and decimal in the vision pass (e.g. "8000" alongside "65535"). The diagram
almost certainly labels every address in hex (8000=32768, FFFF=65535,
F380≈62336 for the Work-area base). Re-OCR the diagram and fold all addresses
to `^X` before treating region boundaries as authoritative. -->

## Terminology (preferred casing)

| Preferred | Avoid | Notes |
|---|---|---|
| RAM file | RAM-file, ramfile | Two words, "RAM" caps. |
| directory | Directory | Lowercase in prose; caps only if heading. |
| bank | Bank | Lowercase in prose. |
| slot | Slot | Lowercase in prose. |
| CMT | cmt | Cassette tape interface — always caps. |
| LCD / CTS / RTS | — | Always caps. |

## Reserved words / opcodes / control codes

_Authoritative source: BASIC-ref Appendix A (full list in
[appendix-a-tables.md](pc-8201a-basic-ref/chapters/appendix-a-tables.md),
source pages 265–266). This is the disambiguation key for all three titles —
if a token's OCR is ambiguous, it must match one of these spellings exactly._

Complete N82-BASIC reserved-word list (ABS … XOR), for grep/disambiguation:

`ABS` `AND` `ASC` `ATN` `BEEP` `BLOAD` `BLOAD?` `BSAVE` `CDBL` `CHR$` `CINT`
`CLEAR` `CLOAD` `CLOAD?` `CLOSE` `CLS` `COM ON/OFF/STOP` `CONT` `COS` `CSAVE`
`CSNG` `CSRLIN` `DATA` `DATE$` `DEFINT/SNG/DBL/STR` `DIM` `EDIT` `END` `EOF`
`EQV` `ERL` `ERR` `ERROR` `EXEC` `EXP` `FILES` `FIX` `FOR…TO…STEP…NEXT` `FRE`
`GOSUB…RETURN` `GOTO` `IF…THEN…ELSE` `IMP` `INKEY$` `INP` `INPUT` `INPUT$`
`INPUT#` `INSTR` `INT` `KEY` `KILL` `LEFT$` `LEN` `LET` `LINE INPUT`
`LINE INPUT#` `LIST/LLIST` `LOAD` `LOCATE` `LOG` `LPOS` `MAXFILES` `MENU`
`MERGE` `MID$` `MOD` `MOTOR` `NAME` `NEW` `NOT` `ON COM GOSUB`
`ON ERROR GOTO…RESUME` `ON…GOTO/GOSUB` `OPEN` `OPEN "COM"` `OR` `OUT` `PEEK`
`POKE` `POS` `POWER` `PRESET` `PRINT/LPRINT` `PRINT USING/LPRINT USING` `PSET`
`READ` `REM` `RENUM` `RESTORE` `RESUME` `RETURN` `RIGHT$` `RND` `RUN` `SAVE`
`SCREEN` `SGN` `SIN` `SOUND` `SPACE$` `SQR` `STOP` `STR$` `STRING$` `TAB` `TAN`
`TIME$` `VAL` `XOR`

### Control codes (BASIC-ref Appendix A3, source pages 271–272)

Full table with TELCOM-mode notes in
[appendix-a-tables.md](pc-8201a-basic-ref/chapters/appendix-a-tables.md).

| Code | Key | Function |
|---|---|---|
| 3 | CTRL+C | interrupt command input |
| 7 | CTRL+G | bell / beeper |
| 8 | CTRL+H | backspace (BS key) |
| 6 | CTRL+I | TAB <!-- source prints 6; this is a likely misprint for ASCII HT=9. Every neighboring control code on APX A3 p271 matches standard ASCII exactly, and CTRL+I=TAB=HT=9 universally. Kept 6 as printed per the byte-faithful rule (glyph is unambiguously a 6 at 400dpi). --> |
| 10 | CTRL+J | line feed |
| 11 | CTRL+K | home position |
| 12 | CTRL+L | clear screen |
| 13 | CTRL+M | carriage return (RETURN key) |
| 14 | CTRL+N | shift out (RS-232C) |
| 15 | CTRL+O | shift in |
| 17 | CTRL+Q | request interrupt during transmission |
| 19 | CTRL+S | authorize reopening of transmission |
| 27 | ESC | begin escape sequence |
| 28–31 | arrow keys | cursor movement <!-- arrow-icon↔direction-text mismatch in source; flagged for Tier B --> |

> **CTRL+I resolved:** read against the source scan at 400dpi (BASIC-ref APX A3
> p271), the glyph is unambiguously a printed **6**, not a rotated/smudged 9.
> It is a source misprint for ASCII HT=9 (every other control code on the page
> matches standard ASCII; only CTRL+I breaks the pattern, and CTRL+I=TAB=HT=9
> universally). Canonical = **6 as printed + flag**, per the byte-faithful rule.
> Chapter file and glossary now agree on 6.

## Cross-title behavioral notes

_Where two titles independently print the same "wrong-looking" value, it's
machine behavior, not OCR error._

| Finding | Resolution | Confirmed by |
|---|---|---|
| TEXT/editor cursor-arrow keycap icons read reversed vs. their described function (right-triangle icon → moves cursor left, up-triangle → scrolls down, etc.) | Transcribe icon-as-printed; the **described function direction is authoritative**. The CTRL-key equivalents (WordStar-style `^S`/`^D`/`^E`/`^X` = left/right/up/down) agree with the *function*, confirming the printed icons are the reversed ones. Not an OCR slip. | User's Guide Ch.7 (p.131) **and** BASIC-ref Appendix A §A3 — independent agreement |
| `CTRL`+`I` listed as control code **6** (not ASCII HT 9) | **Source misprint, not a remap.** At 400dpi the glyph is unambiguously a printed 6, but every neighboring control code on the page matches standard ASCII and CTRL+I=TAB=HT=9 universally — so 6 is a print error for 9. Kept **6 as printed + flag** per the byte-faithful rule. | BASIC-ref Appendix A §A3 (single-sourced; UG CTRL table is WordStar-letter-based and doesn't list `I`) |

## User's Guide — title-specific terms

| Term | Canonical / note | Seen in |
|---|---|---|
| Programmable I/O (PIO) | Canonical `8155`/`8155S` (see Hardware/parts). User's Guide **App C** labels it `81C55` (CMOS variant marking) — transcribed as printed, flagged; treat as the same part. | User's Guide App C |
| `PC-8271-01` (disk), `PC-8023A-C` (printer) | Optional-equipment model numbers as printed in User's Guide App B; differ from some catalogs' `PC-8271A-01` / `PC-8023-C`. Transcribed verbatim from the scan; confirm against a parts list in Tier B. | User's Guide App B |
| Part numbers (App A/B, as printed) | `PC-8201-06`, `PC-8206`, `PC-8293`, `PC-8294`, `PC-8023A-C`/`PC-8023-01`, `PC-6082`, `PC-8281`, `PC-8093` (likely OCR/source typo for `PC-8293`). Transcribed verbatim; confirm against a parts list. | User's Guide App A/B |
| `N82-BASIC` | The dialect name; source sets "82" as a subscript. Render `N82-BASIC` in prose. | User's Guide Ch.6 |
| `CHS$` | user-definable-character function (codes 224–255); codes 131–160 are keyboard-inputtable | User's Guide App C |
| TEXT editor markers | EOF marker `◄`, line-feed/return marker `↵`, PASTE buffer, word wrap, tab stop every 8th column | User's Guide Ch7 |
