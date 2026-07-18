---
name: product-studio
description: Plan, approve, implement, and verify a website, landing page, web app, SaaS, dashboard, PWA, internal tool, mobile-app plan, or redesign. Use for end-to-end product work; not for isolated fixes, single copy edits, read-only explanations, or reference-only tasks.
---

# Product studio

## Orchestration contract

1. Inspect the repository, manifests, existing documentation, code, and `.studio/` before asking questions. Reuse confirmed information.
2. Read `knowledge/KNOWLEDGE_INDEX.md`; identify task, project state, product type, active risks/features, then load only routed documents.
3. If `.studio/` is absent, initialize missing project-local files from `templates/studio/` without overwriting existing material. Report the initialization briefly.
4. Determine state from `.studio/PROJECT_STATE.md` and linked evidence—not chat history. Follow: `uninitialized → discovery → requirements → technical-decision → references-needed → concepts → awaiting-approval → approved → implementation-planning → implementation → specialist-verification → remediation → final-verification → handoff → complete`.
5. Start discovery with an inference-first summary: confirmed facts, safe provisional assumptions, technical recommendations, unsupported public claims, blocking gaps, and non-blocking gaps. State what can already be inferred; reuse conversation and project-record answers. Recommend a reasonable default with correction path rather than asking an open question where one exists. Missing branding, final photography, testimonials, pricing, analytics, CRM, CMS, or legal copy does not block preliminary concepts; use honest placeholders.
6. Define the first complete journey in `USER_FLOWS.md` and `ACCEPTANCE_CRITERIA.md`; separate active, deferred, and rejected scope before concepts.
7. Write up to three genuinely different concepts. Stop for explicit approval. Positive but vague feedback is not approval.
8. After explicit approval, record the decision in `APPROVED_CONCEPT.md`, automatically prepare `COPY.md`, `DESIGN_SYSTEM.md`, `IMPLEMENTATION_PLAN.md`, and `ACCEPTANCE_CRITERIA.md`, resolve universal rules → approved requirements → concept/design system → project taste overrides → user taste profile → house defaults, then run `IMPLEMENTATION_PREFLIGHT.md`. Record a design thesis, signature element, grid strategy, section composition map, responsive recomposition, and material taste exceptions for a new visible direction. If approval also requested implementation, continue without a second approval prompt unless the user asked to stop.
9. Preflight marks each relevant record required, optional, or not applicable with a reason and blocks implementation on missing or inconsistent required evidence. Implement only approved active scope. Preserve existing valid technology unless a documented, user-visible benefit justifies a change.
10. Select only relevant internal roles from `specialists/specs/`: use repo-explorer for unknown existing code; database-architect only for persistent application data; backend-builder for approved server/API/form-delivery work; integration-builder only for approved external providers; security-auditor only for material auth/data/server/integration risk; refactor-engineer only for explicit approved refactoring or structural remediation; performance-auditor for a performance criterion, regression, heavy surface, or measured production handoff; release-engineer only for CI, packaging, preview/production deployment, domain, release, or handoff; operations-engineer only for persistent runtime/data/jobs/material integrations; and browser-qa for runnable visible changes. Record a reason for every selected or skipped role. Static sites skip Phase 2/3 runtime roles. Read-heavy roles may run in parallel only when contracts do not conflict; database/API decisions precede writes; writers are sequential by default. If subagents are unavailable, execute the same stages sequentially and record reports in `.studio/reports/`.
11. Phase 2 records are initialized after approval but required only when active surfaces demand them. Request user input only for material persistence, authentication, paid provider, sensitive data, irreversible migration, vendor lock-in, production credentials, or materially higher operational complexity.
12. Use `.studio/CONTENT_LEDGER.md` for public claims/placeholders and `.studio/ARTIFACT_LEDGER.md` for every visual artifact. Never call a concept render browser output.
13. Run the smallest complete validation for the active scope. Record actual evidence and unavailable checks in `VERIFICATION_REPORT.md` and `BUILD_REPORT.md`; final reporting separately states frontend, backend, database, integration, security-audit, build, test, browser-QA, and production-blocker status. Never claim completion with a broken critical journey.
14. Use this order when relevant: implementation → tests → code review → security remediation → performance audit/remediation → approved refactor/regression verification → browser QA → release preparation → operations readiness. Release never overrides missing security, test, integration, migration, or browser gates; sequential fallback uses the same records.

## Boundaries

- Use `add-reference` for full reference intake, duplicate detection, or reanalysis. Before requesting new references, search the permanent personal library, propose a balanced industry/visual/product/structural-or-UX set with selection reasons and role gaps, and keep only approved summaries, usage, conflicts, and no-copy boundaries in the active project.
- Project facts, screenshots, references, concepts, copy, and generated documents live only in `<project-root>/.studio/`, never in plugin/skill directories. The user-controlled cross-project taste profile is the sole exception: `<WEB_STUDIO_AGENT_HOME>/taste/PROFILE.md`; it stores no project facts or project artifacts.
- Apply the decision hierarchy in `knowledge/core/DECISION_HIERARCHY.md` and approval/factual/no-copy gates before implementation.
- For marketing heroes, apply the H1-first rule only when the product has a hero; never impose it on application screens.

## Required outputs by state

| State | Minimum evidence |
| --- | --- |
| discovery | `PROJECT_BRIEF.md`, `CONFIRMED_FACTS.md`, `ASSUMPTIONS.md`, audience understanding |
| requirements | roles/flows where relevant, `PRODUCT_SPEC.md`, active/deferred scope, first complete journey |
| technical-decision | `TECH_DECISION.md` with up to three options and one recommendation |
| references-needed | request or explicit bypass recorded; project-local reference index inspected |
| concepts | `concepts/CONCEPTS.md` with product, UX, visual, content, and technical trade-offs |
| awaiting-approval | explicit pending approval recorded; no implementation starts |
| approved | `APPROVED_CONCEPT.md`, `COPY.md`, `DESIGN_SYSTEM.md`, plan, acceptance criteria |
| implementation-planning | passed `IMPLEMENTATION_PREFLIGHT.md` with required/optional/not-applicable record reasons |
| implementation | changes mapped to approved active scope and journey; specialist ownership respected |
| specialist-verification / remediation | applicable specialist reports, actual test/browser evidence, and tracked remediation |
| final-verification / handoff / complete | verification and build reports with commands, results, limits, factual/no-copy checks, and provenance |
