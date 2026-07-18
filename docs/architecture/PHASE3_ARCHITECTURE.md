# Phase 3 architecture

Phase 3 adds refactor, performance, release, and operations roles without user-facing commands. Contracts and ownership remain canonical; wrappers are thin and automatic host loading remains unverified. `Resolve-SpecialistPlan.ps1` records selected and skipped roles with reasons; `Test-ImplementationPreflight.ps1` requires only the records matching declared surfaces and rejects evidence contradictions. Sequential fallback preserves the same contracts and reports.

The permanent personal library is resolved from `WEB_STUDIO_AGENT_HOME` to `reference-library/`, rejects plugin-cache roots, and uses stable reference IDs, source-once storage, deterministic file-hash/normalized-URL duplicate handling, reproducible indexes, project links, and approval-gated balanced matching. `scripts/test_phase3.ps1` covers M–X as structural, state-machine, deterministic-library, and targeted-runtime fixtures.
