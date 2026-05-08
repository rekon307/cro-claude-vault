# Prompt Template: Landing Page Review

For when the engagement is a single landing page review, not a full funnel audit. Common for paid-traffic landing pages and high-intent campaign pages where the audit scope is narrower.

---

## Prompt

```
You are operating the CRO knowledge vault as defined in CLAUDE.md.

## Engagement

Client alias: {client_alias}
Vertical: {vertical}
Page URL: {url}
Primary CTA: {what action the page is supposed to drive}
Traffic source: {paid social / paid search / cold email / etc.}
Device split (last 30d): {mobile_pct} mobile / {desktop_pct} desktop / {tablet_pct} tablet

## Data inputs

- Conversion rate (last 30 days): {n}% on {sessions} sessions
- Bounce / single-engagement rate: {n}%
- Top exit element if available: {selector or copy-paste of element}
- Heatmap or session-replay summary if available: {paste or link}

## Task

Review the page against the relevant vault landscapes. Specifically check:

1. Above-the-fold value proposition (load `intelligence/landing-page-landscape.md` if present)
2. CTA placement against [[mobile-thumb-reach-and-tap-target-failure-rates]] for the mobile share
3. Form mechanics if present, against [[form-design-landscape]]
4. Trust signals against [[social-proof-landscape]] if relevant
5. Page weight and load mechanics against [[mobile-page-weight-conversion-elasticity]] for mobile-heavy traffic

For each finding:
- Observation
- Linked heuristic via [[wiki-link]]
- Recommended change (specific, not "improve the CTA")
- Confidence label
- If A/B testable, hypothesis and primary metric

## Output

A short review document, written to engagements/{client_alias}/deliverables/{date}-landing-page-review.md, structured as:

- Page summary (URL, primary CTA, traffic source, device split)
- Findings in priority order
- Quick wins (changes shippable without dev work)
- Test recommendations
- Out of scope
```

---

## Notes for the consultant

- This template is faster than the full audit-draft template because the scope is narrower.
- It is most useful when the client is paying for a one-off review, not a retainer.
- The "quick wins" section is the section the client typically actions first. Keep it specific.
