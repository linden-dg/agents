---
name: competitive-workflow
description: "Explicit-only competitive workflow that runs independent attempts against one settled brief, selects a base, incorporates the strongest parts, and verifies the result. Use only when the user invokes competitive-workflow or directly requests competing attempts."
disable-model-invocation: true
---

# Competitive workflow

Fan out N parallel attempts at the same task. Read every candidate end to end. Pick the strongest as the base. Graft the best ideas from the others into it. Verify the synthesized result.

## Start

Create a task list with one entry per phase before launching anything. The workflow runs autonomously and the list keeps phases from silently disappearing.

1. Frame
2. Fan out
3. Cross-judge when explicitly requested
4. Pick
5. Graft
6. Verify

## Phase A: Frame

The N candidates will receive the same prompt, so the prompt is the contract. Get it right before spawning anything.

1. State the artifact each candidate is producing.
2. Derive the rubric. State what success looks like for *this* task, then turn it into 3-6 concrete gradeable criteria. Concrete: `Adds a --dry-run flag that skips writes`. Vague: `code is correct`. The rubric is the picker's tool in Phase D; candidates only see the task.
3. Pick the runners. Default to two available subagents. Respect a candidate count the user supplied, but never increase it autonomously. Prefer different model families when the host exposes that choice; using the same model twice is acceptable.
4. Assign output paths. Each candidate writes to its own location, using a separate worktree when possible or a distinct temporary directory otherwise. Never let candidates write to shared mutable state.

## Phase B: Fan out

Spawn all N subagents in parallel, each with the task, the path to the shared grounding, its own output path, and instructions to produce both the artifact and a short rationale.

The rationale is mandatory. Without it, the parent cannot tell whether a candidate's structure is principled or accidental, which makes Phase E grafting unreliable. Each rationale names the alternatives the candidate considered and what it rejected.

If a candidate fails to produce output, proceed with N-1 and note the dropout in the synthesis record.

## Phase C: Cross-judge

Skip cross-judging by default; the parent judges the candidates. Run one read-only judge only when the user explicitly requests cross-judging. Prefer a different model family when the host exposes that choice. The judge sees the rubric and completed candidates by path label, scores each criterion, and recommends a base with rationale. Do not start it while candidates are still writing.

## Phase D: Pick a base

Read every candidate end to end before picking. Skimming N candidates surfaces only the candidate whose surface looks most familiar.

Score each candidate against the rubric criterion by criterion, not on holistic feel. If a cross-judge ran, compare its assessment with the parent's and resolve disagreements against the evidence and rubric.

Pick the candidate a future maintainer can extend most easily without breaking invariants. Prefer the cleaner boundary or smaller surface area when two feel tied.

Record the pick and the reason in a short synthesis note alongside the base artifact. Include the cross-judge's verdict only if one ran.

## Phase E: Graft

Walk each losing candidate once more and identify what is worth porting into the base. The signal is usually one or two things per candidate, not most of it.

Fold each graft in deliberately. Do not paste mechanically. The result has to remain coherent under one mental model.

Record what was grafted, from which candidate, and what was rejected and why. The rejection notes are the highest-signal part of the record. Future readers learn from what you considered and dropped, not just what you kept.

When N candidates converge on the same shape, that is a strong agreement signal. Note the convergence in the record and ship the consensus shape. No graft is needed. When N candidates wildly diverge, Phase A was under-specified. Reframe and re-run rather than averaging the divergence.

## Phase F: Verify

Apply `prove-it-works` to the synthesized artifact. The competition does not earn you a pass.

If verification surfaces a problem the competition did not catch, either Phase A was wrong (re-frame and re-run) or one candidate caught it and you missed the graft (go back to Phase E). Don't paper over.

## Outputs

One synthesized artifact. One short synthesis note alongside, naming the base, the grafts (with source candidate), the rejections, the dropouts if any, and the verification result.
