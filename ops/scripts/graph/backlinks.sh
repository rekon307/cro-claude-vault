#!/bin/bash
# Show all incoming links to a given insight.
# Usage: bash ops/scripts/graph/backlinks.sh <insight-name-without-md>

set -e
cd "$(dirname "$0")/../../.."

TARGET="${1:-}"
if [ -z "$TARGET" ]; then
  echo "Usage: bash ops/scripts/graph/backlinks.sh <insight-name>"
  echo "Example: bash ops/scripts/graph/backlinks.sh shipping-cost-revealed-late-is-the-single-biggest-killer"
  exit 1
fi

# Strip .md if present
TARGET="${TARGET%.md}"

echo "Backlinks to [[${TARGET}]]:"
echo ""

COUNT=$(grep -rl --include="*.md" "\[\[${TARGET}\]\]" . 2>/dev/null | grep -v "^\\./intelligence/${TARGET}\\.md$" | wc -l)

grep -rl --include="*.md" "\[\[${TARGET}\]\]" . 2>/dev/null \
  | grep -v "^\\./intelligence/${TARGET}\\.md$" \
  | sort

echo ""
echo "$COUNT incoming link(s)."
