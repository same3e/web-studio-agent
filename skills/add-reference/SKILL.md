---
name: add-reference
description: Analyze, classify, index, deduplicate, or reanalyze website and application references supplied as URLs, screenshots, images, local files, screen collections, or flows. Use only for reference work, not product discovery, stack selection, or implementation.
---

# Add reference

## Orchestration contract

1. Locate the target project and inspect `.studio/` plus `knowledge/KNOWLEDGE_INDEX.md`. Initialize only missing `.studio/references/` files and folders from `templates/studio/`; never overwrite project material.
2. Accept public URLs, website pages, dashboards, web/mobile application screens, screenshots, local images, full-page captures, related screen sets, and interface flows.
3. Keep source evidence project-local in `.studio/references/`. Do not place mutable client reference data in this plugin, global knowledge, or a public release.
4. Use multiple roles when supported by evidence: industry, visual, product, UX, interaction, content, and overlap. Do not force an uncertain classification.
5. Write specific observations to individual analyses and maintain project-local reference, style, industry, product-pattern, and UX-pattern indexes. Reanalysis updates the existing record with a dated note rather than silently discarding prior evidence.
6. Detect duplicates from source URL, content hash, and clear visual/source identity. Link duplicates or versions; do not multiply source assets.
7. Record reusable principles, risks, anti-patterns, and no-copy boundaries. Never retain copied source code, cookies, tokens, private data, full original site copy, or unauthorized downloadable assets.
8. Do not delete original inputs without explicit user permission. Do not automatically commit private screenshots.

## Analysis minimum

Every analysis records source/title/type, industry, product type/platform, roles, visual system, typography/spacing/layout, information architecture, product/UX/interaction/content patterns, useful states, suitable product types, reusable principles, risks, anti-patterns, and elements not to copy. Replace vague labels such as “modern and minimal” with observable evidence.

## Handoff

`add-reference` does not select a technical stack, create concepts, or implement. It leaves evidence in `.studio/references/` for `product-studio` to select and synthesize.
