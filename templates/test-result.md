---
_schema:
  entity_type: "test-result"
  applies_to: "engagements/*/tests/*.md"
  required:
    - description
    - hypothesis
    - primary_metric
    - outcome
    - sample_size
    - runtime
    - created
  optional:
    - client
    - page_or_flow
    - mde
    - secondary_metrics
    - confidence_interval
    - p_value
    - linked_heuristic
    - linked_finding
    - notes
    - modified
  enums:
    outcome:
      - validated
      - invalidated
      - inconclusive
  constraints:
    description:
      format: "One sentence stating what the test was checking"
    hypothesis:
      format: "If we [change], then [primary metric] will [direction] because [user-behavior reason]"
    sample_size:
      format: "n=NUMBER per variant, total N over DATE_RANGE"
    runtime:
      format: "DURATION (start_date to end_date)"

description: ""
hypothesis: ""
primary_metric: ""
outcome: ""
sample_size: ""
runtime: ""
client: ""
page_or_flow: ""
created: YYYY-MM-DD
---

# [test name]

## Hypothesis

[If we change X, then primary metric Y will move in direction Z because user-behavior reason W.]

## Variants

- **Control:** [what was running before]
- **Variant A:** [what changed and why]
- **(Variant B if multivariate):** [...]

## Metrics

- **Primary:** [metric, baseline, MDE]
- **Secondary:** [list of metrics that matter directionally]
- **Guardrail:** [metric that would block shipping the variant if it moved badly]

## Sample size + runtime

[How many sessions per variant, over what date range. If pre-registered, link to the design doc. If not, note the post-hoc calculation.]

## Outcome

[Result with effect size, confidence interval, p-value if relevant. State the outcome label honestly: validated, invalidated, or inconclusive. Do not stretch a marginal result into "validated".]

## Linked Finding

- [[engagements/CLIENT/findings/finding-name]] - the finding this test was designed to address

## Linked Heuristic

- [[heuristic-name]] - if the test directly tested a heuristic, link it. The result either supports or weakens the heuristic and may trigger a `meta_state` update on the heuristic note.

## Notes

[Anything noteworthy: deployment quirks, segment differences, novel patterns observed during the test that did not fit the hypothesis.]

---

Topics:
- [[engagements/CLIENT/index]]
- [[relevant-landscape]]
