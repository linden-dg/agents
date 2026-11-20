---
name: prepare-orchestration
description: Turn an agreed brief or draft plan into phased, numbered changes with a model and effort for each, ready for the orchestrator skill.
disable-model-invocation: true
---

# Prepare orchestration

Run only when the user explicitly invokes this skill.

Turn an agreed brief into a plan the `orchestrator` skill can run: phases that
end in gates, numbered changes that each become one Jujutsu change, and a model
and effort for every change. The plan is the deliverable. Do not implement.

The usual sequence is `refine-scope`, then `architect`, then this skill. The
input is the agreed brief plus the design from `architect`, or a draft plan or
written spec. If the goal or scope is still vague, recommend `refine-scope`.
If the work is non-trivial and has no agreed design, recommend `architect`.
Don't do either job at length here.

## 1. Read

- `.agents/orchestrator/repo.md` in the repository root. If it is missing,
  offer to draft it from
  `~/.agents/skills/orchestrator/references/repo-template.md` and wait for the
  user to approve the draft.
- The nearest `AGENTS.md` or `CLAUDE.md` for each area the work touches,
  the brief, and the design.
- `docs/git-conventions.md` when present. Its area markers, such as one emoji
  per app or package, are the repository's own map of its logical sections.
  If it is absent, read recent `jj log` descriptions for the same pattern.

## 2. Explore

Find the facts yourself; never ask the user for something the code can tell
you. Locate the affected code, the sibling code each change should follow,
existing contracts, and where the tests live. Use a read-only subagent when the
search spans many areas, and keep only its conclusions.

Note where the brief or design and the code disagree. These become questions
in step 5, not silent choices. If a disagreement means the design itself is
wrong, such as an ownership rule or a contract that can't hold, recommend
going back to `architect` rather than redesigning while splitting the work.

## 3. Break the work down

- **Changes.** Each numbered change is one logical change the user can review
  on its own. Aim for one function or type plus any test it warrants, or one fix,
  usually two or three files. Split a change that mixes several behaviours.
- **Areas.** Each change has one honest primary area marker, since its
  description takes exactly one. Work that spans areas usually splits along
  marker boundaries. Keep it together only when splitting would leave a
  change that fails its checks on its own, and name the primary area.
- **Order.** Follow the design. Its types, interfaces and contracts land
  before the code that uses them. Where the design doesn't fix the order, let
  the area dependencies decide it, such as schema and database before the
  services that use them, and services before the app UI. Each change ends in
  a check that proves it.
- **Trace.** Every part of the design lands in some change. Name any part
  that doesn't, and say whether it is deferred.
- **Phases.** Group changes into phases that end at a gate. Put a gate where
  the user needs to review, decide something, or run a step only they can run,
  such as a migration or a manual test.
- **Numbering.** `<phase>.<change>`, such as `2.3`. The orchestrator and the
  user refer to changes by these numbers.
- **Risk.** Flag changes that need a blast-radius check, using the hotspots in
  `repo.md`, in the change's "Read first".

For each change, work out everything the orchestrator's prompt needs. A field
you can't fill means the change isn't scoped yet. See
[references/plan-format.md](references/plan-format.md).

## 4. Assign model and effort

- List the models the host actually offers. On T3 Code, query
  `orchestrator_capabilities`. Otherwise use the models the user names. Never
  invent a model ID.
- Effort:
  - **Low.** Precisely specified work that follows an existing pattern onto
    settled contracts.
  - **Medium.** New logic, judgement calls, or changes whose correctness
    depends on rules the subagent has to apply.
  - **High.** Only with a recorded reason and the user's approval. Never above
    high.
- The "Effort guidance" section of `repo.md` refines these for the repository
  and takes precedence.
- If low looks insufficient because a contract is missing, resolve the
  contract in an earlier change rather than raising the effort.
- Give each assignment a one-line reason.

## 5. Confirm with the user

Present:

- a table of every change: number, description, model, effort, reason,
  depends on;
- the phases and what each gate asks of the user;
- open questions and brief-versus-code conflicts, each with your recommended
  answer;
- decisions whose cost is out of proportion to how they were stated, if any.
  Trace each decision to the changes, files, new concepts, contracts and
  user-run steps it causes. Flag only the outliers, as: the decision, what it
  costs, the simpler option, and what the user would lose. The user chooses.
  Raising a cost is new information, not reopening the decision.

Wait for answers. Revise and present again until the user confirms the
breakdown. Do not write plan files before that.

## 6. Write the plan

Write the files in the plan location `repo.md` gives, following
[references/plan-format.md](references/plan-format.md). Record every decision
the user made during step 5 in the README. Save the agreed design as
`design.md` in the plan directory, as given, so subagents can read it; it
often exists only in the conversation.

Do not create jj changes, start implementation subagents, or edit code.

## 7. Hand back

Give the plan path, the phase and change counts, the user-run steps, and any
deferred items. The next step is `orchestrator`.

## Writing

NZ spelling, em dashes sparingly, no stock AI phrasing. Apply the `unslop`
skill to the plan files and the reply.
