---
description: Complete reference for every available command
type: manual
---

# Skills

The full skill set is grouped by category. Skills resolve domain vocabulary at invocation by reading `ops/derivation-manifest.md`, so the same skill works across different vault domains without forking.

## Processing pipeline

| Command | Purpose | When to use |
|---------|---------|-------------|
| `/extract <source>` | Extract atomic insights from a source (CSV, paste, framework doc) | After dropping a Looker export, framework PDF, or session paste into `incoming/` |
| `/connect <insight>` | Find and write cross-references for a given insight | After `/extract` produces a new insight, before it ships |
| `/update <insight>` | Update with new context, mark stale entries with `meta_state: stale` and `superseded_by:` | When new data lands that affects an existing insight |
| `/verify <insight>` | Verify quality, citations, schema compliance | Before any deliverable that cites the insight |
| `/pipeline` | Run the full extract -> connect -> verify cycle | End of session catch-up; processes everything in `incoming/` |

## Orchestration

| Command | Purpose | When to use |
|---------|---------|-------------|
| `/tasks` | Show the pending task queue | Anytime, to see what is in flight |
| `/next` | Surface the highest-priority next task | When you don't know where to start |
| `/seed <session-id>` | Mine a past session transcript for tasks the agent should have captured | When a session ended with `seed_candidate: true` |
| `/cro-audit-draft <client_alias>` | Custom: produce an audit draft for an engagement | When you have a Looker export ready and want the deliverable shape |

## Diagnostic / quality

| Command | Purpose | When to use |
|---------|---------|-------------|
| `/validate` | Validate vault-wide schema integrity | Before any deliverable; surfaces missing-field violations |
| `/graph` | Graph analysis (orphans, dangling links, density) | Periodically; weekly is reasonable |
| `/stats` | Counts by type, domain, meta_state | Sanity check; before major refactor |
| `/health` | Vault health report (combines validate + graph + freshness) | Quarterly review |

## Meta-cognitive

| Command | Purpose | When to use |
|---------|---------|-------------|
| `/reassess` | Review accumulated observations + tensions | When threshold fires (10 obs / 5 tens) or quarterly |
| `/architect` | Reason about config drift, propose changes | When the system feels off; reads `ops/derivation.md` and proposes |
| `/flag <fact>` | Capture friction or methodology learning into `ops/observations/` or `ops/methodology/` | Inline, whenever something recurs that should not |

## Knowledge / research

| Command | Purpose | When to use |
|---------|---------|-------------|
| `/learn <topic>` | Research a topic, write notes to `incoming/` | Before tackling a new vertical or domain |
| `/refactor <landscape>` | Refactor a landscape or note structure | When a landscape has grown past 25 insights or a domain boundary has shifted |

## Direct file work (no skill needed)

Most read-only operations are handled directly with Read, Glob, Grep, ripgrep. The skills exist for write-heavy operations where the pipeline structure matters.

## Notes

- All skills emit explicit `Next:` suggestions when chaining is set to `suggested` (default in `ops/config.yaml`)
- Skills read `ops/derivation-manifest.md` at invocation for vocabulary; manual edits to that manifest take effect on next invocation
- Custom skills (like `/cro-audit-draft`) live in `.claude/skills/` and follow the same invocation patterns
