---
name: add-reference
description: Analyze, classify, index, deduplicate, or reanalyze website and application references supplied as URLs, screenshots, images, local files, screen collections, or flows. Use only for reference work, not product discovery, stack selection, or implementation.
---

# Add reference

## Orchestration contract

1. Locate the target project and inspect `.studio/` plus `knowledge/KNOWLEDGE_INDEX.md`. Initialize only missing `.studio/references/` files and folders from `templates/studio/`; never overwrite project material.
2. Accept public URLs, website pages, dashboards, web/mobile application screens, screenshots, local images, full-page captures, related screen sets, and interface flows.
3. Ingest canonical source evidence into the permanent personal library resolved from `WEB_STUDIO_AGENT_HOME` (default `%USERPROFILE%\.web-studio-agent` on Windows, `$HOME/.web-studio-agent` elsewhere), never inside a plugin cache, plugin source, or individual project. Keep project selection/usage/conflict/gap records under `.studio/references/`; do not destructively remove older local copies.
4. Use multiple roles when supported by evidence: industry, visual, product, UX, interaction, content, and overlap. Do not force an uncertain classification.
5. Write specific observations to individual analyses and maintain project-local reference, style, industry, product-pattern, and UX-pattern indexes. Reanalysis updates the existing record with a dated note rather than silently discarding prior evidence.
6. Use `scripts/Add-ReferenceLibraryItem.ps1` for local-file or URL-metadata ingest and `scripts/Find-ReferenceLibraryMatch.ps1` for matching. Detect deterministic exact file-hash and normalized-URL duplicates, link an existing stable ID rather than copying it, generate indexes, and report the library path and outcome. Do not claim perceptual matching unless implemented.
7. Record reusable principles, risks, anti-patterns, and no-copy boundaries. Never retain copied source code, cookies, tokens, private data, full original site copy, or unauthorized downloadable assets.
7a. When a reference is selected for an approved project, create or update a compact project-local card under `.studio/references/cards/` that points to the full analysis, records only observed principles and no-copy boundaries, and is routed only to relevant visual roles.
8. Do not delete original inputs without explicit user permission. Do not automatically commit private screenshots.

## Analysis minimum

Every analysis records source/title/type, industry, product type/platform, roles, visual system, typography/spacing/layout, information architecture, product/UX/interaction/content patterns, useful states, suitable product types, reusable principles, risks, anti-patterns, and elements not to copy. Replace vague labels such as “modern and minimal” with observable evidence.

## Handoff

`add-reference` does not select a technical stack, create concepts, or implement. It leaves approved project links and evidence in `.studio/references/` for `product-studio` to select and synthesize; a library match remains a proposal until project approval.
