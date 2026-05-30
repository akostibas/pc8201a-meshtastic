# OCR workflow — scanned technical manuals → markdown

How we converted the NEC PC-8201A Technical Reference (a 1983 scan with a
hidden OCR text layer) into per-chapter markdown. Written to be reused for the
next books. The PC-8201A is the worked example throughout.

## TL;DR

Two tiers, because the cheap pass is good enough for prose but not for
figures/tables:

- **Tier A — mechanical text extraction.** `pdftotext` the embedded OCR layer,
  split per chapter, strip scan noise, light LLM prose cleanup. Fast, free,
  ~80% right. **Tables and figures are NOT trustworthy** from this pass.
- **Tier B — vision re-OCR.** Render the figure/table pages to PNG and read
  them with a vision model. Output mermaid / markdown tables / cropped images
  per a per-type policy. Human-reviewed.

Tier A gives you a complete, navigable draft in minutes. Tier B is the slow,
selective pass that makes the numbers and diagrams correct.

## Prerequisites

```
brew install poppler        # pdftotext, pdftoppm, pdfinfo
brew install tesseract      # optional baseline OCR (we ended up not using it)
ollama pull glm-ocr         # optional local vision model (numeric cross-check)
```

`sips` (built into macOS) is used for cropping. No global language installs.

**Do not commit the source PDF.** It stays in the main checkout only (ours:
`docs/source/<BOOK>.pdf`); scripts take its path via a `PDF=` env override.
Keep books out of git — they're large and may be copyrighted.

---

## Tier A — text extraction

Script: [`bin/extract-chapters.sh`](../bin/extract-chapters.sh)

What it does:
1. Reads a `CHAPTERS` array of `num:start-page:slug` (hand-built from the
   book's table of contents) and computes each chapter's page range.
2. `pdftotext -layout -f <start> -l <end>` per chapter (the `-layout` flag
   preserves column/table spacing).
3. A `clean()` pass strips **only unambiguous** scan noise:
   - page-number footers (`- 13 -` and tilde/underscore variants),
   - repeated all-caps running headers (exact + fuzzy letter-overlap match, to
     catch OCR-mangled variants like `HAROUARE`),
   - dot-leaders, `I/0`→`I/O`, blank-line squeeze.
4. Wraps the output in a fenced ```text block with a provenance header warning
   that tables are unreliable.

**Deliberately NOT done in Tier A:** character-level OCR "corrections"
(`LCD`→`LCO`, `D`↔`O`, `W`↔`U`, garbled hex). A blanket find/replace corrupts
more correct text than it fixes. Leave glyph errors for the LLM prose pass and
Tier B.

Per book you re-derive the `CHAPTERS` page map and re-tune the header/footer
regexes — those are document-specific.

### LLM prose cleanup

After extraction, an LLM pass fixes obvious OCR prose errors **without altering
values**. Hard rule learned the hard way: it must be byte-faithful — do not let
it "improve" wording, drop instructions, renumber, or normalize numbers. We had
to restore ~20 dropped assembly instructions and revert altered hex values that
a too-eager cleanup introduced. When in doubt, preserve the source and annotate
with an inline `<!-- OCR: unclear (...) -->` instead of guessing.

### Notation normalization

Script: [`bin/normalize-hex.sh`](../bin/normalize-hex.sh)

Folds numeric-literal styles to the machine's native convention. For the
PC-8201A that's `^X` for hex and `^B` for binary — the manual prints a **caret**
prefix (e.g. `^XFE44`, `^B11110111`). The LLM pass drifted some literals to C
(`0x`) / BASIC (`&H`) styles, and OCR sometimes misread the caret as a quote
(`'X`/`"X`). Each substitution requires a valid digit to follow the prefix, so
prose punctuation is never touched. **Per book:** confirm the native notation
first; if a book just uses modern `0x`, target that instead.

> **History:** the tech-ref chapters were first normalized to an apostrophe
> form (`'X`/`'B`) before we confirmed the source actually uses a caret. New
> titles use `^X`/`^B`; the tech-ref reconciliation is tracked in a GitHub
> audit issue.

### Marking what Tier A can't do

Wherever the text pass hits a figure or an untrustworthy table, leave a marker
comment in the markdown so Tier B can find it:

```
<!-- FIGURE 9.2: PAGE/OFFSET display RAM map — needs vision re-OCR from source page 157 (target: mermaid or table) -->
<!-- TODO(tier-b): verify register bit table against source page 160 -->
<!-- OCR: unclear ("her", "wco") -->
```

These markers drive the review tracking (below) and are the unit of Tier B work.

---

## Tier B — vision re-OCR of figures and tables

Before committing to a pipeline we ran a one-off bake-off on four
representative figures (memory map, flowchart, keyboard matrix, timing
waveform) across tesseract, glm-ocr (local), claude-sonnet-4-6, and
claude-opus-4-8, scored against hand transcriptions. The scratch outputs
weren't kept — the conclusions are below.

### What we learned (carry these forward)

1. **Render at ≥300 dpi.** The single biggest quality lever. At 200 dpi the
   local vision model *silently dropped entire ASCII diagrams* and returned
   only the prose. For dense grids, crop the region and go to 500 dpi.
2. **claude-sonnet-4-6 is the workhorse.** Faithful transcription, valid
   mermaid where appropriate, and—critically—it knows when mermaid is the
   wrong tool. Fast and cheap.
3. **Escalate to opus only for dense grids** (keyboard-matrix class), ideally
   on a high-dpi crop. Opus caught dual-glyph key cells both other models
   flattened.
4. **glm-ocr (local) is a numeric guard, not an author.** It transcribes values
   but flattens 2D structure (memory map → linear table). Use it only to
   diff numbers against sonnet's reading; never as the diagram source.
5. **tesseract: skip it.** Garbled structure and ~30% of address values.
6. **Known model failure modes the human review must catch:**
   - flowchart **connector topology** (sonnet invented a loop edge / got an
     off-page connector's direction backwards),
   - **dual-character table cells** (shifted glyph over normal) collapsed to one.

### Per-figure-type output policy

| Source figure | Target representation | Model |
|---|---|---|
| memory map / RAM layout | mermaid `block-beta` | sonnet |
| flowchart | mermaid `flowchart TD` (verify edges) | sonnet |
| pin / port / bit-field / register table | markdown table | sonnet |
| dense hand-lettered grid (keyboard matrix) | markdown table | opus + 500dpi crop + human |
| timing / waveform diagram | faithful ASCII code block + cropped image + facts table | sonnet |
| circuit schematic | cropped image (+ caption) | keep image |

Rule of thumb: **don't force a diagram type that loses information.** Timing
diagrams and schematics stay as images; mermaid is for block/flow/table-like
structure.

### Mechanics

Render a page (or crop):

```
pdftoppm -png -r 300 -f <page> -l <page> "$PDF" out/p<page>
# dense grid: render 500dpi then center-crop with sips
sips -c <h> <w> out/p<page>-<page>.png
```

Local vision model caller: [`bin/glm-ocr.sh`](../bin/glm-ocr.sh)
— posts a base64 PNG to ollama's `/api/generate` with `num_ctx 16384` (the
default 4096 is too small to encode a page image and crashes cryptically).

For the sonnet/opus pass, hand the model the PNG path and ask for two things:
(1) a byte-faithful transcription, (2) the target representation per the policy
table. Tell it the machine's native notation is a caret prefix (`^X` hex / `^B`
binary), and that OCR may misread the caret as a quote (`'X`/`"X`) — normalize
back to the caret.

### Numeric guard

Before trusting a Tier B table, diff its numbers against the page's `pdftotext`
layer (and optionally glm-ocr@300). Agreement across independent readings is
the cheapest signal that a hex address or bit-field wasn't invented. Escalate
to opus / human on disagreement.

---

## Review tracking

Script: [`bin/gen-review-issues.sh`](../bin/gen-review-issues.sh)

Scrapes the `FIGURE` and `TODO(tier-b)` markers into one GitHub issue per
chapter (Diagrams + Tables/values checklists, each with a source-line ref),
plus a parent tracker. Dry-run by default; `--create` opens the issues
(needs the `tier-b` label and an authenticated `gh`). Re-run to refresh as
markers are resolved. This gives a human reviewer one page per chapter to check
diagrams off against the original scan — essential, because the model failure
modes above are invisible unless someone compares to the source.

---

## Per-book checklist

1. Put the PDF in the main checkout (not git). Note its page count (`pdfinfo`).
2. Build the `CHAPTERS` page map from the table of contents.
3. Tune `extract-chapters.sh` header/footer regexes to the book's layout; run it.
4. Decide native numeric notation; set up / adjust `normalize-hex.sh`.
5. LLM prose cleanup — byte-faithful, annotate don't guess.
6. Drop `FIGURE` / `TODO(tier-b)` markers at every figure and shaky table.
7. `gen-review-issues.sh --create` to open the per-chapter review issues.
8. Tier B each figure/table per the policy table; numeric-guard the values.
9. Human review against the scan; integrate validated diagrams into chapters.
```
