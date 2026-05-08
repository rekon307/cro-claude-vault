---
description: Machine-readable vocabulary for runtime skills - skill files read this to use domain-specific terms
type: config
---

# Derivation Manifest

Runtime vocabulary for the CRO consulting practice knowledge system. Skills read this manifest at invocation to resolve domain-specific terms.

## Manifest

```yaml
schema_version: 1
generated_at: "2026-05-08T08:30:00Z"
platform: claude-code

dimensions:
  granularity: atomic
  organization: flat
  linking: explicit+implicit
  processing: heavy
  navigation: 3-tier
  maintenance: condition-based
  schema: dense
  automation: full

coherence_result: passed

vocabulary:
  # Folder names
  notes_folder: intelligence
  inbox_folder: incoming
  archive_folder: archive
  ops_folder: ops
  self_folder: self
  templates_folder: templates

  # Note terminology
  note_singular: insight
  note_plural: insights
  notes_collection: intelligence

  # Schema field names (universal - keep stable across domains)
  description: description
  topics: domains
  relevant_notes: relevant_notes

  # Navigation
  topic_map: landscape
  topic_maps: landscapes
  hub: index
  vault_hub: intelligence/index.md

  # Process verbs
  reduce: extract
  reflect: connect
  reweave: update
  verify: verify
  validate: validate
  rethink: reassess
  remember: flag
  seed: seed

  # Command names
  cmd_reduce: /extract
  cmd_reflect: /connect
  cmd_reweave: /update
  cmd_verify: /verify
  cmd_validate: /validate
  cmd_rethink: /reassess
  cmd_remember: /flag
  cmd_seed: /seed
  cmd_pipeline: /pipeline
  cmd_tasks: /tasks
  cmd_stats: /stats
  cmd_graph: /graph
  cmd_next: /next
  cmd_learn: /learn
  cmd_refactor: /refactor
  cmd_audit_draft: /cro-audit-draft

  # Note types
  note_types:
    - heuristic
    - insight
    - audit-finding
    - pattern
    - framework
    - test-result
    - tension
    - methodology

  # Domain labels
  domains:
    - checkout-friction
    - form-design
    - mobile-ux
    - traffic-quality
    - social-proof
    - pricing-display
    - landing-page
    - copy-and-messaging
    - analytics-instrumentation
    - methodology

  meta_states:
    - current
    - stale
    - closed
    - speculative

  verticals:
    - ecommerce-dtc
    - saas-self-serve
    - saas-sales-led
    - lead-gen
    - marketplace
    - subscription
    - other

  funnel_stages:
    - awareness
    - consideration
    - decision
    - retention

  confidence_levels:
    - directly-measured
    - inferred-from-data
    - heuristic-only
    - well-replicated
    - context-dependent
    - emerging
    - personal-experience-only

  severity_levels:
    - critical
    - major
    - minor
    - cosmetic

  engagement_statuses:
    - intake
    - audit-in-progress
    - test-in-flight
    - reporting
    - on-hold
    - closed

  engagement_types:
    - one-off-audit
    - retainer
    - test-program
    - advisory

  test_outcomes:
    - validated
    - invalidated
    - inconclusive

platform_hints:
  context: fork
  allowed_tools: [Read, Write, Edit, Bash, Glob, Grep, AskUserQuestion]
  semantic_search_tool: mcp__qmd__deep_search

personality:
  warmth: clinical
  opinionatedness: opinionated
  formality: professional-casual
  emotional_awareness: task-focused
```

## Extraction Categories

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

## Cross-Domain Connection Syntax

When a finding or insight spans more than one CRO domain, link both landscapes and label the bridge:

```
[[insight-A]] -> [[insight-B]] - [CROSS-DOMAIN: domain-A -> domain-B]
```

Example:

```
[[abandonment-curve-steepest-cart-to-address]] -> [[mobile-thumb-reach-failure-rates]] - [CROSS-DOMAIN: checkout-friction -> mobile-ux]
```

## Skill Invocation Reference

```
/extract <source>          # extract insights from a source file or paste
/connect <insight>         # find and write cross-references
/update <insight>          # update with new context, mark stale entries
/verify <insight>          # verify quality, citations, schema
/validate                  # validate vault-wide schema integrity
/reassess                  # review accumulated observations + tensions
/flag                      # capture friction or methodology learnings
/seed                      # mine an unprocessed session for tasks
/pipeline                  # run the full extract -> connect -> verify cycle
/tasks                     # show pending pipeline tasks
/stats                     # vault stats (counts by type, domain, meta_state)
/graph                     # graph analysis (orphans, dangling, density)
/next                      # surface the next highest-priority task
/learn <topic>             # research a topic, write to incoming/
/refactor                  # refactor a landscape or note structure
/health                    # vault health report
/architect                 # reason about config drift, propose changes
/cro-audit-draft <client>  # custom: produce a structured audit draft for an engagement
```

## Updating This Manifest

This manifest is rewritten when the system is reconfigured. Manual edits are allowed but must be paired with a corresponding update in `ops/derivation.md` (the WHY) so the two stay in sync. Drift between `derivation.md` and this manifest is a kernel-state corruption flag and surfaces during the next `/reassess`.
