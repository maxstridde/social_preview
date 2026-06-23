# Color palette prompt

Paste the block below into ChatGPT, Claude, or any other LLM. Fill in the two
bracketed lines with your site's brand and vibe. You'll get back the exact
hex values to drop into the **CONFIG** block of `og-advanced.sh`.

---

```
I'm generating 1200x630 social preview images with the og-advanced.sh script
from https://github.com/maxstridde/social_preview. The layout has:

- a soft background gradient (BG_TOP -> BG_BOT)
- three decorative shapes behind a framed photo:
    S1 = rounded rectangle, top-left, slightly rotated
    S2 = rounded rectangle, bottom-right, slightly rotated
    S3 = small circle, top-right
- dark title text (TITLE_COL), muted subtitle (SUB_COL), and a dark pill
  button (BTN_COL with BTN_TEXT_COL text)

Brand / site:   [describe your site in one sentence — topic, audience, mood]
Vibe I want:    [e.g. "warm and editorial", "calm and minimal",
                 "playful and bright", "moody and high-contrast"]

Constraints:
- BG_TOP and BG_BOT must be very light (or very dark) so the dark title text
  stays readable.
- S1, S2, S3 must contrast clearly with the background but feel like one
  family — same saturation, same temperature.
- No neon. No pure #FFFFFF or #000000 for the background.
- The three accents should not all be the same hue; aim for two related hues
  plus one accent that pops.

Return only a bash snippet I can paste verbatim into og-advanced.sh, like:

BG_TOP='#......'
BG_BOT='#......'
S1='#......'
S2='#......'
S3='#......'
TITLE_COL='#......'
SUB_COL='#......'
BTN_COL='#......'
BTN_TEXT_COL='......'

Then in one short paragraph, explain the palette choice.
```
