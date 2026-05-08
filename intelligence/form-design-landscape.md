---
description: Field count psychology, label-vs-placeholder patterns, validation timing, optional-field signaling, and the conversion cost of every additional input
type: moc
created: 2026-05-08
---

# form design landscape

The intuitive mental model of forms is that fewer fields equal higher conversion, and almost every CRO blog repeats this as gospel. The data tells a more interesting story: it is not field *count* that drives drop-off, it is *perceived effort*, and the two are only loosely correlated. A form with four fields where two require recall (account number, customer ID) converts worse than a form with seven fields that all auto-fill from browser memory. This means the lever is not "remove fields" but "remove cognitive recall load", which is a different intervention with different design consequences.

The second-strongest pattern is that validation timing matters more than validation copy. Inline validation that fires on blur converts better than on-submit validation across every audit I have seen, but inline validation that fires on keystroke (validating before the user finishes typing) destroys conversion worse than on-submit validation does. The window is narrow and most form libraries default to the wrong behavior.

This landscape collects the field-level heuristics. Checkout-specific form mechanics live in [[checkout-friction-landscape]] because the context shifts the rules. Mobile-specific input mechanics (numeric keyboards, autofill triggers, input mode hints) live in [[mobile-ux-landscape]].

## Core Intelligence

- [[field-count-vs-perceived-effort-divergence]] - the metric that actually moves conversion is not how many fields, but how many require recall vs recognition vs autofill
- [[label-above-field-beats-placeholder-only-on-mobile]] - placeholder-only labels are the most replicated mobile anti-pattern in the literature, and the Material Design floating-label pattern is a defensible compromise
- [[inline-validation-on-blur-not-on-keystroke]] - the validation window matters; on-blur outperforms both on-keystroke and on-submit
- [[optional-field-signaling-required-asterisk-vs-optional-tag]] - marking optional fields with "(optional)" outperforms marking required fields with asterisks in every audit I have run, because users default to assuming everything is required
- [[autofocus-on-first-field-mobile-vs-desktop]] - autofocus on first field helps desktop conversion, hurts mobile because of keyboard-pop layout shift; the default is wrong on at least half the sites I audit

## Cross-Domain Connections

- [[label-above-field-beats-placeholder-only-on-mobile]] -> [[mobile-thumb-reach-and-tap-target-failure-rates]] - [CROSS-DOMAIN: form-design -> mobile-ux] - placeholder-only labels lose context the moment the user taps the field, and on mobile this happens before the user can read the label, compounding tap-target context loss
- [[field-count-vs-perceived-effort-divergence]] -> [[shipping-cost-revealed-late-is-the-single-biggest-killer]] - [CROSS-DOMAIN: form-design -> checkout-friction] - perceived effort and surprise cost are the same psychological lever applied to different inputs; both obey expectation-anchoring

## Active Tensions

- [[autofocus-on-first-field-mobile-vs-desktop]] reveals that the same UX pattern flips sign across devices; this is the strongest evidence I have that "best practice" lists without device qualifiers are unreliable

## Gaps

- No documented insight yet on multi-step form mechanics (the survey/onboarding-flow pattern), which is a different beast from transactional forms
- No data on accessibility-first label patterns and their conversion effect; ethical default but unmeasured impact
