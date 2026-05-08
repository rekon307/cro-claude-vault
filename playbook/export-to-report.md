# Export-to-Report Workflow

This is the procedure that turns a Looker Studio export plus a CRO engagement into a structured audit draft. It is the workflow Claude follows; it is also the workflow the consultant runs end-to-end.

## When to run this

- Start of a new engagement (intake -> first audit draft)
- Mid-engagement, when new data lands (e.g. a fresh month of GA4 data)
- Before a recurring report cycle (monthly check-in, retainer deliverables)

## Inputs

1. **Engagement context** - the engagement file at `engagements/{client_alias}/index.md`. If it does not exist, create it from `templates/client-engagement.md` first.
2. **Data export(s)** - one or more CSVs from Looker Studio, dropped into `engagements/{client_alias}/data/{date}/`
3. **The relevant landscape MOCs** - Claude reads these as part of the standard CLAUDE.md load order

## Steps

### Step 1. Anchor the engagement

Open or create `engagements/{client_alias}/index.md`. Confirm:

- Vertical
- Primary goals (the client's, in their language)
- Key constraints (brand voice, dev resources, test platform, prior tests)
- Data access (what GA4 property, what Looker dashboards, what session-replay tool)

If any of these are missing, ask the consultant before running the audit. An audit run on guessed context is not deliverable.

### Step 2. Instrumentation check

Before any analysis, confirm the funnel data is trustworthy:

- Are `begin_checkout`, `add_shipping_info`, `add_payment_info`, `purchase` all firing?
- Is mobile data segmentable?
- Is session-replay coverage active on funnel pages?

If any answer is no, the first finding in the audit is the instrumentation gap. Findings built on broken data go in a separate "blocked by instrumentation" section.

### Step 3. Anchor the data

For each export, write down:

- File name and date range
- Sample size (n=)
- Segments included and excluded
- Any obvious data quality issues (e.g. one day with anomalous traffic from a campaign launch)

This anchor block goes at the top of every audit draft. Without it, claims downstream are not citable.

### Step 4. Run the audit checklist

Walk through `frameworks/audit-checklist.md` in order. For each section:

1. Pull the relevant slice of data from the export
2. Cross-reference against the relevant landscape's heuristics
3. Write a finding only if the data plus a heuristic together support a claim
4. Mark each finding with confidence (`directly-measured`, `inferred-from-data`, `heuristic-only`)

### Step 5. Generate the audit draft

Use the prompt template at `playbook/prompt-templates/cro-audit-draft.md`. The output goes to `engagements/{client_alias}/deliverables/{date}-audit-draft.md`.

Structure:
- Executive summary (5-7 bullets)
- Findings in priority order (each finding cites data source and vault heuristic)
- Recommended tests
- Open questions
- Out of scope

### Step 6. Consultant review and edit

The draft is a draft. The consultant reads it, rewrites the framing, removes `heuristic-only` claims that do not survive review, and ships the final deliverable to the client. Any new heuristics or patterns surfaced during review go back into the vault using the templates.

### Step 7. Update the vault

After the deliverable ships:

- New heuristics -> `frameworks/heuristics/`
- New patterns -> `intelligence/`
- Engagement state -> update `engagements/{client_alias}/index.md` (status, linked findings, linked tests)
- If the engagement surfaced a tension that contradicts an existing heuristic, mark the existing note `meta_state: stale` and link forward to the new one

## Outputs

- `engagements/{client_alias}/deliverables/{date}-audit-draft.md` - the consultant edits and ships
- `engagements/{client_alias}/findings/*.md` - the structured findings
- `engagements/{client_alias}/tests/*.md` - the recommended tests
- Updated landscapes and heuristics if anything new surfaced

## Reproducibility check

The workflow passes when:

- Re-running the same export produces the same draft (no LLM drift on labeled findings)
- Every claim in the draft has a citation
- No `heuristic-only` claim is stated as fact
- The instrumentation check ran first

If any of these fail, the procedure has drifted and should be re-tightened.
