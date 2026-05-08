---
description: How this knowledge system was derived - design rationale for every dimension
created: 2026-05-08
schema_version: 1
---

# System Derivation

This file records the reasoning behind every configuration choice in this vault. It is the design document. When the system is reconfigured, this file is updated to match. Drift between this file and the live config is a flag.

## Configuration Dimensions

| Dimension | Position | Reasoning | Confidence |
|-----------|----------|-----------|------------|
| Granularity | Atomic | CRO heuristics are atomic by nature; per-engagement audit findings are atomic units of work. The vault must support filter-by-domain, filter-by-confidence, filter-by-vertical, which only works at atomic granularity. | High |
| Organization | Flat (multi-engagement) | Cross-engagement intelligence lives flat (domain-tagged); engagement-bound deliverables are scoped under `engagements/{client_alias}/`. Hybrid: heuristics flat, engagements segregated. | High |
| Linking | Explicit + implicit | The same heuristic shows up in many audits. The same data pattern surfaces across many heuristics. Wiki-link backbone for direct relationships, semantic search for vocabulary divergence ("checkout drop" vs "abandonment cliff" must surface the same notes). | High |
| Processing | Heavy | Multi-source extraction (CSV exports, GA4 raw, screenshots), cross-reference against heuristic library, produce structured deliverable. Full pipeline: extract → connect → verify → update. | High |
| Navigation | 3-tier | Hub → landscape → insight. One landscape per CRO domain (checkout-friction, form-design, mobile-ux, traffic-quality, social-proof, pricing-display, landing-page, copy-and-messaging, analytics-instrumentation). Each landscape indexes 5-30 atomic insights. Projected note volume above 100 within first 5 engagements. | High |
| Maintenance | Condition-based (tight) | Heuristics decay (old studies superseded, mobile patterns shift). Audit findings have lifecycle states. Engagements close. Tight thresholds: 90 days for heuristics, 30 days for in-flight findings, 7 days for unprocessed exports in `incoming/`. | High |
| Schema | Dense | Eight note types (heuristic, insight, audit-finding, pattern, framework, test-result, tension, methodology). Findings carry severity, confidence, domain, client, page_or_flow, sample_size. Tests carry hypothesis, MDE, runtime, primary metric. The audit deliverable is only as defensible as its frontmatter. | High |
| Automation | Full | Claude Code with hook support. SessionStart hook runs orient. PostToolUse hook validates schema on writes to `intelligence/*.md`. SessionEnd hook archives transcripts. Auto-commit on every modification. | High |

## Personality Dimensions

| Dimension | Position | Reasoning |
|-----------|----------|-----------|
| Warmth | Clinical | Professional consulting context. Audit deliverables are read by founders, growth teams, C-suite. Voice is direct, evidence-led, no warmth filler. |
| Opinionatedness | Opinionated | The agent surfaces tensions, pushes back on weak findings, refuses to invent benchmark numbers. Mirrors the consultant's posture. |
| Formality | Professional, casual register | Deliverable framing is professional. Working-session communication is direct and conversational, like a senior analyst talking to the partner. |
| Emotional Awareness | Task-focused | CRO is a quantitative practice. Emotional content (client politics, internal pushback) gets noted as a constraint, not absorbed as the primary signal. |

## Vocabulary Mapping

| Universal Concept | Domain Term | Category |
|-------------------|-------------|----------|
| notes | intelligence | folder |
| inbox | incoming | folder |
| archive | archive | folder |
| ops | ops | folder |
| self | self | folder |
| templates | templates | folder |
| note (singular) | insight | note type |
| note (plural) | insights | note type |
| MOC | landscape | navigation |
| topic_map | landscape | navigation |
| topic_maps | landscapes | navigation plural |
| hub | index | navigation |
| reduce | extract | process phase |
| reflect | connect | process phase |
| reweave | update | process phase |
| verify | verify | process phase |
| validate | validate | process phase |
| rethink | reassess | process phase |
| remember | flag | capture phase |
| domain | CRO consulting practice | domain identifier |

## Extraction Categories

Eight categories the `/extract` skill watches for when processing engagement data, framework docs, or research sources.

| Category | Trigger | Output Type |
|----------|---------|-------------|
| heuristic-evidence | Engagement-data observation that supports or contradicts a known CRO heuristic | insight (linked to `[[heuristic]]`) |
| audit-finding | Specific issue at the page-or-flow level from client data | audit-finding |
| pattern-detection | Same observation across 3+ engagements (heuristic candidate) | pattern |
| test-result | A/B test outcome with hypothesis, MDE, sample size, primary metric | test-result |
| framework-update | Methodology evolution learned from an engagement | framework |
| tool-pattern | Recurring instrumentation issue (GA4, Shopify, Looker) | insight (`domain: analytics-instrumentation`) |
| industry-benchmark | Vertical-specific data point (DTC, SaaS, subscription, lead-gen) | insight (`vertical: ...`) |
| tensions | Contradiction between heuristics, or heuristic vs observed data | tension |

## Note Types (the `type` field enum)

- `heuristic` - well-replicated CRO principle
- `insight` - general cross-engagement finding
- `audit-finding` - specific issue from a client engagement
- `pattern` - recurring observation across 3+ engagements (often promoted to heuristic later)
- `framework` - methodology layer (audit shape, prioritization rubric, severity grading)
- `test-result` - A/B test outcome with structured fields
- `tension` - contradiction between heuristics or between heuristic and data
- `methodology` - vault self-knowledge (lives in `ops/methodology/`)

## Domain Enum (the `domain` field)

- `checkout-friction`
- `form-design`
- `mobile-ux`
- `traffic-quality`
- `social-proof`
- `pricing-display`
- `landing-page`
- `copy-and-messaging`
- `analytics-instrumentation`
- `methodology`

## Platform

- Tier: Claude Code
- Automation: full
- Hooks: SessionStart, PostToolUse (Write|Edit|MultiEdit), SessionEnd

## Active Capabilities

- Wiki-link graph backbone
- Atomic notes (one idea per file)
- 3-tier navigation (hub → landscape → insight)
- Heavy processing pipeline (extract → connect → verify → update)
- Dense schema with frontmatter validation
- Condition-based maintenance with tight thresholds
- Self-evolution loop (observations + tensions → reassess)
- Methodology self-knowledge (`ops/methodology/`)
- Session rhythm (orient, work, persist)
- Templates with `_schema` blocks
- Ethical guardrails (citation discipline, missing-data rule)
- Helper scripts (`ops/scripts/graph/`)
- Graph analysis (orphan detection, dangling links, density)
- Semantic search (vocabulary divergence is real here)
- Personality layer (opinionated, clinical, task-focused)
- Self space (agent persistent memory)

## Coherence Validation

| Check | Result |
|-------|--------|
| atomic + 3-tier navigation + projected volume > 100 | Pass - 9 landscapes index the volume |
| automation = full + platform supports hooks | Pass - Claude Code |
| processing = heavy + automation | Pass - automation is full |
| dense schema + automation | Pass - write-validate hook enforces |
| explicit+implicit linking + semantic search available | Pass - opted in |
| volume projection + maintenance thresholds | Pass - pre-emptively tight |

Compensating mechanisms active: semantic search compensates for vocabulary divergence across CRO domains (a "checkout drop" finding must surface for "abandonment cliff" queries).

## Known High-Risk Failure Modes

These get included in `CLAUDE.md` Common Pitfalls section:

1. **Heuristic-only audit findings shipped without engagement-data anchoring** - most likely failure mode. Mitigated by mandatory `confidence` field on `audit-finding` notes and citation discipline in deliverables.
2. **Orphan heuristics** - heuristic notes with no incoming `[[wiki-links]]` from engagement findings. `/validate` surfaces.
3. **Stale benchmarks** - vertical-specific data ages out fast (12-18 months). Tight thresholds + condition-based maintenance prevent silent staleness.
4. **MOC sprawl** - CRO has fuzzy domain boundaries (is "scarcity-anchor pricing" social-proof or pricing-display?). Cross-domain links in landscape headers are mandatory.

## Generation Parameters

- Folders: `intelligence/`, `engagements/`, `templates/`, `self/`, `ops/`, `manual/`, `playbook/`, `frameworks/`
- Skills: full processing pipeline plus a CRO-specific `/cro-audit-draft` that wraps `/extract` with the audit deliverable shape
- Hooks: session-orient, session-end, write-validate, auto-commit
- Templates: insight, landscape, audit-finding, heuristic, client-engagement, test-result, tension
- Topology: single-domain, multi-engagement, agent-driven processing
