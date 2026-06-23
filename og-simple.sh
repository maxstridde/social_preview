#!/usr/bin/env bash
# og-simple.sh — minimal 1200x630 social preview.
# A single photo, cropped to fit, with a dark gradient at the bottom
# and two centered lines of text plus a small underline.
#
# Usage:  ./og-simple.sh input.jpg output.jpg
#
# Requires ImageMagick 7 (`magick`).

set -euo pipefail

# ------------------------------------------------------------------ config
TITLE="Blog by Your Name"
SUBTITLE="Read now"

# Font file. Common locations:
#   macOS user fonts:   ~/Library/Fonts/<file>.ttf
#   macOS system fonts: /System/Library/Fonts/Supplemental/<file>.ttf
#   Linux:              /usr/share/fonts/.../<file>.ttf
FONT="${HOME}/Library/Fonts/EBGaramond-ExtraBold.ttf"

TEXT_COLOR="white"
GRADIENT_OPACITY=0.7   # 0 = invisible, 1 = solid black bottom half

# Output canvas — 1200x630 is the standard Open Graph size.
W=1200
H=630
# ------------------------------------------------------------------------

INPUT="${1:-input.jpg}"
OUTPUT="${2:-output.jpg}"

if [[ ! -f "$INPUT" ]]; then
  echo "Input not found: $INPUT" >&2
  exit 1
fi
if [[ ! -f "$FONT" ]]; then
  echo "Font not found: $FONT" >&2
  echo "Edit FONT at the top of this script to point at a .ttf you have installed." >&2
  exit 1
fi

magick "$INPUT" \
  -auto-orient \
  -resize "${W}x${H}^" \
  -gravity center \
  -extent ${W}x${H} \
  \( -size ${W}x${H} xc:none \
     \( -size ${W}x$((H/2)) gradient:none-black \
        -channel A -evaluate pow 0.7 -evaluate multiply ${GRADIENT_OPACITY} +channel \) \
     -gravity south -composite \) \
  -compose over -composite \
  -font "$FONT" \
  -fill "$TEXT_COLOR" \
  -gravity center \
  -pointsize 64 \
  -annotate +0+135 "$TITLE" \
  -annotate +0+235 "$SUBTITLE" \
  -gravity none \
  -stroke "$TEXT_COLOR" \
  -strokewidth 4 \
  -draw "stroke-linecap round line $((W/2-140)),$((H-126)) $((W/2+140)),$((H-126))" \
  -stroke none \
  "$OUTPUT"

echo "Wrote $OUTPUT"
