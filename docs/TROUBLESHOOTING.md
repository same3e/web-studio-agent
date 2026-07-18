# Troubleshooting

If a skill does not appear, validate the manifest, reinstall/update the marketplace entry, and start a new thread. If state is wrong, inspect `.studio/PROJECT_STATE.md` and required evidence. If references are missing, keep the original source and record the limitation rather than guessing.
# Context packages

If a context manifest is stale, regenerate the repository map after manifest/configuration/root changes, resolve rules after state/concept/mode changes, then compile the affected role again. Runtime packages under `.studio/runtime/` are intentionally ignored. Structural manifest validation does not prove a host reused context or that a model read every selected file.
