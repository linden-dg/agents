# Plan format

The shape the `orchestrator` skill expects. One directory per plan, in the
location `.agents/orchestrator/repo.md` gives:

```text
<plan-slug>/
  README.md
  design.md
  phase-1-<slug>.md
  phase-2-<slug>.md
```

## README.md

- **Context.** The problem and why now.
- **Scope.** Included, excluded, and deferred. Deferred items will be built
  later, so name them clearly enough that the current work can leave room for
  them.
- **Decisions.** Every settled user decision, one per line. When scope
  changes, edit the affected line rather than appending a new one.
- **Changes.** One table row per change:

  | Change | Description | Model | Effort | Reason | Depends on |
  | --- | --- | --- | --- | --- | --- |

  The description is the suggested Jujutsu description, written to the
  repository's conventions.
- **Phases.** Ordered links to the phase files, each with a status:
  not started, in progress, at gate, or done.
- **Verification.** Plan-specific manual checks and user-run steps. Standard
  checks live in `repo.md`; don't copy them here.
- **Approvals.** Deviations the user approved during execution, such as high
  effort for one change. Starts empty.
- **Decided gate items.** Decisions made at gates. Starts empty.

## design.md

The agreed design from `architect`: usage, types, interfaces, seams to
protect, ownership, module map, flow, alternatives and risks. Copy it as agreed; don't rewrite it.
Omit the file when the plan had no separate design step.

## Phase files

Start with a link back to the README, then:

- **Goal.** What the phase delivers.
- **Gate.** What the user reviews, decides or runs before the next phase.

Then one section per change, headed with its number and title. Description,
model and effort live only in the README table.

- **Depends on.** Earlier changes and the contracts they settle.
- **Read first.** Files to read, the sibling code to follow, and the parts of
  `design.md` this change implements. For a risky change, add the blast-radius
  hotspots from `repo.md` that apply.
- **Changes.** What changes and why, at a high level. No code.
- **Acceptance.** Checkable criteria, one per line.
- **Seams.** The agreed seams this change protects and the behaviours each
  test pins. Omit the field when the change has none.
- **Stop if.** Conditions where the subagent must stop and report instead of
  working around the problem.
- **Checks.** The focused checks from `repo.md` that prove this change.
