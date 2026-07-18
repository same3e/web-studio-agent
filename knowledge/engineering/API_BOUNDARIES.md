# API boundaries

Separate transport from business logic. Each operation has explicit request, response, error, authentication, authorization, idempotency, ownership, and versioning behavior in `.studio/API_CONTRACT.md`. Do not expose provider or database details to clients unnecessarily.
