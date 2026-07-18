# Code quality

## Purpose and precedence

Use this language-agnostic standard for implementation, code review, testing, and approved refactoring. Resolve rules in this order: security, correctness, data integrity, factual and approval constraints; approved project requirements and acceptance criteria; existing repository architecture and conventions; approved technical decision; these canonical rules; applicable stack defaults; model preference. A valid repository convention overrides a global default, never a hard security or correctness rule.

Load only approved stack modules detected from repository manifests and the technical decision. Do not impose a language, framework, package manager, or UI library.

## Rule schema

Each rule has `id`, `category`, `strength` (`hard`, `default`, or `recommendation`), `rule`, `rationale`, `applies_when`, `exceptions`, and `evidence`. The compact catalog below uses those fields in columns; an approved exception records its rule ID, reason, owner, and validation impact in the project plan or report.

| ID | Category / strength | Rule | Applies when / exceptions | Evidence |
| --- | --- | --- | --- | --- |
| CQ-01 | Repository awareness / hard | Inspect architecture, manifests, dependencies, conventions, and runnable commands before editing. | All implementation; none. | Exploration/report evidence. |
| CQ-02 | Repository awareness / hard | Preserve valid conventions unless an approved technical reason changes them. | Existing code; no stylistic replacement. | Plan and diff. |
| CQ-03 | Scope / hard | Make the smallest complete approved change; do not mix unrelated feature, refactor, dependency, or migration work. | All changes; explicit approved combined scope only. | Scope mapping. |
| CQ-04 | Scope / hard | Do not expand scope silently. | All changes; user approval required for material expansion. | Approval record. |
| CQ-05 | Structure / default | Give each module one primary responsibility and keep public interfaces minimal. | Proportionate to active code; no universal line limit. | Review/diff. |
| CQ-06 | Architecture / hard | Keep domain logic independent of UI, transport, storage, and framework glue unless approved architecture requires otherwise. | Material domain logic; small local code may remain direct. | Technical decision/review. |
| CQ-07 | Architecture / default | Do not create abstractions before stable repetition or a clear boundary; avoid dumping-ground modules. | New abstractions; named, bounded modules are allowed. | Review rationale. |
| CQ-08 | Boundaries / hard | UI must not access privileged infrastructure directly; active providers stay behind an explicit boundary or adapter. | Privileged/provider surface; approved direct boundary only. | Contract and source review. |
| CQ-09 | Clarity / default | Prefer explicit readable code and domain names; functions honour their names and avoid unrelated hidden effects. | All code; performance-critical exception documented. | Review. |
| CQ-10 | Clarity / default | Comments explain why, constraints, risk, or non-obvious decisions; remove stale code, imports, debug output, and commented-out implementations. | All changed files; retained diagnostics require reason. | Diff/static check where configured. |
| CQ-11 | Maintainability / default | TODOs state reason and completion condition. | New TODOs; no context-free markers. | Review. |
| CQ-12 | Contracts / hard | Validate untrusted API, form, environment, storage, URL, webhook, file, and provider input at runtime; static types are insufficient. | Every untrusted boundary; documented trusted boundary only. | Tests/contract evidence. |
| CQ-13 | Contracts / hard | Handle null, missing, partial, and malformed values explicitly; public APIs, events, jobs, and stored formats have explicit contracts. | Relevant boundary/state; not applicable only when absent. | Schema/contract/tests. |
| CQ-14 | Types / hard | Do not use unbounded unsafe types or assertions to bypass correctness; assertions require a real invariant. | Typed stacks; approved contained interop exception. | Review and validation. |
| CQ-15 | Contracts / default | Derive duplicate contracts from a canonical schema/shared contract where safely possible. | Repeated external contracts; justified separate consumer model allowed. | Design/review. |
| CQ-16 | State / default | Keep state at lowest practical owner; do not store derived state unless caching or synchronization requires it. | Stateful code; documented cache/sync exception. | Review/tests. |
| CQ-17 | Effects / hard | Isolate side effects from pure business logic where proportionate; mutations have a clear owner and observable result. | Async/mutations; small adapter exception. | Tests/review. |
| CQ-18 | Async / hard | Consider duplicate execution, races, stale responses, cancellation, retry, timeout, and idempotency where applicable. | Async, retries, writes; record non-applicable factors. | Tests/runtime evidence. |
| CQ-19 | State / hard | Avoid hidden global mutable state, especially for request-specific data. | Server/client runtime; approved lifecycle singleton only. | Review. |
| CQ-20 | Errors / hard | Do not swallow errors; empty catches or log-only handling require an explicitly safe-to-ignore documented reason. | Error paths; safe cleanup exception documented. | Tests/review. |
| CQ-21 | Errors / hard | Handle failures at the correct boundary; user errors are safe, specific, actionable, and expected business failures are not unknown crashes. | User/server surface; no sensitive detail. | Tests/browser/runtime. |
| CQ-22 | Logging / hard | Never log secrets, credentials, sensitive data, or full untrusted payloads; use structured project-appropriate logs for persistent runtime. | Logs/server surface; redaction evidence. | Review/runtime config. |
| CQ-23 | Dependencies / hard | Check existing dependencies and do not add one for trivial safe behavior; record material dependency reason and impact. | Dependency change; approved security/maintenance exception. | Plan/report/lockfile. |
| CQ-24 | Dependencies / hard | Do not change package manager, lockfile strategy, framework, runtime, or build system without approved benefit; remove newly introduced unused dependencies. | Tooling/dependency changes. | Technical decision/diff. |
| CQ-25 | Testing / hard | Derive tests from approved observable behavior and add automatable regression coverage for fixed defects. | Changed behavior/bug fix; documented non-automatable limit. | Test report. |
| CQ-26 | Testing / hard | Keep tests deterministic and independent; do not hide failures with broad mocks, sleeps, ignored assertions, retries, snapshots, or catch-all fallbacks. | Automated tests; justified controlled fake allowed. | Test review/results. |
| CQ-27 | Testing / hard | Do not change valid behavior merely to make a weak test pass; static inspection is not executed runtime verification. | Tests/review; none. | Results classification. |
| CQ-28 | Evidence / hard | Report commands, pass/fail/skip/block status, and unverified areas; builds and units do not prove browser, integration, data, deployment, or production behavior. | Completion reports; none. | Build/verification report. |
| CQ-29 | Security / hard | Secrets never enter source, bundles, logs, screenshots, fixtures, or committed configuration. | All work; none. | Review/scans. |
| CQ-30 | Security / hard | Authentication is not authorization; enforce authorization at trusted server/data boundaries and treat external input as untrusted. | Auth/data/API surfaces; none. | Security/contract tests. |
| CQ-31 | Data safety / hard | Follow approved sensitive-data collection, retention, logging, and deletion rules; destructive operations need validation, authorization, and recovery consideration. | Sensitive/destructive surface; none. | Plan/tests/runbook. |
| CQ-32 | Performance / default | Avoid obvious N+1 access, duplicate requests, unbounded work, unnecessary client boundaries, repeated heavy work, and uncontrolled render loops. | Relevant surface; evidence-based exception. | Review/measurement. |
| CQ-33 | Performance / hard | Do not claim performance without measurement or weaken correctness, accessibility, maintainability, or security for an optimization. | Performance claim/change; none. | Measurement evidence. |
| CQ-34 | Completion / hard | Claim only evidence actually obtained; state known debt, accepted risks, deferred cleanup, and unavailable commands explicitly. | All reports; none. | Project reports. |

## Specialist application

Implementation specialists load this file plus only applicable approved stack modules, preserve conventions, and report deviations, dependencies, tests, and unavailable checks. Test engineers verify only testable behavior. Refactor engineers identify violated IDs, preserve defined invariants, keep feature work separate, and report remaining debt. Reviewers classify each finding against this catalog; browser/runtime claims remain runtime evidence.
