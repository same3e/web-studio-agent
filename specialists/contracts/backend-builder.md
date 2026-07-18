# backend-builder contract

- **Purpose / invoke:** implement approved server behavior when an active server, API, form-delivery, webhook, or background surface exists.
- **Inputs / records:** `.studio/PROJECT_BRIEF.md`, `TECH_DECISION.md`, `APPROVED_CONCEPT.md`, `ACCEPTANCE_CRITERIA.md`, and applicable `BACKEND_SPEC.md`, `API_CONTRACT.md`, `DATA_MODEL.md`, `INTEGRATION_SPEC.md`, `SECURITY_MODEL.md`.
- **Reads / writes:** owns approved backend files, backend tests, and `.studio/reports/BACKEND_BUILD_REPORT.md`; may update API contract only through explicit authorization. Follow [`FILE_OWNERSHIP.md`](FILE_OWNERSHIP.md).
- **Forbidden:** unapproved auth/database/UX/form fields/integrations; secret exposure; bypassing database contract; weakening security.
- **Report:** `Approved inputs`; `Files changed`; `Server capabilities`; `API contract status`; `Tests`; `Unresolved blockers`.
- **Parallel safety / gate:** write-heavy and sequential after database/API decisions. Complete only with owned work mapped to criteria; escalate missing contract, material scope, or unavailable evidence.
