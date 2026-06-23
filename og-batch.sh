#!/usr/bin/env bash
# og-batch.sh — run one of the og scripts over every image in a folder.
#
# Usage:
#   ./og-batch.sh [input_dir] [output_dir] [script]
#
# Defaults:
#   input_dir  = .
#   output_dir = ./og
#   script     = ./og-simple.sh   (swap to ./og-advanced.sh for the fancy one)

set -euo pipefail

INPUT_DIR="${1:-.}"
OUTPUT_DIR="${2:-./og}"
SCRIPT="${3:-./og-simple.sh}"

if [[ ! -x "$SCRIPT" ]]; then
  echo "Script not executable: $SCRIPT" >&2
  echo "Run: chmod +x $SCRIPT" >&2
  exit 1
fi

mkdir -p "$OUTPUT_DIR"

shopt -s nullglob nocaseglob
for img in "$INPUT_DIR"/*.{jpg,jpeg,png}; do
  filename="$(basename "$img")"
  output="$OUTPUT_DIR/${filename%.*}.jpg"
  echo "Processing: $filename → $output"
  "$SCRIPT" "$img" "$output"
done
shopt -u nullglob nocaseglob

echo "Done."
[[ "$OSTYPE" == darwin* ]] && open "$OUTPUT_DIR" || true
