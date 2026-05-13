#!/usr/bin/env bash
# gpt-image-gen — calls OpenAI Images API (gpt-image-2) and saves PNG to disk.
# Usage: run.sh "<prompt>" "<output_path>" ["<size>"] ["<quality>"]
# Reads OPENAI_API_KEY from ./.env (current working directory).
#
# Tool detection order (Windows-friendly): powershell.exe -> python -> jq.
# PowerShell is preferred on Windows because Python from MS Store is a stub.

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

# Convert bash-style path to Windows path for PowerShell when needed
abs_output() {
  if command -v cygpath >/dev/null 2>&1; then
    cygpath -w "$1"
  else
    echo "$1"
  fi
}

# --- PowerShell path (preferred on Windows) ---
run_powershell() {
  local win_output
  win_output=$(abs_output "$OUTPUT_PATH")
  OPENAI_API_KEY="$OPENAI_API_KEY" \
  PS_PROMPT="$PROMPT" \
  PS_SIZE="$SIZE" \
  PS_QUALITY="$QUALITY" \
  PS_OUTPUT="$win_output" \
  powershell.exe -NoProfile -ExecutionPolicy Bypass -Command '
    $ErrorActionPreference = "Stop"
    $body = @{
      model         = "gpt-image-2"
      prompt        = $env:PS_PROMPT
      size          = $env:PS_SIZE
      quality       = $env:PS_QUALITY
      output_format = "png"
    } | ConvertTo-Json -Compress
    $headers = @{
      "Authorization" = "Bearer $($env:OPENAI_API_KEY)"
      "Content-Type"  = "application/json"
    }
    try {
      $resp = Invoke-RestMethod -Method Post -Uri "https://api.openai.com/v1/images/generations" -Headers $headers -Body $body -TimeoutSec 120
    } catch {
      Write-Error ("API call failed: " + $_.Exception.Message + " | " + $_.ErrorDetails.Message)
      exit 3
    }
    if (-not $resp.data -or -not $resp.data[0].b64_json) {
      Write-Error ("Unexpected response: " + ($resp | ConvertTo-Json -Depth 5))
      exit 3
    }
    [IO.File]::WriteAllBytes($env:PS_OUTPUT, [Convert]::FromBase64String($resp.data[0].b64_json))
  '
}

# --- Python path ---
run_python() {
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
  curl -sS -X POST "https://api.openai.com/v1/images/generations" \
    -H "Authorization: Bearer $OPENAI_API_KEY" \
    -H "Content-Type: application/json" \
    -d "$PAYLOAD" | python -c "
import sys, json, base64
data = json.loads(sys.stdin.read())
if 'error' in data:
    sys.stderr.write('API ERROR: ' + json.dumps(data['error']) + '\n')
    sys.exit(3)
b64 = data['data'][0].get('b64_json')
if not b64:
    sys.stderr.write('No b64_json: ' + json.dumps(data)[:500] + '\n')
    sys.exit(3)
sys.stdout.buffer.write(base64.b64decode(b64))
" > "$OUTPUT_PATH"
}

# --- jq path ---
run_jq() {
  PAYLOAD=$(jq -n --arg p "$PROMPT" --arg s "$SIZE" --arg q "$QUALITY" '{
    model: "gpt-image-2", prompt: $p, size: $s, quality: $q, output_format: "png"
  }')
  curl -sS -X POST "https://api.openai.com/v1/images/generations" \
    -H "Authorization: Bearer $OPENAI_API_KEY" \
    -H "Content-Type: application/json" \
    -d "$PAYLOAD" | jq -r '.data[0].b64_json' | base64 --decode > "$OUTPUT_PATH"
}

# Detect a working tool. On Windows, MS Store python is a useless stub —
# test it with a real invocation before trusting `command -v`.
python_works() {
  command -v python >/dev/null 2>&1 || return 1
  python -c "print(1)" >/dev/null 2>&1
}

if command -v powershell.exe >/dev/null 2>&1; then
  run_powershell
elif python_works; then
  run_python
elif command -v jq >/dev/null 2>&1; then
  run_jq
else
  echo "ERROR: no usable tool found (need powershell.exe, working python, or jq)" >&2
  exit 4
fi

if [ ! -s "$OUTPUT_PATH" ]; then
  echo "ERROR: output file empty or missing: $OUTPUT_PATH" >&2
  exit 2
fi

BYTES=$(wc -c < "$OUTPUT_PATH")
echo "OK: $OUTPUT_PATH ($BYTES bytes)"
