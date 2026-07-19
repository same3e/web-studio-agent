# Record contract integrity audit

## Baseline

Recorded on local `main` at `151a9f7`. The working tree already contained the
in-progress remediation edits to `Test-StudioRecord.ps1`, the shared fixture,
and this audit before baseline execution; no unrelated work was discarded. The
existing Phase 1–4, frontend, code-quality, context, false-guarantee, syntax,
and specialist-orchestration suites passed. Those suites do not prove that all
required record contracts have schemas, typed templates, and type-specific
runtime validators.

## Findings

- **Incomplete validator:** `technical-decision` was envelope-only despite
  being a base implementation requirement.
- **Schema/validator drift:** only a subset of record types has dedicated JSON
  schemas; several surface-required records therefore cannot be checked for
  schema/validator/template alignment.
- **Template/schema drift:** governed templates have not yet been verified
  against a canonical record-contract registry.
- **Unused registry field:** specialist path hints remain advisory until the
  registry ownership-policy remediation is complete.
- **Host-runtime-only limitation:** structural PowerShell checks do not prove
  native agent execution, browser, API, database, deployment, or hosted CI
  behavior.

## Final remediation findings

- **Missing schema / typed template / validator:** resolved for all 33
  runtime-enforced record contracts in `record-contract-registry.json`.
  Requirement routing now resolves filenames from this registry rather than a
  duplicate `$types` map.
- **Incomplete validator:** resolved for technical decisions, migration and
  retention records, external services, behavior invariants, deployment and
  backup/recovery, and the release and operations record families. The
  `not-applicable` envelope short-circuits type-specific requirements only
  after a meaningful typed reason is present.
- **Schema/validator and template/schema drift:** `test_record_contract_integrity.ps1`
  parses each schema and template, verifies identity and validator coverage,
  rejects empty data, accepts valid synthetic typed fixtures, and checks UTF-8
  BOM/no-BOM parser parity.
- **Placeholder bypass / unsafe type coercion:** structured placeholder reasons
  reject exact, prefix, bracketed, and filler placeholders. Boolean, array,
  object, enum, ID, and reference helpers do not use string coercion.
- **Unused registry field:** `defaultOwnedPaths` was removed. Registry field
  policy labels runtime fields and advisory routing hints; specialist write-path
  blocking reads `requiresAssignedWritePaths` from the registry.
- **Duplicated security logic:** the shared potential-secret scanner is used by
  migration validation, Phase 2 contracts, and environment-contract validation.
  Reports expose category and redacted preview rather than a matched value.
- **Documentation/runtime mismatch:** release documentation now states the
  local `pwsh` requirement and its installation boundary. Structural checks do
  not establish native host-agent, browser, API, database, deployment, or
  hosted-CI runtime behavior.
