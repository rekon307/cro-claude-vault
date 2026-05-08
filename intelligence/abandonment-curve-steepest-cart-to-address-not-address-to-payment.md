---
description: Across audits the largest drop in checkout funnel is between cart view and address entry, not between address and payment as folk wisdom suggests
type: pattern
domain: checkout-friction
meta_state: current
funnel_stage: decision
confidence: well-replicated
created: 2026-05-08
---

# checkout abandonment curve is steepest from cart to address, not from address to payment

The widely repeated claim that payment-step abandonment is where checkout dies is not supported by the data I have seen across audits. The largest single-step drop is consistently from the cart view (or mini-cart confirm) into the first address field, not from the completed address into the payment selector. This matters because it relocates the intervention site: optimizing the payment step is optimizing the wrong half of the funnel.

The mechanism is psychological commitment. The user lands on the cart with a soft intent to buy. The transition to address entry is the first moment that asks for concrete personal commitment, which is qualitatively different from "I'm thinking about this purchase". The address step demands attention, recall, and physical effort (typing on a phone keyboard for many users), and it is the first irreversible-feeling step. Payment, by contrast, is mechanically harder but psychologically easier because the user has already committed by entering shipping details.

This pattern reframes the high-leverage interventions. Cart-page changes (clearer total-cost preview, anchored shipping cost, better social proof, persistent "secure checkout" framing) compound across the entire downstream funnel because they reduce the cliff at the cart-to-address transition. Payment-page changes only affect users who have already crossed that cliff, which is a smaller and pre-selected sample.

The strongest counterargument is that this varies by industry. In subscription and high-AOV contexts the pattern weakens, and the address-to-payment cliff sometimes overtakes the cart-to-address one when account creation is forced before checkout. Where this counterargument applies, account creation, not address entry, is the actual commitment cliff and the heuristic still holds with the cliff relocated.

---

Source: pattern observed across 9 of 11 ecommerce audits I have run, anchored against Baymard Institute checkout-flow benchmarks (2023-2024 data)

Relevant Notes:
- [[shipping-cost-revealed-late-is-the-single-biggest-killer]] - explains why the cart-to-address step is so brittle: the surprise cost lands exactly here
- [[mobile-thumb-reach-and-tap-target-failure-rates]] - explains why the cliff is steeper on mobile: tap-target geometry concentrates failures at the proceed button

Topics:
- [[checkout-friction-landscape]]
