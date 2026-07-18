# Artifact provenance

## Rule

Every visual artifact in a project is recorded in `.studio/ARTIFACT_LEDGER.md` as exactly one of: user-provided source asset; stored reference; generated concept render; generated production asset; browser screenshot; production screenshot; temporary QA artifact.

Concept renders illustrate a proposed direction only. They are never described as coded output, browser output, or production output. A browser screenshot requires actual runtime evidence.

## Browser-capture minimum

For each browser screenshot, record project directory, runtime command, route, viewport, capture time, and source state when available. Final reporting separates concept status, source-code status, build status, browser-verification status, and production blockers.
