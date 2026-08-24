---
name: canon
description: Explicit-only workshop for creating or revisiting docs/CANON.md through a focused interview about stable project language. Use only when the user invokes canon or asks to develop the project's canon.
disable-model-invocation: true
---

# Canon

Create or revise `docs/CANON.md`, the project's small set of authoritative definitions.

It is intentionally narrower than a scratchpad or decision log.

## Keep the bar high

A canon entry belongs only when it is:

- specific to this project;
- likely to matter in later conversations;
- needed to resolve a real ambiguity;
- stable enough to state in one or two sentences.

Do not record implementation details, plans, task status, open questions, preferences, conversation summaries, general programming terms, or architectural decisions. Report those separately when they arise.

Keep the file sparse. Update or remove an existing definition instead of appending a competing interpretation. Do not add a term merely because it appeared in the conversation.

## Inspect before asking

Read `docs/CANON.md` if it exists. Inspect relevant code, tests, and project documentation for how the terms are currently used. Find facts yourself; ask the user only for meanings and decisions that the repository cannot settle.

For an initial canon, start with terms the user named. If none were named, propose a small candidate set from genuinely ambiguous project language and confirm the scope before interviewing. Do not catalogue every domain noun.

For a revision, identify the entries or contradictions under review. Preserve unaffected definitions.

## Interview in rounds

Treat unresolved definitions and relationships as a decision tree. In each round, ask every question whose prerequisites are already settled. Give a recommended answer for each question, based on repository evidence when available. Use the host's structured question tool when it has one; otherwise use a numbered Markdown list.

When a question depends on an unsettled answer, leave it for a later round. When the user's wording conflicts with the existing canon or code, show the conflict and ask which meaning is authoritative. Do not assume that either the file or implementation automatically wins.

Finish when the in-scope terms have precise meanings, important exclusions are clear, and no definition depends on an unanswered question.

## Draft the canon

Use this shape:

```md
# Canon

Stable definitions for project-specific language.

This is not a scratchpad, specification, decision log, or project history.
Only change it when the user explicitly asks to record or revise a definition.

## Language

**Account**

An organization that owns billing and data. It does not mean an individual login.

_Avoid:_ Tenant, customer account
```

Use singular canonical terms. Include `_Avoid_` only when a competing word causes real confusion. Add subheadings only when the canon has natural groups.

Show the complete proposed file or a focused diff before writing. Wait for explicit approval, then create or update only `docs/CANON.md`.

## Make it discoverable

After writing the canon, check existing agent instruction files. If an existing `AGENTS.md` or `CLAUDE.md` does not point to the canon, offer this one-line addition and wait for separate approval:

> Read `docs/CANON.md` when domain terminology is relevant. Use its definitions, and never modify it unless the user explicitly invokes `canon` or asks to record or revise a definition.

Do not create a new agent instruction file as part of this workflow.

Finish with the terms added, changed, or removed, plus any unresolved candidates deliberately left out.
