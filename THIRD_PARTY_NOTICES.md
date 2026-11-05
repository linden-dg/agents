# Third-party notices

This file is the source map for copied and adapted skills. It is intentionally separate from the runtime skill instructions.

| Source | Pinned revision | Used for |
| --- | --- | --- |
| [Cursor pstack](https://github.com/cursor/plugins/tree/main/pstack) | `46125561306434d8a1d7745d540d8932ab0cd2a2` | `unslop`, `prove-it-works`, `regression-test`, `blast-radius`, `competitive-workflow` from upstream `arena`; the subagent prompt fields in `orchestrator` from the `poteto-mode` Orchestrate playbook; approval and durable-learning guidance used by `canon` |
| [Cursor Team Kit](https://github.com/cursor/plugins/tree/main/cursor-team-kit) | `46125561306434d8a1d7745d540d8932ab0cd2a2` | `deslop` |
| [Matt Pocock skills](https://github.com/mattpocock/skills) | `5b15a47f2d7150f545fbcacbfe381787fc0230dc` | `diagnosing-bugs`, `wizard`, `refine-scope` from upstream `grilling`, `test-seams` from upstream `tdd`, `canon`, and the architecture vocabulary reference |
| [FetchUpstream pstack port](https://github.com/FetchUpstream/pstack-plugin) | `ba2205db1f83295154e31abc762f533954f581bb` | `how`, `why`, `architect` |

The local versions change invocation controls, host-specific tooling, dependencies between skills, reporting formats, and budget defaults. `unslop` is retained without substantive instruction changes.

## MIT License notices

Copyright (c) 2026 Lauren Tan  
Copyright (c) 2026 Cursor  
Copyright (c) 2026 Matt Pocock

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

The FetchUpstream source is an unofficial port of pstack, independently maintained and not affiliated with or endorsed by Cursor or the original author.
