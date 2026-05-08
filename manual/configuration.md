---
description: How to adjust the system via ops/config.yaml
type: manual
---

# Configuration

The live operational config is `ops/config.yaml`. The historical record of why each choice was made is `ops/derivation.md`. The two are intentionally separate: config can drift; derivation explains the original reasoning.

## Adjusting a setting

Edit `ops/config.yaml` directly. Changes take effect on next session start (the SessionStart hook reads the config). For per-session overrides, pass flags to skill invocations.

## Common adjustments

| Want to... | Change |
|------------|--------|
| Loosen heuristic stale threshold | `thresholds.heuristic_stale_days: 180` (default 90) |
| Speed up processing for high-volume catch-up | `processing_settings.depth: quick` (or use `/pipeline --depth quick`) |
| Block deliverables with unlabeled claims | `cro_practice.confidence_label_required_for_delivery: true` (default true) |
| Disable auto-commit | Edit `.claude/settings.json` and remove the auto-commit hook |
| Make the agent less opinionated | `personality.opinionatedness: neutral` (default opinionated) |
| Change the default vertical | `cro_practice.vertical_default: subscription` (default ecommerce-dtc) |

## Detected drift

If you change something in `ops/config.yaml` that contradicts the rationale in `ops/derivation.md`, run `/architect`. It will:

1. Read both files
2. Identify the dimension that drifted
3. Surface the original reasoning
4. Either confirm the change is intentional (and update `ops/derivation.md`) or flag it as accidental drift

## Adding a new domain

CRO practices grow. To add a domain (e.g. you decide to specialize in email-CRO):

1. Add the domain to `ops/derivation-manifest.md` in the `domains:` enum
2. Create the landscape MOC at `intelligence/{new-domain}-landscape.md` from the `landscape` template
3. Run `/refactor` to surface insights that should be tagged with the new domain

## Adding a new vertical

To add a vertical to the `vertical:` enum (e.g. you take a `marketplace-aggregator` engagement):

1. Add the vertical to `ops/derivation-manifest.md` in the `verticals:` enum
2. The change takes effect immediately for new notes; existing notes with `vertical:` already set are unaffected

## Reset

If the configuration becomes unrecoverable, run `/reseed`. It re-runs the derivation conversation, generates a fresh `derivation.md`, `derivation-manifest.md`, and `config.yaml`, and asks the consultant to confirm before overwriting.

The `intelligence/`, `engagements/`, and `self/` content is never overwritten by `/reseed` - only the configuration files and the manual.

## See also

- [[meta-skills]] - how `/architect` and `/reassess` work
- [[troubleshooting]] - what to do when things break
