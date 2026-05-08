# Prompt Template: Funnel Analysis

For when the consultant has a fresh GA4 funnel export and wants Claude to identify the load-bearing drop and recommend where to focus the audit. This is a triage prompt; it produces direction, not a deliverable. The output feeds the audit-draft prompt afterward.

---

## Prompt

```
You are operating the CRO knowledge vault as defined in CLAUDE.md.

## Engagement

Client alias: {client_alias}
Vertical: {vertical}
Date range: {start} to {end}

## Funnel data (paste from Looker / GA4)

Step 1 ({step_1_name}): {n_1} sessions
Step 2 ({step_2_name}): {n_2} sessions ({pct_1_to_2}% of step 1)
Step 3 ({step_3_name}): {n_3} sessions ({pct_2_to_3}% of step 2)
Step 4 ({step_4_name}): {n_4} sessions ({pct_3_to_4}% of step 3)
Step 5 ({step_5_name}): {n_5} sessions ({pct_4_to_5}% of step 4)

[If device split available, include it as separate columns]

## Task

1. Identify the steepest step-to-step drop. Cross-reference against [[abandonment-curve-steepest-cart-to-address-not-address-to-payment]] and the device split if available.
2. Flag any step where the drop looks anomalous (much larger than typical for this vertical, or much larger on one device than the other).
3. Check whether the funnel step naming suggests an instrumentation issue. Specifically: is `add_shipping_info` present and at the right point? Are any steps suspiciously named or missing? Cross-reference [[ga4-funnel-step-mismatch-between-uacs-event-naming]].
4. Recommend where the audit focus should land based on the drop pattern. Be specific: "the cart-to-address drop is the load-bearing one, and the mobile share is twice the desktop share, so the audit should prioritize mobile cart-page interventions" rather than "look at the cart".

## Output

A short triage note, written to engagements/{client_alias}/triage/{date}-funnel-triage.md:

- Funnel summary (date range, sample size, steps)
- Steepest drop: {step} -> {next_step}, {pct}%
- Probable cause hypotheses (each with linked heuristic)
- Instrumentation flags if any
- Recommended audit focus (the 1-2 areas to prioritize)
- Data the audit will need that is missing from this export

This is a triage note, not a deliverable. The consultant uses it to scope the audit, then runs the audit-draft prompt against the prioritized cuts.
```
