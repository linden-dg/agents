---
name: stay-in-scope
description: Keep code changes within the user-requested behavior and named systems. Apply when implementation could drift into adjacent cleanup, redesign, migration, deployment, data, or shared behavior.
---

# Stay in scope

Treat existing user changes and adjacent behavior as intentional unless the task or evidence says otherwise.

- Make the smallest coherent change that satisfies the request. The smallest coherent change is not necessarily the smallest diff.
- Do not add guards, compatibility layers, duplicated paths, or special cases merely to avoid changing the correct seam.
- Do not delete, redesign, migrate, deploy, modify data or external state, or clean up adjacent code unless the requested outcome requires it.
- If a clean solution requires architectural work outside the current scope, stop before adding a workaround. Explain the friction and the redesign option, then ask for direction.
- If another required step would materially expand scope or change product behavior, stop and ask.
- Report unrelated problems separately. Do not fix them opportunistically.
- Before finishing, inspect the diff for unrelated edits and verify both the requested behavior and the adjacent contracts that must remain unchanged.
