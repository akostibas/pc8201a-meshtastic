# Appendix B: Memory Maps

> Vision-OCR'd from the image-only scan of NEC8201A-BasicReference.pdf
> (source pages 279–280). Transcribed faithfully; **numeric/tabular values
> are pending Tier B verification** — do not treat as authoritative yet.

## B. Memory Maps

### Map 1 — RAM Address Layout (single-bank view)

<!-- FIGURE B.1: Memory map diagram showing RAM address regions from 8000 to 65535, with labeled blocks for Work area, File control block, String region, FOR/GOSUB stack, System stack, Array region, Pure variable region, Machine language program file (.CO), ASCII code text file (.DO), and BASIC program file (.BA). Annotations note that File control block changes according to MAXFILES, and String/stack regions change according to CLEAR statement number 1 parameter. Source page 279 (target: image) -->

The following table summarises the regions shown in the diagram on source page 279:

| Address Range | Region | Notes |
|---|---|---|
| 62336–65535 | Work area | |
| (below 62336, variable) | File control block | Changes according to MAXFILES |
| (variable) | String region | Changes according to CLEAR statement number 1 parameter |
| (variable) | FOR/GOSUB stack | Changes according to CLEAR statement number 1 parameter |
| (variable) | System stack | Changes according to CLEAR statement number 1 parameter |
| (variable) | Array region | |
| (variable) | Pure variable region | |
| (variable) | Machine language program file (.CO) | |
| (variable) | ASCII code text file (.DO) | |
| 8000–(variable) | BASIC program file (.BA) | |

### Map 2 — RAM Bank Configuration

<!-- FIGURE B.2: Multi-column memory bank diagram showing four configurations side by side: (1) RAM 16K #1 (32768–65535) + RAM 16K option (below 32768), with System ROM 32K (0–32767); (2) RAM 32K #2 (option) with unlabeled lower block; (3) RAM 32K #3 with dashed-border lower block; (4) RAM cartridge with dashed-border lower block. Address markers: 65535 (top), 32768/32767 (midpoint), 0 (bottom). Source page 280 (target: image) -->

The addresses for RAM #2 and RAM #3 can be designated as either 0 through 32767 or 32768 through 65535.

Each block can affect a bank conversion in 32K byte segments.

| Bank | Size | Address Range Options |
|---|---|---|
| RAM #1 | 16K (built-in) | 32768–65535 (upper half) |
| RAM #1 option | 16K (option) | below 32768 (lower half) |
| RAM #2 | 32K (option) | 0–32767 or 32768–65535 |
| RAM #3 | 32K (option) | 0–32767 or 32768–65535 |
| RAM cartridge | 32K | 0–32767 or 32768–65535 |
| System ROM | 32K | 0–32767 |
