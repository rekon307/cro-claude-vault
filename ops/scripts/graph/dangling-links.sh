#!/bin/bash
# Detect dangling wiki links - [[targets]] that resolve to no file.
# Run: bash ops/scripts/graph/dangling-links.sh

set -e
cd "$(dirname "$0")/../../.."

DANGLING=0

# Extract every [[target]] reference, skip path-style (containing /), URLs, and source-file refs.
grep -rho --include="*.md" '\[\[[^]]\+\]\]' . 2>/dev/null \
  | sed 's/^\[\[//; s/\]\]$//' \
  | grep -v '/' \
  | grep -v '\.md$' \
  | grep -v '\.csv$' \
  | grep -v '\.pdf$' \
  | grep -v '\.json$' \
  | sort -u \
  | while read -r target; do
      [ -z "$target" ] && continue
      # Check the target resolves somewhere
      if [ ! -f "intelligence/${target}.md" ] \
         && [ ! -f "ops/observations/${target}.md" ] \
         && [ ! -f "ops/tensions/${target}.md" ] \
         && [ ! -f "ops/methodology/${target}.md" ] \
         && [ ! -f "self/${target}.md" ] \
         && [ ! -f "frameworks/${target}.md" ]; then
        echo "DANGLING  [[${target}]]"
        DANGLING=$((DANGLING + 1))
      fi
    done

# Note: while loop above runs in subshell so DANGLING resets; this is intentional -
# the per-line "DANGLING" output IS the report. Total count below uses a separate count.

TOTAL=$(grep -rho --include="*.md" '\[\[[^]]\+\]\]' . 2>/dev/null \
  | sed 's/^\[\[//; s/\]\]$//' \
  | grep -v '/' \
  | grep -v '\.md$' \
  | sort -u \
  | while read -r target; do
      [ -z "$target" ] && continue
      if [ ! -f "intelligence/${target}.md" ] \
         && [ ! -f "ops/observations/${target}.md" ] \
         && [ ! -f "ops/tensions/${target}.md" ] \
         && [ ! -f "ops/methodology/${target}.md" ] \
         && [ ! -f "self/${target}.md" ] \
         && [ ! -f "frameworks/${target}.md" ]; then
        echo "x"
      fi
    done | wc -l)

echo ""
if [ "$TOTAL" -eq 0 ]; then
  echo "No dangling links."
else
  echo "$TOTAL dangling reference(s). Either create the target note or rewrite the link."
fi
