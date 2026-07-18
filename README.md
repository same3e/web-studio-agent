# Web Studio Agent

Web Studio Agent is an open-source workflow for Codex and Claude Code that turns a product idea into an approved, implemented, and verified website or web application. It keeps decisions and evidence close to the project instead of treating a successful build as the end of the work.

## What it does

It guides an idea through discovery, scope, technical decisions, references, distinct concepts, explicit approval, implementation, and verification. It supports landing pages, business websites, SaaS, dashboards, internal tools, AI applications, PWAs, redesigns, and refactoring of existing projects.

It selects specialist work from the project surface, so a simple landing page does not inherit a database or operations process intended for a persistent application.

It exists to help coding agents avoid starting before approval, inventing product facts or fake form success, selecting unnecessary backend/database/security/release work, declaring completion after a build, or confusing concept renders with browser evidence.

## Who it is for

- Developers building a product or client project with Codex or Claude Code.
- Teams that want project decisions, scope, and verification evidence recorded in files.
- Existing projects that need an audit, a bounded refactor, or a clearer delivery workflow.

## Skills

### `product-studio`

Inspects an existing repository, performs inference-first discovery, separates facts and assumptions from active, deferred, and rejected scope, recommends an approach, searches the personal reference library, proposes distinct concepts, waits for explicit approval, coordinates relevant internal agents, and records checks, blockers, and unavailable evidence honestly.

### `add-reference`

Analyzes URLs, screenshots, application screens, flows, and local images. It stores reusable references in the permanent personal library; classifies industry, style, role, section, platform, pattern, and suitable project type; detects exact file-hash and normalized-URL duplicates; records reusable principles and no-copy boundaries; and links approved references to the active project. It does not claim perceptual-image duplicate detection.

## Internal agents

Internal agents are selected automatically from the active project surface; they are not user commands. A static site does not require database or operations work. When native subagents are unavailable, `product-studio` uses the same contracts sequentially.

| Agent | Responsibility |
| --- | --- |
| `repo-explorer` | Maps an existing codebase before changes. |
| `frontend-builder` | Implements approved visible web surfaces. |
| `backend-builder` | Builds approved APIs, server logic, and jobs. |
| `database-architect` | Designs persistence, migrations, and data constraints. |
| `integration-builder` | Implements approved external-provider adapters. |
| `test-engineer` | Adds and runs applicable automated tests. |
| `code-reviewer` | Reviews implementation risks and regressions. |
| `security-auditor` | Audits relevant auth, data, server, and integration risk. |
| `refactor-engineer` | Plans and verifies approved behavior-preserving refactors. |
| `performance-auditor` | Separates measured performance evidence from risks and hypotheses. |
| `browser-qa` | Verifies runnable visible journeys in a browser. |
| `release-engineer` | Prepares release evidence, packaging, and rollback gates. |
| `operations-engineer` | Defines proportionate operational readiness for persistent services. |

## Installation

### Claude Code

```text
/plugin marketplace add same3e/web-studio-agent
/plugin install web-studio-agent@web-studio-agent
/reload-plugins
```

Then run `/web-studio-agent:product-studio` or `/web-studio-agent:add-reference`. A new Claude Code session also reloads plugin metadata.

### Codex

Web Studio Agent is not yet published in the Codex Plugin Directory. Its Codex manifest is structurally validated, but public installation and local host discovery remain runtime-unverified. See [INSTALL.md](INSTALL.md) for the current local test procedure.

## Project data

`<project-root>/.studio/` contains project-specific decisions, scope, selected references, approval, implementation plans, and verification reports.

Canonical reusable references live in the personal library resolved from `WEB_STUDIO_AGENT_HOME`:

- Windows: `%USERPROFILE%\.web-studio-agent\`
- macOS/Linux: `$HOME/.web-studio-agent/`

`.studio/references/` stores project links, usage, conflicts, gaps, and no-copy boundaries—not a copied global library. Private project data must not live in plugin source or plugin cache.

## Current status

- Architecture and deterministic validation: complete.
- Platform runtime verification: partial.
- Stable release readiness: not yet confirmed.

Manifest and package structure are validated, and sequential fallback is structurally tested. Clean Codex and Claude installation, native specialist auto-loading, fresh-chat black-box workflows, real browser QA, generated API/database runtime, and real performance measurement remain unverified. Workflow configuration is present; the latest hosted GitHub Actions run was not verified in this environment.

## License

[MIT](LICENSE)
