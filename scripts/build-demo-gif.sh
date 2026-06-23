#!/usr/bin/env bash
# build-demo-gif.sh — regenerate assets/examples/demo.gif from the example
# outputs. Run after changing og-simple.sh / og-advanced.sh and regenerating
# the example JPGs.
#
# Loop: original -> result, three times (simple-wide, advanced-wide,
# advanced-tall). Each frame is held for 2s.

set -euo pipefail

cd "$(dirname "$0")/.."

OUT="assets/examples/demo.gif"
FRAME_W=600
FRAME_H=315
DELAY=200          # hundredths of a second per frame (200 = 2s)
PAD_COLOR="#e6e9f0"

FRAMES=(
  assets/wide.jpg                       assets/examples/simple-wide.jpg
  assets/wide.jpg                       assets/examples/advanced-wide.jpg
  assets/tall.jpg                       assets/examples/advanced-tall.jpg
)

TMP=$(mktemp -d)
trap 'rm -rf "$TMP"' EXIT

i=0
for src in "${FRAMES[@]}"; do
  out="$TMP/$(printf '%02d' "$i")-$(basename "$src")"
  magick "$src" -auto-orient \
    -resize "${FRAME_W}x${FRAME_H}" \
    -background "$PAD_COLOR" -gravity center \
    -extent "${FRAME_W}x${FRAME_H}" \
    "$out"
  i=$((i+1))
done

magick -delay "$DELAY" -loop 0 "$TMP"/*.jpg -layers Optimize "$OUT"

echo "Wrote $OUT"
