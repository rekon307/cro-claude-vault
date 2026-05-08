---
description: Why each configuration dimension was chosen for this CRO consulting practice vault
category: derivation-rationale
status: active
created: 2026-05-08
---

# derivation rationale for the CRO consulting practice vault

Eight configuration dimensions decide what kind of system this is. Three of them carry the most weight for CRO work: granularity, processing depth, and schema density. The other five follow.

**Granularity is atomic** because heuristics are atomic by nature ("inline validation on blur, never on keystroke" is one idea), and engagement findings are atomic too ("the cart-to-address step on mobile drops 18% on iOS Safari"). Atomic granularity makes filter-by-domain, filter-by-confidence, and filter-by-vertical work. Moderate granularity would force every audit to re-derive its claims from a long source note, which is the failure mode this vault exists to prevent.

**Processing is heavy** because the workflow is a multi-source pipeline: a Looker Studio CSV plus engagement context plus the heuristic library plus prior findings, all needing to flow through extract → connect → verify → update before producing a structured audit draft. Light processing collapses extraction and connection into a single LLM step, which loses the citation discipline that makes the deliverables defensible.

**Schema is dense** because the audit deliverable is only as defensible as its frontmatter. Every audit-finding carries severity, confidence, domain, client, page_or_flow, sample_size. Every test-result carries hypothesis, MDE, runtime, primary metric. Dense schema is the thing that lets a client read a draft and trust the claims, because each claim is anchored to a sample size, a date range, and a known heuristic.

The remaining dimensions cascade from these three. Atomic granularity demands explicit linking and 3-tier navigation (without the landscape MOC layer, atomic notes become an undifferentiated pile). Heavy processing demands condition-based maintenance (heavy processing generates new heuristic candidates faster than periodic review can catch them). Dense schema demands full automation (write-validate hook enforces what manual review forgets). Single-domain (CRO) means multi-domain off, but the `vertical` field cuts across all the CRO domains so cross-vertical synthesis still works.

## Personality choices

The personality is opinionated and clinical because the consultant's posture is opinionated and clinical. The vault should mirror it: surface tensions, push back on weak findings, refuse to invent benchmark numbers. Warmth would corrupt the deliverable voice. Emotional awareness would pull attention away from the data.

## What was excluded

Multi-domain was not turned on because CRO is a single-domain practice; cross-vertical work happens inside the domain via the `vertical` schema field. Sleep-processing was not turned on because background processing of incoming/ during idle is a useful pattern only when the user is paying attention to alerting; for a CRO consultant whose attention is on the active engagement, idle-time auto-processing risks generating findings the consultant has not asked for. Voice capture was not turned on because the input format is structured (CSVs, screenshots, pasted GA4 tables), not voice memos.

## What this vault is optimized for

- Producing structured audit drafts from Looker Studio exports in minutes, not hours
- Compounding cross-engagement intelligence: a pattern observed in engagement N becomes a heuristic for engagement N+1
- Defensibility: every claim in a deliverable cites both data and a vault heuristic
- Reproducibility: re-running the same export against the same vault produces the same draft

## What this vault is NOT optimized for

- One-off heuristic lookup without a connected engagement (the vault rewards systematic use)
- High-velocity capture without processing (incoming/ has a 7-day stale threshold; if material sits longer it surfaces as a friction signal)
- Solo journaling or reflection (the personality and structure are work-oriented, not personal)

---

Topics:
- [[methodology]]
