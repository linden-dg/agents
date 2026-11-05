# Python

Language rules for Python changes. Repository rules in
`.agents/orchestrator/repo.md` take precedence.

## Type escapes

- A type-checker suppression names the rule, such as
  `# ty: ignore[rule-name]`, with a short comment on why. Never use a bare
  `# type: ignore`.
- `typing.cast` and `Any` carry the same short reason.

## Extra deslop focus areas

- `Any`, `cast()` or a suppression used only to silence the type checker.
- Broad `except Exception` or `try/except` blocks on trusted code paths.
- Lenient conversions that turn bad values into `None` or nulls without
  saying so, such as non-strict casts.
- `isinstance` guards on values whose types are already known.
- Mutable default arguments.
