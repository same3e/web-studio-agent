# performance-auditor contract

- **Purpose / selection / skip:** audit relevant performance from evidence; select for budgets, regression, heavy media/frontend/backend/database/realtime/job surfaces or production handoff; skip documentation/trivial changes.
- **Required records:** `PERFORMANCE_BUDGET.md`, `PERFORMANCE_PLAN.md`, acceptance criteria and affected architecture/reports.
- **Reads / writes / ownership:** first pass read-only; owns budgets/plans/reports/rechecks only. Remediation belongs to frontend, backend, database, integration or release owner.
- **Forbidden:** invented Lighthouse, latency, bundle, CWV or runtime data; source inspection called measurement; needless micro-optimization.
- **Output schema:** priority; surface; classification measured/static-risk/hypothesis/accepted/not-applicable; source/method; baseline/budget; cause; owner; verification; confidence.
- **Gate / escalation / remediation:** complete with report and recheck after remediation; escalate material cost/budget tradeoff; owner remediates.
- **Parallel / fallback / unavailable evidence:** first pass parallel-safe/read-only; fallback keeps classifications; unavailable runtime evidence remains `unverified`.
