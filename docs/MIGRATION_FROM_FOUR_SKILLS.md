# Migration from four skills

## Status

The active entry points are `skills/product-studio/SKILL.md` and `skills/add-reference/SKILL.md`. Migration validation passed before legacy removal. Original skills are preserved in `backups/four-skills-pre-product-studio-2026-07-18/`; removed release-tree material is preserved in `backups/phase3-removed-from-release-tree-2026-07-18/`.

| Old skill | Old rule | Old file | New skill | New knowledge document | Status | Validation result |
| --- | --- | --- | --- | --- | --- | --- |
| `studio-setup` | inspect workspace and preserve user material | `SKILL.md`, `workspace-contract.md` | product-studio / add-reference | `core/PROJECT_FILE_RULES.md`, `safety/DESTRUCTIVE_ACTIONS.md` | migrated | seed + migration validation |
| `studio-setup` | create missing studio structure | `SKILL.md` | product-studio / add-reference | `core/PROJECT_STATE.md`, templates/studio | migrated | template and initialization test |
| `studio-setup` | persistent defaults and stack exception | `SKILL.md` | product-studio | `ui/VISUAL_DIRECTION.md`, `engineering/STACK_SELECTION.md` | migrated | index coverage |
| `add-reference` | URL, screenshot, inbox and grouping modes | `SKILL.md`, `inbox-processing.md` | add-reference | `references/REFERENCE_WORKFLOW.md`, `references/REFERENCE_ROLES.md` | migrated | skill scope and index checks |
| `add-reference` | hash duplicate/version detection | `SKILL.md`, `scan_inbox.py` | add-reference | `references/REFERENCE_WORKFLOW.md` | migrated | duplicate-fixture test |
| `add-reference` | canonical storage and safe original preservation | `SKILL.md`, `inbox-processing.md` | add-reference | `core/PROJECT_FILE_RULES.md`, `safety/DESTRUCTIVE_ACTIONS.md` | migrated | no-delete policy check |
| `add-reference` | evidence-based style classification | `SKILL.md`, `analysis-format.md`, `STYLE_INDEX.md` | add-reference | `references/STYLE_CLASSIFICATION.md`, `references/REFERENCE_ANALYSIS.md` | migrated | required analysis fields check |
| `add-reference` | no-copy boundaries and reference index | `SKILL.md`, `REFERENCE_INDEX.md` | add-reference | `references/NO_COPY.md`, `references/REFERENCE_APPLICATION.md` | migrated | no-copy check |
| `new-site-project` | inspect materials before questions | `SKILL.md` | product-studio | `business/PROJECT_DISCOVERY.md`, `core/USER_INTERACTION.md` | migrated | routing check |
| `new-site-project` | fact classification and offer gate | `SKILL.md` | product-studio | `business/CONFIRMED_FACTS.md`, `copy/FACT_BASED_COPY.md` | migrated | factual-copy check |
| `new-site-project` | conversion-first / brand-led modes | `SKILL.md`, `COPY_RULES.md` | product-studio | `copy/LANDING_PAGE_COPY.md`, `ux/CONVERSION.md` | migrated | marketing workflow fixture |
| `new-site-project` | industry/style reference synthesis | `SKILL.md` | product-studio | `references/REFERENCE_SELECTION.md`, `references/REFERENCE_APPLICATION.md` | migrated | concept gate check |
| `new-site-project` | exactly distinct concepts and approval wait | `SKILL.md`, `concept-format.md` | product-studio | `core/APPROVAL_GATES.md`, `core/PROJECT_STATE.md` | migrated | state-transition fixture |
| `new-site-project` | post-approval project docs | `SKILL.md`, root templates | product-studio | templates/studio and `core/SOURCE_OF_TRUTH.md` | migrated | template coverage check |
| `build-site` | approved-concept gate and scope preservation | `SKILL.md` | product-studio | `core/APPROVAL_GATES.md`, `product/PRODUCT_REQUIREMENTS.md` | migrated | implementation-block fixture |
| `build-site` | approved/factual copy and proof constraints | `SKILL.md`, `COPY_RULES.md` | product-studio | `copy/FACT_BASED_COPY.md`, `verification/FACT_AUDIT.md` | migrated | factual-copy check |
| `build-site` | responsive, a11y, motion, performance safeguards | `SKILL.md`, `verification-checklist.md`, `UX_RULES.md` | product-studio | `ux/ACCESSIBILITY.md`, `ui/RESPONSIVE_DESIGN.md`, verification docs | migrated | verification routing check |
| `build-site` | type/lint/build/browser verification and report | `SKILL.md`, checklist, build template | product-studio | `verification/VERIFICATION_WORKFLOW.md`, `verification/BUILD_REPORT.md` | migrated | report-template check |
| all four | H1-first hero exception rule | root/knowledge/templates/skills | product-studio | `ui/TYPOGRAPHY.md`, `copy/COPY_RULES.md` | migrated, conditional | marketing-only routing check |
| all four | data preservation, reversible decisions, no fabricated claims | root rules and skills | both | safety documents | migrated | safety scan |

## Legacy removal result

- The old `.agents/skills/` entry points and obsolete `public-release/` copy were removed from the release tree after validation.
- Flat legacy knowledge, root templates, historical project/example material, and old migration scaffold were removed from the release tree and retained only under `backups/`.
- The routed modular knowledge tree, `templates/studio/`, and two active skills are the release structure.

## Retirement condition

Legacy entry points were removed only after the migration validator passed and all mapping rows remained `migrated`. Keep backups out of any public commit; they contain historical material and are not release artifacts.
