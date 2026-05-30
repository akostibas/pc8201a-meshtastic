# Appendix C: Tables & Diagrams

> Vision-OCR'd from NEC8201A-UsersGuide.pdf (image-only scan, source pages 203-210 / printed C-1..C-8), 2026-05-30.
> Figures/tables are transcribed per the project's per-figure-type policy; values flagged with TODO(tier-b) still need a human check against the scan.
> **Do not treat numeric/tabular values here as authoritative** — Tier B review pending.

## Memory Maps

### Memory Map 1

<!-- FIGURE C.1: BASIC RAM memory map (^X8000-^XFFFF region, decimal 8000-65535 shown in source) — source page 203 (target: mermaid) -->

```block-beta
columns 1
  a["65535 — Work area"]
  b["62336 — File control block (changes according to MAXFILES)"]
  c["String region (changes according to CLEAR statement number 1 parameter)"]
  d["FOR/GOSUB stack"]
  e["System stack"]
  f["(free space)"]
  g["Array region"]
  h["Pure variable region"]
  i["Machine language program file .CO"]
  j["ASCII code text file .DO"]
  k["BASIC program file .BA — 8000"]
```

Note: the source labels the top of the block "65535", the File-control-block
boundary "62336", and the bottom of the block "8000". These are shown as bare
decimals in the source (not hex).

### Memory Map 2

<!-- FIGURE C.2: System ROM / RAM bank layout (decimal 0, 32767, 32768, 65535 boundaries) — source page 204 (target: mermaid) -->

```block-beta
columns 4
  block:upper:4
    columns 4
    a["65535\nRAM 16K #1\n----\nRAM 16K (option)\n32768"]
    b["(empty)"]
    c["RAM 32K #2 (option)"]
    d["RAM 32K #3 / RAM cartridge"]
  end
  block:lower:4
    columns 4
    e["32767\nSystem ROM 32K\n0"]
    f["(empty)"]
    g["(dashed / optional)"]
    h["(dashed / optional)"]
  end
```

- The addresses for RAM #2 and RAM #3 can be designated as either 0 through 32767 or 32768 through 65535.
- Each block can affect a bank conversion in 32K byte segments.

## Character Code Table

The Character Code Table spans source pages 205-209 (printed C-3..C-7),
decimal codes 0-255. Codes 0-31 are the Control Code Table (unique codes that
cannot be output as characters); a continuous code/character grid follows.
Cross-checked against the shared glossary; the BASIC Reference's Appendix A is
the authoritative key for char/control codes.

### Decimal 0-53 (source page 205, printed C-3)

| Decimal | Character |
|---|---|
| 0 | (Control Code Table — unique code that cannot be output as characters) |
| 1 | (control code) |
| 2 | (control code) |
| 3 | (control code) |
| 4 | (control code) |
| 5 | (control code) |
| 6 | (control code) |
| 7 | (control code) |
| 8 | (control code) |
| 9 | (control code) |
| 10 | (control code) |
| 11 | (control code) |
| 12 | (control code) |
| 13 | (control code) |
| 14 | (control code) |
| 15 | (control code) |
| 16 | (control code) |
| 17 | (control code) |
| 18 | (control code) |
| 19 | (control code) |
| 20 | (control code) |
| 21 | (control code) |
| 22 | (control code) |
| 23 | (control code) |
| 24 | (control code) |
| 25 | (control code) |
| 26 | (control code) |
| 27 | (control code) |
| 28 | (control code) |
| 29 | (control code) |
| 30 | (control code) |
| 31 | (control code) |
| 32 | (space) |
| 33 | ! |
| 34 | " |
| 35 | # |
| 36 | $ |
| 37 | % |
| 38 | & |
| 39 | ' |
| 40 | ( |
| 41 | ) |
| 42 | * |
| 43 | + |
| 44 | , |
| 45 | - |
| 46 | . |
| 47 | / |
| 48 | 0 |
| 49 | 1 |
| 50 | 2 |
| 51 | 3 |
| 52 | 4 |
| 53 | 5 |

<!-- TODO(tier-b): verify Character Code Table 0-53 codes against source page 205 -->

### Decimal 54-110 (source page 206, printed C-4)

| Decimal | Character |
|---|---|
| 54 | 6 |
| 55 | 7 |
| 56 | 8 |
| 57 | 9 |
| 58 | : |
| 59 | ; |
| 60 | < |
| 61 | = |
| 62 | > |
| 63 | ? |
| 64 | @ |
| 65 | A |
| 66 | B |
| 67 | C |
| 68 | D |
| 69 | E |
| 70 | F |
| 71 | G |
| 72 | H |
| 73 | I |
| 74 | J |
| 75 | K |
| 76 | L |
| 77 | M |
| 78 | N |
| 79 | O |
| 80 | P |
| 81 | Q |
| 82 | R |
| 83 | S |
| 84 | T |
| 85 | U |
| 86 | V |
| 87 | W |
| 88 | X |
| 89 | Y |
| 90 | Z |
| 91 | [ |
| 92 | ¥ |
| 93 | ] |
| 94 | ^ |
| 95 | _ |
| 96 | \ |
| 97 | a |
| 98 | b |
| 99 | c |
| 100 | d |
| 101 | e |
| 102 | f |
| 103 | g |
| 104 | h |
| 105 | i |
| 106 | j |
| 107 | k |
| 108 | l |
| 109 | m |
| 110 | n |

<!-- OCR: unclear (94 rendered as a small upward caret "⌃", transcribed as ^; 96 rendered as a backslash "\") -->
<!-- TODO(tier-b): verify Character Code Table 54-110 codes against source page 206 -->

### Decimal 111-167 (source page 207, printed C-5)

| Decimal | Character |
|---|---|
| 111 | o |
| 112 | p |
| 113 | q |
| 114 | r |
| 115 | s |
| 116 | t |
| 117 | u |
| 118 | v |
| 119 | w |
| 120 | x |
| 121 | y |
| 122 | z |
| 123 | { |
| 124 | \| |
| 125 | } |
| 126 | ~ |
| 127 | (none shown) |
| 128 | ◀ (left-pointing filled triangle) |
| 129 | ↵ (return / carriage-return arrow symbol) |
| 130 | ■ (solid block) |
| 131 | (User-defined characters — Potential to be input from the Keyboard) |
| 132 | (user-defined) |
| 133 | (user-defined) |
| 134 | (user-defined) |
| 135 | (user-defined) |
| 136 | (user-defined) |
| 137 | (user-defined) |
| 138 | (user-defined) |
| 139 | (user-defined) |
| 140 | (user-defined) |
| 141 | (user-defined) |
| 142 | (user-defined) |
| 143 | (user-defined) |
| 144 | (user-defined) |
| 145 | (user-defined) |
| 146 | (user-defined) |
| 147 | (user-defined) |
| 148 | (user-defined) |
| 149 | (User-defined characters — Potential to be input from the Keyboard) |
| 150 | (user-defined) |
| 151 | (user-defined) |
| 152 | (user-defined) |
| 153 | (user-defined) |
| 154 | (user-defined) |
| 155 | (user-defined) |
| 156 | (user-defined) |
| 157 | (user-defined) |
| 158 | (user-defined) |
| 159 | (user-defined) |
| 160 | (user-defined) |
| 161 | (user-defined) |
| 162 | (user-defined) |
| 163 | (user-defined) |
| 164 | (user-defined) |
| 165 | (user-defined) |
| 166 | (user-defined) |
| 167 | (user-defined) |

Note: in the source, the "User-defined characters (Potential to be input from
the Keyboard)" annotation brackets two ranges: 131-160 (second column,
starting after a dashed line below 130) and 149-160 (third column). The dashed
lines fall below 130 and below 160. No glyphs are printed for the
user-defined codes — cells are intentionally blank in the source.

<!-- OCR: unclear (128 = filled left-triangle, 129 = return-arrow glyph, 130 = solid block) -->
<!-- TODO(tier-b): verify Character Code Table 111-167 codes (esp. glyphs 128-130 and user-defined range boundaries) against source page 207 -->

### Decimal 168-223 (source page 208, printed C-6)

All cells in codes 168-223 are blank in the source (continuation of the
user-defined range). A dashed line falls below 223.

| Decimal | Character |
|---|---|
| 168 | (blank) |
| 169 | (blank) |
| 170 | (blank) |
| 171 | (blank) |
| 172 | (blank) |
| 173 | (blank) |
| 174 | (blank) |
| 175 | (blank) |
| 176 | (blank) |
| 177 | (blank) |
| 178 | (blank) |
| 179 | (blank) |
| 180 | (blank) |
| 181 | (blank) |
| 182 | (blank) |
| 183 | (blank) |
| 184 | (blank) |
| 185 | (blank) |
| 186 | (blank) |
| 187 | (blank) |
| 188 | (blank) |
| 189 | (blank) |
| 190 | (blank) |
| 191 | (blank) |
| 192 | (blank) |
| 193 | (blank) |
| 194 | (blank) |
| 195 | (blank) |
| 196 | (blank) |
| 197 | (blank) |
| 198 | (blank) |
| 199 | (blank) |
| 200 | (blank) |
| 201 | (blank) |
| 202 | (blank) |
| 203 | (blank) |
| 204 | (blank) |
| 205 | (blank) |
| 206 | (blank) |
| 207 | (blank) |
| 208 | (blank) |
| 209 | (blank) |
| 210 | (blank) |
| 211 | (blank) |
| 212 | (blank) |
| 213 | (blank) |
| 214 | (blank) |
| 215 | (blank) |
| 216 | (blank) |
| 217 | (blank) |
| 218 | (blank) |
| 219 | (blank) |
| 220 | (blank) |
| 221 | (blank) |
| 222 | (blank) |
| 223 | (blank) |

<!-- TODO(tier-b): verify Character Code Table 168-223 codes against source page 208 -->

### Decimal 224-255 (source page 209, printed C-7)

Codes 224-242 are annotated "User-defined characters (Output by using the
CHS$ function)"; codes 243-255 are annotated "Characters (Output by using the
CHS$ function)". No glyphs are printed.

| Decimal | Character |
|---|---|
| 224 | (User-defined characters — Output by using the CHS$ function) |
| 225 | (user-defined, CHS$) |
| 226 | (user-defined, CHS$) |
| 227 | (user-defined, CHS$) |
| 228 | (user-defined, CHS$) |
| 229 | (user-defined, CHS$) |
| 230 | (user-defined, CHS$) |
| 231 | (user-defined, CHS$) |
| 232 | (user-defined, CHS$) |
| 233 | (user-defined, CHS$) |
| 234 | (user-defined, CHS$) |
| 235 | (user-defined, CHS$) |
| 236 | (user-defined, CHS$) |
| 237 | (user-defined, CHS$) |
| 238 | (user-defined, CHS$) |
| 239 | (user-defined, CHS$) |
| 240 | (user-defined, CHS$) |
| 241 | (user-defined, CHS$) |
| 242 | (user-defined, CHS$) |
| 243 | (Characters — Output by using the CHS$ function) |
| 244 | (CHS$) |
| 245 | (CHS$) |
| 246 | (CHS$) |
| 247 | (CHS$) |
| 248 | (CHS$) |
| 249 | (CHS$) |
| 250 | (CHS$) |
| 251 | (CHS$) |
| 252 | (CHS$) |
| 253 | (CHS$) |
| 254 | (CHS$) |
| 255 | (CHS$) |

<!-- TODO(tier-b): verify Character Code Table 224-255 codes and the CHS$ annotation boundaries against source page 209 -->

## Function Block Diagram

<!-- FIGURE C.3: Function Block Diagram (CPU 80C85, ROM/RAM banks, PIO, UART, interfaces) — illustration, source page 210. TODO(tier-b): crop image from source. -->

Block contents transcribed for reference (pictorial diagram on source page 210):

- **CPU 80C85** — connects to BCR Interface and CMT Interface (right side).
- System bus (vertical) connects CPU to: **ROM 32K byte**, **RAM 16K byte #1**,
  and (inside a dashed "Option" box) **RAM 16K byte**, **RAM 32K byte #2**,
  **ROM 32K byte**.
- **Keyboard** → CPU/PIO.
- **PIO 81C55** → **Centronics (Printer) Interface**.
- **LCD Controller** → **LCD**; **CLOCK** block adjacent.
- **UART IM6402** → **Multiplexer** → **RS-232C Interface**, **SIO1 Interface**,
  **SIO2 Interface**.

<!-- OCR: unclear (PIO labelled "81C55" in this diagram; the shared glossary canonical is "8155"/"8155S" — left as printed) -->
