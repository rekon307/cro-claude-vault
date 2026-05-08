---
_schema:
  entity_type: "insight"
  applies_to: "intelligence/*.md"
  required:
    - description
    - domain
  optional:
    - type
    - meta_state
    - created
    - modified
    - client
    - vertical
    - traffic_source
    - device
    - funnel_stage
    - alternatives
    - rationale
    - status
    - superseded_by
    - outcome
  enums:
    type:
      - insight
      - heuristic
      - audit-finding
      - pattern
      - experiment
      - tension
      - methodology
    domain:
      - checkout-friction
      - form-design
      - mobile-ux
      - traffic-quality
      - social-proof
      - pricing-display
      - landing-page
      - copy-and-messaging
      - analytics-instrumentation
    meta_state:
      - current
      - stale
      - closed
      - speculative
    funnel_stage:
      - awareness
      - consideration
      - decision
      - retention
    outcome:
      - validated
      - invalidated
      - inconclusive
  constraints:
    description:
      max_length: 200
      format: "One sentence adding context beyond the title, no trailing period"
    domain:
      format: "Must be one of the nine CRO domains"

description: ""
type: insight
domain: ""
meta_state: current
created: YYYY-MM-DD
---

# prose-as-title proposition about the CRO observation

[Body: 150-400 words showing reasoning. Use connective words: because, but, therefore, which means, however. Show the path to the conclusion, not just the conclusion. Acknowledge uncertainty. Consider strongest counterargument. Invoke other insights as prose, e.g. "this fits the broader pattern noted in [[mobile-checkout-abandonment-on-shipping-step]]".]

---

Source: [[source filename]] or "GA4 export 2026-04 client-x" or "direct observation"

Relevant Notes:
- [[related insight]] adds [what dimension this contributes]

Topics:
- [[relevant-landscape]]
