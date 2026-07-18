# Current-state audit — Phase 1

Audit date: 2026-07-18. This record describes the repository before the Phase 1 specialist additions.

## Repository and user-facing surface

- Active skills are only [`skills/product-studio/SKILL.md`](../../skills/product-studio/SKILL.md) and [`skills/add-reference/SKILL.md`](../../skills/add-reference/SKILL.md). The release validator enforces exactly two `SKILL.md` files below `skills/` in [`scripts/validate_migration.ps1`](../../scripts/validate_migration.ps1).
- `product-studio` owns discovery through verification; `add-reference` owns project-local reference intake and analysis. Their boundaries are explicit in their respective skill files.
- Methodology is modular under [`knowledge/`](../../knowledge/) and routed by [`knowledge/KNOWLEDGE_INDEX.md`](../../knowledge/KNOWLEDGE_INDEX.md). Templates are under [`templates/studio/`](../../templates/studio/); the current validator is [`scripts/validate_migration.ps1`](../../scripts/validate_migration.ps1).

## Current orchestration and state

- The current sequence is `uninitialized → discovery → requirements → technical-decision → references-needed → concepts → awaiting-approval → approved → implementation → verification → complete`, defined in [`knowledge/core/PROJECT_STATE.md`](../../knowledge/core/PROJECT_STATE.md), [`skills/product-studio/SKILL.md`](../../skills/product-studio/SKILL.md), and [`docs/PROJECT_STATE_MACHINE.md`](../PROJECT_STATE_MACHINE.md).
- Project state is project-local in `.studio/PROJECT_STATE.md`; current initialization templates include brief, facts, assumptions, scope, concepts, copy, design, plan, acceptance, build, verification, technical decision, and reference indexes (see [`templates/studio/`](../../templates/studio/)).
- Mandatory evidence is state-dependent in the table in [`skills/product-studio/SKILL.md`](../../skills/product-studio/SKILL.md). Existing templates do not yet express a deterministic implementation-preflight decision, artifact provenance, or a content ledger.

## Validation and packaging

- [`scripts/validate_migration.ps1`](../../scripts/validate_migration.ps1) validates skill count/frontmatter, knowledge-index coverage, local-link safety, manifests, template initialization, legacy migration links, release artifacts, examples, and CI linkage.
- Codex packaging is [` .codex-plugin/plugin.json`](../../.codex-plugin/plugin.json) (path has no leading space in the filesystem); its `skills` entry is `./skills/`. Skill UI cards are [`skills/product-studio/agents/openai.yaml`](../../skills/product-studio/agents/openai.yaml) and [`skills/add-reference/agents/openai.yaml`](../../skills/add-reference/agents/openai.yaml).
- Claude packaging is [` .claude-plugin/plugin.json`](../../.claude-plugin/plugin.json) and [` .claude-plugin/marketplace.json`](../../.claude-plugin/marketplace.json). CI invokes the validator from [`.github/workflows/validate.yml`](../../.github/workflows/validate.yml).

## Reference and project-data model

- `add-reference` stores source evidence and analysis only in `.studio/references/`, using [`templates/studio/references/ANALYSIS.template.md`](../../templates/studio/references/ANALYSIS.template.md), indexes, and the rules in [`knowledge/references/`](../../knowledge/references/).
- The existing model distinguishes references and no-copy observations, but not generated concept renders, production assets, browser captures, or temporary QA captures as distinct artifact classes.
- The plugin already keeps mutable project facts, screenshots, concepts, and copy out of global plugin directories in [`skills/product-studio/SKILL.md`](../../skills/product-studio/SKILL.md) and [`skills/add-reference/SKILL.md`](../../skills/add-reference/SKILL.md).

## Duplications, gaps, and risks

- State transition text is duplicated between the product skill, `PROJECT_STATE.md`, and `PROJECT_STATE_MACHINE.md`. The specialist model will make one canonical state-machine document authoritative while retaining these entry points for compatibility.
- The post-approval output list in `product-studio` names records but does not require a machine-readable preflight result; implementation can therefore be described before the full approved-record set is evidenced.
- Current verification templates do not force a distinction between static source inspection, concept imagery, executed browser checks, or production evidence.
- A technical decision template exists at [`templates/studio/TECH_DECISION.template.md`](../../templates/studio/TECH_DECISION.template.md), but its headings do not yet cover all active/deferred surfaces, operational burden, security/privacy, or deliberately excluded complexity.
- Introducing specialists risks role overlap, conflicting edits, duplicated methodology in platform wrappers, and accidentally exposing internal roles as user commands. Phase 1 therefore keeps roles outside `skills/`, gives read-only roles no writes, and specifies file ownership for writers.

## Compatibility-sensitive files

Keep the two active skill paths and their names, both plugin manifests, existing knowledge files, `templates/studio/` initialization behavior, `scripts/validate_migration.ps1`, `.github/workflows/validate.yml`, and release documents backward compatible. No existing knowledge file is removed in Phase 1.
