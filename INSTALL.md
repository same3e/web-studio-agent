# Installation

## Requirements

- Codex desktop/CLI or Claude Code with plugin support.
- A local checkout for local development or a Git repository for shared installation.

## Validated local checks

From this repository, run `pwsh -File scripts/validate_migration.ps1` and `pwsh -File scripts/test_phase4.ps1`. These validate package structure locally; they do not install a global plugin.

## Codex

The Codex manifest is `.codex-plugin/plugin.json` and exposes `skills/`. This repository has not performed a global Codex installation in this phase, so no install command is claimed as tested. Use your Codex plugin manager’s local-plugin flow after validation and confirm both skills appear before relying on it.

## Claude Code

For local marketplace validation, run `claude plugin validate .` from the repository if the Claude CLI is available. For a local test, add the directory as a marketplace and install `web-studio-agent@web-studio-agent` at user scope, then run `/reload-plugins`. These commands must be executed by the user in their Claude environment; this repository does not modify global Claude configuration.

## Update and uninstall

Use the host’s plugin update/remove commands for the marketplace entry used during installation. Start a new thread after updating so skill metadata is reloaded. Uninstall removes the plugin; it must not delete project-local `.studio/` data.

## Security

Inspect third-party plugin sources before installation. Keep secrets and private project data outside plugin folders. Do not install unreviewed marketplace content with broad permissions.
