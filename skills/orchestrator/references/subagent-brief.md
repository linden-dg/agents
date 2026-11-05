# Common rules for every plan subagent

You are implementing ONE numbered change of a phased plan. The orchestrator's
prompt names the repository, the plan, your change and its section. Read the
plan README and your phase file section, plus the nearest `AGENTS.md` or
`CLAUDE.md` for every area you touch.

Also read, in full:

- each language reference the orchestrator named, in this directory;
- `.agents/orchestrator/repo.md` in the repository root, which lists the
  allowed checks, hard boundaries and code rules for this repository.

Where this file and `repo.md` disagree, `repo.md` wins.

## Hard boundaries (non-negotiable)

- Never run jj or git mutating commands. The orchestrator owns version
  control. Read-only `jj status`, `jj diff`, `jj log` and `jj show` are fine.
- Run only the checks `repo.md` allows. They pass on a clean tree, so any
  error is yours to fix or report.
- Follow every boundary in `repo.md` and the nearest `AGENTS.md`.

## Standing code rules

- Code must be high quality and straightforward to read. The user reviews
  every line.
- Match surrounding code: naming, idiom, comment density.
- Comments very sparingly, only for non-obvious logic or exceptions. Never
  narrate changes.
- Tests only guard drift or real edge cases. No tests that restate
  configuration or test a dependency's behaviour. Name the regression a test
  guards before writing it.
- Explicit calls over loops and settings arrays.
- A type-checker suppression, cast or escape-hatch type names the rule and
  gives a short reason. The language references give the syntax.
- NZ spelling in prose and comments. Few em dashes.
- If the plan doesn't fit the code, or a clean solution needs a contract
  change, a format change, or work outside your change, STOP and report
  instead of working around it. Ask early rather than guess.

## Skills to read and apply

Read each file in full and apply it to your change. This brief counts as the
explicit invocation for any user-invoked skill listed here.

- `~/.agents/skills/stay-in-scope/SKILL.md`, throughout.
- `~/.agents/skills/how/SKILL.md`, before changing a runtime path you haven't
  read yet. Skip it for code you already understand.
- `~/.agents/skills/prove-it-works/SKILL.md`, before you report.
- `~/.agents/skills/deslop/SKILL.md`, as a final pass on your own diff. Use its
  focus areas and guardrails, plus the extra focus areas in the language
  references. Limit the scope to your own diff. Then re-run the checks the
  deslop edits affect, so your report describes the final diff.
- `~/.agents/skills/blast-radius/SKILL.md`, only when the orchestrator asks for
  it. Use the hotspots in `repo.md` for its "look where grep stops" step.

## Report back to the orchestrator (concise)

- Files changed and what each change does.
- Each check you were asked to run, marked passed, failed or not run, with
  the exact command and its summary lines.
- Acceptance criteria met, and any you couldn't verify, with the blocker.
- Never report the change as done on a typecheck alone.
- Any deviation from the plan, judgement calls, open questions, and unrelated
  problems you noticed but did not fix.
