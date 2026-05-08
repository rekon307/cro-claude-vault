---
_schema:
  entity_type: "audit-finding"
  applies_to: "engagements/*/findings/*.md"
  required:
    - description
    - severity
    - confidence
    - domain
  optional:
    - client
    - page_or_flow
    - device
    - traffic_source
    - data_source
    - sample_size
    - linked_heuristic
    - linked_pattern
    - recommended_test
    - status
    - created
    - modified
  enums:
    severity:
      - critical
      - major
      - minor
      - cosmetic
    confidence:
      - directly-measured
      - inferred-from-data
      - heuristic-only
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
    status:
      - draft
      - delivered
      - test-running
      - test-completed
      - dismissed-by-client
  constraints:
    description:
      format: "One sentence stating the issue, not the fix"
    sample_size:
      format: "n=NUMBER over DATE_RANGE, e.g. 'n=14,832 sessions, 2026-04-01 to 2026-04-30'"

description: ""
severity: ""
confidence: ""
domain: ""
client: ""
page_or_flow: ""
data_source: ""
sample_size: ""
status: draft
created: YYYY-MM-DD
---

# [page or flow] [issue summary]

## Observation

[What the data shows. Be specific. Numbers, segments, devices, traffic sources. Show the path from raw data to the conclusion. Reference the GA4/Looker query or screenshot. If heuristic-only, say so explicitly.]

## Why It Matters

[Connect the observation to revenue, conversion rate, or experience. Quantify if possible: "this segment is X% of sessions and converts at Y vs site average Z, so the gap represents ~$N/month in lost revenue at current AOV." Do not invent numbers.]

## Linked Heuristic / Framework

- [[heuristic-name]] - the CRO principle this finding violates
- [[pattern-name]] - the recurring pattern this fits

## Recommended Test

[A/B test hypothesis. Variant description. Primary metric. Secondary metrics. MDE. Minimum sample size. Expected runtime. Risk of false positive.]

## Notes for the Audit Draft

[How this finding should be framed in the deliverable. Tone, supporting visuals, level of technical detail for this client.]
