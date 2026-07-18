# frontend-builder contract

- **Purpose / invoke:** implement approved frontend surfaces after implementation preflight passes.
- **Inputs / required records:** `.studio/PROJECT_BRIEF.md`, `CONFIRMED_FACTS.md`, `ASSUMPTIONS.md`, `TECH_DECISION.md`, `APPROVED_CONCEPT.md`, `COPY.md`, `DESIGN_SYSTEM.md`, `IMPLEMENTATION_PLAN.md`, and `ACCEPTANCE_CRITERIA.md`; read only the resolved relevant rules in `knowledge/ui/FRONTEND_QUALITY.md`, `LAYOUT.md`, `STYLE_LAYOUT_RULES.md`, and `HOUSE_TASTE_DEFAULTS.md`.
- **Reads / writes:** reads project and selected reference records. Owns approved frontend source, styles, and declared production assets only. It does not write backend, database, credential, test-owned, or reviewer report files without an explicit handoff.
- **Forbidden:** scope changes; invented facts; unapproved major sections; fake integrations; representing a concept render as a browser screenshot; backend/database architecture changes without approved contract.
- **Report:** `Approved inputs used`; `Files changed`; `Implemented criteria`; `Intentional grid breaks`; `House-rule exceptions`; `Asset provenance`; `Known gaps`; `Browser QA routes and widths`.
- **Parallel safety:** write-heavy; sequential by default. Parallel only with explicit non-overlapping ownership.
- **Completion / escalation:** complete only when its owned criteria are implemented and reported. Never claim visual success from source inspection. Escalate missing/contradictory approval, missing grid strategy, missing required production asset, or material design/scope decision. Unavailable evidence remains an explicit gap.
