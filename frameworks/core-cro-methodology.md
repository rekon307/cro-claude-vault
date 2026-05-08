---
description: The consultant's working CRO methodology, populated during onboarding from the consultant's own frameworks
type: framework
domain: methodology
meta_state: placeholder
created: 2026-05-08
---

# Core CRO Methodology

This file is the consultant's source of truth for how CRO audits are run. It is intentionally placeholder content in this demo vault. In a real engagement it gets populated during onboarding from the consultant's existing notes, slides, internal docs, or a structured extraction session.

The methodology answers four questions:

1. **What does an audit always cover?** The non-negotiable scope.
2. **What gets prioritized when scope must be cut?** The triage rules.
3. **How is severity assigned?** The labeling rubric.
4. **How is the deliverable structured?** The output shape.

Below is a generic skeleton. Replace each section during onboarding.

## What an audit always covers

- Funnel quality (instrumentation check before any analysis)
- Top-3 traffic sources and their device split
- Top-3 entry pages by sessions
- Cart-to-checkout conversion mechanics
- Mobile-specific issues (separate cut, not buried in desktop analysis)
- At least one test recommendation per high-severity finding

## Triage rules when scope must be cut

- Drop verticals/segments below N sessions/month from primary analysis (they go in "out of scope" with a note)
- Drop platform issues that require dev work outside the consultant's scope (they go in a separate "engineering recommendations" section)
- Keep findings that are testable within the client's existing test platform; flag findings that require new platform setup as a precondition

## Severity rubric

- **Critical** - revenue impact estimable at >5% of monthly revenue, or breaking a known compliance / accessibility line
- **Major** - revenue impact estimable at 1-5% of monthly revenue, or affecting a primary funnel step
- **Minor** - revenue impact <1% but worth fixing during a regular release cycle
- **Cosmetic** - no measurable revenue impact; flagged for completeness only

## Deliverable shape

See the audit-draft prompt template in `playbook/prompt-templates/cro-audit-draft.md` and the demo deliverable at `engagements/_example-client/deliverables/2026-05-08-audit-draft.md`.

---

Topics:
- [[methodology]]
