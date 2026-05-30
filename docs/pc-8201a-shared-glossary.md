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

## Memory map (authoritative source: BASIC-ref Appendix B)

| Address | Meaning | Seen in |
|---|---|---|
| `'X0000` | ROM start | Tech-ref ch.2 |
| `'X7FFF` | ROM end | Tech-ref ch.2 |
| `'X8000` | RAM start | Tech-ref ch.2 |
| `'XFFFF` | top of address space | Tech-ref ch.2 |

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

_Authoritative source: BASIC-ref Appendix A. `@basic-ref-ocr` to seed this
section once that appendix is OCR'd — it becomes the disambiguation key for all
three titles._

| Token | Canonical | Source |
|---|---|---|
| _(to be filled by basic-ref-ocr)_ | | |
