# Security perimeter and reference hardening audit

Baseline: `main` at `d7de21c4503af7a5cb2229cd1865f0af42912845` was clean and its pre-change deterministic suite passed.

The shared path layer rejects lexical escapes, Windows device and ADS forms, broad globs, forbidden roots, and physical symlink escapes before writes. It is used by project-relative authorization and atomic generated-output writes.

Reference ingestion uses an executable allow-list policy, size and magic checks, shared secret scanning, URL credential/sensitive-query removal, temporary capture, a bounded exclusive lock, atomic folder promotion, canonical JSON and generated Markdown indexes. Reference records are explicitly untrusted and cannot authorize execution or scope. The integrity command is `pwsh -NoProfile -File scripts/reference/Test-ReferenceLibraryIntegrity.ps1 -AgentHome <path>`; `-RebuildIndexes` explicitly rebuilds generated indexes.

Limitations: binary/PDF content is not proven secret-free; prompt-injection signals are advisory; network filesystems and unsupported link creation may limit physical-link verification. URL ingestion does not fetch networks.
