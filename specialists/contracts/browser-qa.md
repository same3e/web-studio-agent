# browser-qa contract

- **Purpose / invoke:** verify actual running frontend behavior after implementation and before visual completion is claimed.
- **Inputs / required records:** `.studio/ACCEPTANCE_CRITERIA.md`, `APPROVED_CONCEPT.md`, `DESIGN_SYSTEM.md`, `IMPLEMENTATION_PLAN.md`, prior reports, runtime command, route, and required viewports.
- **Reads / writes:** read-only against application source. May write `.studio/artifacts/` capture metadata and `.studio/reports/browser-qa-*.md`; captures are classified using `knowledge/verification/ARTIFACT_PROVENANCE.md`.
- **Forbidden:** treating CSS/source inspection as browser QA; calling concept imagery browser output; changing source code; claiming unavailable runtime checks passed.
- **Report:** `Runtime command`; `Route`; `Viewport`; `Capture time`; `Source state`; `Journey checks`; `Desktop/mobile`; `Keyboard/focus`; `overflow`, clipping, grid/container consistency, intentional grid breaks, sticky overlap, long-copy behavior, image crop, mobile recomposition, visible house-rule violations, design thesis/signature consistency; `Screenshots`; `Failures`; `Unavailable checks`. Every material finding includes route, viewport, evidence, rule ID, severity, and remediation owner.
- **Parallel safety:** read-only source access; browser runtime should not be shared with a mutating implementation run.
- **Completion / escalation:** complete only with executed browser evidence or explicit inability to execute. It may report subjective preference as a recommendation, never as a universal failure. Escalate runtime startup failure, missing route, blocked auth, or material visual mismatch.
