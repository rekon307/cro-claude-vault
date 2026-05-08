#!/bin/bash
# CRO vault - schema validation on intelligence/*.md and engagements/**/*.md writes
# PostToolUse hook on Write|Edit|MultiEdit. Receives tool input as JSON on stdin.
# Emits warning to stderr if frontmatter fields are missing or wiki links dangle.

cd "${CLAUDE_PROJECT_DIR:-$(pwd)}"

INPUT=$(cat)

if command -v jq &>/dev/null; then
  FILE=$(echo "$INPUT" | jq -r '.tool_input.file_path // empty')
else
  FILE=$(echo "$INPUT" | grep -o '"file_path":"[^"]*"' | head -1 | sed 's/"file_path":"//;s/"//')
fi

[ -z "$FILE" ] && exit 0
[ ! -f "$FILE" ] && exit 0

WARNS=""

# Validate intelligence/*.md (skip index and landscapes - they have a different schema)
case "$FILE" in
  */intelligence/index.md) exit 0 ;;
  */intelligence/*-landscape.md)
    HEAD=$(head -20 "$FILE")
    echo "$HEAD" | grep -q "^---$" || WARNS="${WARNS}no YAML frontmatter; "
    echo "$HEAD" | grep -q "^description:" || WARNS="${WARNS}missing description; "
    echo "$HEAD" | grep -q "^type: moc" || WARNS="${WARNS}missing type:moc; "
    ;;
  */intelligence/*.md)
    HEAD=$(head -25 "$FILE")
    echo "$HEAD" | grep -q "^---$" || WARNS="${WARNS}no YAML frontmatter; "
    echo "$HEAD" | grep -q "^description:" || WARNS="${WARNS}missing description; "
    echo "$HEAD" | grep -q "^type:" || WARNS="${WARNS}missing type; "
    echo "$HEAD" | grep -q "^domain:" || WARNS="${WARNS}missing domain; "
    echo "$HEAD" | grep -q "^meta_state:" || WARNS="${WARNS}missing meta_state; "
    echo "$HEAD" | grep -q "^created:" || WARNS="${WARNS}missing created; "
    ;;
  */engagements/*/findings/*.md)
    HEAD=$(head -25 "$FILE")
    echo "$HEAD" | grep -q "^---$" || WARNS="${WARNS}no YAML frontmatter; "
    echo "$HEAD" | grep -q "^description:" || WARNS="${WARNS}missing description; "
    echo "$HEAD" | grep -q "^severity:" || WARNS="${WARNS}missing severity; "
    echo "$HEAD" | grep -q "^confidence:" || WARNS="${WARNS}missing confidence; "
    echo "$HEAD" | grep -q "^domain:" || WARNS="${WARNS}missing domain; "
    echo "$HEAD" | grep -q "^status:" || WARNS="${WARNS}missing status; "
    ;;
  */engagements/*/index.md)
    HEAD=$(head -20 "$FILE")
    echo "$HEAD" | grep -q "^description:" || WARNS="${WARNS}missing description; "
    echo "$HEAD" | grep -q "^status:" || WARNS="${WARNS}missing status; "
    echo "$HEAD" | grep -q "^vertical:" || WARNS="${WARNS}missing vertical; "
    echo "$HEAD" | grep -q "^client_alias:" || WARNS="${WARNS}missing client_alias; "
    ;;
  *) exit 0 ;;
esac

# Dangling wiki-link check - extract [[targets]], skip path-style and file-extension refs
DANGLING=""
while IFS= read -r target; do
  [ -z "$target" ] && continue
  case "$target" in
    */*|*.md|*.csv|*.pdf|*.json|*.txt) continue ;;
  esac
  if [ ! -f "intelligence/${target}.md" ] \
     && [ ! -f "ops/observations/${target}.md" ] \
     && [ ! -f "ops/tensions/${target}.md" ] \
     && [ ! -f "ops/methodology/${target}.md" ] \
     && [ ! -f "self/${target}.md" ] \
     && [ ! -f "frameworks/${target}.md" ]; then
    DANGLING="${DANGLING}${target}; "
  fi
done < <(grep -ho '\[\[[^]]\+\]\]' "$FILE" 2>/dev/null | sed 's/^\[\[//; s/\]\]$//' | sort -u)

if [ -n "$DANGLING" ]; then
  WARNS="${WARNS}dangling wiki links: ${DANGLING}"
fi

if [ -n "$WARNS" ]; then
  echo "[write-validate] $FILE: $WARNS" >&2
fi

exit 0
