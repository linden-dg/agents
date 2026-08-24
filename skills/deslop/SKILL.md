---
name: deslop
description: Remove AI-generated code slop from a named scope or the current diff.
disable-model-invocation: true
---

# Remove AI code slop

Run only when the user explicitly invokes this skill.

Clean the scope the user named. If none was named, inspect the current diff against the repository's detected base branch.

## Focus Areas

- Extra comments that are unnecessary or inconsistent with local style
- Defensive checks or try/catch blocks that are abnormal for trusted code paths
- Casts to `any` used only to bypass type issues
- Deeply nested code that should be simplified with early returns
- Redundant, tautological, implementation-coupled, or language/framework/schema tests that do not protect useful behavior
- Framework anti-patterns supported by local conventions, official guidance, or concrete harm in this codebase
- Other patterns inconsistent with the file and surrounding codebase

## Guardrails

- Keep behavior unchanged unless fixing a clear bug.
- Keep comments and tests that protect a non-obvious contract; simplicity alone is not a reason to delete them.
- Prefer minimal, focused edits over broad rewrites.
- Keep the final summary concise (1-3 sentences).
