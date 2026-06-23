# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this project is

Three bash scripts that generate **1200×630 Open Graph / social preview images** using ImageMagick 7:

- `og-simple.sh` — photo + dark gradient + two text lines
- `og-advanced.sh` — photo in a framed card with shadow, accent shapes, title, and a pill button; auto-adapts to portrait vs landscape input
- `og-batch.sh` — runs either script over a whole folder of images

`PROMPT.md` is a ready-made LLM prompt for generating a matching color palette to paste into `og-advanced.sh`.

## Running the scripts

```bash
chmod +x og-simple.sh og-advanced.sh og-batch.sh

./og-simple.sh  assets/wide.jpg out.jpg
./og-advanced.sh assets/wide.jpg out.jpg
./og-batch.sh ~/photos ~/photos/og ./og-advanced.sh
```

**Prerequisite:** ImageMagick 7 (`magick` command). Fonts default to `~/Library/Fonts/` (macOS); edit the `FONT*` variables at the top of each script to point at any local `.ttf`.

## Script architecture

Each script has a **CONFIG block** at the top (all caps variables) — that's the only place users normally need to edit. Everything below that block is the ImageMagick pipeline.

`og-advanced.sh` is the complex one:
1. Normalizes EXIF orientation and reads input dimensions to pick a landscape (540×384) or portrait (384×520) photo box
2. Builds intermediate PNGs in a `mktemp` directory (cleaned up on exit): rounded-corner photo, white frame, blurred shadow, accent shapes, pill button, background gradient, top accent line
3. Composites all layers in a single final `magick` call
4. All shape/text offsets are derived from `BX`/`BY` (photo box origin) so they track both orientations automatically

`og-batch.sh` globs `*.jpg`, `*.jpeg`, `*.png` (case-insensitive) and delegates to whichever script is passed as `$3`.

## Gitignore notes

`og/`, `output.jpg`, and `out.jpg` are excluded (batch output and quick test outputs). `.DS_Store` is excluded. `.claude/` is also excluded.
