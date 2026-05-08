---
_schema:
  entity_type: "heuristic"
  applies_to: "frameworks/heuristics/*.md"
  required:
    - description
    - domain
    - confidence
  optional:
    - sources
    - counterexamples
    - related_principle
    - created
    - modified
  enums:
    domain:
      - checkout-friction
      - form-design
      - mobile-ux
      - traffic-quality
      - social-proof
      - pricing-display
      - landing-page
      - copy-and-messaging
      - analytics-instrumentation
    confidence:
      - well-replicated
      - context-dependent
      - emerging
      - personal-experience-only
  constraints:
    description:
      format: "One sentence stating the principle as a rule, not a description"

description: ""
domain: ""
confidence: ""
created: YYYY-MM-DD
---

# [heuristic name as imperative or declarative principle]

## Principle

[One paragraph stating the principle clearly. What to do, what to avoid, and the underlying user-behavior reason. Should be usable as a direct prompt to Claude when reviewing a client site.]

## When It Applies

[Conditions under which this heuristic is load-bearing. Funnel stage, device, traffic source, vertical. Be specific about scope.]

## When It Does Not Apply

[Counter-cases where this heuristic is wrong or weak. Honesty here is what makes the vault trustworthy. A heuristic with no documented limits is propaganda.]

## Evidence

[Studies, case-rate data, internal observations. Cite sources or note "personal experience only across N engagements". Do not bluff.]

## Related Principles

- [[other-heuristic]] - extends or constrains this
