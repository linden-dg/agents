# TypeScript

Language rules for TypeScript and TSX changes. Repository rules in
`.agents/orchestrator/repo.md` take precedence.

## Type escapes

- No `any`. Use `unknown` and narrow it, or fix the type at its source.
- A type assertion (`as`), non-null assertion (`!`) or `@ts-expect-error`
  carries a short reason in a comment, in the form `repo.md` requires. Never
  use `@ts-ignore`.
- A lint suppression names the exact rule and sits on the line it applies to.

## Extra deslop focus areas

- `as` casts, `!` and `as unknown as` used only to silence the compiler.
- Optional chaining or `?? fallback` on values whose types are already
  non-nullable.
- Floating promises. Keep `await` where the caller depends on completion, and
  don't swap it for `void` to quiet a lint.
- Re-declared types that duplicate an inferred or exported type.
- Conditional object spreads where an explicit property would read plainly.
