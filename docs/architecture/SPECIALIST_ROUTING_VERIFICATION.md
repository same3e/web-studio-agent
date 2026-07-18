# Specialist routing verification — Phase 1.1

The executable resolver is [`scripts/Resolve-SpecialistPlan.ps1`](../../scripts/Resolve-SpecialistPlan.ps1). It is invoked by [`scripts/Test-ImplementationPreflight.ps1`](../../scripts/Test-ImplementationPreflight.ps1) only after all required approved-state records exist.

| Fixture | Selected | Skipped | Evidence and rule |
| --- | --- | --- | --- |
| Simple landing | frontend-builder, test-engineer, code-reviewer, browser-qa | repo-explorer | No `package.json`, `src`, or `app` exists; resolver follows the simple-landing matrix in [`SPECIALIST_SYSTEM.md`](SPECIALIST_SYSTEM.md). |
| Existing frontend repository | repo-explorer, frontend-builder, test-engineer, code-reviewer, browser-qa | none of the Phase 1 roles | A fixture `package.json` and `src/` makes existing-code exploration applicable. |
| Documentation-only content change | none | repo-explorer, frontend-builder, test-engineer, code-reviewer, browser-qa | `PROJECT_STATE.md` marks the change documentation-only; implementation and browser roles are not selected merely because they exist. |

Phase 2 roles do not exist in the resolver and are therefore never selected. The report always records `sequential if platform subagents are unavailable`, matching [`skills/product-studio/SKILL.md`](../../skills/product-studio/SKILL.md) and [`SPECIALIST_SYSTEM.md`](SPECIALIST_SYSTEM.md).

## Read-only role evidence

The runtime fixture copied `repo-explorer.toml` and `code-reviewer.toml` into its own `.codex/agents/` directory. A repo-explorer and a first-pass code-reviewer were then invoked with their canonical contracts in read-only mode. Both returned the required report structures, and the SHA-256 value of `protected-source.txt` before and after was identical: `DD8A490568F771CE751512C6ED553BAEB25100F9562F4DC270C077940CEB1DF9`.

This Codex session's subagent API does not expose selection by project-local custom-agent name, so successful host loading of the copied TOML templates remains unverified. The role contracts themselves were actually exercised; wrapper-type selection was not claimed.
