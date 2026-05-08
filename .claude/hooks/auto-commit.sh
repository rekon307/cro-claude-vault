#!/bin/bash
# CRO vault - auto-commit after every file modification
# PostToolUse hook on Write|Edit|MultiEdit|NotebookEdit. Async.
# Commits only the file the tool actually touched, not the entire dirty tree.
# Disable by removing this hook from .claude/settings.json.

set -e
cd "${CLAUDE_PROJECT_DIR:-$(pwd)}"

git rev-parse --is-inside-work-tree &>/dev/null || exit 0

INPUT=$(cat)

if command -v jq &>/dev/null; then
  FILE=$(echo "$INPUT" | jq -r '.tool_input.file_path // .tool_input.notebook_path // empty')
else
  FILE=$(echo "$INPUT" | grep -o '"file_path":"[^"]*"' | head -1 | sed 's/"file_path":"//;s/"//')
  [ -z "$FILE" ] && FILE=$(echo "$INPUT" | grep -o '"notebook_path":"[^"]*"' | head -1 | sed 's/"notebook_path":"//;s/"//')
fi

[ -z "$FILE" ] && exit 0
[ ! -f "$FILE" ] && exit 0

# Path inside repo
REPO_ROOT=$(git rev-parse --show-toplevel)
REL_PATH="${FILE#$REPO_ROOT/}"

# Only commit if the file is dirty
git diff --quiet --exit-code -- "$REL_PATH" 2>/dev/null && {
  git diff --cached --quiet --exit-code -- "$REL_PATH" 2>/dev/null && exit 0
}

git add -- "$REL_PATH" 2>/dev/null
git commit -q -m "auto: update ${REL_PATH}" -- "$REL_PATH" 2>/dev/null || true

exit 0
