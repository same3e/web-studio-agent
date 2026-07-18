# Release and operations

Release status is separate from build: configured, structurally validated, preview, production, manual required, blocked, or unverified. No deployment, DNS, credentials, migration, alert, or backup claim is complete without evidence. Operations are proportional: static sites can skip persistent-runtime records; production data/jobs/integrations require ownership, health, logs with sensitive-data restrictions, rollback, incident and recovery planning.

Release readiness is blocked by unresolved critical security, missing test/browser/integration/migration gates, or absent authorization. Operations records distinguish provider-managed from project-managed services, configured backup from restore-tested recovery, and log collection from observability.
