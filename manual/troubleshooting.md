---
description: Common issues and resolution patterns
type: manual
---

# Troubleshooting

## Orphan insights (notes with no incoming `[[wiki-links]]`)

**Detection:** `bash ops/scripts/graph/orphans.sh` lists every orphan.

**Cause:** insight was written but the connection step (`/connect`) was skipped, or the relevant landscape did not pick it up.

**Resolution:** for each orphan, either link it from the relevant landscape's "Core Intelligence" list, or mark it `meta_state: stale` if it should have been retired, or delete it if it was a draft. An orphan rate above 5% means the connection step is being skipped systematically.

## Dangling wiki links (`[[targets]]` that resolve to no file)

**Detection:** `bash ops/scripts/graph/dangling-links.sh` lists every dangling link.

**Cause:** target was renamed, deleted, or never existed (typo in the link).

**Resolution:** for each dangling link, either create the target note, fix the link to point at the correct target, or remove the link. If the cause was a rename, set `superseded_by:` on the renamed note so future refactors can chain.

## Stale content (`meta_state: current` notes not updated in 90+ days)

**Detection:** `/health` surfaces stale notes by domain.

**Cause:** the heuristic was correct when written but the underlying patterns may have shifted (especially mobile UX, where the iOS Safari behavior changes per major release).

**Resolution:** read the note. If it still holds, bump `modified` to the current date. If it is drifting, write a new version, mark the old `meta_state: stale`, link forward via `superseded_by:`. If it is wrong, mark it `meta_state: closed`.

## Methodology drift (system behavior diverging from `ops/derivation.md`)

**Detection:** `/architect` reports drift between config and derivation.

**Cause:** ad-hoc `ops/config.yaml` edits accumulated without updating the derivation rationale, or the consultant's practice evolved without the system being told.

**Resolution:** run `/architect` and approve or reject each proposed change. The skill updates `ops/derivation.md` for accepted changes and reverts `ops/config.yaml` for rejected ones.

## Inbox overflow (too many items in `incoming/`)

**Detection:** `/health` flags `incoming/` items older than 7 days.

**Cause:** capture is faster than processing, or the consultant has been busy and material accumulated.

**Resolution:** run `/pipeline --depth quick` to catch up. If overflow recurs, either tighten the capture (only drop in `incoming/` what you commit to processing within a week) or loosen the threshold (`thresholds.incoming_stale_days: 14`).

## Pipeline stalls (tasks stuck in queue)

**Detection:** `/tasks` shows entries with `status: in_progress` older than a few days, or `/next` returns nothing.

**Cause:** task was blocked by a dependency that resolved silently, or status was not updated when work completed.

**Resolution:** read the queue, fix status fields, run `/next` again. If a class of task keeps stalling, escalate to `/reassess`.

## Heuristic-only claims shipped to client

**Detection:** post-delivery review finds the deliverable contained a `heuristic-only` claim that was not flagged or rewritten.

**Cause:** verification step skipped, or the consultant overrode the flag without rewriting the claim.

**Resolution:** add the incident to `ops/observations/`. If it recurs, set `cro_practice.confidence_label_required_for_delivery: true` (it is `true` by default; verify).

## Common mistakes

| Mistake | Correction |
|---------|------------|
| Writing an insight title as a noun phrase ("checkout abandonment") | Rewrite as a proposition ("checkout abandonment is steepest from cart to address") |
| Skipping `/verify` before delivery | Add it to your session-end checklist; eventually move to `/architect` to enforce |
| Editing an old insight in place when the change should supersede it | Mark old `meta_state: stale`, write a new insight, link `superseded_by:` |
| Linking heuristics by topic name rather than insight title | Use the canonical title (filename without `.md`); the dangling-links script catches mistakes |
| Writing a finding without a linked vault heuristic | Either add the heuristic to the vault first, or label the finding `confidence: heuristic-only` |

## When to ask for help

The system is not magic. If something feels structurally wrong (the agent's responses are consistently off, the deliverables feel generic, the friction signals are increasing rather than decreasing), it is usually a configuration issue rather than a content issue. Run `/architect` first; if `/architect` cannot resolve it, the answer is usually in `ops/derivation.md` and a change of dimension position is required.

## See also

- [[meta-skills]] - `/architect`, `/reassess`, `/flag`, `/health`
- [[configuration]] - how to adjust thresholds and behavior
