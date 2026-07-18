# Platform specialist wrappers

## Canonical source

The role specifications and contracts in [`specialists/`](../../specialists/) are platform-neutral and authoritative. Platform wrappers only map a role to a host's supported format. They do not copy role methodology.

## Codex

Codex project-scoped custom agents are standalone TOML files under `.codex/agents/`; each has `name`, `description`, and `developer_instructions`. Phase 1 packages matching templates in [`platforms/codex/agents/`](../../platforms/codex/agents/) rather than installing them to a user-global directory. To enable them for a cloned project, copy these files to that project's `.codex/agents/` directory.

Explorer, reviewer, browser-QA, and first-pass security-auditor templates request `sandbox_mode = "read-only"`. Backend-builder, database-architect, and integration-builder are bounded write-capable templates. Runtime parent permission policy still takes precedence. Codex can run bounded subagents, but the orchestrator uses sequential fallback if those facilities are unavailable. No experimental or recursive delegation is required.

## Claude Code

Claude-compatible subagent definitions are packaged as Markdown templates in [`platforms/claude/agents/`](../../platforms/claude/agents/). To enable them in a Claude Code project, copy them to `.claude/agents/`. Each template has frontmatter for name, description, and tools, and references its canonical contract. Backend/database/integration use bounded write tools; security-auditor uses read-only tools for first pass. They do not depend on Agent Teams; that remains optional future work.

## Limitations and installation scope

The repository contains templates only. It does not modify `~/.codex/agents/`, `~/.claude/agents/`, or any user-global configuration. A host that does not load project-local custom agents still receives the same sequential role flow through `product-studio`. Unverified host-specific fields are intentionally absent.

Phase 3A adds refactor-engineer and performance-auditor as read-only first-pass wrappers, plus bounded release-engineer and operations-engineer wrappers. Automatic host loading remains unverified.
