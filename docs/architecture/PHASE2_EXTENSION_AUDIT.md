# Phase 2 extension audit

Audit date: 2026-07-18. Phase 2 extends, rather than replaces, the Phase 1 architecture.

## Exact extension points

- User orchestration is [`skills/product-studio/SKILL.md`](../../skills/product-studio/SKILL.md). It preserves exactly two user-facing skills and currently selects five Phase 1 roles.
- Canonical specs are [`specialists/specs/`](../../specialists/specs/) and contracts are [`specialists/contracts/`](../../specialists/contracts/). The shared contract schema is [`ROLE_CONTRACT_FORMAT.md`](../../specialists/contracts/ROLE_CONTRACT_FORMAT.md).
- Routing is implemented by [`scripts/Resolve-SpecialistPlan.ps1`](../../scripts/Resolve-SpecialistPlan.ps1); its report separates selected/skipped roles and declares sequential fallback.
- Preflight is [`scripts/Test-ImplementationPreflight.ps1`](../../scripts/Test-ImplementationPreflight.ps1); approved-record initialization is [`scripts/Initialize-ApprovedProjectRecords.ps1`](../../scripts/Initialize-ApprovedProjectRecords.ps1).
- Project templates use [`templates/studio/`](../../templates/studio/) and write state only under project-local `.studio/`.
- Codex wrappers are TOML templates in [`platforms/codex/agents/`](../../platforms/codex/agents/); Claude wrappers are Markdown frontmatter templates in [`platforms/claude/agents/`](../../platforms/claude/agents/). Their shared mapping documentation is [`PLATFORM_AGENTS.md`](PLATFORM_AGENTS.md).
- Existing deterministic checks are [`scripts/validate_migration.ps1`](../../scripts/validate_migration.ps1), [`scripts/test_phase1_behavioral.ps1`](../../scripts/test_phase1_behavioral.ps1), and [`scripts/test_phase1_runtime.ps1`](../../scripts/test_phase1_runtime.ps1).

## Existing conventions and risks

Contracts already define purpose, invocation, records, allowed reads/writes, prohibitions, report, parallel safety, gate, escalation, and unavailable evidence. Reports are project-local. Read-only first passes exist for explorer/reviewer/browser QA; frontend and test work are sequential by default.

Phase 2 adds write-heavy layers, so overlapping files are the main risk: API routes can be touched by backend and integration work, schemas by database and backend work, and security remediation by every owner. A canonical ownership document and explicit temporary handoff are required. Phase 2 must not duplicate methodology into platform wrappers, turn roles into skills, change Phase 1 template behavior, remove provenance/content safeguards, or require backend ceremony for static sites.
