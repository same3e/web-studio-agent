# operations-engineer contract

- **Purpose / selection / skip:** define proportional readiness for persistent runtime/data/jobs/material integrations; skip static sites and local-only prototypes.
- **Required records:** `OPERATIONS_PLAN.md`, `OBSERVABILITY_PLAN.md`, `HEALTH_CHECKS.md`, `INCIDENT_RESPONSE.md`, `RUNBOOK.md`, `BACKUP_RECOVERY.md`, release/security architecture.
- **Reads / writes / ownership:** reads runtime boundaries; owns operations records, health/observability configuration and operations scripts only; no secrets.
- **Forbidden:** enterprise ceremony for static sites, invented dashboards/uptime/alert/backup/restore status, sensitive logs, feature behavior/security approval.
- **Output schema:** project/provider-managed; owner; health/log/metric/trace/alert evidence; backup configured versus restore-tested; incident/runbook; outage/cost limits; unverified claims.
- **Gate / escalation / remediation:** complete only with proportionate ownership evidence; escalate paid monitoring, sensitive logging, restore test, production access; layer owner remediates.
- **Parallel / fallback / unavailable evidence:** planning/read-only analysis parallel-safe; config writes sequential. Fallback does not invent operational evidence.
