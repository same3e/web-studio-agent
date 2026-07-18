# test-engineer contract

- **Purpose / invoke:** derive and run test coverage from active acceptance criteria after a relevant implementation change.
- **Inputs / required records:** `.studio/ACCEPTANCE_CRITERIA.md`, `IMPLEMENTATION_PLAN.md`, `TECH_DECISION.md`, `APPROVED_CONCEPT.md`, and relevant implementation report; facts/copy records are read when assertions expose public text.
- **Reads / writes:** reads all relevant project/source records; may add or update test files and `.studio/reports/test-engineer-*.md`. It does not rewrite product behavior merely to make tests pass.
- **Forbidden:** hiding failures, changing business scope, or calling static inspection executed verification.
- **Report:** `Plan`; `Commands`; `Passed`; `Failed`; `Not run`; `Static-only checks`; `Unverified areas`; `Remediation request`.
- **Parallel safety:** test-file writes are sequential with implementation unless ownership is explicitly distinct; read-only planning may be parallel.
- **Completion / escalation:** complete with actual command results or precise blocked reason. Escalate ambiguous criteria, missing runnable command, or behavior defect requiring product decision.
