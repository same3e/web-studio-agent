# repo-explorer contract

- **Purpose / invoke:** inspect an existing repository before implementation, when architecture or affected surfaces are not established.
- **Inputs / records:** repository, `.studio/PROJECT_BRIEF.md`, `CONFIRMED_FACTS.md`, `ASSUMPTIONS.md`, `TECH_DECISION.md`, `APPROVED_CONCEPT.md`, `IMPLEMENTATION_PLAN.md`, and `ACCEPTANCE_CRITERIA.md` when present. Missing records are reported, not invented.
- **Reads / writes:** may read repository and project records; writes no source or project decision files. It may return a report for the orchestrator to store.
- **Forbidden:** implementation, dependency changes, scope changes, and claims that a runtime was verified.
- **Report:** `Status`; `Relevant files`; `Architecture and surfaces`; `Dependencies/tests`; `Risks`; `Missing evidence`; `Recommended next role`.
- **Parallel safety:** read-only; parallel-safe with other read-only roles.
- **Completion / escalation:** complete when relevant paths and risks are evidenced. Escalate inaccessible repository, contradictory approved records, or a material scope conflict. If evidence is unavailable, name the unavailable path and consequence.
