# skills/

Skills are documented in `manual/skills.md`. The processing-pipeline skills (`/extract`, `/connect`, `/update`, `/verify`, `/validate`, `/reassess`, `/flag`, `/health`, `/architect`, etc.) are part of the broader Claude Code skill ecosystem and resolve domain vocabulary at invocation by reading `ops/derivation-manifest.md`.

The CRO-specific custom skill `/cro-audit-draft` lives in `playbook/prompt-templates/cro-audit-draft.md` and is invoked as a prompt template against this vault rather than as a separate skill file. The output goes to `engagements/{client_alias}/deliverables/{date}-audit-draft.md`.

To add a new custom skill specific to your CRO practice (e.g. `/heuristic-extract` for converting research papers into vault heuristics), drop a `SKILL.md` file in this folder following the standard skill schema, and update `ops/derivation-manifest.md > vocabulary > cmd_*` to give it a stable command name.
