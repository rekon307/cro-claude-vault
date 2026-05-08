---
description: Field count psychology, label-vs-placeholder patterns, validation timing, optional-field signaling, and the conversion cost of every additional input
type: moc
created: 2026-05-08
---

# form design landscape

The intuitive mental model is that fewer fields equal higher conversion, and almost every CRO blog repeats this as gospel. The data tells a more interesting story: it is not field count that drives drop-off, it is perceived effort, and the two are only loosely correlated. A form with four fields where two require recall (account number, customer ID) converts worse than a form with seven fields that all auto-fill from browser memory. This means the lever is not "remove fields" but "remove cognitive recall load", which is a different intervention with different design consequences.

The second-strongest pattern is that validation timing matters more than validation copy. Inline validation that fires on blur converts better than on-submit validation across every audit I have seen, but inline validation that fires on keystroke (validating before the user finishes typing) destroys conversion worse than on-submit validation does. The window is narrow and most form libraries default to the wrong behavior.

This landscape collects the field-level heuristics. Checkout-specific form mechanics live in [[checkout-friction-landscape]] because the context shifts the rules. Mobile-specific input mechanics (numeric keyboards, autofill triggers, input mode hints) live in [[mobile-ux-landscape]].

## Core Intelligence

- [[inline-validation-on-blur-not-on-keystroke]] - the timing window matters; on-blur outperforms both on-keystroke and on-submit, and most form libraries ship with the wrong default

## Cross-Domain Connections

- [[inline-validation-on-blur-not-on-keystroke]] -> [[shipping-cost-revealed-late-is-the-single-biggest-killer]] - [CROSS-DOMAIN: form-design -> checkout-friction] - perceived effort and surprise cost are the same psychological lever applied to different inputs; both obey expectation-anchoring

## Active Tensions

(None recorded yet in this demo. Active vaults typically carry 1-3 tensions per landscape: e.g. autofocus on first field helps desktop conversion but hurts mobile because of keyboard-pop layout shift.)

## Gaps

- No documented insight yet on multi-step form mechanics (the survey/onboarding-flow pattern), which is a different beast from transactional forms
- No data on accessibility-first label patterns and their conversion effect; ethical default but unmeasured impact
