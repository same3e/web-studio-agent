# Project files

All mutable project state lives in `<project-root>/.studio/`: facts, assumptions, users, scope, references, concepts, approval, copy, system, plan, criteria, and reports. Global plugin folders contain only reusable methodology, templates, skills, manifests, and validators.
# Context records

`.studio/PROJECT_SNAPSHOT.md` is a compact active routing aid, not a replacement for canonical records. `.studio/REPO_MAP.json` and `.studio/context/RESOLVED_RULES.*` are generated caches; `.studio/runtime/context/` contains ephemeral role manifests and is ignored. `CONTEXT_INDEX.md` points to active concept, plan, and latest role evidence without moving historical files. Initialize missing context records safely with `scripts/context/initialize_project_context.ps1`; snapshot refreshes preserve user edits and stop on contradictory state.
