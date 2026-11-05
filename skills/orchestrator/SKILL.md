---
name: orchestrator
description: Execute a phased implementation plan as orchestrator, with one subagent per numbered change, diff review, Jujutsu changes, and phase gates.
disable-model-invocation: true
---

# Orchestrator

Run only when the user explicitly invokes this skill.

You are the orchestrator for a written, phased plan. Subagents implement. They
edit files and report back to you. You review their actual diff, never only
their summary, then accept it, fix it, or escalate to the user.

## Before starting a session

1. Read `.agents/orchestrator/repo.md` in the repository root. It holds the
   check commands, boundaries, code rules, plan location and blast-radius
   hotspots for this repository. If it is missing, stop. Offer to draft it from
   [references/repo-template.md](references/repo-template.md) and wait for the
   user to approve the draft.
2. Read the plan's README or overview, its "Decided gate items", and the next
   phase file.
3. Pick every language reference that matches the code the phase touches:
   [references/typescript.md](references/typescript.md),
   [references/python.md](references/python.md) or
   [references/rust.md](references/rust.md). A Tauri change usually needs both
   Rust and TypeScript. If none matches, say so and rely on `repo.md` alone.

## Roles

- Do small mechanical fixes yourself. Send anything substantive to a subagent.
- The user reviews every line by hand. Code must be high quality and
  straightforward to read. Ask early rather than guess, and err on the side of
  caution.

## Subagents

- One subagent per numbered change, Claude Opus or Codex Sol, at low or medium
  effort.
- Use high effort only for a particularly complex change or after a subagent
  has failed, and ask the user first. Record each approval in the plan README.
- Subagents can't always load skills, so they work from files. Every prompt
  starts by telling the subagent to read these in full:
  - `~/.agents/skills/orchestrator/references/subagent-brief.md`
  - each matching language reference in the same directory
  - `.agents/orchestrator/repo.md`
- For a risky change, also point it at `~/.agents/skills/blast-radius/SKILL.md`
  and the hotspots section of `repo.md`.
- After the reading list, each prompt gives:
  - the change number and its plan section;
  - the files to read and the sibling code to follow;
  - the user decisions that apply;
  - acceptance criteria, one per line;
  - explicit stop conditions;
  - the focused checks to run.
- Tell the subagent to trust the code over plan names where they differ.
- A subagent cannot ask you a question mid-task. A field you cannot fill means
  the change is not scoped yet; resolve it before spawning.
- For a second attempt, start a fresh subagent with the same reading list, the
  consolidated scope and what went wrong. Don't resume the failed one.
- When a subagent stops on a condition, bring it to the user with a
  recommendation. Don't work around it.

## Version control (jj)

- This workflow is an exception to any repository rule that reserves mutating
  `jj` commands for the user, and to `commit` being user-invoked. The user has
  approved you creating new changes, and nothing else.
- Write descriptions with the message rules in the `commit` skill
  (`~/.agents/skills/commit/SKILL.md`) and the repository's
  `docs/git-conventions.md`. Take the message rules only, not its `jj commit`
  step.
- The only mutating command you may run is `jj new -m "<description>"`. One
  change per numbered plan change, created before delegating. Use the
  description the phase file gives when it has one. No bookmarks.
- Never modify an existing change. No `jj describe`, `jj edit`, `squash`,
  `rebase`, `abandon` or `split`. The user does the squashes. The working-copy
  change you just created can take file edits while it is still unreviewed;
  once you move on, it is an existing change.
- Fixes to an existing change, a subagent's or your own, go in a new change at
  the top of the stack. Prefix it `SQUASH` and name the target in the body,
  using the target's area marker:
  `jj new -m "SQUASH <marker> fix: <what>" -m "Squash into <change id>"`.
- If a change you created ends up empty, leave it and list it in the gate
  report.

## Flow

1. Explain before acting. After any user decision, say how it changes the plan
   and wait for an explicit go before editing or launching agents.
2. For each change, create the jj change, delegate, review the diff, run the
   focused checks from `repo.md`, then accept or fix.
3. Before each gate, run the full checks from `repo.md`. Then get a fresh-eyes
   review of the whole phase diff from a read-only reviewer subagent. Give it
   the known and accepted items so it doesn't re-report them. Verify each
   finding yourself before reporting it.
4. Stop at every phase gate. Stop earlier if a change hits a problem.
5. The gate report covers:
   - the change list;
   - check results;
   - SQUASH changes and their targets;
   - empty changes;
   - decisions needed, each with your recommendation;
   - user-run steps such as manual review or testing;
   - unrelated issues found along the way, reported and not fixed.
6. Record the gate's decisions in the plan README under "Decided gate items",
   update the phase files those decisions affect, and mark the phase status.
7. Start a fresh session at a phase boundary.

## Writing

NZ spelling, em dashes sparingly, no stock AI phrasing. Apply the `unslop`
skill to reports. Answer the point first.
