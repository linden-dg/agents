# Agent skills

A small, opinionated skill set shared across Codex, Claude Code, and OpenCode. Skills are kept locally so their invocation rules and dependencies stay predictable.

## Model-invoked skills

These may be selected when their descriptions match the task.

| Skill | Purpose |
| --- | --- |
| `unslop` | Keep model-written prose simple and direct. |
| `stay-in-scope` | Prevent adjacent cleanup and unauthorized redesign. |
| `prove-it-works` | Verify the real artifact before declaring completion. |
| `regression-test` | Add one cheap, focused regression check when a clear seam exists. |
| `diagnosing-bugs` | Build a tight reproduction loop and trace root causes. |
| `blast-radius` | Trace callers, contracts, and downstream effects of a change. |
| `how` | Explain how an existing system works from source evidence. |
| `why` | Recover rationale from code, history, and available context. |
| `code-review` | Review a diff separately against repository standards and its spec. |
| `wizard` | Build an interactive script for setup steps only a human can perform. |

## User-invoked skills

These run only when requested. This keeps expensive, interactive, or highly opinionated workflows from taking over ordinary tasks.

| Skill | Purpose and cost |
| --- | --- |
| `bruh` | Restate the last message in plain human language, with no jargon. |
| `canon` | Create or revisit the stable definitions in `docs/CANON.md`. |
| `deslop` | Clean a named scope or current diff without changing behavior. |
| `refine-scope` | Turn a vague idea or draft spec into an agreed planning brief. |
| `architect` | Design types, ownership, interfaces, and flows before implementation. |
| `competitive-workflow` | Run competing attempts, select a base, and incorporate the strongest parts. |
| `test-seams` | Protect selected public interfaces with behavior tests. |
| `audit-codebase-exhaustive` | Audit every subsystem; potentially high context and subagent cost. |
| `improve-codebase-architecture` | Run a bounded, read-only search for deepening opportunities. |

Plannotator remains an external plugin rather than a copied skill.

## Project canon

Projects may keep a small `docs/CANON.md` for stable, project-specific definitions. It is a glossary, not a scratchpad or decision log. Invoke `canon` to create or revise it; ordinary work may read it but must not update it automatically.

## Install

Run:

```bash
scripts/setup.sh
```

This creates symlinks in both `~/.agents/skills` (Codex and OpenCode) and `~/.claude/skills` (Claude Code). Existing real directories and unrelated symlinks are never overwritten.

Useful variants:

```bash
scripts/setup.sh --dry-run
scripts/setup.sh --verify
scripts/setup.sh --agents-only
scripts/setup.sh --claude-only
scripts/setup.sh --remove
```

Use `--agents-dir PATH` or `--claude-dir PATH` to override a target, including for isolated tests.

Claude reads `disable-model-invocation: true`; Codex reads `policy.allow_implicit_invocation: false` from `agents/openai.yaml`. OpenCode does not currently enforce either field, so explicit-only skills also state the restriction in their descriptions and bodies.

## Maintenance

The copied skills are intentionally adapted rather than automatically synchronized. Review upstream changes against the pinned revisions in [THIRD_PARTY_NOTICES.md](THIRD_PARTY_NOTICES.md), then port only changes that fit this collection.
