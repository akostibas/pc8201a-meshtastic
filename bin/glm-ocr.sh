#!/usr/bin/env bash
#
# glm-ocr.sh — run the local glm-ocr vision model (via ollama) on a PNG.
#
# Uses ollama's native /api/generate with the image base64-encoded in the
# "images" array. num_ctx is bumped to 16384 because the default 4096 is too
# small to encode a page image and glm-ocr crashes cryptically otherwise.
#
# Usage: glm-ocr.sh <image.png> ["prompt"]
set -euo pipefail

img="${1:?usage: glm-ocr.sh <image.png> [prompt]}"
prompt="${2:-Transcribe this document image to Markdown. Preserve all numbers, addresses, and table/diagram structure exactly. Do not paraphrase.}"

b64=$(base64 -i "$img" | tr -d '\n')

payload=$(python3 -c '
import json,sys
print(json.dumps({
  "model":"glm-ocr:latest",
  "prompt":sys.argv[1],
  "images":[sys.argv[2]],
  "stream":False,
  "options":{"num_ctx":16384,"temperature":0}
}))
' "$prompt" "$b64")

curl -s http://localhost:11434/api/generate -d "$payload" \
  | python3 -c 'import json,sys; print(json.load(sys.stdin)["response"])'
