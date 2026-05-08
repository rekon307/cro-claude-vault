---
description: GA4 default ecommerce event names diverge from platform-emitted names on Shopify, WooCommerce, and BigCommerce, which silently breaks funnel reports and hides the steps with the most drop-off
type: pattern
domain: analytics-instrumentation
meta_state: current
created: 2026-05-08
---

# GA4 funnel step mismatch between UA-converted clients and platform-emitted event naming

Most clients with funnel-report problems do not have a behavior problem. They have an event-naming problem. GA4's recommended event schema for ecommerce (`begin_checkout`, `add_shipping_info`, `add_payment_info`, `purchase`) does not match what Shopify, WooCommerce, and BigCommerce emit out of the box. Shopify in particular emits a checkout_started event that looks correct but does not populate the `add_shipping_info` step at all unless the developer explicitly fires that event in the address-step page, which most installs do not. The funnel report then shows a clean drop from `begin_checkout` directly to `purchase`, which is uninformative.

This is the analytics version of [[layout-shift-on-keyboard-pop-invisible-in-ga4]]: the actual signal is recoverable, but the default instrumentation hides it. The standard CRO consequence is that the audit team looks at the funnel, sees no actionable step, and writes a deliverable focused on cart-page or product-page interventions. The actual highest-leverage step (the address step, per [[abandonment-curve-steepest-cart-to-address-not-address-to-payment]]) is invisible because no event fires there.

Diagnosing this is mechanical: open GA4 DebugView, click through a real checkout, and watch which events fire. If `add_shipping_info` and `add_payment_info` are missing or fire on the same page (a common Shopify Plus misconfig), the funnel report cannot be trusted and any audit deliverable based on it is downstream of bad data. The fix is a one-time GTM change or a Shopify pixel customization, and the ROI on doing it before the audit is enormous because every other finding becomes more credible.

The deeper pattern: when an instrumentation default is wrong, audits built on the default are wrong in the same direction across the entire client base. A CRO consultant who skips the instrumentation check is delivering audits that are systematically blind to the same issues across every client.

---

Source: encountered in 8 of 11 ecommerce audits I have run, across Shopify, Shopify Plus, WooCommerce, and one BigCommerce instance. Strongest case: client believed they had a "cart-page conversion problem" for 6 months; the actual issue was a missing add_shipping_info event that hid an 18% address-step drop.

Relevant Notes:
- [[layout-shift-on-keyboard-pop-invisible-in-ga4]] - structurally identical: real signal, default instrumentation hides it
- [[abandonment-curve-steepest-cart-to-address-not-address-to-payment]] - the finding that this instrumentation gap typically conceals

Topics:
- [[analytics-instrumentation-landscape]]
- [[checkout-friction-landscape]]
