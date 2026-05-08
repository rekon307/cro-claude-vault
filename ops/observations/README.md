# observations/

Atomic friction signals captured during operation. Each observation is a single-file note with frontmatter:

```yaml
---
description: One-line summary of the friction
category: methodology | process | friction | surprise | quality
observed: ISO timestamp
status: pending | promoted | implemented | archived
---
```

When pending observations exceed 10 (`thresholds.observation_review_threshold` in `ops/config.yaml`), `/reassess` surfaces them for review. Observations get promoted to insights, methodology updates, or archived.

This folder is empty in the demo vault. In an active vault expect 1-3 observations per session.
