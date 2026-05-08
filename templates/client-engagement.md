---
_schema:
  entity_type: "client-engagement"
  applies_to: "engagements/*/index.md"
  required:
    - description
    - status
    - vertical
    - client_alias
    - created
  optional:
    - engagement_type
    - start_date
    - end_date
    - primary_goals
    - key_constraints
    - data_access
    - reporting_cadence
    - linked_landscapes
    - modified
  enums:
    status:
      - intake
      - audit-in-progress
      - test-in-flight
      - reporting
      - on-hold
      - closed
    engagement_type:
      - one-off-audit
      - retainer
      - test-program
      - advisory
    vertical:
      - ecommerce-dtc
      - saas-self-serve
      - saas-sales-led
      - lead-gen
      - marketplace
      - subscription
      - other
  constraints:
    description:
      format: "One sentence summarizing the engagement scope"

description: ""
status: intake
vertical: ""
client_alias: ""
engagement_type: ""
created: YYYY-MM-DD
---

# [client alias] [engagement type]

## Scope

[What's in scope, what's out. Funnels covered, devices covered, traffic sources analyzed.]

## Data Access

[GA4 property ID. Looker Studio dashboards available. Segment / Heap / Hotjar / Fullstory access. Date ranges. Known data quality issues.]

## Primary Goals

[The 1-3 outcomes the client is paying for. Phrased in their language, not as your deliverables.]

## Key Constraints

[Brand voice rules, legal constraints, dev resource limits, test platform, prior tests run. Anything that disqualifies a recommendation before it gets written.]

## Reporting Cadence

[Weekly status, monthly retro, ad-hoc, etc. Who's on the call, what they read first.]

## Linked Findings

- [[engagements/CLIENT/findings/finding-name]]

## Linked Tests

- [[engagements/CLIENT/tests/test-name]]

## Linked Deliverables

- [[engagements/CLIENT/deliverables/YYYY-MM-DD-audit-draft]]

---

Topics:
- [[engagements/CLIENT]]
