---
name: refine-scope
description: Explicit-only interview for refining the scope of a plan, decision, or idea before implementation. Use only when the user invokes refine-scope or directly asks to refine scope.
disable-model-invocation: true
---

Interview the user relentlessly until you reach a shared understanding. Map this as a **design tree**: every decision branches into the decisions that hang off it.

Work the tree in **rounds**. The **frontier** is every decision whose prerequisites are already settled: the questions you can ask _now_ without guessing at answers you haven't heard yet. Ask the whole frontier in one round: number each question and give your recommended answer. Then wait for the user's answers before the next round.

Use the host's structured question tool when it has one. Otherwise use a numbered Markdown list. In either format, give the recommended answer with each question.

Each round the user answers reshapes the tree: settled decisions push the frontier outward and unblock questions that depended on them. Recompute the frontier and ask the next round. A question whose answer depends on another question still open in this round belongs to a _later_ round, not this one.

Finding _facts_ is your job, never the user's. When a frontier question needs a fact from the environment, investigate it with the available tools; use a sub-agent only when the added cost is justified. Do not ask the user for anything you could find yourself. The _decisions_ are the user's: put each to them and wait.

The session is done when the frontier is empty: every branch of the design tree visited, nothing left silently assumed. Present a compact agreed brief covering the goal, in-scope and out-of-scope work, settled decisions, acceptance conditions, and anything deliberately deferred. Do not act on it until the user confirms you have reached a shared understanding.
