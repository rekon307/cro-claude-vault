---
description: Processing pipeline, maintenance cycle, and session rhythm
type: manual
---

# Workflows

## The processing pipeline

The pipeline turns raw source material into structured, connected insights. Five phases:

### 1. Capture (zero-friction)

Drop anything into `incoming/`. CSV exports, framework PDFs, session pastes, screenshots. No structure required at this stage. The agent processes from `incoming/` during `/pipeline` runs.

### 2. Extract

`/extract <source>` reads the source fully, then emits atomic insights using the eight extraction categories (heuristic-evidence, audit-finding, pattern-detection, test-result, framework-update, tool-pattern, industry-benchmark, tensions). Each insight gets a draft frontmatter with required fields populated.

### 3. Connect

`/connect <insight>` finds cross-references: which landscape it belongs to, which existing insights extend or contradict it, whether it crosses a domain boundary. Writes the wiki links into the insight's `Relevant Notes` and `Topics` footers, and updates the relevant landscape's "Core Intelligence" list.

### 4. Verify

`/verify <insight>` checks quality: schema completeness, citation discipline, descriptive title (not declarative-vague), no hallucinated benchmark numbers. Marks the insight as `meta_state: current` if it passes.

### 5. Update

`/update <insight>` is invoked later when new data lands. If the new data extends the insight, the body is updated and `modified` is bumped. If the new data supersedes the insight, the old one gets `meta_state: stale` plus `superseded_by: [[new-insight]]`, and a new insight is created.

## The maintenance cycle

Maintenance is condition-based rather than scheduled. Conditions are documented in `ops/config.yaml > thresholds:`. The relevant ones:

| Condition | Threshold | Trigger | Action |
|-----------|-----------|---------|--------|
| Heuristic untouched | 90 days | `meta_state: current` notes not modified | Surface for review on next `/health` |
| Audit finding untouched | 30 days | In-flight findings not updated | Surface on `/next` for status check |
| Incoming/ overflow | 7 days | Any file in `incoming/` unprocessed | Surface on `/next` for `/pipeline` run |
| Pending observations | 10 | Threshold cross | Surface `/reassess` recommendation on next session start |
| Pending tensions | 5 | Threshold cross | Surface `/reassess` recommendation on next session start |
| Orphan insights | 3 | Orphan count exceeded | Surface on `/health` for connection work |
| Benchmark age | 540 days | Notes with vertical-specific data older than 18 months | Surface on `/health` for verification or stale-flag |

When a threshold fires, the SessionStart orient phase prepends a warning to the orientation summary. The user can act on it or defer.

## The session rhythm

Every session follows orient → work → persist:

### Orient (auto, SessionStart hook)

Reads:
- `self/identity.md` (1-2 lines reminding the agent of its role)
- `self/methodology.md` (the processing principles)
- `self/goals.md` (active threads)
- `self/relationships.md` (relevant people)
- `self/memory/` (recent personal-context insights)
- `ops/reminders.md` (overdue first)
- `ops/derivation.md` (configuration context if drift is suspected)
- `ops/queue/tasks.md`
- `ops/observations/` and `ops/tensions/` counts

Outputs a one-screen orientation summary at session start.

### Work

The agent does what was requested. During work it can:
- Process via `/extract`, `/connect`, `/update`, `/verify`
- Capture observations via `/flag`
- Surface tensions inline (auto-write to `ops/tensions/` when contradiction detected)
- Update `ops/queue/tasks.md` as tasks come and go

### Persist (auto, SessionEnd hook)

- Archives the session transcript symlink to `ops/sessions/{started}.json`
- Marks the session as `seed_candidate: true` if substantive (transcript above N tokens AND not just maintenance)
- Auto-commits the working tree (via `auto-commit.sh` PostToolUse hook, runs continuously during the session)
- Updates `current.json` to reflect the session ending cleanly

If a session ends abnormally (SIGKILL, OOM, terminal close), the next SessionStart hook detects the dangling `current.json` and marks it `crashed`, archiving it before starting fresh.

## Batch processing

For high-volume catch-up (e.g. processing a quarter of accumulated `incoming/`):

```
/pipeline --depth quick
```

`quick` mode collapses connect+verify into one pass and reduces the sample-size of cross-reference candidates. Use when you are catching up, not when you are doing primary processing.

For rigorous primary processing:

```
/pipeline --depth deep
```

`deep` mode runs each phase in fresh context, with full quality gates. Use for the first audit on a new client or when the deliverable is going to a high-stakes client.

Default is `standard`, which is what `/pipeline` uses with no flags.
