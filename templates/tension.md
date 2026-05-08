---
_schema:
  entity_type: "tension"
  applies_to: "ops/tensions/*.md"
  required:
    - description
    - involves
    - observed
    - status
  optional:
    - resolution
    - resolved_at
    - notes
  enums:
    status:
      - pending
      - resolved
      - dissolved
  constraints:
    description:
      format: "One sentence summarizing the contradiction"

description: ""
involves:
  - "[[insight-A]]"
  - "[[insight-B]]"
observed: YYYY-MM-DD
status: pending
---

# [tension as a sentence - describe the contradiction]

## What Conflicts

[State what each linked note claims and where they collide.]

## Why It Matters

[What decision is blocked by this tension. What would be different if we resolved one way vs the other.]

## What Would Resolve It

[Specific data that would adjudicate, or a structural reframe that would dissolve the tension. Not "more research" - be specific.]

## Resolution

(Filled in when status changes to resolved or dissolved.)
