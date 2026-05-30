#!/usr/bin/env bash
#
# escape-metavars.sh — make `<metavariable>` syntax placeholders render safely.
#
# The manuals describe command syntax with angle-bracket metavariables
# (<expression>, <variable>, <line number>...). In PROSE, a single-word
# `<expression>` is parsed by Markdown/HTML renderers as an unknown tag and
# silently dropped. This wraps such placeholders in backticks so they survive
# and read as code. Lines inside fenced ``` code blocks are left untouched —
# angle brackets render literally there.
#
# Idempotent: a placeholder already inside backticks is skipped.
#
# Usage:
#   bin/escape-metavars.sh [--write] <file.md> [<file.md> ...]
# Default is a dry run (unified diff to stdout); pass --write to edit in place.
set -euo pipefail

WRITE=0
if [ "${1:-}" = "--write" ]; then WRITE=1; shift; fi
[ "$#" -ge 1 ] || { echo "usage: escape-metavars.sh [--write] <file.md>..." >&2; exit 1; }

tmp=$(mktemp)
trap 'rm -f "$tmp"' EXIT

for f in "$@"; do
  [ -f "$f" ] || { echo "escape-metavars: not a file: $f" >&2; continue; }
  awk '
    BEGIN { infence = 0 }
    {
      line = $0
      # toggle fenced-code state on lines starting with ``` (allow leading ws)
      if (line ~ /^[ \t]*```/) { infence = !infence; print line; next }
      if (infence) { print line; next }
      # In prose: wrap <word ...> placeholders in backticks, unless already
      # immediately wrapped by a backtick. Placeholder = starts with a letter,
      # then letters/digits/space/_$%#. (covers <line number>, <expression>).
      out = ""
      rest = line
      while (match(rest, /<[A-Za-z][A-Za-z0-9 _$%#.-]*>/)) {
        pre  = substr(rest, 1, RSTART - 1)
        tok  = substr(rest, RSTART, RLENGTH)
        post = substr(rest, RSTART + RLENGTH)
        # skip if already backticked on either side
        prevch = (length(pre) > 0) ? substr(pre, length(pre), 1) : ""
        nextch = (length(post) > 0) ? substr(post, 1, 1) : ""
        if (prevch == "`" || nextch == "`") {
          out = out pre tok
        } else {
          out = out pre "`" tok "`"
        }
        rest = post
      }
      out = out rest
      print out
    }
  ' "$f" > "$tmp"

  if [ "$WRITE" = 1 ]; then
    if ! cmp -s "$f" "$tmp"; then cp "$tmp" "$f"; echo "escaped: $f"; fi
  else
    diff -u "$f" "$tmp" || true
  fi
done
