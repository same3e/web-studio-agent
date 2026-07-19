# Typed record regression audit

Initial verification at `6af4f16ca0fe26eaaad036e6a534cb62061af6b8` found that the migration and behavioral suites passed. The prior Phase 1 runtime, Phase 2, Phase 3, Phase 4, frontend, and context suites built prose-only `.studio` fixtures and treated a shared file list as valid. Those assumptions are obsolete: a valid fixture now needs metadata, an explicit state, product type, active surfaces, scope, approval, criteria, and only its applicable records.

One real regression was also found: `build_repo_map.ps1` used strict property access for absent `devDependencies`. It is corrected to test the JSON property first. No validator was loosened: legacy-unstructured documents still block, and static fixtures remain structural/project-state integration evidence rather than host-agent or browser runtime evidence.
