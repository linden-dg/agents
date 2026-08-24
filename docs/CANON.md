# Canon

Stable definitions for project-specific language.

This is not a scratchpad, specification, decision log, or project history.
Only change it when the user explicitly asks to record or revise a definition.

## Skills

**Local skill**

A skill owned by this repository under `skills/` and installed through
`scripts/setup.sh`. Its local files are the version that agents follow.

**Model-invoked skill**

A skill the model may select automatically when a request matches its
description. The user may also invoke it by name.

_Avoid:_ Automatic skill

**User-invoked skill**

A skill whose workflow runs only when the user names or selects it. A request
that merely resembles its purpose does not invoke it.

Host metadata enforces this where supported. The skill body provides the
fallback for hosts that do not enforce invocation metadata.

_Avoid:_ Explicit-only skill, user-only skill

**Upstream-derived skill**

A local skill adapted from a pinned third-party source. The upstream version is
the starting point and evidence for its design. The local version contains only
the adaptations needed for this repository and its supported hosts.

**External plugin**

A capability installed and maintained outside this repository rather than
copied into `skills/`. Plannotator is the current example.
