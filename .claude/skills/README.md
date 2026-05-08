# Vault Maintenance Skills

The vault includes a small set of automated maintenance routines, exposed as Claude Code skills, that keep the graph healthy without manual review. Each skill is a documented procedure, not a magic button. They are listed here so the consultant knows what is available and the operator knows when to invoke them.

## architect

Schema enforcement. Reads every file's frontmatter and validates against the `_schema` block in the corresponding template. Flags missing required fields, invalid enum values, malformed dates. Run before any major review or after a bulk import.

## graph

Wiki-link integrity. Walks every `[[wiki-link]]` and confirms the target exists. Flags broken links. Optionally suggests fixes when a target was renamed (using the file's `superseded_by` field).

## health

Freshness report. Lists every note where `meta_state: current` but the file has not been modified in 90+ days. The consultant reviews and either marks `meta_state: stale` or refreshes the content. The point is to keep "current" trustworthy.

## validate

Per-engagement audit deliverable check. For a given `engagements/{client}/deliverables/{date}-audit-draft.md`, confirms:

- Every quantitative claim cites a data source
- Every qualitative claim cites a vault heuristic via `[[wiki-link]]`
- No `heuristic-only` confidence label is unmarked
- The instrumentation check section exists and ran

If any check fails, the deliverable is not shippable until the issue is resolved.

## reweave

Refactor connections. When a landscape is created or restructured, walks the relevant insight notes and confirms they link to the right landscape. Helps when the vault grows past the point where manual hand-linking is reliable.

---

These skills are reference material. The actual skill implementations live in a separate repo / are wired into the consultant's Claude Code setup during the build phase. The vault itself does not need to know how the skills work, only what they enforce.
