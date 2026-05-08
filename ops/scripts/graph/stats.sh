#!/bin/bash
# Vault stats: counts by type, domain, meta_state.
# Run: bash ops/scripts/graph/stats.sh

set -e
cd "$(dirname "$0")/../../.."

echo "── Vault stats ──"
echo ""

TOTAL=$(find intelligence -maxdepth 1 -name "*.md" -type f | wc -l)
LANDSCAPES=$(find intelligence -maxdepth 1 -name "*-landscape.md" -type f | wc -l)
INSIGHTS=$((TOTAL - LANDSCAPES))

echo "Total notes in intelligence/:  $TOTAL"
echo "  Landscapes (MOCs):           $LANDSCAPES"
echo "  Insight notes:               $INSIGHTS"
echo ""

echo "── By type ──"
grep -h "^type:" intelligence/*.md 2>/dev/null \
  | sort | uniq -c | sort -rn | sed 's/^/  /'
echo ""

echo "── By domain ──"
grep -h "^domain:" intelligence/*.md 2>/dev/null \
  | sort | uniq -c | sort -rn | sed 's/^/  /'
echo ""

echo "── By meta_state ──"
grep -h "^meta_state:" intelligence/*.md 2>/dev/null \
  | sort | uniq -c | sort -rn | sed 's/^/  /'
echo ""

echo "── Engagements ──"
ENG=$(find engagements -mindepth 1 -maxdepth 1 -type d 2>/dev/null | wc -l)
echo "  Engagement folders:          $ENG"
echo ""

echo "── Pending operational items ──"
OBS=$(find ops/observations -name "*.md" -type f 2>/dev/null | grep -v "README.md" | wc -l)
TEN=$(find ops/tensions -name "*.md" -type f 2>/dev/null | grep -v "README.md" | wc -l)
echo "  Pending observations:        $OBS"
echo "  Pending tensions:            $TEN"
