# Personal reference library

Resolve root from `WEB_STUDIO_AGENT_HOME`; default is `%USERPROFILE%\.web-studio-agent` on Windows and `$HOME/.web-studio-agent` elsewhere. Library path is `<home>/reference-library/`, outside plugin cache/source/project. Tests override the variable with a disposable root.

`scripts/Add-ReferenceLibraryItem.ps1` ingests one local file or URL metadata record, stores the source once under `references/ref-<stable-id>/source`, writes `SOURCE.md`, `metadata.json`, and evidence-limited `ANALYSIS.md`, generates indexes, and optionally links the stable ID to the active project. Exact file hash and normalized URL duplicates return the existing ID without copying. `scripts/Find-ReferenceLibraryMatch.ps1` returns ranked matched dimensions, role-balanced proposals, reasons, confidence, and gaps; it never makes a project requirement without approval.
