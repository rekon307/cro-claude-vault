---
_schema:
  entity_type: "landscape"
  applies_to: "intelligence/*-landscape.md"
  required:
    - description
    - type
  optional:
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

[Opening synthesis paragraph: NOT "this landscape collects insights about X." Instead: "The core pattern in X is Y because Z. This matters because..." This IS thinking, not meta-description. It should read like the opening of a CRO audit section, not like a folder description.]

[Second paragraph if needed: scope and adjacencies. What this landscape covers and what it does not. What links to which other landscape.]

## Core Intelligence

- [[insight title]] - what it contributes to understanding this domain
- [[another insight]] - how it fits or challenges existing understanding

## Cross-Domain Connections

[Explicit cross-domain links discovered while working in this landscape:]
- [[insight]] -> [[cross-domain insight]] - [CROSS-DOMAIN: domain-A -> domain-B]

## Active Tensions

- [[insight A]] and [[insight B]] conflict because... [genuine unresolved conflict, with a brief note on what would resolve it]

## Gaps

[What is missing from this landscape that we know we need? Open questions, missing data, hypotheses untested. Honesty here is what makes the landscape trustworthy as a query surface.]
