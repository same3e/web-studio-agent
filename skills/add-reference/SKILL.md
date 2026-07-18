---
name: add-reference
description: Analyze and catalog website URLs, supplied screenshots, visual fragments, or every new image in this studio's inbox as reusable web-design references. Use when a user shares inspiration, asks to process inbox materials, or wants reference grouping, analysis, and indexing automated without manually editing Markdown.
---

# Add reference

## Modes

- **Inbox batch (default):** Recursively find new assets in `inbox/` when the user asks to process all new images. Do not require a per-reference subfolder.
- **Explicit group:** Treat supplied images as one site when the user explicitly says they belong together; this overrides automatic grouping.
- **URL, folder, URL plus screenshots, or fragment:** Preserve the previous input modes and apply the same cataloging result.

## Inbox workflow

1. Run `$studio-setup` logic if the studio, `inbox/`, or reference index is missing. Read `inbox/processed-manifest.json`; create it with the documented empty schema if absent.
2. Recursively inventory `inbox/`, excluding `inbox/processed/`, `README.md`, and the manifest. Support PNG, JPG, JPEG, and WEBP directly. For GIF, BMP, TIFF, AVIF, HEIC, HEIF, or another common image type, attempt a PNG copy for the reference.
3. Calculate SHA-256 for every candidate source file. Skip a file whose hash already exists in the manifest. A changed file has a new hash and is a new version.
4. Inspect all unprocessed assets and group them only with clear evidence of the same site or direction: shared interface, logo, typography, visual system, content, or sequential screens. If unclear, keep assets separate. Treat an isolated hero, section, photo, type study, or palette as a `visual-fragment` reference.
5. For each group, infer one canonical storage category and create `references/<category>/<reference-id>/source/`. A reference is stored once only; do not duplicate its source or analysis into industry or style folders. Use a stable ID such as `ref-YYYYMMDD-short-slug`, adding a numeric suffix only on collision. Copy assets to `source/`; normalize filenames only on copies.
6. Classify the observed reference automatically before writing it: identify its primary **industry**, one primary **style family** from `knowledge/STYLE_INDEX.md`, one or more canonical **style tags**, concrete **visual modifiers**, **classification confidence** (`high`, `medium`, or `low`), and short **classification evidence** based only on observable visual traits. Use the canonical lowercase kebab-case tags and alias mappings in `knowledge/STYLE_INDEX.md`; do not create a synonym, title-case tag, or industry-specific tag. Infer only from visible evidence; use `mixed / unclear` or omit an uncertain tag instead of guessing. Keep industry and style separate: industry describes conversion and content patterns, while style describes visual language.
7. Write `analysis.md` using [analysis-format.md](references/analysis-format.md), with `Quick profile` immediately after `Source`. Clearly separate observations, adaptable patterns, and no-copy boundaries.
8. Add a concise entry containing every Quick profile field to `knowledge/REFERENCE_INDEX.md`, including industry, style family, style tags, visual modifiers, strongest sections, suitable project types, classification confidence, and concise classification evidence. Append manifest records only after the reference, analysis, and index entry all exist.
9. After confirming the copied source files, analysis, index entry, and manifest record exist, permanently delete the processed originals from `inbox/`. If any step fails, keep every original in place and do not write its manifest record.

## Grouping decisions

Read [inbox-processing.md](references/inbox-processing.md) before processing an inbox batch. Do not ask the user to resolve an ambiguous group: create separate references instead.

## Quality bar

Analyze visual direction, typography, color, grid, composition, pages, sections, UX, CTA, copy, motion, mobile, strengths, weaknesses, fit, adaptations, and no-copy boundaries. Set Quick profile fields from observed evidence; mark completeness and mobile evidence honestly. Do not invent details that cannot be observed. Use `knowledge/STYLE_INDEX.md` as a controlled vocabulary, but do not force a style label when evidence is weak.

## Commands

- `$add-reference Обработай все новые изображения из inbox.`
- `$add-reference Добавь этот сайт: [URL].`
- `$add-reference Все последние четыре изображения относятся к одному сайту.`
