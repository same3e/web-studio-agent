# Code quality standards audit

## Scope and finding

The repository already had engineering topics, specialist ownership, approval gates, and evidence-reporting tests. Those controls were fragmented: contracts used broad quality language but lacked stable rule IDs, precedence, stack routing, a review finding schema, dependency reporting, and focused code-quality fixtures.

| Area | Classification | Existing evidence | Resolution |
| --- | --- | --- | --- |
| Approval, scope, ownership | already enforced | product-studio, preflight, FILE_OWNERSHIP | Reused; code rules reference them. |
| API/data/security/reliability topics | documented but vague | engineering and safety knowledge packs | Cross-linked through canonical quality rules, not duplicated. |
| Review quality language | documented but vague | code-reviewer contract | Added rule-ID finding schema and classifications. |
| Test evidence boundaries | already enforced and duplicated | test contract, verification rules, phase fixtures | Reused; canonical rule unifies language. |
| Refactor invariants/no mixed feature work | already enforced | refactor contract and Phase 3 fixtures | Reused; requires violated IDs and remaining debt. |
| Stack conventions | missing | generic stack-selection guidance | Added only TypeScript, React, Next.js, Node, and Python modules because supported starters/runtime surfaces make them relevant. |
| Dependency rationale and report fields | missing | generic dependency hygiene references | Added templates, contracts, and fixtures. |
| Runtime behavior | runtime-only | browser/integration/database operations | Explicitly remains outside static proof. |
| Architecture/readability claims | unsuitable for deterministic validation | subjective/proportionate judgments | Checked structurally only; reviewer evidence remains human/source-bound. |

## Non-goals

This pass does not create a universal linter, force a technology stack, turn static checks into runtime claims, or replace project conventions with global preferences.
