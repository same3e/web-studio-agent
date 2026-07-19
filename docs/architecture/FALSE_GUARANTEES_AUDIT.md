# False guarantees audit

Before this pass, implementation preflight, specialist routing, and context compilation were primarily **file-existence-only** and **regex-only**. Empty templates could pass preflight; required context files were silently filtered out; frontend roles were selected without a declared visible surface; and initialization created irrelevant records.

The remediation uses a canonical JSON metadata envelope at the start of governed Markdown records. The PowerShell validator enforces the envelope plus the active record-specific constraints; it is deliberately not a full JSON Schema engine. JSON Schema files document the contract, while `scripts/records/Test-StudioRecord.ps1` is the executable subset.

Current guarantee classification: records and preflight are schema/content-enforced; route index is generated from canonical tables plus a routing-only overlay; compiler requirements are content-enforced and blocked explicitly; browser and host-agent evidence remain runtime-only and are never implied by structural fixtures. Legacy records without metadata are classified `legacy-unstructured`, not valid.
