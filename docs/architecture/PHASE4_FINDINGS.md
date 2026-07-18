# Phase 4 findings

| ID | Classification | Evidence | Subsystem | Owner | Remediation / regression | Status |
| --- | --- | --- | --- | --- | --- | --- |
| P4-001 | environment limitation | `git rev-parse --is-inside-work-tree` failed: `detected dubious ownership` | repository integrity | environment/user | Do not change global Git configuration; perform non-Git validation. | unverified source-control status |
| P4-002 | documentation / packaging hygiene | Root `.gitignore` did not exclude `.studio/`, `.env*`, `.studio-phase4/`, or Phase 3 disposable output. | release package hygiene | release-engineer | Added narrow ignore rules; validate package candidate exclusion. | remediated, pending regression |
| P4-003 | platform limitation | `codex --help` could not start because host process access was denied; Claude CLI is not installed. | Codex/Claude runtime loading | platform environment | Keep host runtime loading unverified; validate packaging/schema only. | unverified |
| P4-004 | test | Initial Phase 4 package-path detector interpreted PowerShell regex escapes such as `:\\s` as a Windows path. | Phase 4 package audit | release-engineer | Narrowed the detector to actual local-machine path prefixes; rerun Phase 4 suite. | remediated |
| P4-005 | implementation | Phase 4 SaaS fixture declared `Production SaaS handoff`, but routing did not select `release-engineer`. | Phase 3 routing | product-studio | Added the explicit production-SaaS-handoff selector; `scripts/test_phase4.ps1` exercises it. | remediated, pending full regression |
