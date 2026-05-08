#!/bin/bash
# CRO vault - SessionEnd hook
# Archives ops/sessions/current.json, marks substantive sessions seed_candidate: true.

cd "${CLAUDE_PROJECT_DIR:-$(pwd)}" || exit 0

INPUT=$(cat)

if command -v jq &>/dev/null; then
  SESSION_ID=$(echo "$INPUT" | jq -r '.session_id // empty')
  TRANSCRIPT_PATH=$(echo "$INPUT" | jq -r '.transcript_path // empty')
  REASON=$(echo "$INPUT" | jq -r '.reason // empty')
else
  SESSION_ID=$(echo "$INPUT" | grep -o '"session_id":"[^"]*"' | head -1 | sed 's/"session_id":"//;s/"//')
  TRANSCRIPT_PATH=$(echo "$INPUT" | grep -o '"transcript_path":"[^"]*"' | head -1 | sed 's/"transcript_path":"//;s/"//')
fi

[ -f ops/sessions/current.json ] || exit 0

# Read started + id from current.json
if command -v jq &>/dev/null; then
  STARTED=$(jq -r '.started // empty' ops/sessions/current.json)
  CURRENT_ID=$(jq -r '.id // empty' ops/sessions/current.json)
else
  STARTED=$(grep -o '"started":"[^"]*"' ops/sessions/current.json | head -1 | sed 's/"started":"//;s/"//')
  CURRENT_ID=$(grep -o '"id":"[^"]*"' ops/sessions/current.json | head -1 | sed 's/"id":"//;s/"//')
fi

# If the IDs do not match, the SessionStart hook will handle it
[ "$CURRENT_ID" = "$SESSION_ID" ] || exit 0

# Mark substantive sessions as seed_candidate (transcript line count > 50 = substantive)
SEED_CANDIDATE=false
if [ -n "$TRANSCRIPT_PATH" ] && [ -f "$TRANSCRIPT_PATH" ]; then
  LINES=$(wc -l < "$TRANSCRIPT_PATH" 2>/dev/null || echo "0")
  if [ "$LINES" -gt 50 ]; then
    SEED_CANDIDATE=true
  fi
fi

if command -v jq &>/dev/null; then
  jq --arg ended "$(date -u --iso-8601=seconds)" \
     --argjson seed "$SEED_CANDIDATE" \
     --arg transcript "$TRANSCRIPT_PATH" \
     '. + {ended: $ended, status: "completed", seed_candidate: $seed, transcript_path: $transcript}' \
     ops/sessions/current.json > ops/sessions/current.json.tmp \
     && mv ops/sessions/current.json.tmp ops/sessions/current.json
fi

# Archive - rename current.json to {started}.json
if [ -n "$STARTED" ]; then
  ARCHIVE_NAME=$(echo "$STARTED" | tr ':' '-')
  mv ops/sessions/current.json "ops/sessions/${ARCHIVE_NAME}.json"
fi

exit 0
