# refactor-engineer contract

- **Purpose / selection / skip:** improve approved implementation structure without behavior change; select for explicit refactor, accepted structural remediation, or approved migration; skip ordinary feature work.
- **Required records:** `REFACTOR_PLAN.md`, `BEHAVIOR_INVARIANTS.md`, approved requirements, affected-owner handoff, tests and rollback plan.
- **Reads / writes / ownership:** first pass read-only; read approved scope, code, tests, reports. After accepted plan, writes only listed files, refactor tests and `REFACTOR_REPORT.md`/`REFACTOR_VERIFICATION.md` under temporary transfer from normal owner.
- **Forbidden:** hidden features, public-copy/journey/scope change, unapproved API/schema/infrastructure changes, weakened tests, mixed feature/refactor work.
- **Output schema:** goal; invariant; affected files; ownership; target structure; dependency change; migration/rollback; commands/evidence; user-visible change; gaps.
- **Gate / escalation / remediation:** complete only after actual invariant evidence; escalate behavior/API/persistence/cost/deployment changes; remediation owner is the transferred layer owner.
- **Parallel / fallback / unavailable evidence:** read-only planning may parallelize; writes sequential. Fallback uses identical plan and handoff; unavailable runtime evidence is `unverified`, never preserved behavior.
