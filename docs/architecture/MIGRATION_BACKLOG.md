# Migration backlog — deferred after Phase 3A

| Item | Purpose | Dependencies and risks | Phase | Acceptance criteria |
| --- | --- | --- | --- | --- |
| refactor-engineer | Reduce implementation debt | Stable tests and approved behavior; regression risk; owns refactor-only paths | 3 | Behavior-preserving refactor with test evidence |
| release-engineer | Produce deployable release path | Deployment target and secrets ownership; accidental publication risk; owns release config | 3 | Reproducible release checklist without publishing by default |
| performance-audit | Evaluate relevant performance risks | Representative runtime data; risk of premature optimization; read-only first pass | 3 | Evidence-backed budget and remediation ownership |
| observability-operations | Operational traces, alerts, runbooks | Approved production boundary; risk of secret/log leakage; owns ops records | 3 | Safe operational contract and verification plan |
| Personal reference library | Cross-project reusable reference metadata | Consent and data isolation; client-data leakage risk | 3 | Opt-in, non-source-copy library with provenance |
| Reference classification and matching | Style/industry/role/type matching and deduplication | Stable analysis schema; false matches risk | 3 | Explainable matches and duplicate links |
| Advanced worktree parallelism | Isolated parallel implementation | VCS/worktree support; merge conflict risk | 3 | Explicit ownership and reproducible integration |
| Claude Agent Teams mode | Optional team orchestration | Stable host support; nondeterministic delegation risk | 3 | Opt-in only, sequential fallback remains complete |
| Complete end-to-end architecture verification | Full product journey across all specialist layers | Requires representative app, provider sandbox, and browser environment; evidence gap risk | 3 | Integrated E2E report separates verified and unavailable evidence |
