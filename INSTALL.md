# Installation

## Requirements

- Codex desktop/CLI or Claude Code with plugin support.
- A local checkout of this repository.
- PowerShell 7 for the repository validation commands.

## Verify the checkout

Run the structural checks before attempting a host installation:

```powershell
pwsh -NoProfile -File scripts/validate_migration.ps1
pwsh -NoProfile -File scripts/test_phase4.ps1
```

These validate manifests, skill structure, templates, knowledge routing, wrappers, and deterministic fixtures. They do not install the plugin or prove host skill discovery.

## Claude Code

The checkout provides `.claude-plugin/plugin.json` and `.claude-plugin/marketplace.json`.

1. Use Claude Code’s supported local-marketplace flow to add this checkout.
2. Install `web-studio-agent@web-studio-agent` at the scope you intend to use.
3. Run `/reload-plugins` or start a new Claude Code session.
4. Confirm that `product-studio` and `add-reference` are discoverable.

If the Claude CLI is available, `claude plugin validate .` is a useful additional check. Local marketplace installation and runtime discovery have not been verified by this repository’s deterministic suite.

## Codex

The checkout provides `.codex-plugin/plugin.json`, which exposes `./skills/`.

1. Use Codex’s supported local-plugin or plugin-manager flow to select this checkout.
2. Start a new task after installation so the skill metadata is refreshed.
3. Confirm that `product-studio` and `add-reference` are discoverable.

No Codex CLI or marketplace installation command is claimed as runtime-tested here. The manifest and package structure are structurally validated; host installation, discovery, and native specialist loading still need a manual check in a compatible Codex environment.

## Local development

Edit the checkout directly, then run the relevant validation. For a full deterministic regression pass:

```powershell
pwsh -NoProfile -File scripts/validate_migration.ps1
pwsh -NoProfile -File scripts/test_phase1_behavioral.ps1
pwsh -NoProfile -File scripts/test_phase1_runtime.ps1
pwsh -NoProfile -File scripts/test_phase2_contracts.ps1
pwsh -NoProfile -File scripts/test_phase3.ps1
pwsh -NoProfile -File scripts/test_phase4.ps1
```

Project state belongs in `<project-root>/.studio/`. The permanent reference library is resolved from `WEB_STUDIO_AGENT_HOME` and defaults to `%USERPROFILE%\.web-studio-agent\` on Windows or `$HOME/.web-studio-agent/` on macOS/Linux.

## Update and uninstall

Use the host’s update/remove action for the marketplace or local-plugin entry you added. Reload the plugin metadata or begin a new task after an update.

Uninstalling removes the host’s plugin entry. It does not delete a project’s `.studio/` directory or the personal reference library.

## Runtime-verification limits

The repository structurally validates package manifests and sequential fallback. Clean Codex installation, clean Claude installation, user-facing skill discovery, native specialist auto-loading, fresh-chat workflows, and real browser/API/database/performance checks require a compatible host runtime and remain separate manual verification steps.
