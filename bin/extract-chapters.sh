#!/usr/bin/env bash
#
# extract-chapters.sh — split the NEC PC-8201A Technical Reference PDF into
# one markdown file per chapter, using the PDF's embedded OCR text layer.
#
# This is the "Tier A" pass: fast and free, but the source is scanned OCR,
# so prose is ~80% right and TABLES ARE UNRELIABLE. Table-heavy chapters are
# meant to be re-done later with a vision/OCR model ("Tier B").
#
# The script is self-aware: it reports what it's about to do and refuses with
# an actionable message if the source PDF is missing.
#
# Usage:
#   bin/extract-chapters.sh [chapter-number]
#     (no arg)  extract all chapters
#     <N>       extract only chapter N (e.g. to re-review one)
#
# Env:
#   PDF   override source PDF path
#   OUT   override output dir (default: docs/chapters)

set -euo pipefail

PDF="${PDF:-/Users/alexi/LocalDocs/pc8201a-meshtastic/docs/source/NEC8201A-TechRef.pdf}"
OUT="${OUT:-docs/chapters}"
LAST_PAGE=258

# chapter : start-page : slug-title   (titles cleaned from OCR'd headings)
CHAPTERS=(
  "1:11:introduction"
  "2:13:memory-map"
  "3:27:how-to-use-2nd-rom"
  "4:49:how-to-use-2nd-3rd-ram"
  "5:60:understanding-the-ram-file-concept"
  "6:76:directory-structure"
  "7:79:ram-organization"
  "8:102:ram-file-handling"
  "9:154:lcd-interface"
  "10:184:keyboard-interface"
  "11:192:cmt-interface"
  "12:205:serial-interface"
  "13:221:barcode-reader"
  "14:223:parallel-interface"
  "15:228:hardware"
)

# --- preconditions -----------------------------------------------------------
if ! command -v pdftotext >/dev/null 2>&1; then
  echo "ERROR: pdftotext not found. Install poppler (brew install poppler)." >&2
  exit 1
fi
if [ ! -f "$PDF" ]; then
  echo "ERROR: source PDF not found at: $PDF" >&2
  echo "  The PDF is not tracked in git; it lives only in the main checkout." >&2
  echo "  Set PDF=/abs/path/to/NEC8201A-TechRef.pdf and re-run." >&2
  exit 1
fi

want="${1:-all}"
mkdir -p "$OUT"
echo "Source : $PDF"
echo "Output : $OUT/"
echo "Mode   : ${want}"
echo

# Cleanup pass. We only remove structural noise and fix artifacts that are
# UNAMBIGUOUS in this document. Character-level OCR swaps (LCD->LCO, HOW->HOU,
# D<->O, W<->U, garbled hex literals) are intentionally NOT touched here: a
# blanket find/replace would corrupt more correct text than it fixes. The
# real fix for garbled glyphs and figures is the Tier B vision re-OCR.
#
# Two-pass awk strips:
#   - page-number footers like "- 13 -" (incl. tilde/underscore noise variants)
#   - running-header lines: a short all-caps line (the chapter title, however
#     OCR mangled it) that repeats >=3 times across the chapter's pages.
# Then sed/cat handle dot-leaders, I/0, and blank-line squeeze.
# $1 = chapter title (used to fuzzy-match OCR-mangled running headers)
clean() {
  awk -v title="${1:-}" '
    function nletters(s,  r){ r=toupper(s); gsub(/[^A-Z]/,"",r); return r }
    BEGIN {
      nt = nletters(title); tl = length(nt)
      for (i=1; i<=tl; i++) tc[substr(nt,i,1)]++
    }
    { raw[NR]=$0; t=$0; gsub(/^[ \t]+|[ \t]+$/,"",t); trimmed[NR]=t; cnt[t]++ }
    END {
      for (i=1; i<=NR; i++) {
        t = trimmed[i]
        squished = t; gsub(/[ \t]/,"",squished)
        # page-number footer: dashes/tilde on both sides of a 1-3 digit number
        if (squished ~ /^[-~_.]+[0-9]{1,3}[-~_.]+$/) continue
        up = t; gsub(/[^A-Z]/,"",up)
        low = t; gsub(/[^a-z]/,"",low)
        # repeated all-caps running header (no lowercase, short, recurs)
        if (length(t)>0 && length(t)<=40 && length(up)>=4 && length(low)==0 && cnt[t]>=3) continue
        # fuzzy running-header match: order-independent letter overlap vs the
        # chapter title, within a tight length window. Catches OCR spelling
        # variants (HAROUARE, RAM FIL€ CONCEPT) that split the count above.
        # Skip the first 5 lines so the opening CHAPTER/TITLE block survives.
        if (i > 5 && tl >= 4) {
          nl = nletters(t); ll = length(nl)
          if (ll > 0 && ll-tl <= 4 && tl-ll <= 4) {
            split("", lc); ov = 0
            for (j=1; j<=ll; j++) { c=substr(nl,j,1); lc[c]++ }
            for (c in tc) { m = (lc[c] < tc[c] ? lc[c] : tc[c]); ov += m }
            if (ov/tl >= 0.7) continue
          }
        }
        print raw[i]
      }
    }' \
  | sed -E \
      -e 's#I/0#I/O#g' \
      -e 's/(• *){2,}/ /g' \
      -e 's/[[:space:]]+$//'
}

slug_to_title() {
  # introduction -> Introduction ; how-to-use-2nd-rom -> How To Use 2nd Rom
  echo "$1" | tr '-' ' ' | awk '{for(i=1;i<=NF;i++)$i=toupper(substr($i,1,1))substr($i,2)}1'
}

extract_one() {
  local ch="$1" start="$2" slug="$3" end="$4"
  local title; title="$(slug_to_title "$slug")"
  local num; num=$(printf "%02d" "$ch")
  local file="$OUT/${num}-${slug}.md"

  printf "  CH%-2s pages %3d-%-3d -> %s\n" "$ch" "$start" "$end" "$file"

  {
    echo "# Chapter ${ch}: ${title}"
    echo
    echo "> Auto-extracted from the OCR text layer of NEC8201A-TechRef.pdf"
    echo "> (source pages ${start}-${end}). Prose is approximate and **tables"
    echo "> are unreliable** — pending Tier B vision re-OCR. Do not treat"
    echo "> numeric/tabular values here as authoritative."
    echo
    echo '```text'
    pdftotext -layout -f "$start" -l "$end" "$PDF" - 2>/dev/null | clean "$title" | cat -s
    echo '```'
  } > "$file"
}

n=${#CHAPTERS[@]}
for i in "${!CHAPTERS[@]}"; do
  IFS=':' read -r ch start slug <<<"${CHAPTERS[$i]}"
  # end = (next chapter start - 1), or LAST_PAGE for the final chapter
  if [ "$((i+1))" -lt "$n" ]; then
    IFS=':' read -r _ next_start _ <<<"${CHAPTERS[$((i+1))]}"
    end=$((next_start - 1))
  else
    end="$LAST_PAGE"
  fi
  if [ "$want" = "all" ] || [ "$want" = "$ch" ]; then
    extract_one "$ch" "$start" "$slug" "$end"
  fi
done

echo
echo "Done."
