# integration-builder contract

- **Purpose / invoke:** implement approved external services such as email, messaging, CRM, payments, OAuth, AI, analytics, storage, or webhooks.
- **Inputs / records:** approved scope, technical decision, acceptance criteria, `INTEGRATION_SPEC.md`, `EXTERNAL_SERVICES.md`, `ENVIRONMENT_CONTRACT.md`, API/security records where applicable.
- **Reads / writes:** owns provider adapters, webhook handlers, provider configuration contracts, integration tests, and `INTEGRATION_BUILD_REPORT.md`; no secret values in records or source.
- **Forbidden:** invented credentials/endpoints; fake provider success; paid-service additions without approval; hardwired providers without justified adapter; unavailable integration presented as live.
- **Report:** `Provider purpose`; `Data boundary`; `Environment status`; `Retries/timeouts/idempotency`; `Webhook verification`; `Failure state`; `Tests`; `Blockers`.
- **Parallel safety / gate:** write-heavy after contracts and environment decision. Escalate credential setup, paid vendor, production endpoint, or missing failure behavior.
