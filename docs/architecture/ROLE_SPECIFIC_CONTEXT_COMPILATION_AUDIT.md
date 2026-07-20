# Role-specific context compilation audit

## Implemented remediation

Stage 3 now validates project records through a shared context accessor before nested data access, returning stable `CONTEXT_*` errors rather than raw property failures. Canonical state, mode, task and paths are authoritative; conflicting CLI values block. Active scope is selected from `ACTIVE_AND_DEFERRED_SCOPE.md`, bounded by assignment tasks, criteria, surfaces and allowed paths.

The executable routing registry drives mandatory and conditional records, delta roles, rule groups, reference roles and repository-map inclusion. Rules use role, state, surface, product type and detected stack filters and are sorted by priority then ID. Approved active project-local reference cards remain untrusted and carry a no-copy boundary.

The schema-v3 fingerprint deterministically includes project/role/mode/state, scope, assignment, plan, selected records/rules/deltas/cards, registry/index/overlay, repository map, approval, technical-decision and applicable security inputs. Cache reuse also checks schema, project, role, mode, manifest parseability and contributor existence. Outputs continue through the authorized atomic-write helper.

## Evidence and limitations

Dedicated role-selection and cache/routing PowerShell suites exercise targeted compiler behavior; the efficiency suite remains independent. These tests prove local structural behavior only. Native Codex/Claude reuse, host staged loading, complete prompt-injection detection, browser, API, database, deployment and hosted CI behavior remain unverified.
