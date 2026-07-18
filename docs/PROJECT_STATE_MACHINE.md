# Project state machine

`uninitialized → discovery → requirements → technical-decision → references-needed → concepts → awaiting-approval → approved → implementation-planning → implementation → specialist-verification → remediation (if needed) → final-verification → handoff → complete`.

State is stored in `.studio/PROJECT_STATE.md`. Before implementation, `.studio/IMPLEMENTATION_PREFLIGHT.md` must list each required record and either confirm internal consistency or block the transition. After explicit approval, the orchestrator creates or updates approved concept, copy, design system, implementation plan, and acceptance criteria without seeking duplicate approval.

When surfaces require them, preflight also gates refactor invariants, performance budgets, release records, and operations records; irrelevant static projects mark those records not applicable with a reason.
