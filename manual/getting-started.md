---
description: First session guide - orienting, creating your first insight, building your first connection
type: manual
---

# Getting Started

This is the first thing to read after you have the vault installed and Claude Code running against it.

## What to expect in your first session

When you start a Claude Code session in this folder, the SessionStart hook reads:

- `self/identity.md`, `self/methodology.md`, `self/goals.md`, `self/relationships.md`
- `ops/reminders.md` (overdue items surfaced first)
- `ops/derivation.md` (so the agent knows the configuration rationale)
- `ops/queue/tasks.md` (pending pipeline + maintenance tasks)
- `ops/observations/` and `ops/tensions/` (counts, with threshold warnings if applicable)

The agent will report back with: who I am, what I am working on, and what is overdue. That is the orient phase.

## Creating your first insight

Use the `templates/insight.md` template. Required fields: `description`, `type`, `domain`, `meta_state`, `created`.

Insight title format: prose-as-title. Not "checkout abandonment" but "checkout abandonment is steepest from cart to address, not address to payment". The title carries the proposition; the body shows the evidence.

Body format: 150-400 words. Show the reasoning. Use connective words (because, but, therefore, however). Do not just state the conclusion.

Footer: `Source:` (where the claim comes from), `Relevant Notes:` (at least one related insight), `Topics:` (at least one landscape).

The write-validate hook checks frontmatter on save. If you forget a required field, you will see a warning.

## Building your first connection

Connections are wiki links: `[[insight-title-without-extension]]`.

When you write a new insight, link it to:

1. **At least one landscape.** Add the link in the `Topics:` footer.
2. **At least one related insight.** Add the link in the `Relevant Notes:` footer with a brief annotation explaining what the relation contributes.

If the connection is cross-domain, label it explicitly: `[[other-insight]] - [CROSS-DOMAIN: domain-A -> domain-B]`. The cross-domain label surfaces during landscape review and prevents accidental siloing.

After writing, update the relevant landscape's "Core Intelligence" list to include the new insight.

## The session rhythm

Every session follows this structure:

1. **Orient** (auto, via SessionStart hook): read self, reminders, queue, friction signals
2. **Work**: process incoming exports, write findings, update insights, run `/extract` / `/connect` / `/verify`
3. **Persist** (auto, via SessionEnd hook): archive transcript, commit changes, surface seed-candidate sessions for next session

If you feel like the agent is missing context, the orient phase needs more in `self/`. If you feel like the agent is repeating itself, the persist phase is not capturing what should have been captured. Both are tunable.

## Where to go next

- [[skills]] - every command available
- [[workflows]] - the pipeline in detail
- [[configuration]] - how to adjust the system
