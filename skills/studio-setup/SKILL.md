---
name: studio-setup
description: Initialize or maintain a repo-scoped web-studio workspace: create its knowledge base, reference library, templates, project folders, and operating rules. Use when setting up this studio, repairing missing studio files, or changing persistent studio defaults.
---

# Studio setup

## Workflow

1. Inspect the workspace, `AGENTS.md`, `knowledge/`, `templates/`, `references/`, and `projects/`; reuse existing answers and never ask for data available there.
2. Create missing directories and starter files. Preserve user-authored content; before a material rewrite, save a timestamped copy in `backups/`.
3. Ask only questions that change persistent studio defaults. Offer concise concrete choices and keep sensible defaults when no answer is needed.
4. Maintain the five files in `knowledge/`, the root `AGENTS.md`, templates, and `knowledge/REFERENCE_INDEX.md`. Update indexes yourself.
5. End by listing what changed and any assumptions recorded.

## Defaults

Use the initial rules in `knowledge/` unless the user overrides them: commercially useful, distinctive modern work with generous space and strong hierarchy; never copy references; no scroll-jacking; design mobile separately; use concrete conversion copy; avoid empty claims; default to Next.js App Router, TypeScript, CSS Modules, Framer Motion, and Vercel. Permit a project-specific stack change when justified and document it.

## Commands

- `Use $studio-setup to initialize this folder as a web studio.`
- `Use $studio-setup to update our studio rules for a luxury hospitality focus.`

Read [workspace-contract.md](references/workspace-contract.md) before repairing an incomplete workspace.
