---
description: Vault hub - entry point to the cross-engagement CRO intelligence graph
type: moc
---

# intelligence

This is the cross-engagement CRO knowledge graph. Heuristics, patterns observed across engagements, and the methodology layer all live here. Engagement-bound deliverables (audit drafts, findings, tests for a specific client) live under `engagements/{client_alias}/`.

The graph is queried four ways:

1. **By landscape** - open the relevant `*-landscape.md`, which is the synthesis-first MOC for that CRO domain
2. **By type** - `rg '^type: heuristic' intelligence/*.md` returns every heuristic; same for `pattern`, `audit-finding`, etc.
3. **By backlinks** - `bash ops/scripts/graph/backlinks.sh <insight-name>` shows every place a given insight is referenced
4. **By semantic search** - for vocabulary divergence ("checkout drop" vs "abandonment cliff" return the same notes)

## Landscapes (one per CRO domain)

- [[checkout-friction-landscape]] - abandonment, payment coverage, trust signal placement, the cart-to-address cliff
- [[form-design-landscape]] - field count vs effort, validation timing, label patterns, autofocus
- [[mobile-ux-landscape]] - thumb reach, tap targets, viewport-shift abandonment, sticky element conflicts
- (The remaining six landscapes - `traffic-quality-landscape`, `social-proof-landscape`, `pricing-display-landscape`, `landing-page-landscape`, `copy-and-messaging-landscape`, `analytics-instrumentation-landscape` - exist in the live vault but are not included in this demo to keep the snapshot small.)

## Engagement Layer

Live engagement work is under `engagements/{client_alias}/`. The demo carries a single placeholder at `engagements/_example-client/` showing the structure. In the live vault each engagement folder contains an `index.md`, a `data/` folder for raw exports, a `findings/` folder for audit findings, a `tests/` folder for test recommendations, and a `deliverables/` folder for the audit draft and any client-facing reports.

## How to Read

Open a landscape first, not an insight. The landscape's opening paragraph carries the synthesis; the insight notes carry the evidence. Reading insights without the landscape produces dots without the connecting lines.

## How to Add

When a new insight is captured (via `/extract` or by hand):

1. Use the `templates/insight.md` template
2. Set `domain` to one of the nine CRO domains
3. Set `meta_state: current` and `created: YYYY-MM-DD`
4. Add at least one `[[wiki-link]]` to a landscape and one to a related insight
5. Update the relevant landscape's "Core Intelligence" list

The write-validate hook checks frontmatter on save. The dangling-links script catches broken wiki links. Run `/validate` before any deliverable.
