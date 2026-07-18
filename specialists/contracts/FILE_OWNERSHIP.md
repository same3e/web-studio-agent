# File ownership

## Default ownership

| Role | Project records | Source-code areas | Reports |
| --- | --- | --- | --- |
| frontend-builder | design/copy implementation inputs (read) | frontend routes, components, styles, client interaction, frontend tests | frontend build report |
| backend-builder | BACKEND_SPEC, API_CONTRACT (only when authorized) | API routes, server services, jobs, server validation, backend tests | BACKEND_BUILD_REPORT |
| database-architect | DATABASE_DECISION, DATA_MODEL, MIGRATION_PLAN, DATA_RETENTION | schema, migrations, database policies | DATABASE_REPORT |
| integration-builder | INTEGRATION_SPEC, EXTERNAL_SERVICES, ENVIRONMENT_CONTRACT | provider adapters, webhook handlers, provider contracts, integration tests | INTEGRATION_BUILD_REPORT |
| security-auditor | THREAT_MODEL, SECURITY_MODEL | none on first pass | SECURITY_REPORT |
| refactor-engineer | REFACTOR_PLAN, BEHAVIOR_INVARIANTS | only explicit temporary transfer | REFACTOR_REPORT, REFACTOR_VERIFICATION |
| performance-auditor | PERFORMANCE_BUDGET, PERFORMANCE_PLAN | none on first pass | PERFORMANCE_REPORT, PERFORMANCE_RECHECK |
| release-engineer | RELEASE_PLAN, DEPLOYMENT_MATRIX, RELEASE_CHECKLIST, ROLLBACK_PLAN, CHANGELOG_PLAN | CI, deployment, packaging, release scripts | RELEASE_REPORT, DEPLOYMENT_VERIFICATION |
| operations-engineer | OPERATIONS_PLAN, OBSERVABILITY_PLAN, HEALTH_CHECKS, INCIDENT_RESPONSE, RUNBOOK, BACKUP_RECOVERY | health/observability config, operations scripts | OPERATIONS_READINESS |
| test-engineer | read all applicable records | test-owned files only | test report |
| code-reviewer / repo-explorer / browser-qa | read-only | none on first pass | their project-local reports only when assigned |

## Shared-file handoff

No two write specialists own one file by default. A shared file requires a project-local written handoff with temporary owner, reason, expected changes, order, and conflict-resolution owner. Security findings are assigned to the affected layer owner; the auditor remains read-only until a separate approved remediation assignment.

Project-specific ownership may narrow these boundaries but may not silently broaden them.
