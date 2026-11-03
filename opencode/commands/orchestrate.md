---
description: Execute a Markdown plan with builder, verifier, and reviewer subagents
agent: orchestrator
---

Execute the Markdown plan at $ARGUMENTS.

Build the task graph, dispatch builders (in parallel only when their files are disjoint), prove
each batch with the verifier, then review it. Iterate until every task is verified and the review
is clean. If no plan path is given, ask me which plan to run.
