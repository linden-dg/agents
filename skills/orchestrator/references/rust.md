# Rust

Language rules for Rust changes, including Tauri hosts. Repository rules in
`.agents/orchestrator/repo.md` take precedence.

## Escapes

- A lint suppression uses `#[expect(lint_name, reason = "...")]` on the
  smallest item it applies to. Use `#[allow]` only where `#[expect]` would
  misfire, such as code that is dead on one target only, and give a comment
  on why.
- Every `unsafe` block carries a `// SAFETY:` comment stating the invariant
  that makes it sound. Don't add `unsafe` without asking.
- `unwrap()` and `expect()` only where failure is a bug, with the invariant in
  the `expect` message. Propagate recoverable errors with `?`.

## Extra deslop focus areas

- `.clone()`, `.to_string()` or `.to_owned()` added only to satisfy the borrow
  checker where a borrow would do.
- `unwrap_or_default()` or `.ok()` that quietly discards an error the caller
  should see.
- `Box<dyn Error>` or stringly errors where the crate already has an error
  type.
- Wrapping in `Arc<Mutex<_>>` or adding a lifetime parameter that the call
  sites don't need.
- `match` blocks that restate `?`, `map`, `ok_or` or `if let`.
- `pub` widened beyond what callers use.

## Tauri

- Long-running or blocking work in a command runs off the async runtime, not
  inline in an async command.
- Errors that cross IPC are serialisable and safe to show the user. Don't send
  internal paths or secrets to the webview.
- Don't widen capabilities, permissions, scopes or the CSP without asking.
- Don't hand-edit generated TypeScript bindings. Regenerate them the way
  `repo.md` describes.
- A change on both sides of IPC also follows the TypeScript reference.
