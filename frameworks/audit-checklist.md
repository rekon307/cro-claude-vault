---
description: The minimum checklist every audit runs through, in order; populated during onboarding to match the consultant's actual practice
type: framework
domain: methodology
meta_state: placeholder
created: 2026-05-08
---

# Audit Checklist

This is a generic skeleton. Replace during onboarding with the consultant's actual checklist.

## 0. Pre-audit instrumentation check

- Verify GA4 events fire on every funnel step (open DebugView, click through a real checkout)
- Confirm `add_shipping_info` and `add_payment_info` exist and are not collapsed onto one page (see [[ga4-funnel-step-mismatch-between-uacs-event-naming]])
- Confirm device split data is queryable (some clients have GA4 setups that hide it)
- Verify session-replay tool is recording the funnel pages (Hotjar, Fullstory, Microsoft Clarity)

If instrumentation is broken, the audit pauses here. Findings built on broken funnel data are not deliverable.

## 1. Traffic shape

- Top-5 sources by sessions, conversion rate, and revenue
- Device split (mobile vs desktop vs tablet) per top source
- Geographic skew if relevant
- New vs returning split

## 2. Entry-page analysis

- Top-5 entry pages by sessions
- Bounce rate per entry page (with caveat: GA4 "engagement rate" is not bounce rate)
- Conversion rate by entry page
- Top exit pages and their position in the funnel

## 3. Funnel mechanics

- Cart -> checkout drop
- Checkout step-by-step drop (if instrumentation supports it)
- Payment selection -> purchase complete
- Mobile vs desktop funnel comparison (separate cut, not aggregated)

## 4. Page-level audit

- Run heuristic review against `intelligence/*-landscape.md` for the top-3 funnel-load-bearing pages
- Document specific issues with screenshots and DOM-level references where applicable
- Cross-reference each finding against a vault heuristic; flag any finding without a linked heuristic as either "missing heuristic" or "speculative"

## 5. Recommended tests

- One test per high-severity finding
- Each test has hypothesis, variant, primary metric, MDE, sample size, runtime
- Tests that share a variant are bundled (do not run conflicting tests in parallel)

## 6. Out of scope

- Anything dropped during triage, with a one-line reason
- This section is non-optional; it is the part clients re-read when they wonder why an obvious issue was not in the audit
