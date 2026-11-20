# Workflow

How I use these skills for a piece of feature work, from a loose idea to
reviewed changes. Each step is a separate decision; I don't run them all for
every task.

## 1. Discuss

Start with a loose discussion (often using voice!). Talk around the requirements and
what I want to achieve, often with references to issues (e.g. in Linear). The aim is a
high-level scope, not a detailed plan. This is all read-only, nothing gets edited.

## 2. Refine the scope

Invoke `refine-scope`. This skill interviews me in rounds, with a recommended
answer for each question, until every option has been worked through. It ends
with an agreed brief: goal, in and out of scope, settled decisions, acceptance
conditions and deferred items.

I usually ask the agent to summarise the result, then read it through before
moving on.

> **TIP:** Don't invoke this too early - it'll dive straight into the detail.
> Make sure you have a pretty strong scope before starting refinement.

> **TIP:** Don't hesitate to exit out of this process back to the discussion!
> Quite often during this step I realise I don't have enough context to answer
> the questions, or I feel like the scope has been narrowed too early. If that
> happens, it's best to cancel early and go back to a more freeform discussion.

## 3. Design

Invoke `architect`. It looks at the brief from a technical angle and designs
or mocks the types, interfaces, ownership and flow. It also lists the seams to
protect: the interfaces that get tests worth keeping.

**This is probably the most valuable skill in the workflow**. It produces
code/pseudocode snippets that help me understand what the final shape
will look like. This is where I often catch poor decisions from the earlier steps.

## 4. Decide: ship or park

Look at the brief and design and decide whether the work is ready to go.

- **Park it.** Put the brief and design into Linear and stop.
- **Go.** Decide whether the change is big enough to need orchestration.
  Smaller work skips the next two steps.

## 5. Prepare the plan

Invoke `prepare-orchestration`. It breaks the brief and design into phases
and numbered changes, assigns a model and effort to each change, and confirms
the breakdown with me. Then it writes the plan into the repository, in the
location `.agents/orchestrator/repo.md` gives, including `design.md`.

## 6. Implement the plan

Start a completely fresh session and invoke `orchestrator`. The plan files
carry everything it needs, so none of the earlier conversation comes with it.

The orchestrator creates one jj change per numbered change and hands each to a
subagent. Subagents apply `stay-in-scope`, `prove-it-works` and `deslop` to
their own work, `blast-radius` for risky changes, and `test-seams` for changes
with agreed seams. At each phase gate the orchestrator runs the full checks,
has a fresh reviewer check the phase against the plan and design, and stops
for my review. Start a fresh session at each phase boundary.

## 7. REVIEW THE DAMN CODE

Orchestrator creates small contained changes that are easy to review in a
step-by-step fashion.

> **TIP:** Don't be afraid to challenge the implementation. Quite often you
> made small decisions during planning that you didn't realise the full impact
> of until implementation. Tell the agent to fix things using SQUASH changes,
> and let it resolve conflicts.

## 8. Final pass

Once the plan has been implemented, I'll sometimes get a fresh agent
to do another full pass through with the `review-changes` skill. Tell it
the base to compare against, usually the directly change before the first phase. 
It reviews everything from there to the working copy, and finds the spec in the
plan directory.


## Tips

### Code smells

The `deslop` skill is your friend. Orchestrator subagents already run it on
each change, and outside orchestration you should force the agent to use it
after it makes a change. But don't rely on it - **you are the arbiter of
taste**. In particular watch out for:

- Excessive guarding of edge cases, race conditions etc that are unlikely/
  impossible to happen in production - for example rechecking data shapes or
  types on internal function interfaces when the external seam has already
  guaranteed the shape.
- Excessive testing. Apply a blow torch to tests and force the agent to
  justify each one.
- Names that make no sense. It doesn't matter what the agent says, if a file,
  function, or variable name doesn't make sense to you then it needs a new name.
  Get the LLM to brainstorm names until you find one that fits (or more likely
  throw all the suggestions out and pick your own).

### Audit

Use `improve-codebase-architecture` when an area keeps hurting - you find
yourself constantly modifying, refactoring, or renaming it.

Use `audit-codebase-exhaustive` occasionally for a review of the whole repo.
This skill is a big run, burns tokens, and produces a long report.

Both of these can be intense/dense audits, `bruh` can be your friend here!
