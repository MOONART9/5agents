#!/usr/bin/env bash
# gpt-image-gen — calls OpenAI Images API (gpt-image-2) and saves PNG to disk.
# Usage: run.sh "<prompt>" "<output_path>" ["<size>"] ["<quality>"]
# Reads OPENAI_API_KEY from ./.env (current working directory).

set -euo pipefail

PROMPT="${1:?missing prompt}"
OUTPUT_PATH="${2:?missing output path}"
SIZE="${3:-1024x1024}"
QUALITY="${4:-medium}"

if [ -f .env ]; then
  set -a
  . <(grep -E '^OPENAI_API_KEY=' .env)
  set +a
fi

if [ -z "${OPENAI_API_KEY:-}" ]; then
  echo "ERROR: OPENAI_API_KEY missing or empty in .env" >&2
  exit 1
fi

mkdir -p "$(dirname "$OUTPUT_PATH")"

# Build payload — prefer python (always available with Claude Code's bundled env),
# fall back to jq if not.
if command -v python >/dev/null 2>&1; then
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
elif command -v jq >/dev/null 2>&1; then
  PAYLOAD=$(jq -n --arg p "$PROMPT" --arg s "$SIZE" --arg q "$QUALITY" '{
    model: "gpt-image-2",
    prompt: $p,
    size: $s,
    quality: $q,
    output_format: "png"
  }')
else
  echo "ERROR: neither python nor jq available to build JSON payload" >&2
  exit 4
fi

RESPONSE=$(curl -sS -X POST "https://api.openai.com/v1/images/generations" \
  -H "Authorization: Bearer $OPENAI_API_KEY" \
  -H "Content-Type: application/json" \
  -d "$PAYLOAD")

# Decode b64_json — prefer python, fall back to jq+base64
if command -v python >/dev/null 2>&1; then
  echo "$RESPONSE" | python -c "
import sys, json, base64
data = json.loads(sys.stdin.read())
if 'error' in data:
    sys.stderr.write('API ERROR: ' + json.dumps(data['error']) + '\n')
    sys.exit(3)
if 'data' not in data or not data['data']:
    sys.stderr.write('Unexpected response: ' + json.dumps(data)[:500] + '\n')
    sys.exit(3)
b64 = data['data'][0].get('b64_json')
if not b64:
    sys.stderr.write('No b64_json in response: ' + json.dumps(data)[:500] + '\n')
    sys.exit(3)
sys.stdout.buffer.write(base64.b64decode(b64))
" > "$OUTPUT_PATH"
else
  echo "$RESPONSE" | jq -r '.data[0].b64_json' | base64 --decode > "$OUTPUT_PATH"
fi

if [ ! -s "$OUTPUT_PATH" ]; then
  echo "ERROR: output file empty or missing: $OUTPUT_PATH" >&2
  echo "API response (first 500 chars):" >&2
  echo "${RESPONSE:0:500}" >&2
  exit 2
fi

BYTES=$(wc -c < "$OUTPUT_PATH")
echo "OK: $OUTPUT_PATH ($BYTES bytes)"
