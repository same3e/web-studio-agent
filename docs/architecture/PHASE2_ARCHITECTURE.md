# Phase 2 architecture

Phase 2 adds four internal roles: backend-builder, database-architect, integration-builder, and security-auditor. They are selected by `product-studio`, never invoked manually by users.

## Ownership and order

Ownership is canonical in [`FILE_OWNERSHIP.md`](../../specialists/contracts/FILE_OWNERSHIP.md). Default order is requirements → technical decision → database architecture (when persistence exists) → API contract → backend → integrations → frontend → tests → code review → security audit → remediation → browser QA. Static sites skip Phase 2 roles; a lead form selects backend/integration but can skip database; authenticated SaaS generally selects database/backend/security and relevant integrations; database-only work skips frontend/browser.

## Records, validators, and fallback

Phase 2 project records have required/optional/deferred/not-applicable status with a reason. Preflight resolves only active surfaces, rejects contradictions, and produces a role plan. Validators check record/contract consistency, never runtime security or provider delivery. When subagents are unavailable, `product-studio` runs the same contracts and order sequentially.

## Platform mapping and limitations

Thin Codex and Claude templates are packaged under `platforms/`; no global installation occurs. Security auditor is read-only for first pass. Provider credentials, production migrations, provider delivery, penetration testing, and production security verification remain outside Phase 2.
