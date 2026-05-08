---
description: User manual for the CRO consulting practice knowledge system
type: manual
---

# Manual

Welcome to your CRO consulting practice knowledge system. This manual explains how everything works.

## Pages

- [[getting-started]] - Your first session, your first insight, and your first connection
- [[skills]] - Every available command with when to use it and examples
- [[workflows]] - The processing pipeline, maintenance cycle, and session rhythm
- [[configuration]] - How to adjust settings via `ops/config.yaml`
- [[meta-skills]] - `/architect`, `/reassess`, `/flag`, `/health` explained
- [[troubleshooting]] - Common issues and how to resolve them

## Quick reference

**Where things live:**

| If you want to... | Go to... |
|-------------------|----------|
| Read a CRO heuristic | `intelligence/*.md` (filter by `type: heuristic`) |
| Read a domain landscape | `intelligence/*-landscape.md` |
| Read about a client engagement | `engagements/{client_alias}/index.md` |
| Read an audit deliverable | `engagements/{client_alias}/deliverables/` |
| Adjust system behavior | `ops/config.yaml` |
| Understand why the system is configured this way | `ops/derivation.md` |
| See pending tasks | `ops/queue/tasks.md` |
| See past session transcripts | `ops/sessions/` |

**Where to start a new audit:**

1. Create or update `engagements/{client_alias}/index.md` from the `client-engagement` template
2. Drop the Looker Studio CSV into `engagements/{client_alias}/data/{date}/`
3. Run the audit-draft prompt template at `playbook/prompt-templates/cro-audit-draft.md`
4. Edit the resulting draft, ship to the client, then push new heuristics back into `intelligence/`
