---
_schema:
  entity_type: "observation"
  applies_to: "ops/observations/*.md"
  required:
    - description
    - category
    - observed
    - status
  optional:
    - context
    - notes
    - resolution
    - resolved_at
  enums:
    category:
      - methodology
      - process
      - friction
      - surprise
      - quality
    status:
      - pending
      - promoted
      - implemented
      - archived
  constraints:
    description:
      format: "One sentence summarizing the friction signal"

description: ""
category: ""
observed: YYYY-MM-DD
status: pending
---

# [observation as a sentence]

## What Happened

[Describe the friction or surprise. Specific session, specific note, specific moment. Be concrete.]

## What It Suggests

[What rule, heuristic, or methodology change might address this if it recurs. Speculate honestly.]

## Action

[What to do next. Either: wait for it to recur (most observations), promote to a tension or insight, or escalate to /reassess immediately.]
