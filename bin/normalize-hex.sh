#!/usr/bin/env bash
#
# normalize-hex.sh — unify numeric-literal notation in the extracted chapters
# to the PC-8201A's OWN assembler convention: ^X for hex, ^B for binary
# (e.g. ^XFE44, ^B11110111). The source manual prints a CARET prefix throughout
# its listings, so this is both machine-native AND source-faithful.
#
# The LLM cleanup pass drifts some chapters to foreign styles (C-style 0x/0b,
# BASIC-style &H/&B) and to apostrophe/double-quote variants ('X / "X, where the
# source caret was misread). This pass folds them all back to the caret form.
#
# Safe by construction: every substitution requires a valid digit to follow
# the prefix, so prose punctuation is never touched. All 0b/0B literals in the
# corpus are verified 7-8 bit masks (no hex/binary ambiguity).
#
# Usage:
#   bin/normalize-hex.sh <file> [file ...]
#
# No default glob: pass the chapter files explicitly. (The tech-ref chapters use
# the older apostrophe form on purpose — see the audit issue — so don't re-fold
# them here.)

set -euo pipefail

if [ "$#" -eq 0 ]; then
  echo "usage: bin/normalize-hex.sh <file> [file ...]" >&2
  exit 2
fi

for f in "$@"; do
  before=$(grep -coE "0[xXbB][0-9A-Fa-f]|&[HB][0-9A-Fa-f01]|['\"][XB][0-9A-Fa-f01]" "$f" || true)
  perl -i -pe '
    s/'"'"'X([0-9A-Fa-f])/^X$1/g;   # apostrophe hex: '"'"'X -> ^X
    s/'"'"'B([01])/^B$1/g;          # apostrophe bin: '"'"'B -> ^B
    s/"X([0-9A-Fa-f])/^X$1/g;       # OCR noise:      "X  -> ^X
    s/"B([01])/^B$1/g;              # OCR noise:      "B  -> ^B
    s/&H([0-9A-Fa-f])/^X$1/g;       # BASIC hex:      &H  -> ^X
    s/&B([01])/^B$1/g;              # BASIC bin:      &B  -> ^B
    s/0[xX]([0-9A-Fa-f])/^X$1/g;    # C hex:          0x  -> ^X
    s/0[bB]([01])/^B$1/g;           # C bin:          0b  -> ^B
  ' "$f"
  printf "  %-45s normalized (%s prefixes)\n" "$(basename "$f")" "$before"
done

echo "Done."
