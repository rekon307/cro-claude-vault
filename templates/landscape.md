---
_schema:
  entity_type: "landscape"
  applies_to: "intelligence/*-landscape.md"
  required:
    - description
  optional:
    - type
    - created
  enums:
    type:
      - moc
  constraints:
    description:
      format: "One sentence synthesizing what this landscape covers and why it matters"

description: ""
type: moc
created: YYYY-MM-DD
---

# [landscape name]

[Opening synthesis paragraph: NOT "this landscape collects insights about X." Instead: "The core pattern in X is Y because Z. This matters because..." This IS thinking, not meta-description. Should read like the opening of a CRO audit section, not like a folder description.]

## Core Intelligence

- [[insight title]] - what it contributes to understanding this domain
- [[another insight]] - how it fits or challenges existing understanding

## Cross-Domain Connections

[Explicit cross-domain links discovered while working in this landscape:]
- [[insight]] -> [[cross-domain insight]] - [CROSS-DOMAIN: domain-A -> domain-B]

## Active Tensions

- [[insight A]] and [[insight B]] conflict because... [genuine unresolved conflict]

## Gaps

[What is missing from this landscape that we know we need? Open questions, missing data, hypotheses untested.]
