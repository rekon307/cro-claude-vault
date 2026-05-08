# Prompt Template: CRO Audit Draft

This is the prompt the consultant invokes when they have a Looker Studio export ready and want a structured audit draft against the vault. The vault's `CLAUDE.md` is loaded as the system prompt; this is the user-message input.

---

## Prompt

```
Run the export-to-report workflow against the data and engagement below.

## Engagement

Client alias: {client_alias}
Vertical: {vertical}
Primary goals: {primary_goals}
Key constraints: {key_constraints}
Data access: {data_access}

## Data export

Source: {source_name, e.g. "Looker Studio dashboard 'Acme Q2 Funnel'"}
Date range: {start} to {end}
Sample size: {n}
Segments included: {segments}

[CSV data pasted below, or attached as file]

{paste CSV here}

## Task

1. Run the instrumentation check. If anything is off, the first finding is the instrumentation gap.
2. Anchor the data (date range, sample size, segments, quality caveats).
3. Walk through frameworks/audit-checklist.md and produce findings in priority order.
4. For each finding:
   - State the observation with the data slice that supports it
   - Cross-reference the relevant vault heuristic by [[wiki-link]]
   - Recommend a test (hypothesis, variant, primary metric, MDE, sample size, runtime) where applicable
   - Label confidence: directly-measured, inferred-from-data, or heuristic-only
5. Produce the audit draft in this structure:
   - Executive summary (5-7 bullets)
   - Findings in priority order
   - Recommended tests
   - Open questions
   - Out of scope

## Constraints

- Cite the data source for every quantitative claim
- Cite the vault heuristic for every qualitative claim
- Do not invent benchmark numbers
- Mark any heuristic-only claim explicitly so I can rewrite or remove it before delivery
- If the data does not support a finding I would have expected, say so explicitly

Write the draft to engagements/{client_alias}/deliverables/{date}-audit-draft.md.
```

---

## Notes for the consultant

- This prompt is intentionally rigid. The rigidity is what produces consistent output across engagements.
- The first time you run it on a new client, the output will surface gaps in the engagement file (missing constraints, missing data access detail). Fix those in the engagement file, then re-run.
- The "Out of scope" section is non-optional. Clients re-read it more often than the executive summary.
- If a finding lands without a `[[wiki-link]]` to a heuristic, that is a flag: either add the heuristic to the vault or treat the finding as speculative.

See the demo deliverable at `engagements/_example-client/deliverables/2026-05-08-audit-draft.md` for the output shape.
