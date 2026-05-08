#!/bin/bash
# Detect orphan insights - files in intelligence/ with no incoming wiki links from any other file.
# Run: bash ops/scripts/graph/orphans.sh
# An orphan is a quality leak: a finding nobody can navigate to.

set -e
cd "$(dirname "$0")/../../.."

ORPHANS=0

for file in intelligence/*.md; do
  [ -f "$file" ] || continue
  base=$(basename "$file" .md)
  # Skip the index and landscapes (they are roots)
  case "$base" in
    index|*-landscape) continue ;;
  esac

  # Look for [[base]] anywhere in the vault outside the file itself
  if ! grep -rl --include="*.md" "\[\[${base}\]\]" . | grep -v "^\\./${file}$" | head -1 > /dev/null; then
    echo "ORPHAN  $file"
    ORPHANS=$((ORPHANS + 1))
  fi
done

if [ "$ORPHANS" -eq 0 ]; then
  echo "No orphan insights."
else
  echo ""
  echo "$ORPHANS orphan insight(s) found. Each orphan should be linked from at least one landscape and one related insight, or marked meta_state: stale."
fi
