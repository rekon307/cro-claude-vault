---
description: Time-bound commitments. Surfaced at session start by the orient hook. Overdue items appear first.
type: reminders
---

# Reminders

Commitments with explicit due dates. The session-orient hook reads this file and surfaces overdue items at the top of orientation. Format each reminder as:

```
- [ ] YYYY-MM-DD - reminder text - context (engagement, tension, follow-up)
```

When complete, change to `- [x]` and add `done: YYYY-MM-DD` at the end. Done items can be moved to the Archive section quarterly.

## Active

(Empty in the demo vault. Active vaults typically carry 3-8 reminders.)

## Archive

(Quarterly cleanup target. Move completed reminders here.)
