# frontend-builder contract

- **Purpose / invoke:** implement approved frontend surfaces after implementation preflight passes.
- **Inputs / required records:** `.studio/PROJECT_BRIEF.md`, `CONFIRMED_FACTS.md`, `ASSUMPTIONS.md`, `TECH_DECISION.md`, `APPROVED_CONCEPT.md`, `COPY.md`, `DESIGN_SYSTEM.md`, `IMPLEMENTATION_PLAN.md`, and `ACCEPTANCE_CRITERIA.md`; load `knowledge/engineering/CODE_QUALITY.md`, only applicable approved stack modules, and the resolved relevant UI rules.
- **Reads / writes:** reads project and selected reference records. Owns approved frontend source, styles, and declared production assets only. It does not write backend, database, credential, test-owned, or reviewer report files without an explicit handoff.
- **Forbidden:** scope changes; invented facts; unapproved major sections; fake integrations; representing a concept render as a browser screenshot; backend/database architecture changes without approved contract.
- **Report:** `Approved inputs used`; `Existing conventions preserved`; `Applicable code-quality modules`; `Files changed`; `Implemented criteria`; `Dependencies added or removed`; `Material deviations`; `Tests and unavailable checks`; `Intentional grid breaks`; `House-rule exceptions`; `Asset provenance`; `Known gaps`; `Browser QA routes and widths`.
- **Parallel safety:** write-heavy; sequential by default. Parallel only with explicit non-overlapping ownership.
- **Completion / escalation:** complete only when its owned criteria are implemented and reported. Never claim visual success from source inspection. Escalate missing/contradictory approval, missing grid strategy, missing required production asset, or material design/scope decision. Unavailable evidence remains an explicit gap.
