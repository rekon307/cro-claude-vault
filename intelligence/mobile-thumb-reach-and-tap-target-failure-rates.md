---
description: The bottom-third of the mobile viewport is the thumb-reach zone where one-handed taps are reliable, and CTAs placed outside this zone produce measurably higher tap-failure rates
type: heuristic
domain: mobile-ux
meta_state: current
funnel_stage: decision
confidence: well-replicated
created: 2026-05-08
---

# mobile thumb-reach geometry and tap-target failure rates

The thumb-reach map (Steven Hoober's research, 2013, replicated by Luke Wroblewski) divides a phone-held-one-handed into three zones: easy reach, mid-stretch, and hard-stretch. The bottom-third is the easy zone for both right- and left-handed users. CTAs placed in this zone produce more reliable taps, and CTAs placed in the top-third (where most desktop-derived layouts put them, anchored to the header or hero) produce a long tail of failed taps that are recorded as engagement and then exit.

The intuition that "tap targets just need to be 44px square" is correct but not sufficient. A 44px button at the top of the viewport, requiring the user to reach with a partially-extended thumb on a 6-inch phone, has higher failure rates than a 36px button in the bottom-third. The dimension that drives accuracy is thumb-reach distance, not pixel size, once a basic minimum is met. Most published "tap target" guidance focuses on size and ignores position.

The intervention this enables is sticky-bottom CTA placement on mobile checkout and PDP pages. Done well, the sticky CTA stays in the easy-reach zone regardless of scroll position, and the rest of the page can use whatever layout makes sense. Done badly, the sticky CTA conflicts with the sticky nav, or covers content the user is trying to read, or crashes into the iOS home indicator.

A cross-cutting consequence: the CTA-at-bottom geometry is also why [[layout-shift-on-keyboard-pop-invisible-in-ga4]] is so destructive. The layout shift happens specifically in the zone where the sticky CTA was anchored, which is also the zone where the user's thumb was already moving. The two issues compound: the CTA was correctly placed for thumb reach, then moved at the moment of tap.

---

Source: Hoober 2013 (canonical), Wroblewski "Mobile First" 2011, internal observation across 6 mobile DTC audits

Relevant Notes:
- [[layout-shift-on-keyboard-pop-invisible-in-ga4]] - the dynamic version of this problem, where the geometry was correct but the layout reflowed
- [[abandonment-curve-steepest-cart-to-address-not-address-to-payment]] - the funnel layer this geometric issue concentrates in

Topics:
- [[mobile-ux-landscape]]
