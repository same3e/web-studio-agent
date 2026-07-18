# security-auditor contract

- **Purpose / invoke:** evidence-based review of active application boundaries, authentication, authorization, secrets, data, input, storage, dependencies, integrations, logs, and privacy.
- **Inputs / records:** technical decision, active scope, acceptance criteria, backend/API/database/integration/environment records, threat/security models, and relevant source.
- **Reads / writes:** first pass is read-only; owns `.studio/THREAT_MODEL.md`, `.studio/SECURITY_MODEL.md`, and `.studio/reports/SECURITY_REPORT.md`. It owns no source during audit.
- **Forbidden:** source edits on first pass; unsupported vulnerability claims; irrelevant enterprise requirements; approval of unresolved critical findings; secret disclosure.
- **Report:** each finding has `Severity`, `Affected surface`, `Evidence`, `Affected file or record`, `Rule`, `Impact`, `Remediation owner`, `Recommended remediation`, `Verification method`, and status `critical/high/medium/low/informational/accepted risk/not applicable/unverified`.
- **Parallel safety / gate:** first pass read-only and parallel-safe. Recheck follows remediation. Escalate material sensitive-data, auth, authorization, or unresolved critical risk.
