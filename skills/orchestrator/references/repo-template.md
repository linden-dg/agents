# Repository orchestration rules

Template for `.agents/orchestrator/repo.md`. Copy it into the repository and
replace each section with that repository's facts. Keep it to what differs
from the shared brief. Delete a section only when it truly does not apply.

## Plans

Where plans live (for example `.plans/<slug>/`) and the files each plan has.

## Checks

The exact commands, in the form a subagent can run from the repository root:

- full checks, run at every gate;
- focused checks, run after each change, with the path or filter syntax;
- formatter command for named files;
- which checks CI runs, and any known command that looks right but fails.

State whether every check passes on a clean tree.

## Hard boundaries

Commands and files a subagent must never touch: deployment, database,
secrets, external services, generated files.

## Code rules

Repository conventions a subagent would otherwise get wrong: patterns to
follow, where tests go, error types, suppression syntax required by the
linter, contracts that must not change without asking.

## Blast-radius hotspots

Where a symbol search stops in this repository: on-disk or wire formats,
string-encoded identifiers, execution ordering, public exports, generated
code.

## Release notes

How descriptions feed the changelog, if they do, and any rule about `SQUASH`
changes before a release.
