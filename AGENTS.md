# Agent instructions

## Source discipline

Before creating or substantially changing a skill, inspect comparable skills
from pstack and Matt Pocock's skills. Prefer an established upstream workflow
over inventing one from scratch.

Use `THIRD_PARTY_NOTICES.md` to record the source and pinned revision of copied
or adapted material.

Treat upstream wording and structure as evidence. Preserve them unless a change
is needed for:

- the user's stated workflow;
- Jujutsu rather than Git;
- Codex, Claude Code, or OpenCode compatibility;
- context or subagent cost;
- dependencies that this repository intentionally does not include.

Make the smallest justified adaptation. Do not rewrite a skill merely to make
it feel locally authored. When pstack and Matt offer similar approaches, prefer
the more self-contained one unless the other has a clear advantage.

Do not import a large interconnected skill set to obtain one useful workflow.
Copy only the skill and references needed for that workflow.

Keep `unslop` close to upstream. Apply its writing guidance to skill prose.

## Skill boundaries

Each skill should do one recognizable job. Keep it self-contained where
practical.

Use plain, action-oriented names that indicate what the skill produces or does.
Avoid metaphorical names when they obscure the workflow. Check for collisions
with built-in, installed, and plugin skills before choosing a name.

Keep frontmatter descriptions short. Describe the capability and its scope.
Do not prefix descriptions with `Explicit-only` or repeat invocation policy in
them.

Put detailed instructions in the skill body. Add references only when they
reduce conditional material in the main skill.

## Invocation policy

Classify every skill as model-invoked or user-invoked. A model-invoked skill
may run when a request matches its description. A user-invoked skill runs only
when the user names or selects it; a request that merely resembles its purpose
does not invoke it.

Use model invocation for small, predictable workflows that are broadly useful
and cheap enough to run without a separate decision. Give them narrow
descriptions so they do not trigger on adjacent work.

Use user invocation for workflows that are:

- interactive or highly opinionated;
- a deliberate phase in the user's workflow;
- expensive in context or subagent usage;
- likely to redirect or restructure the work;
- locally mutating commands such as `commit`.

Parallel competitive workflows must be user-invoked. Keep their default agent
count conservative and never increase it automatically.

For user-invoked skills:

- set `disable-model-invocation: true` for Claude Code;
- set `policy.allow_implicit_invocation: false` in `agents/openai.yaml`;
- put `Run only when the user explicitly invokes this skill.` in the body as
  the OpenCode fallback.

## Local workflow preferences

Use Jujutsu as the source-control model. Do not introduce Git-specific commands
or branch assumptions unless the skill explicitly supports Git as well.

Use a focused regression test when a bug has a cheap, correct test path. Use
`test-seams` when the user deliberately selects interfaces worth protecting.

## Repository maintenance

Keep installable skills under `skills/<name>/`.

When adding or renaming a skill:

- update `README.md`;
- update internal skill references;
- update `THIRD_PARTY_NOTICES.md` when attribution changes;
- add the old name to the setup script's retired list;
- keep Claude and Codex invocation metadata aligned;
- verify installation and removal using temporary target directories.

Validate changed skills with the skill validator. The validator does not
recognize Claude's `disable-model-invocation` field, so remove that field only
for the validation pass and restore it immediately afterward.

Do not use Git as the working-copy authority. Use Jujutsu commands, and account
for environments where snapshotting may be restricted.
