# CRO Knowledge Vault (demo)

A reference implementation of a Claude-operated knowledge vault for a CRO consulting practice. Sanitized snapshot of an architecture I run for my own business across multiple domains, retargeted here for cross-engagement CRO work.

The vault is the single source of truth across client engagements. Claude reads it, processes raw data exports from Looker Studio against the heuristic library, and produces structured CRO audit drafts with citation discipline at every step. The architecture is designed so the loop is reproducible: same export → same vault → same draft.

## What's here

```
.
├── CLAUDE.md                       # operating directive (the prompt engineering layer)
├── README.md                       # this file
├── intelligence/                   # cross-engagement knowledge graph
│   ├── index.md                    # vault hub
│   ├── *-landscape.md              # synthesis MOCs per CRO domain
│   └── *.md                        # atomic insight notes
├── engagements/                    # per-client work
│   └── _example-client/
│       ├── index.md                # engagement file
│       ├── data/                   # raw exports (gitignored in production)
│       ├── findings/               # audit findings
│       ├── tests/                  # test recommendations
│       └── deliverables/           # audit drafts
├── frameworks/                     # consultant's working methodology
├── playbook/                       # the export-to-report workflow + 3 prompt templates
├── templates/                      # schema-validated note templates
├── self/                           # agent persistent memory
│   ├── identity.md
│   ├── methodology.md
│   ├── goals.md
│   ├── relationships.md
│   └── memory/
├── ops/                            # operational coordination
│   ├── derivation.md               # WHY each config dimension was chosen
│   ├── derivation-manifest.md      # machine-readable runtime vocabulary
│   ├── config.yaml                 # live operational settings
│   ├── methodology/                # vault self-knowledge
│   ├── observations/               # friction signals (atomic)
│   ├── tensions/                   # contradictions
│   ├── queue/                      # unified pipeline + maintenance task queue
│   ├── sessions/                   # archived session metadata
│   ├── scripts/graph/              # graph analysis (orphans, dangling, backlinks)
│   └── reminders.md                # time-bound commitments
├── manual/                         # 7 user-navigable docs
└── .claude/
    ├── settings.json               # hooks + permissions
    ├── hooks/                      # session-orient, write-validate, auto-commit, session-end
    └── skills/                     # custom skill stubs
```

## How it works

1. The consultant exports data from Looker Studio (wired to GA4 + any other sources).
2. Claude is invoked with this folder loaded; `CLAUDE.md` is the system prompt.
3. The SessionStart hook reads `self/`, `ops/reminders.md`, `ops/queue/`, and surfaces threshold warnings.
4. The consultant pastes the export and invokes one of the prompt templates from `playbook/prompt-templates/`.
5. Claude runs through the export-to-report workflow: instrumentation check → data anchor → audit checklist → findings → test recommendations → draft.
6. Every claim cites both data source and vault heuristic. Confidence is labeled per claim.
7. The consultant edits, ships to client, and pushes new heuristics back into `intelligence/`.

## What the schema gives you

Every template has a `_schema` block in its frontmatter. The schema declares required fields, optional fields, enums, and format constraints. The PostToolUse `write-validate` hook checks frontmatter on every save. Notes that violate the schema get flagged before they reach the deliverable.

Example: every insight note must declare `domain` (one of nine CRO domains) and `meta_state` (one of: current, stale, closed, speculative). When a heuristic is superseded by a newer one, the old note is marked `meta_state: stale` and `superseded_by: [[new-note]]`. Claude reads `meta_state: stale` and treats the note as historical context, not as a current rule.

## What the landscapes (MOCs) give you

A landscape is not a folder. It is a synthesized view of a domain: opening paragraph that *thinks*, links to the load-bearing insights, explicit cross-domain connections, active tensions, and known gaps. When Claude is asked about a domain, it reads the landscape first; the landscape orients the rest of the search. A vault without landscapes is a pile of notes; a vault with landscapes is queryable.

Three landscapes are populated in this demo (`checkout-friction`, `form-design`, `mobile-ux`). The full nine landscapes per CRO domain are populated during onboarding from the consultant's actual practice.

## What the operating directive (`CLAUDE.md`) gives you

`CLAUDE.md` is the prompt engineering layer. Most "Claude + vault" setups skip this and end up with generic CRO advice from training data. With the directive in place, Claude operates as your analytical partner against your specific frameworks, with confidence labels, citation discipline, and a missing-data rule that keeps deliverables defensible.

The directive enforces:

- **Source-of-record rule** (no duplication between live engagement data and cross-engagement intelligence)
- **Missing-data honesty** (do not invent benchmarks; say what is not in the data)
- **Confidence labeling** (every claim is `directly-measured`, `inferred-from-data`, or `heuristic-only`)
- **Citation discipline** (every quantitative claim cites a data source; every qualitative claim cites a vault heuristic via wiki link)
- **Pipeline compliance** (route new content through `/extract` → `/connect` → `/verify` rather than direct writes)

## Why the vault, not just one big prompt

A single prompt with all the heuristics in it works at small scale and breaks at audit volume. The vault gives:

- **Consistency across clients** - the same heuristic library applied to every engagement
- **Citation discipline** - every finding has a wiki-linked source
- **Compounding intelligence** - patterns observed in one engagement become heuristics for the next
- **Reproducibility** - re-running the same export produces the same draft (modulo LLM drift)
- **Defensibility** - the audit deliverable's framing, methodology, and rationale are traceable back to vault content the consultant authored

## How configuration works

Every dimension is reasoned about in `ops/derivation.md` and lived out in `ops/config.yaml`. The two are intentionally separate: config can drift; derivation explains the original reasoning. A drift between them is a flag and surfaces during `/architect`.

The eight configuration dimensions for this CRO practice:

| Dimension | Position | Why |
|-----------|----------|-----|
| Granularity | atomic | heuristics and findings are atomic units |
| Organization | flat (multi-engagement) | cross-engagement intelligence is flat; engagements segregated under `engagements/{client_alias}/` |
| Linking | explicit + implicit | wiki backbone plus semantic search for vocabulary divergence |
| Processing | heavy | full pipeline (extract → connect → verify → update) |
| Navigation | 3-tier | hub → landscape → insight |
| Maintenance | condition-based (tight) | CRO heuristics decay fast |
| Schema | dense | eight note types, validated frontmatter, audit deliverable defensibility |
| Automation | full | Claude Code with hooks |

Adjusting a dimension is a `ops/config.yaml` edit. The historical reasoning stays in `ops/derivation.md`. If the change is structural (e.g. adding a new CRO domain), `/architect` updates both.

## Hooks

Four shell hooks run automatically:

| Hook | Triggered by | What it does |
|------|--------------|--------------|
| `session-orient.sh` | SessionStart | Reads orient state, emits warnings, writes `ops/sessions/current.json` |
| `write-validate.sh` | PostToolUse (Write) | Validates frontmatter against schema, flags dangling wiki links |
| `auto-commit.sh` | PostToolUse (Write) | Commits each modified file immediately |
| `session-end.sh` | SessionEnd | Archives session, marks substantive sessions as seed candidates |

All four are simple bash scripts in `.claude/hooks/`. Disable any by removing the entry from `.claude/settings.json`.

## What this demo includes vs the live build

This snapshot includes the architecture and a working sample. The live build for a real CRO consultant would include:

- All 9 landscape MOCs populated from the consultant's actual practice (this demo has 3)
- 50-200 atomic insight notes seeded from the consultant's existing notes / decks / docs
- Custom prompt templates tuned to the consultant's deliverable shape
- Vertical-specific framework files (DTC, SaaS self-serve, lead-gen) if the consultant works across multiple verticals
- Real client engagements under `engagements/` (intentionally absent here for confidentiality reasons)

## License

This demo vault is shared as evidence of architecture. Use the structure freely; the content is illustrative.
