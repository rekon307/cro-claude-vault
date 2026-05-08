---
description: Thumb reach zones, tap-target failure rates, viewport-shift induced abandonment, sticky element conflicts, and why mobile is not a smaller desktop
type: moc
created: 2026-05-08
---

# mobile UX landscape

Mobile is not a smaller desktop. The most common audit failure I see is teams treating mobile as a responsive variant when it is a fundamentally different interaction model: thumb-based, single-handed, attention-fragmented, and sensitive to layout shift in ways desktop users never experience. The conversion gap between mobile and desktop on most DTC sites is not a "mobile is harder" problem, it is a "mobile is being designed by people on desktops" problem, and the gap closes dramatically when you instrument the right signals.

The single most underweighted mobile metric in standard CRO practice is layout shift on input focus. When a user taps a field and the keyboard pops, the page reflows, the proceed button moves, and a non-trivial percentage of users tap whatever ends up under their thumb (which is no longer the proceed button). This is invisible in funnel analytics but visible in session recordings, which is why mobile audits without recording data are blind on the most impactful issue.

This landscape carries the mobile-specific mechanics. Form behaviors that flip sign on mobile (autofocus, placeholder labels) appear in [[form-design-landscape]] but their mobile-specific reasoning sits here. Checkout flow patterns are in [[checkout-friction-landscape]].

## Core Intelligence

- [[mobile-thumb-reach-and-tap-target-failure-rates]] - the bottom-third zone (thumb-reach) is undermonetized on most sites; CTA placement and sticky-bar logic should follow this
- [[layout-shift-on-keyboard-pop-invisible-in-ga4]] - this is the single most consequential mobile issue I have ever quantified, and it does not show up in standard funnel reports because the failed tap is recorded as engagement, not abandonment
- [[sticky-add-to-cart-vs-sticky-nav-conflict]] - both belong on mobile, but they conflict for screen real estate; the resolution depends on funnel stage
- [[ios-safari-viewport-units-bug-affects-cta-positioning]] - vh units behave differently in Safari on iOS; CTAs anchored with vh end up partly hidden behind the address bar on a measurable fraction of sessions
- [[mobile-page-weight-conversion-elasticity]] - mobile conversion is more page-weight elastic than desktop in every audit I have run, and the most common offender is third-party tag bloat, not images

## Cross-Domain Connections

- [[layout-shift-on-keyboard-pop-invisible-in-ga4]] -> [[ga4-funnel-step-mismatch-between-uacs-event-naming]] - [CROSS-DOMAIN: mobile-ux -> analytics-instrumentation] - both are cases where the most consequential signal is invisible in default GA4 reports, which suggests the instrumentation defaults are leaking attention away from mobile-specific issues
- [[mobile-thumb-reach-and-tap-target-failure-rates]] -> [[abandonment-curve-steepest-cart-to-address-not-address-to-payment]] - [CROSS-DOMAIN: mobile-ux -> checkout-friction] - the cart-to-address drop is not equally distributed across devices; mobile carries the disproportionate share, and tap-target geometry is the most likely cause

## Active Tensions

- [[sticky-add-to-cart-vs-sticky-nav-conflict]] has no clean resolution. The data supports both depending on funnel stage. This is the kind of tension that should be tested per-engagement rather than answered with a global heuristic.

## Gaps

- No documented insight on PWA / installed-app conversion patterns vs mobile-web; the data is fragmented and most clients do not have a comparable surface
- Apple Pay / Google Pay express path effects on mobile flow truncation are observed but not yet structured into a heuristic
