---
description: Deep guide to /architect, /reassess, /flag, /health
type: manual
---

# Meta-Skills

The meta-skills are how the system reasons about itself. They are not part of the audit-production pipeline; they are how the vault stays healthy and evolves.

## /architect

Reasons about configuration drift and proposes changes.

When invoked, `/architect`:

1. Reads `ops/derivation.md` (the WHY)
2. Reads `ops/config.yaml` (the live state)
3. Reads `ops/derivation-manifest.md` (the runtime vocabulary)
4. Diffs the three for inconsistency
5. Surfaces accumulated friction signals from `ops/observations/` that suggest a structural issue
6. Proposes specific config changes with rationale
7. Asks the consultant to approve or reject each

Use `/architect` when:

- The system feels off but you cannot articulate why
- A `/reassess` session surfaced more than 3 observations pointing at the same dimension
- You took on a new vertical or use case that the current config does not handle well
- It has been more than 3 months since the last `/architect` review

## /reassess

Reviews accumulated observations and tensions.

When invoked, `/reassess`:

1. Reads every pending entry in `ops/observations/` and `ops/tensions/`
2. Groups by category (methodology, process, friction, surprise, quality)
3. For each group, proposes resolution: promote to insight, dissolve, leave pending, escalate to `/architect`
4. Asks the consultant to approve or reject each
5. Updates the relevant `status:` fields and writes a methodology note if a structural learning emerged

`/reassess` fires automatically (as a recommendation, not an action) when pending observation count exceeds 10 or tension count exceeds 5.

Use `/reassess` manually when:

- A pattern keeps recurring during sessions
- You suspect the heuristic library has drift
- Quarterly review

## /flag

Captures friction or methodology learnings inline, mid-session.

When invoked with no arguments, `/flag` prompts for:

- Category (methodology / process / friction / surprise / quality)
- Description (one sentence)
- Optional context

The capture writes to `ops/observations/{slug}.md` using the observation template. It does not interrupt the work in progress; the captured observation surfaces during the next `/reassess`.

Use `/flag` when:

- The agent's response surprised you in a way that suggests the system needs to update
- A heuristic in the vault is contradicted by what just happened
- A pattern just recurred that should have been captured earlier
- Something in the workflow felt clunky and you want to remember why

`/flag` is the cheapest meta-skill. It is the right default when you notice something. The cost of capturing too many observations is small (review filters them); the cost of not capturing enough is real (the system stops learning).

## /health

Vault health report. Combines validate + graph + freshness in one output.

When invoked, `/health` reports:

- Schema violations (notes missing required frontmatter fields)
- Orphan notes (insights with no incoming `[[wiki-links]]`)
- Dangling links (`[[targets]]` that resolve to no file)
- Stale notes (`meta_state: current` notes older than threshold)
- Stale benchmarks (vertical-specific data older than 18 months)
- Pending observation / tension counts

Use `/health` when:

- Quarterly review
- Before a major refactor
- After a major data import where the agent processed >10 sources

`/health` is read-only. It does not modify the vault. Take its output and decide which issues warrant action.

## Relationship between meta-skills

```
session-level   →   /flag          (capture friction inline)
threshold-level →   /reassess      (process accumulated friction)
structural-level →  /architect     (propose config changes from patterns)
periodic-level   →   /health        (overall vault hygiene snapshot)
```

`/flag` produces inputs for `/reassess`. `/reassess` produces inputs for `/architect`. `/architect` produces config changes. The four-step loop is how the vault evolves without manual schema rewrites.
