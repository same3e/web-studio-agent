# Installation

## Claude Code

### Install from GitHub

The marketplace and plugin manifests both identify this plugin as `web-studio-agent`. In Claude Code, run:

```text
/plugin marketplace add same3e/web-studio-agent
/plugin install web-studio-agent@web-studio-agent
/reload-plugins
```

Equivalent terminal commands are:

```bash
claude plugin marketplace add same3e/web-studio-agent
claude plugin install web-studio-agent@web-studio-agent
```

Start a new Claude Code session if the installed plugin is not immediately visible.

### Verify the skills

Run either command in Claude Code:

```text
/web-studio-agent:product-studio
/web-studio-agent:add-reference
```

### Update

```text
/plugin marketplace update web-studio-agent
/reload-plugins
```

### Uninstall

```text
/plugin uninstall web-studio-agent@web-studio-agent
```

Uninstalling the plugin must not delete project-local `.studio/`, the permanent personal reference library, or generated project files.

## Codex

### Current availability

Web Studio Agent is not yet published in the Codex Plugin Directory, so public one-click installation is not currently available. `.codex-plugin/plugin.json` and the package structure are structurally validated; real Codex installation, user-facing skill discovery, and native specialist loading remain unverified.

### Local development test

Prepare a checkout:

```powershell
git clone https://github.com/same3e/web-studio-agent.git
cd web-studio-agent
pwsh -NoProfile -File scripts/validate_migration.ps1
pwsh -NoProfile -File scripts/test_phase4.ps1
```

Then perform this manual runtime test:

1. Open ChatGPT Codex Desktop and open **Plugins**.
2. Select **Create a new plugin**.
3. Check whether the current interface provides local-folder, repository-import, or upload import.
4. If it does, select the cloned repository, start a new thread, and confirm `product-studio` and `add-reference` appear.

Steps 3–4 are not yet completed runtime verification. If the interface has no local repository import, the remaining public distribution path is publication in the Codex Plugin Directory. Cloning the repository alone does not install the plugin.

### Public installation after directory publication

After publication, the intended flow is: open Codex, open **Plugins**, find **Web Studio Agent**, review its two skills, install it, and start a new thread. This is not currently available for this plugin.

## Project data

Project-specific decisions, selected references, approvals, plans, and reports live in `<project-root>/.studio/`.

The permanent personal reference library is resolved from `WEB_STUDIO_AGENT_HOME`: `%USERPROFILE%\.web-studio-agent\` on Windows and `$HOME/.web-studio-agent/` on macOS/Linux. Removing a plugin does not remove either location.

## Troubleshooting

### Claude plugin is not visible

1. Run `/plugin marketplace update web-studio-agent`.
2. Run `/reload-plugins`.
3. Start a new Claude Code session.
4. Confirm the marketplace and plugin names are both `web-studio-agent`.
5. From a repository checkout, run `claude plugin validate .` when the CLI is available.

### Codex plugin is not visible

Confirm the plugin was actually imported through the Codex interface or published in the Plugin Directory, restart Codex, start a new thread, and verify `.codex-plugin/plugin.json` exists. Cloning the repository does not install the plugin.

## Runtime verification status

- Manifests and package structure: structurally validated.
- Deterministic repository tests: passed.
- Claude plugin installed in a real host: not verified by this repository’s deterministic suite.
- Codex plugin installed in a real host: not verified.
- User-facing skills discovered in a real host: not verified.
- Native agents loaded in a real host: not verified.
- Sequential fallback: structurally tested.
