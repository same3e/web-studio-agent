# Context compilation

## Purpose

Compile small, role-aware project context packages without replacing canonical `.studio/` records. The compiler selects pointers, compact rule summaries, current evidence, and relevant repository paths; it never embeds source-code bodies, secrets, or complete canonical rule text.

## Inputs and routing

Inputs are project state and snapshot, approved scope and records, repository map, role, task, workflow mode, affected paths, rule route index, selected reference cards, and latest relevant delta. Resolve project facts and decisions before global defaults. Select only the role's active surface; request explicit additional context when the package is insufficient.

## Modes and budgets

| Mode | Non-code target / warning | Concepts | Cards | Previous reports |
| --- | --- | --- | --- |
| lean | 8,000 / 12,000 approximate tokens | 1 | 1–3 | latest only |
| standard | 16,000 / 24,000 | up to 3 | 3–5 | latest relevant |
| thorough | 30,000 / 45,000 | up to 3 | as needed | all material current evidence |

Counts use UTF-8 characters divided by four and are approximate, not provider token counts. These are context-package targets, never a reason to skip approval, facts, security, acceptance criteria, test, browser, or provenance gates.

## Selection and omission

Hard relevant rules, active approval/scope/facts/contracts, current blockers, and required evidence cannot be trimmed. On warning, omit duplicate prose, superseded reports, rejected concepts, old remediation history, low-priority recommendations, optional rule details, secondary cards, then unrelated repository documentation. If still over budget, mark `exceeded`, identify contributors, and stage the work; never silently truncate.

Exclude `superseded`, `rejected`, `historical`, and runtime-cache material by default. Prefer active-context pointers and latest relevant evidence rather than moving existing files. Full canonical details load only for implementation, exceptions, violations, remediation, or an explicit contract requirement.

## Caches and invalidation

Rebuild the repository map when manifests, lockfiles, framework/test/database configuration, source roots, or ownership map change. Rebuild resolved rules when state, mode, stack, active surface, approved concept, taste profile/override, or rule index changes. Rebuild a role package when task, changed files, active scope, relevant project record, or prior delta changes. Use content hashes where practical; timestamps alone are insufficient.

## Safety and limits

Deny environment, secret, credential, cookie, sensitive ignored, and full payload files. A deny-pattern check is not complete secret detection. Static context validation proves only manifest structure and routing; it does not prove host-session reuse, model file reading, or runtime behavior.

## Same-session preference

When host support and risk allow, lean work may run implementation, tests, and internal self-review sequentially in one context while retaining contracts and delta reports. Independent review remains required when risk or criteria require it. Security, migrations, and high-risk release decisions are not collapsed to save context; host reuse is not claimed as verified.
