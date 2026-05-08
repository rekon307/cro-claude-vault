# tensions/

Contradictions between heuristics, between heuristic and observed data, or between system assumptions and engagement reality. Each tension is a single-file note with frontmatter:

```yaml
---
description: One-line summary of the contradiction
involves:
  - "[[insight-A]]"
  - "[[insight-B]]"
observed: ISO timestamp
status: pending | resolved | dissolved
---
```

When pending tensions exceed 5 (`thresholds.tension_review_threshold`), `/reassess` surfaces them. Tensions resolve in three ways: one side wins (mark the loser `meta_state: stale`), both reframe (write a new insight that subsumes them), or the tension dissolves under more data.

This folder is empty in the demo vault.
