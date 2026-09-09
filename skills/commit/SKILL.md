---
name: commit
description: Describe and finalize the current Jujutsu change using the project's commit conventions.
disable-model-invocation: true
---

# Commit

Run only when the user explicitly invokes this skill.

Commit the current Jujutsu change. Use `jj`, never Git commands or Git's index model.

## Read the repository's conventions

Read `docs/git-conventions.md` when it exists. It is authoritative for:

- area markers such as emoji or icons;
- allowed commit types;
- imperative, past-tense, or other subject wording;
- subject length and body rules;
- repository-specific classification guidance.

Read `docs/CANON.md` when it exists so the description uses the project's established language.

If `docs/git-conventions.md` is absent, inspect recent Jujutsu descriptions for an established pattern. Use the shared defaults below only where the repository has no rule. Never invent an area marker. If the repository requires one and no mapping is available, ask the user.

## Inspect the whole change

Inspect `jj status`, `jj diff --summary`, `jj diff`, and the existing description of `@`. Describe everything in the current change, not merely the work from the latest conversation.

Stop if there is nothing to commit. If the change contains unrelated work with no honest primary area or subject, explain the split and ask before running `jj split` or an interactive commit.

## Write the description

Use the repository's format. Unless it says otherwise:

```text
[area marker] [type]: [short description]

[optional body]
```

- Choose exactly one marker for the primary affected area. The marker identifies the area, not the kind of change.
- Copy the marker exactly from the project file, including any Unicode variation selector. Follow it with an ordinary U+0020 space, never a non-breaking space.
- Use the conventional commit type that describes the result:
  - `feat` for a new capability;
  - `fix` for a defect correction;
  - `refactor` for restructuring without a behavior change;
  - `perf` for a performance improvement;
  - `test` for a test-only change;
  - `docs` for a documentation-only change;
  - `style` for formatting without a behavior or visible presentation change;
  - `build` for dependencies or build configuration;
  - `ci` for CI/CD configuration;
  - `chore` for maintenance not covered above;
  - `revert` for reverting an earlier change.
- Use `feat` for an intentional visual change and `fix` for a corrected visual defect. Follow the project file when it uses a different type name, such as `cicd` instead of `ci`.
- Follow the repository's subject mood. If it does not specify one, match recent descriptions. If no pattern exists, use lowercase past tense form.
- Describe the result, not the activity. Do not restate the type and do not add a trailing period.
- Aim for a 20 to 30 character short description. Do not exceed 50 characters unless the project file permits it.

Do not write a paragraph in the body.

Add one only for durable information the diff does not show, such as a tradeoff, non-obvious behavior, or a constraint future work must preserve. Before you write a paragraph body, tell the user two things:
- the one fact the future reader needs
- where the diff does not show that fact

Do not write the paragraph if the fact is already in the change.
Look in the code comments, the docstrings, the variable descriptions
and the docs. Do not write the paragraph to repeat the subject line.

This rule is only about paragraphs. For a necessary cross-area change, keep one primary marker in the subject. The body may use project-defined markers in short bullets for distinct secondary changes.

## Finalize and verify

Run `jj commit -m <description>` to describe `@` and create a new working-copy change on top. If the user asked only for a draft, return the description without running it.

Do not push, move bookmarks, rebase, squash, or perform unrelated cleanup.

Verify the description and contents of `@-`, then check that `@` is the new working-copy change. Report the committed change ID and final description.
