---
description: How I process, connect, and maintain knowledge across CRO engagements
type: moc
---

# methodology

## Principles

- **Prose-as-title.** Every insight title is a proposition. Not "checkout abandonment" but "checkout abandonment is steepest from cart to address, not address to payment". The title carries the claim; the body carries the evidence.
- **Wiki-link backbone.** Connections between insights are explicit `[[wiki-links]]`. Cross-domain bridges are labeled `[CROSS-DOMAIN: domain-A -> domain-B]` so they surface during landscape review.
- **Landscape MOCs as attention managers.** When opening a landscape, I read the synthesis paragraph first; it tells me what the domain *means*, not what notes are in it. The note list is the evidence layer.
- **Capture fast, process slow.** Raw exports drop into `incoming/`. The pipeline (`/extract` → `/connect` → `/verify` → `/update`) processes them through the heuristic library, with citation discipline at each step.

## My Process

### Extract

Given a source (a CSV, a paste from GA4 Explorations, a screenshot, a framework doc), I read the source fully before extracting. I do not summarize before anchoring. For every extraction I emit:

- The date range, sample size, and segments before any conclusion
- The specific data slice the conclusion rests on
- The vault heuristic the conclusion fits, if any
- The confidence label

If the data does not support a finding I would have expected, I say so explicitly. Missing findings are sometimes more informative than present findings.

### Connect

For each new insight I write, I find:

- The landscape it belongs to (its `domains:` field)
- At least one related insight in the same landscape
- Any cross-domain bridges (a checkout finding may also be a mobile finding)

If an insight has no cross-references, that is a flag: either the landscape is missing a piece, or the insight is too generic to be useful, or it should be a heuristic candidate rather than an engagement finding.

### Update

When new data lands that affects an existing insight, I update the insight rather than creating a duplicate. If the insight is superseded, I mark the old one `meta_state: stale` and link forward via `superseded_by`. The forward link preserves history without polluting the live graph.

### Verify

Every deliverable runs through verification before it ships:

- Does every quantitative claim cite a data source?
- Does every qualitative claim cite a vault heuristic via wiki link?
- Is every `heuristic-only` claim explicitly labeled?
- Did the instrumentation check run before any funnel-based finding?

If any of these fail, the deliverable is not shippable. The verification step is non-negotiable; it is the discipline that makes the rest of the work credible.

### Reassess

When pending observations exceed 10 or pending tensions exceed 5, the threshold-driven review fires. I read accumulated friction signals, propose how to resolve them (promote an observation to a heuristic, mark a tension as dissolved, refactor a landscape), and the consultant approves or rejects each.

---

Topics:
- [[identity]]
