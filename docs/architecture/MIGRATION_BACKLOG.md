# Migration backlog — deferred after Phase 1

| Item | Purpose | Dependencies and risks | Phase | Acceptance criteria |
| --- | --- | --- | --- | --- |
| backend-builder | Implement approved server contracts | Approved API/data contract; risk of scope and secret leakage | 2 | Owns backend paths and verifies contract tests |
| database-architect | Model data, migration, retention | Backend contract and privacy decisions; migration risk | 2 | Schema rationale, migration and rollback plan |
| integration-builder | Build real external integrations | Credentials and approved vendor contracts; fake-success risk | 2 | Real/error states verified without secrets in records |
| security-auditor | Review product security posture | Threat model and runnable project; false assurance risk | 2 | Evidence-backed, read-only first-pass findings |
| refactor-engineer | Reduce implementation debt | Stable tests and approved behavior; regression risk | 2 | Behavior-preserving refactor with test evidence |
| release-engineer | Produce deployable release path | Deployment target and secrets ownership; accidental publication risk | 2 | Reproducible release checklist without publishing by default |
| Personal reference library | Cross-project reusable reference metadata | Consent and data isolation; client-data leakage risk | 3 | Opt-in, non-source-copy library with provenance |
| Reference classification and matching | Style/industry/role/type matching and deduplication | Stable analysis schema; false matches risk | 3 | Explainable matches and duplicate links |
| Advanced worktree parallelism | Isolated parallel implementation | VCS/worktree support; merge conflict risk | 3 | Explicit ownership and reproducible integration |
| Claude Agent Teams mode | Optional team orchestration | Stable host support; nondeterministic delegation risk | 3 | Opt-in only, sequential fallback remains complete |
