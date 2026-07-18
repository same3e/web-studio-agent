# Specialist system — canonical model

## Canonical relationship

`product-studio` and `add-reference` remain the only user-facing skills. `product-studio` is the orchestrator: it selects internal specialists from [`specialists/specs/`](../../specialists/specs/) according to active product surfaces, state, and risk. Users do not manually coordinate specialists.

Canonical role specifications describe behavior; contracts in [`specialists/contracts/`](../../specialists/contracts/) define inputs, ownership, and completion evidence. Knowledge packs in [`knowledge/`](../../knowledge/) define reusable rules. Validators in [`scripts/`](../../scripts/) make deterministic checks. Project-local `.studio/` records remain the source of truth. Platform files in [`platforms/`](../../platforms/) are thin launch wrappers, never a second methodology source.

## Execution rules

- Specialists may not silently alter approved product scope, business facts, approved copy, concept direction, or technical contracts. Material conflict is escalated to the orchestrator; only the user resolves a material product decision.
- One specialist may not overwrite another specialist's decision record. Read shared records, write only its explicit output path, and return proposed changes outside its ownership.
- `repo-explorer`, first-pass `code-reviewer`, and `browser-qa` are read-only. `test-engineer` owns tests and reports; `frontend-builder` owns approved frontend implementation. Neither may modify the other's files without an explicit ownership handoff.
- Parallel execution is allowed only for read-only roles or where distinct input/output paths and contracts make it safe. Write-heavy work is sequential by default.
- If platform subagents are unavailable, `product-studio` executes the same specialist stages sequentially in its own context and emits the same reports. It must not claim delegation occurred.

## Selection matrix

| Situation | Required specialist sequence |
| --- | --- |
| Existing frontend implementation | repo-explorer → frontend-builder → test-engineer → code-reviewer → browser-qa |
| New simple landing after approval | frontend-builder → test-engineer → code-reviewer → browser-qa |
| No runnable frontend change | only relevant read-only audit/review; browser-qa is recorded not applicable |

Backend, database, integration, security, refactor, performance, release, and operations roles are never implicitly selected; each requires an active surface recorded by routing.

## Phase 3A sequence

When relevant: approved implementation → tests → code review → security audit/remediation → performance audit/remediation → approved refactor/regression verification → browser QA → release preparation → operations readiness → final release gate. Refactoring cannot hide feature work; performance remediation belongs to the owning layer; release cannot override missing browser, integration, migration, security, or test gates.
