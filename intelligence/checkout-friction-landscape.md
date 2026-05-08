---
description: Checkout abandonment causes, the order-of-fields problem, payment method coverage, trust signal placement, and the gap between desktop and mobile completion mechanics
type: moc
created: 2026-05-08
---

# checkout friction landscape

The dominant pattern in DTC checkout is that abandonment is not caused by any single field, button, or visual choice. It is caused by the *cumulative cognitive load* of presenting cost, shipping, account creation, and payment details before the user has psychologically committed to the purchase. Every checkout audit I have run shows the same shape: the curve is steepest between the cart view and the address step, not between address and payment as most people assume. This means the pre-checkout layer (cart, mini-cart, sticky bar) carries more conversion weight than the checkout flow itself, and most teams instrument and optimize the wrong half of the funnel.

This landscape covers what the data consistently shows about checkout drop-off, the heuristics that have replicated across engagements, the device-specific patterns that matter most, and the open tensions where best practices conflict. Mobile-specific mechanics are deep enough to warrant their own landscape ([[mobile-ux-landscape]]); this one focuses on cross-device principles. Form mechanics are deep enough to warrant their own landscape ([[form-design-landscape]]); this one only references the form heuristics most relevant to checkout context.

## Core Intelligence

- [[abandonment-curve-steepest-cart-to-address-not-address-to-payment]] - the most replicated finding across audits, and it changes where instrumentation effort should land
- [[guest-checkout-conversion-uplift-context-dependent]] - guest checkout helps in B2C DTC under $80 AOV, often hurts in subscription and high-AOV contexts where account-creation friction is offset by reorder mechanics
- [[trust-badge-placement-near-payment-not-header]] - badges high on the page are decorative, badges adjacent to the CC field are functional, and the eye-tracking literature supports this
- [[shipping-cost-revealed-late-is-the-single-biggest-killer]] - hiding shipping cost until step 3 destroys conversion more reliably than any other single anti-pattern
- [[shipping-as-surprise-cost-vs-anchored-expectation]] - the issue is not shipping cost itself but the gap between user expectation and revealed cost; anchoring on the cart page neutralizes most of the damage

## Cross-Domain Connections

- [[abandonment-curve-steepest-cart-to-address-not-address-to-payment]] -> [[mobile-thumb-reach-and-tap-target-failure-rates]] - [CROSS-DOMAIN: checkout-friction -> mobile-ux] - the cart-to-address drop is amplified on mobile by tap-target failures on the proceed button, compounding what is already the steepest segment
- [[trust-badge-placement-near-payment-not-header]] -> [[social-proof-recency-decay]] - [CROSS-DOMAIN: checkout-friction -> social-proof] - trust badges and social proof obey the same recency rule, which suggests a shared cognitive model
- [[shipping-cost-revealed-late-is-the-single-biggest-killer]] -> [[ga4-funnel-step-mismatch-between-uacs-event-naming]] - [CROSS-DOMAIN: checkout-friction -> analytics-instrumentation] - the shipping-step problem is often invisible in GA4 reports because the step is named differently across platforms, masking the drop in standard funnel views

## Active Tensions

- [[guest-checkout-conversion-uplift-context-dependent]] and [[email-capture-as-precondition-for-cart-recovery]] conflict because guest-checkout removes the email gate that powers abandoned-cart recovery, and the recovery delta can exceed the checkout-completion delta in retention-heavy verticals. The resolution is vertical-dependent and should never be applied as a default rule.

## Gaps

- No replicated data on whether one-page vs multi-step checkout is better in 2026 (the 2017-era Baymard finding may be stale; mobile patterns have shifted)
- No insight yet on Apple Pay / Shop Pay express path effects on attribution, which is increasingly a measurement gap rather than a UX gap
- Subscription-vertical checkout patterns are underrepresented in this landscape; need 2-3 more engagements to fill
