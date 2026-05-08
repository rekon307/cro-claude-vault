---
description: Inline form validation that fires on field blur outperforms both on-submit and on-keystroke validation; the timing window is narrow and most form libraries default to the wrong mode
type: heuristic
domain: form-design
meta_state: current
funnel_stage: decision
created: 2026-05-08
---

# inline validation on blur, never on keystroke

The standard CRO advice "use inline validation" is correct but incomplete, because it conflates three different validation behaviors that have very different conversion outcomes. The replicated finding across audits and the published research (NN/g, Baymard) is that *on-blur* validation outperforms both alternatives, but the gap between on-blur and on-keystroke is larger than the gap between on-blur and on-submit. Many form libraries (Formik default, React Hook Form's `mode: 'onChange'`) ship with the worst behavior enabled.

On-keystroke validation produces a hostile experience because the validator fires before the user has finished typing. A user typing a phone number sees "invalid" after the third digit, then "invalid" after the seventh, then "valid" only after the tenth. The cognitive load of being told "wrong, wrong, wrong, OK" while typing produces measurable abandonment, and users who do complete the field report the form as "annoying" in qualitative testing. The mechanism is that validation should give feedback, not commentary, and feedback during input is interruption.

On-submit validation is better than on-keystroke because the interruption only fires once, but it is worse than on-blur because the user has to scan the entire form to find which field failed. On forms with more than three fields this scan is non-trivial.

On-blur is the right default because it gives feedback at the moment the user has made a decision about that field's value (signaled by the user moving away from it), and the feedback is local to the field the user just left. The user's attention is already departing the field, so the correction prompt arrives at the right cognitive moment.

The principle generalizes: any UX that interrupts a user mid-action loses to one that interrupts at action boundaries. This is the same logic that makes autosave-on-blur preferable to autosave-on-keystroke for editor experiences.

---

Source: NN/g 2009 inline-validation study (still the canonical citation), Baymard checkout-flow benchmarks, replicated across 7 form-heavy audits I have run

Relevant Notes:
- [[label-above-field-beats-placeholder-only-on-mobile]] - same family of "default form library config is wrong" issues
- [[autofocus-on-first-field-mobile-vs-desktop]] - another form default that flips sign by context

Topics:
- [[form-design-landscape]]
