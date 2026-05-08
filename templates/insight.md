---
_schema:
  entity_type: "insight"
  applies_to: "intelligence/*.md"
  required:
    - description
    - type
    - domain
    - meta_state
    - created
  optional:
    - vertical
    - funnel_stage
    - device
    - traffic_source
    - client
    - confidence
    - rationale
    - status
    - superseded_by
    - outcome
  enums:
    type:
      - heuristic
      - insight
      - audit-finding
      - pattern
      - framework
      - test-result
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
    vertical:
      - ecommerce-dtc
      - saas-self-serve
      - saas-sales-led
      - lead-gen
      - marketplace
      - subscription
      - other
    funnel_stage:
      - awareness
      - consideration
      - decision
      - retention
    confidence:
      - directly-measured
      - inferred-from-data
      - heuristic-only
      - well-replicated
      - context-dependent
      - emerging
      - personal-experience-only
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

[Body: 150-400 words showing reasoning. Use connective words: because, but, therefore, which means, however. Show the path to the conclusion, not just the conclusion. Acknowledge uncertainty. Consider the strongest counterargument. Invoke other insights as prose, e.g. "this fits the broader pattern noted in [[mobile-checkout-abandonment-on-shipping-step]]".]

---

Source: [[source filename]] or "GA4 export 2026-04 client-x" or "direct observation"

Relevant Notes:
- [[related insight]] adds [what dimension this contributes]

Topics:
- [[relevant-landscape]]
