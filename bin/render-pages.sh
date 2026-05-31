#!/usr/bin/env bash
#
# render-pages.sh — render a PDF page range to PNG + downscaled JPEG for the
# Tier B vision-OCR pass.
#
# The image-only scans have no text layer, so every page is read by a vision
# model. Vision subagents hit an image-size cap (~2000px on the long edge) when
# several page images accumulate in context, so we render a crisp PNG at high
# dpi AND a downscaled JPEG that stays under the cap. Hand the subagent the
# JPEGs; keep the PNGs for high-dpi crops of dense grids.
#
# Usage:
#   bin/render-pages.sh <out_dir> <first_page> <last_page> [dpi] [max_px]
#
# Env:
#   PDF=/abs/path/to/book.pdf   (required; the PDF is NOT in git — main checkout)
#
# Defaults: dpi=300, max_px=1560 (long-edge cap for the JPEG).
#
# Example:
#   PDF=docs/source/NEC8201A-BasicReference.pdf \
#     bin/render-pages.sh build/basic-ref/ch2 21 29
set -euo pipefail

OUT=${1:?usage: render-pages.sh <out_dir> <first> <last> [dpi] [max_px]}
FIRST=${2:?missing first page}
LAST=${3:?missing last page}
DPI=${4:-300}
MAXPX=${5:-1560}

: "${PDF:?set PDF=/abs/path/to/book.pdf (the source PDF is not in git)}"
[ -f "$PDF" ] || { echo "render-pages: PDF not found: $PDF" >&2; exit 1; }
command -v pdftoppm >/dev/null || { echo "render-pages: need poppler (brew install poppler)" >&2; exit 1; }
command -v sips >/dev/null || { echo "render-pages: need sips (macOS built-in)" >&2; exit 1; }

mkdir -p "$OUT"
echo "render-pages: $PDF pages $FIRST-$LAST @ ${DPI}dpi -> $OUT (jpeg long-edge <= ${MAXPX}px)"
pdftoppm -png -r "$DPI" -f "$FIRST" -l "$LAST" "$PDF" "$OUT/p"

shopt -s nullglob
for f in "$OUT"/p-*.png; do
  base=$(basename "$f" .png)
  sips -s format jpeg -Z "$MAXPX" "$f" --out "$OUT/$base.jpg" >/dev/null
done

n=$(ls "$OUT"/p-*.jpg 2>/dev/null | wc -l | tr -d ' ')
echo "render-pages: wrote $n jpeg(s) + png(s) to $OUT"
ls "$OUT"/p-*.jpg
