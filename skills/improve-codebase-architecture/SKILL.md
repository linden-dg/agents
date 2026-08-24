---
name: improve-codebase-architecture
description: Explicit-only read-only scan for high-value opportunities to deepen modules and improve interfaces, ownership, testability, and navigability. Use only when directly invoked.
disable-model-invocation: true
---

# Improve Codebase Architecture

Find architectural friction and propose a short ranked set of deepening opportunities. Do not edit the repository, create domain documentation, or record decisions during discovery.

Read [references/codebase-design/SKILL.md](references/codebase-design/SKILL.md) for the shared vocabulary. Consult its linked references only when the task needs them.

## 1. Choose the scan scope

Use the module, subsystem, or pain point the user named. Otherwise inspect recent history to identify code that changes repeatedly, then choose a bounded scan area. Widen the scan only when there is no meaningful hotspot.

Read applicable repository guidance, domain glossaries, ADRs, implementation, call sites, and tests. Treat documented decisions as evidence, not immutable law.

## 2. Look for material friction

Explore the selected area and ask:

- Does understanding one concept require jumping through many shallow modules?
- Is an interface nearly as complex as its implementation?
- Do multiple modules own the same rule or leak details across a seam?
- Are callers coordinating steps that one deeper module should own?
- Is important behavior hard to test through a stable public interface?
- Would deleting a suspected shallow module concentrate complexity, or merely move it?

Do not recommend abstraction for stylistic consistency, hypothetical reuse, or line-count reduction. Prefer clear local code when it already has good ownership and locality.

## 3. Validate candidates

Check each candidate against current source and real usage. Reject or narrow findings that misunderstand intentional behavior, duplicate another finding, or only relocate complexity.

For every accepted candidate, provide:

1. Files and current ownership.
2. Concrete evidence of friction.
3. The proposed deeper module or seam, without prematurely fixing its full interface.
4. Expected improvements to locality, leverage, and testing.
5. Risks, constraints, and conflicts with existing decisions.
6. Recommendation strength: `Strong`, `Worth exploring`, or `Speculative`.

## 4. Report and hand off

Return a concise Markdown report ranked by value, confidence, effort, and blast radius. Include a top recommendation and explain why it should go first.

Do not generate or open HTML by default. If the user requests a visual report, or a diagram would materially clarify several relationships, recommend the external Plannotator visual plugin.

After the user selects a candidate, recommend that they explicitly invoke `refine-scope` to settle constraints and decisions, then `architect` to design the interface and ownership. Do not invoke either explicit workflow automatically.
