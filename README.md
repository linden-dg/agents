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
| `wizard` | Build an interactive script for setup steps only a human can perform. |

## User-invoked skills

These run only when requested. This keeps expensive, interactive, or highly opinionated workflows from taking over ordinary tasks.

| Skill | Purpose and cost |
| --- | --- |
| `bruh` | Restate the last message in plain human language, with no jargon. |
| `commit` | Describe and finalize the current Jujutsu change. |
| `review-changes` | Review a diff separately against repository standards and its spec. |
| `deslop` | Clean a named scope or current diff without changing behavior. |
| `refine-scope` | Turn a vague idea or draft spec into an agreed planning brief. |
| `architect` | Design types, ownership, interfaces, and flows before implementation. |
| `competitive-workflow` | Run competing attempts, select a base, and incorporate the strongest parts. |
| `prepare-orchestration` | Break an agreed brief into phased changes with a model and effort for each. |
| `orchestrator` | Run a phased plan with one subagent per change, jj changes, and phase gates. |
| `test-seams` | Protect selected public interfaces with behavior tests. |
| `audit-codebase-exhaustive` | Audit every subsystem; potentially high context and subagent cost. |
| `improve-codebase-architecture` | Run a bounded, read-only search for deepening opportunities. |

Plannotator remains an external plugin rather than a copied skill.

See [docs/workflow.md](docs/workflow.md) for how the planning and orchestration skills fit together.

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

Claude reads `disable-model-invocation: true`; Codex reads `policy.allow_implicit_invocation: false` from `agents/openai.yaml`. OpenCode does not currently enforce either field, so user-invoked skills also state the restriction in their bodies.

## Global instructions

The shared writing rules in `globals/AGENTS.md` and `globals/CLAUDE.md` apply
`unslop` to conversation as well as authored documents. Install their symlinks
separately from the skills:

```bash
scripts/setup-globals.sh
```

The script links `AGENTS.md` for Codex and OpenCode, and `CLAUDE.md` for Claude
Code. It refuses to replace existing files or unrelated links. Use `--dry-run`,
`--verify`, or `--remove` to inspect, check, or undo the change. The
`--codex-file`, `--claude-file`, and `--opencode-file` options provide isolated
targets for testing.

## Maintenance

The copied skills are intentionally adapted rather than automatically synchronized. Review upstream changes against the pinned revisions in [THIRD_PARTY_NOTICES.md](THIRD_PARTY_NOTICES.md), then port only changes that fit this collection.
