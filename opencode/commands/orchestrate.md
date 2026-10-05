---
description: Execute a plan from .agents/plans/ with builder subagents and a reviewer loop
agent: orchestrator
---

Execute the plan at $ARGUMENTS.

Work the task graph: dispatch builder subagents (parallel where safe), run a reviewer, and iterate until the plan is verified done. If no plan path is given, ask me which plan to run.
