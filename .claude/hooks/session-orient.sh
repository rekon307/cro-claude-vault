#!/bin/bash
# CRO vault - session orientation hook
# Reads stdin (Claude Code session_id JSON), tracks the session in ops/sessions/current.json,
# emits orientation context that the agent reads at session start.

set -e
cd "${CLAUDE_PROJECT_DIR:-$(pwd)}"

INPUT=$(cat)
SESSION_ID=""
if command -v jq &>/dev/null; then
  SESSION_ID=$(echo "$INPUT" | jq -r '.session_id // empty')
else
  SESSION_ID=$(echo "$INPUT" | grep -o '"session_id":"[^"]*"' | head -1 | sed 's/"session_id":"//;s/"//')
fi

if [ -n "$SESSION_ID" ]; then
  TIMESTAMP=$(date -u +"%Y%m%d-%H%M%S")
  mkdir -p ops/sessions

  # Crash recovery: if a previous session's current.json has a different ID, mark crashed and archive
  if [ -f ops/sessions/current.json ] && command -v jq &>/dev/null; then
    PREV_ID=$(jq -r '.id // empty' ops/sessions/current.json)
    PREV_STARTED=$(jq -r '.started // empty' ops/sessions/current.json)
    PREV_STATUS=$(jq -r '.status // empty' ops/sessions/current.json)
    if [ -n "$PREV_ID" ] && [ "$PREV_ID" != "$SESSION_ID" ]; then
      if [ "$PREV_STATUS" = "active" ]; then
        jq --arg s "crashed" --arg e "unknown" '. + {status: $s, ended: $e}' ops/sessions/current.json > ops/sessions/current.json.tmp \
          && mv ops/sessions/current.json.tmp ops/sessions/current.json
      fi
      mv ops/sessions/current.json "ops/sessions/${PREV_STARTED:-$TIMESTAMP}.json"
    fi
  fi

  # Write current.json for this session
  if command -v jq &>/dev/null; then
    jq -n --arg id "$SESSION_ID" --arg started "$(date -u --iso-8601=seconds)" \
      '{id: $id, started: $started, status: "active"}' > ops/sessions/current.json
  else
    cat > ops/sessions/current.json <<EOF
{"id":"${SESSION_ID}","started":"$(date -u --iso-8601=seconds)","status":"active"}
EOF
  fi
fi

# Emit orientation context as additionalContext so the agent reads it before its first turn
{
  echo "## Vault orientation"
  echo ""

  # Reminders (overdue first)
  if [ -f ops/reminders.md ]; then
    OVERDUE=$(grep -E '^- \[ \] [0-9]{4}-[0-9]{2}-[0-9]{2}' ops/reminders.md 2>/dev/null | awk -v today="$(date +%Y-%m-%d)" '$3 < today' | head -5)
    if [ -n "$OVERDUE" ]; then
      echo "### Overdue reminders"
      echo "$OVERDUE"
      echo ""
    fi
  fi

  # Threshold warnings
  OBS_COUNT=$(find ops/observations -name "*.md" -type f 2>/dev/null | grep -v "README.md" | wc -l)
  TEN_COUNT=$(find ops/tensions -name "*.md" -type f 2>/dev/null | grep -v "README.md" | wc -l)
  if [ "$OBS_COUNT" -ge 10 ]; then
    echo "WARNING: $OBS_COUNT pending observations. Consider running /reassess."
    echo ""
  fi
  if [ "$TEN_COUNT" -ge 5 ]; then
    echo "WARNING: $TEN_COUNT pending tensions. Consider running /reassess."
    echo ""
  fi

  # Incoming overflow check
  if [ -d incoming ]; then
    INCOMING=$(find incoming -name "*.md" -type f -mtime +7 2>/dev/null | wc -l)
    if [ "$INCOMING" -gt 0 ]; then
      echo "WARNING: $INCOMING file(s) in incoming/ unprocessed for >7 days. Consider running /pipeline."
      echo ""
    fi
  fi

  # Pending tasks
  if [ -f ops/queue/tasks.md ]; then
    PENDING=$(grep -c "^  status: pending" ops/queue/tasks.md 2>/dev/null || echo "0")
    echo "Pending tasks: $PENDING"
  fi

  echo ""
  echo "Read self/identity.md, self/methodology.md, self/goals.md, ops/reminders.md before responding."
} >&2

exit 0
