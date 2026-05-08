---
description: Unified task queue for pipeline work + condition-driven maintenance
type: queue
schema_version: 3
---

# Task Queue

The lifecycle backbone. Every note flows through a task state; condition-based maintenance writes here when thresholds fire.

## Pipeline Tasks

(Pending pipeline work goes here. `/extract`, `/connect`, `/verify`, `/update` write tasks. `/next` reads them.)

## Maintenance Tasks

(Auto-generated when condition thresholds fire. Auto-closed when the condition is no longer satisfied.)

## Schema

Each task entry follows:

```yaml
- id: short-slug
  kind: pipeline | maintenance
  title: One-line description
  target: relative/path/to/note.md
  status: pending | in_progress | done | skipped
  created: ISO timestamp
  blocked_by: [task-id, task-id]   # optional
  reason: why this task fired (esp. for maintenance)
```

## Empty State

This queue is empty in the demo vault. In an active engagement, expect 3-10 pipeline tasks pending after each Looker export, plus 0-3 maintenance tasks per week from condition-driven thresholds.
