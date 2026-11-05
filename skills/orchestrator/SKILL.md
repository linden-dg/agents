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
2. Read the plan's README, its change table, its "Decided gate items",
   `design.md` when present, and the next phase file. Plans written by
   `prepare-orchestration` have this shape. If the plan has no model and
   effort per change, stop and offer to run `prepare-orchestration` first.
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

- One subagent per numbered change, using the model and effort the plan
  assigns it. Any deviation, such as high effort after a failed attempt, goes
  to the user first. Record each approval in the plan README.
- Work in the main workspace. Run one editing subagent at a time, and no
  worktrees unless the user asks for one.
- Subagents can't always load skills, so they work from files. Every prompt
  starts by telling the subagent to read these in full:
  - `~/.agents/skills/orchestrator/references/subagent-brief.md`
  - each matching language reference in the same directory
  - `.agents/orchestrator/repo.md`
- For a risky change, also point it at `~/.agents/skills/blast-radius/SKILL.md`
  and the hotspots section of `repo.md`.
- After the reading list, each prompt gives:
  - the change number and its plan section, plus `design.md` when the plan
    has one;
  - the files to read and the sibling code to follow;
  - the user decisions that apply;
  - accepted prior contracts and deviations from earlier changes, since a
    subagent can't see its siblings' work;
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
- The only mutating command you may run is `jj new`. One change per numbered
  plan change, created before delegating. Use the description the phase file
  gives when it has one. No bookmarks.
- Before the first `jj new` of a session, run `jj status` and `jj log`. If `@`
  holds edits that aren't part of the plan, stop and ask the user how to
  proceed. Never sweep them into a plan change.
- Create each change on the accepted stack head with
  `jj new <head> -m "<description>"`, and record its stable change ID. Review
  and report by that ID, never by whatever `@` points to after a subagent has
  run.
- Never modify an existing change. No `jj describe`, `jj edit`, `squash`,
  `rebase`, `abandon` or `split`.
  The user does the squashes. The working-copy change you just created can take
  file edits while it is still unreviewed; once you move on, it is an existing change.
- Fixes to an existing change, a subagent's or your own, go in a new change
  inserted directly after the change they fix, with a description that starts
  with `SQUASH`.
  - Each SQUASH change targets exactly one change, and names that change ID in
    its subject or body. Fixes for two changes go in two SQUASH changes, so the
    user never has to split one.
  - If a SQUASH change introduces conflicts in later changes, resolve them with
    another SQUASH inserted after the conflicted change, working from the bottom up.
  - The rest of the description follows the repository's conventions and uses
    the target's area marker, for example
    `jj new --insert-after <change id> -m "SQUASH <marker> fix: <what>" -m "Squash into <change id>"`.
  - Create a SQUASH change only when there is a fix to make.
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
4. Stop at every phase gate. Stop earlier if a change hits a problem, or
   grows past its plan because of a decision, such as a new concept, a
   contract change or work in another area. Show the user what the decision
   now costs and the simpler option before continuing.
5. When the user changes scope mid-phase, edit the affected README decision
   line and phase sections in place before the next change starts.
6. The gate report covers:
   - the change list;
   - check results;
   - SQUASH changes and their targets;
   - empty changes;
   - decisions needed, each with your recommendation;
   - user-run steps such as manual review or testing;
   - unrelated issues found along the way, reported and not fixed.
7. Record the gate's decisions in the plan README under "Decided gate items",
   update the phase files those decisions affect, and mark the phase status.
8. Start a fresh session at a phase boundary.

## Writing

NZ spelling, em dashes sparingly, no stock AI phrasing. Apply the `unslop`
skill to reports. Answer the point first.
