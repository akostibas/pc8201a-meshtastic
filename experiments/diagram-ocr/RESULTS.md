# Diagram OCR experiment — model comparison

Goal: pick a model + pipeline for Tier B (turning the manual's figures into
mermaid diagrams / markdown tables). Tested on the NEC PC-8201A Technical
Reference (1983 scan, hidden OCR text layer).

## Setup

- Source: `docs/source/NEC8201A-TechRef.pdf`
- Render: `pdftoppm -png -r {200,300}` → PNG per page
- Models:
  - **tesseract** 5 (local, `--psm 6`)
  - **glm-ocr:latest** (local, ollama, `/api/generate`, `num_ctx 16384`, temp 0) — see `glm-ocr.sh`
  - **claude-sonnet-4-6** (subagent reads the PNG)
  - **claude-opus-4-8** (main agent reads the PNG)
- Scoring against a hand transcription of the image (ground truth).

## Primary test: p15 — Fig 2.1 Memory Map (ASCII block diagram)

A 4-column (Bank 0–3) memory map with 6 hex address labels and 8 named
RAM/ROM blocks. Ground truth in `results/p15.opus-4-8.md`.

| Model | Diagram captured? | Address values | Block labels | 2D structure | Mermaid-ready | Speed |
|---|---|---|---|---|---|---|
| tesseract | text only, mangled | 2 of 6 wrong (`XC88@Q`, `X880@`) | partial | lost | no | instant |
| glm-ocr @200dpi | **NO** — dropped entire figure, returned only the prose paragraph | n/a | n/a | n/a | no | ~35s |
| glm-ocr @300dpi | yes, as a flat md table | **all 6 correct** | all correct | flattened (addresses in own rows; bottom row merged) | partial — needs hand-fixing | ~47s |
| claude-sonnet-4-6 @300dpi | yes | all correct | all correct + caught Bank 1 empty upper half + parenthesised aliases + footer labels | **preserved** | **yes** (clean block-beta w/ address column) | ~19s |
| claude-opus-4-8 @300dpi | yes | all correct | all correct, same detail | preserved | yes | — |

### Findings

1. **glm-ocr is resolution-sensitive for figures.** At 200dpi it silently
   discarded the ASCII diagram and returned only the prose — regardless of how
   explicitly the prompt asked for the diagram. At 300dpi it transcribed the
   figure. Lesson: render Tier B pages at **≥300dpi**.
2. **glm-ocr flattens 2D layout.** Even when it captured the figure, it emitted
   a linear md table that loses which address range bounds which block. Values
   are right; spatial relationships need a human/LLM second pass. It is a
   transcriber, not a diagram *translator*.
3. **tesseract is unusable for figures** — garbles both structure and ~30% of
   the address values. Fine only as a cheap numeric cross-check, not a source.
4. **sonnet ≈ opus** on this diagram: both fully correct, both produced valid
   mermaid. Sonnet's output was actually the best-laid-out (it added an address
   column the opus pass omitted), at ~half the cost/latency. **Sonnet is the
   recommended workhorse;** reserve opus for figures sonnet struggles on.

### Recommended pipeline (provisional, pending 3 more diagrams)

1. `pdftoppm -r 300` the figure's page.
2. **sonnet** reads the PNG → (a) faithful transcription, (b) mermaid / md table.
3. Guard: diff the numbers in sonnet's transcription against the page's
   `pdftotext` layer (and optionally glm-ocr@300) to catch invented/dropped
   values.
4. Escalate to opus only if sonnet's transcription disagrees with the guard.

## Secondary tests (3 more diagrams, all @300dpi)

Models run: **glm-ocr** + **claude-sonnet-4-6** on all three; **opus-4-8** added
on the hard one (p184). Raw outputs in `results/`.

### p130 — Fig 8.5 LNKFIL flowchart (sequence of boxes → mermaid flowchart)

| Model | Result |
|---|---|
| glm-ocr | Got all 8 box texts verbatim, but rendered them as a 1-column md table — **lost the flow/arrows entirely**. Mangled the entry box border (`¥`). |
| sonnet | All 8 boxes correct; produced a valid `flowchart TD`. Invented an unverified `loop back` edge from a `\|<---` rail — flagged it. |

**Verdict:** sonnet wins — only it produced an actual flowchart. glm-ocr is a
transcriber, not a translator. Watch sonnet for hallucinated edges; verify
connectors against the page.

### p184 — Fig 10.1 keyboard matrix (dense hand-lettered grid → table)

| Model | Result |
|---|---|
| glm-ocr | Recovered grid shape + strobe/data labels; readable but several wrong cells; flattened dual-glyph keys. |
| sonnet | Grid shape + PA0–PA2 correct; PA3–PB0 increasingly wrong/mis-aligned; **self-flagged** the uncertain rows. Flattened dual-glyph keys. |
| opus-4-8 (500dpi crop) | Caught the **dual-character key structure** (shifted glyph over normal) that both others dropped; PA0–PA4 solid; still `(?)` on PA5. |

**Verdict:** the genuine hard case. No model is trustworthy unaided on the
symbol rows. Best move: opus on a **high-dpi crop** + human verification of
PA3–PA5, cross-checked against the other readings to surface disagreements.
Higher resolution mattered more than model choice here.

### p195 — Fig 11.2 EAR/SDI waveform (timing diagram)

| Model | Result |
|---|---|
| glm-ocr | Prose perfect; waveform collapsed to one meaningless `+ + +` line. |
| sonnet | Prose + all labels correct; **correctly judged mermaid unsuitable**, recommended ASCII-art code block + image, and produced a clean key-facts table (MARK=2400Hz=high, SPACE=1200Hz=low). |

**Verdict:** sonnet wins. The right Tier-B output for timing diagrams is **not
mermaid** — keep faithful ASCII + a facts table, and retain the cropped image.
Sonnet made that call correctly on its own.

## Conclusions (all 4 diagrams)

1. **Render at ≥300dpi.** This was the single biggest quality lever — at 200dpi
   glm-ocr silently dropped figures; at 500dpi opus recovered detail invisible
   at 300. For dense figures, crop + go higher.
2. **claude-sonnet-4-6 is the workhorse.** It transcribed faithfully, produced
   valid mermaid where appropriate, and—crucially—**knew when mermaid was the
   wrong tool**. Fast and cheap.
3. **Escalate to opus only for dense grids** (keyboard-matrix class), ideally on
   a high-dpi crop.
4. **glm-ocr is a guard, not an author.** Use its transcription only to
   numeric-diff against sonnet's (catch invented/dropped values); never as the
   diagram source. It cannot translate structure.
5. **tesseract: drop it.** Garbles structure and values.
6. **Per-figure-type policy:**
   - memory maps / RAM layouts → mermaid `block-beta` (sonnet)
   - flowcharts → mermaid `flowchart TD` (sonnet; verify edges)
   - pin/port/bit tables, keyboard matrix → markdown table (sonnet; opus+crop+human for dense ones)
   - timing/waveform, circuit schematics → **keep ASCII + cropped image**, add a facts table; do NOT force mermaid

### Recommended Tier-B pipeline

1. `pdftoppm -r 300` (─ ≥500 + crop for dense grids) the figure page.
2. **sonnet** reads PNG → faithful transcription + (mermaid | table | ASCII+image) per the policy above.
3. Guard: numeric-diff sonnet's transcription against the page `pdftotext` layer (and glm-ocr@300) to flag invented/dropped values.
4. Escalate to **opus** on disagreement or dense grids.
5. Human verifies the figures still flagged uncertain (e.g. keyboard symbol rows).
