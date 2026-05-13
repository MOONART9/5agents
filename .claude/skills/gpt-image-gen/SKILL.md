---
name: gpt-image-gen
description: Wrapper for OpenAI Images API. Sends a prompt to gpt-image-2 and saves the resulting PNG to disk. Use whenever an agent needs to generate an image programmatically (typically invoked by Yuval, the image-design agent). Reads OPENAI_API_KEY from .env.
---

# gpt-image-gen — OpenAI Images API Wrapper

מעטפת ל-`POST /v1/images/generations` של OpenAI. שולחת prompt, מקבלת תמונה ב-base64, מפענחת לקובץ PNG. **המודל המשמש: `gpt-image-2`** (יצא 21 באפריל 2026 — לא להחליף לאף מודל אחר, גם אם הזיכרון הפנימי לא מכיר אותו).

## חובה

- `OPENAI_API_KEY` ב-`.env` של הפרויקט.
- `curl` זמין (קיים בכל Git Bash / WSL / Linux / Mac).
- מפענח base64 — `jq + base64` (Linux/Mac) **או** Python 3 (fallback ל-Windows / Git Bash).

## Workflow

1. **קלוט את הפרמטרים** מהקורא: `prompt` (חובה), `output_path` (חובה), אופציונלי `size` (default `1024x1024`), אופציונלי `quality` (default `medium`).
2. **טעון את `OPENAI_API_KEY`** מ-`.env`. אם חסר/ריק — עצור עם הודעת שגיאה ברורה.
3. **בצע את הקריאה** (ראה תבניות למטה).
4. **אמת**: קובץ קיים, גודל > 0 בתים.
5. **דווח**: path הקובץ + גודל.

## תבנית A — Linux / Mac / WSL (`jq` זמין)

```bash
#!/usr/bin/env bash
set -euo pipefail

PROMPT="$1"
OUTPUT_PATH="$2"
SIZE="${3:-1024x1024}"
QUALITY="${4:-medium}"

# Load OPENAI_API_KEY from .env
if [ -f .env ]; then
  export $(grep -E '^OPENAI_API_KEY=' .env | xargs)
fi

if [ -z "${OPENAI_API_KEY:-}" ]; then
  echo "ERROR: OPENAI_API_KEY missing or empty in .env" >&2
  exit 1
fi

mkdir -p "$(dirname "$OUTPUT_PATH")"

curl -sS -X POST "https://api.openai.com/v1/images/generations" \
  -H "Authorization: Bearer $OPENAI_API_KEY" \
  -H "Content-Type: application/json" \
  -d "$(jq -n --arg p "$PROMPT" --arg s "$SIZE" --arg q "$QUALITY" '{
    model: "gpt-image-2",
    prompt: $p,
    size: $s,
    quality: $q,
    output_format: "png"
  }')" \
  | jq -r '.data[0].b64_json' \
  | base64 --decode > "$OUTPUT_PATH"

if [ ! -s "$OUTPUT_PATH" ]; then
  echo "ERROR: output file empty or missing: $OUTPUT_PATH" >&2
  exit 2
fi

echo "OK: $OUTPUT_PATH ($(wc -c < "$OUTPUT_PATH") bytes)"
```

## תבנית B — Python fallback (Windows / Git Bash ללא `jq`)

```bash
#!/usr/bin/env bash
set -euo pipefail

PROMPT="$1"
OUTPUT_PATH="$2"
SIZE="${3:-1024x1024}"
QUALITY="${4:-medium}"

if [ -f .env ]; then
  export $(grep -E '^OPENAI_API_KEY=' .env | xargs)
fi

if [ -z "${OPENAI_API_KEY:-}" ]; then
  echo "ERROR: OPENAI_API_KEY missing or empty in .env" >&2
  exit 1
fi

mkdir -p "$(dirname "$OUTPUT_PATH")"

# Build payload via python (no jq dependency)
PAYLOAD=$(python -c "
import json, sys
print(json.dumps({
    'model': 'gpt-image-2',
    'prompt': sys.argv[1],
    'size': sys.argv[2],
    'quality': sys.argv[3],
    'output_format': 'png',
}))
" "$PROMPT" "$SIZE" "$QUALITY")

# Call API and pipe response into python for decode
curl -sS -X POST "https://api.openai.com/v1/images/generations" \
  -H "Authorization: Bearer $OPENAI_API_KEY" \
  -H "Content-Type: application/json" \
  -d "$PAYLOAD" \
  | python -c "
import sys, json, base64
data = json.loads(sys.stdin.read())
if 'error' in data:
    sys.stderr.write('API ERROR: ' + json.dumps(data['error']) + '\n')
    sys.exit(3)
b64 = data['data'][0]['b64_json']
sys.stdout.buffer.write(base64.b64decode(b64))
" > "$OUTPUT_PATH"

if [ ! -s "$OUTPUT_PATH" ]; then
  echo "ERROR: output file empty or missing: $OUTPUT_PATH" >&2
  exit 2
fi

echo "OK: $OUTPUT_PATH ($(wc -c < "$OUTPUT_PATH") bytes)"
```

## פרמטרים נתמכים (OpenAI Images API)

| פרמטר | ערכים מומלצים | ברירת מחדל |
|---|---|---|
| `model` | `gpt-image-2` (חובה — אל תחליף) | — |
| `prompt` | מחרוזת באנגלית/עברית | חובה |
| `size` | `1024x1024`, `1024x1536` (פורטרט), `1536x1024` (לנדסקייפ) | `1024x1024` |
| `quality` | `low`, `medium`, `high` | `medium` |
| `output_format` | `png`, `webp` | `png` |

## טיפול בשגיאות

- **HTTP 401** → `OPENAI_API_KEY` שגוי/פג. בדקי את `.env`.
- **HTTP 429** → rate limit. המתיני 30 שניות ונסי שוב.
- **HTTP 400 עם הודעה על model** → ⚠️ **לא** להחליף את שם המודל. `gpt-image-2` הוא המודל הנכון (יצא 21.04.2026). בדקי את שאר הפרמטרים (`size`, `quality`) — סביר ש-typo שם.
- **`.data[0].b64_json` חסר** → תגובה מעוותת או חסומה ע"י content policy. הדפיסי את התגובה המלאה לדיבאג.

## דוגמת קריאה מהסוכן (yuval)

```bash
bash .claude/skills/gpt-image-gen/run.sh \
  "Minimalist illustration of a CRM dashboard, flat design, copper accents on cream background, RTL layout" \
  "yuval/outputs/2026-05-13-crm-dashboard.png" \
  "1536x1024" \
  "high"
```
