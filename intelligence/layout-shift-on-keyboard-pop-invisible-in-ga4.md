---
description: Mobile users tapping a field experience a viewport reflow when the keyboard opens, which moves the proceed button under the user's already-moving thumb and produces failed taps invisible in standard funnel reports
type: pattern
domain: mobile-ux
meta_state: current
funnel_stage: decision
confidence: directly-measured
created: 2026-05-08
---

# layout shift on mobile keyboard pop is the most consequential issue invisible in GA4

The single highest-leverage mobile checkout fix I have ever shipped did not come out of GA4 funnel analysis. It came out of session-replay review of failed mobile checkouts where users tapped what should have been the proceed button and instead landed on a different element because the page had reflowed when the keyboard opened. The user perceives this as the button "not working" and abandons. The funnel report shows engagement at the address step and no progression, which reads as "users typed in their address and then changed their mind", which is wrong.

The mechanism is straightforward and broken-by-default in most checkout templates. The address form has a proceed CTA below the last field. When the user focuses the last field, iOS Safari (and Android Chrome with most autofill flows) opens the keyboard, which compresses the visible viewport. Pages that anchor the CTA with vh units, sticky-bottom positioning, or absolute positioning relative to the form react in ways the designer never tested, because the designer was on desktop. The CTA either disappears under the keyboard, or jumps up by the keyboard height, arriving under the user's still-moving thumb a fraction of a second later.

The reason this is invisible in standard analytics is that the failed tap is recorded as a tap on whatever non-CTA element ended up under the thumb. That tap is a "click" event, which counts as engagement in most setups, and the subsequent abandonment is attributed to whatever the user did next, not to the failed CTA tap. Standard CRO practice will look at this funnel and conclude there is no issue at the address step, because the data shows engagement followed by exit, which reads as "user lost interest".

The fix is testable in any session-replay tool: filter for sessions on iOS Safari that abandoned at the address step, watch 10 of them, count keyboard-pop layout shifts. In every audit I have run on a mobile-first DTC site, this exercise has produced shippable interventions in under an hour. The reason it is not standard practice is that GA4 does not surface it, so it does not make the audit checklist.

---

Source: direct observation across 6 mobile-first DTC audits, plus Hotjar session recording reviews. Strongest case: 14% mobile completion rate uplift from a single CSS fix anchoring the CTA above the form rather than below.

Relevant Notes:
- [[mobile-thumb-reach-and-tap-target-failure-rates]] - the geometric layer this issue lives in
- [[ga4-funnel-step-mismatch-between-uacs-event-naming]] - related class of issue: signal exists but instrumentation hides it

Topics:
- [[mobile-ux-landscape]]
