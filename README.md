# CRO Knowledge Vault (demo)

A reference implementation of an Obsidian-style CRO knowledge vault wired to Claude. Reads like a working consultant's vault, structured so it is the single source of truth across client engagements, and queryable through Claude to produce reproducible audit drafts from raw GA4 / Looker Studio exports.

This repo is sanitized demo content. The architecture is the same as the production vault I run for my own business (currently 233 notes, 13 landscape MOCs, schema-validated frontmatter, wiki-link cross-domain graph). Domain rewritten to CRO; client names, revenue figures, and personal data removed.

## What's here

```
.
├── CLAUDE.md                          # Operating directive (the prompt engineering layer)
├── README.md                          # This file
├── templates/                         # Schema-validated templates (frontmatter _schema blocks)
│   ├── insight-note.md
│   ├── landscape.md
│   ├── audit-finding.md
│   ├── heuristic.md
│   └── client-engagement.md
├── intelligence/                      # The cross-engagement knowledge graph
│   ├── checkout-friction-landscape.md
│   ├── form-design-landscape.md
│   ├── mobile-ux-landscape.md
│   └── *.md                           # Sample insight notes that the landscapes index
├── frameworks/                        # The consultant's working methodology
│   ├── core-cro-methodology.md
│   └── audit-checklist.md
├── playbook/                          # The export-to-report workflow + prompt templates
│   ├── export-to-report.md
│   └── prompt-templates/
│       ├── cro-audit-draft.md
│       ├── landing-page-review.md
│       └── funnel-analysis.md
├── self/                              # Consultant identity layer
│   └── methodology.md
└── .claude/
    └── skills/                        # Vault maintenance skills (architect, graph, health, validate, reweave)
        └── README.md
```

In a live engagement there is also an `engagements/{client_alias}/` folder under each active client, containing the engagement file, data exports, findings, tests, and deliverables. That folder is intentionally absent here for confidentiality reasons; the templates show what would go there.

## How it works

1. The consultant exports raw data from Looker Studio (which is wired to GA4 and any other sources).
2. Claude is invoked with this repo loaded and `CLAUDE.md` as the system prompt.
3. The consultant pastes the export, calls one of the prompt templates from `playbook/prompt-templates/`, and gets a structured audit draft back.
4. The draft cites both the data source and the vault heuristics that support each finding. Confidence is labeled per claim.
5. The consultant edits, rewrites the framing, and ships to the client. New patterns surfaced during the engagement go back into the vault.

The two non-obvious parts are the schema-validated frontmatter (which is what keeps the vault queryable as it grows past 100 notes) and the operating directive in `CLAUDE.md` (which is the actual prompt engineering layer; without it, Claude produces generic CRO advice).

## What the schema gives you

Every template has a `_schema` block in its frontmatter. The schema declares required fields, optional fields, enums, and format constraints. Notes that violate the schema are flagged by the `architect` maintenance skill before they cause problems downstream.

Example: every insight note must declare `domain` (one of nine CRO domains) and `meta_state` (one of: current, stale, closed, speculative). When a heuristic is superseded by a newer one, the old note is marked `meta_state: stale` and `superseded_by: [[new-note]]`. Claude reads `meta_state: stale` and treats the note as historical context, not as a current rule.

## What the landscapes (MOCs) give you

A landscape is not a folder. It is a synthesized view of a domain: opening paragraph that *thinks*, links to the load-bearing insights, explicit cross-domain connections, active tensions, and known gaps. When Claude is asked about a domain, it reads the landscape first; the landscape orients the rest of the search. A vault without landscapes is a pile of notes; a vault with landscapes is queryable.

## Why the vault, not just one big prompt

A single prompt with all the heuristics in it works at small scale and breaks at audit volume. The vault gives:

- **Consistency across clients** - the same heuristic library is applied to every engagement
- **Citation discipline** - every finding has a wiki-linked source
- **Compounding intelligence** - patterns observed in one engagement become heuristics for the next
- **Reproducibility** - re-running the same export produces the same draft (modulo LLM drift)
- **Defensibility** - the audit deliverable's framing, methodology, and rationale are traceable back to vault content the consultant authored

## Structure carried over from the production vault

This demo mirrors the architecture of the production business-intelligence vault I run as my own working system. The patterns translate cleanly across domains because they are about *how knowledge is structured*, not about what the knowledge is *about*. The production vault uses the same:

- Frontmatter `_schema` blocks on every template
- Landscape MOCs as the synthesis layer over each domain
- Wiki-link graph as the actual analytical surface
- `meta_state` lifecycle: current -> stale -> closed, with `superseded_by` links forward
- Source-of-record rule (live data lives in one place, intel notes link, never duplicate)
- Operating directive (`CLAUDE.md`) as the prompt engineering layer

The translation work for a new consultant is in two places: (1) the consultant's actual frameworks and heuristics, populated into `frameworks/` and `intelligence/` during onboarding; (2) the consultant's voice and prioritization rules, captured in `self/methodology.md` and reflected in `CLAUDE.md`. Architecture stays the same; content is theirs.

## License

This demo vault is shared as evidence of architecture. Use the structure freely; the content is illustrative.
