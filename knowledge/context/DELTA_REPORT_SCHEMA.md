# Compact specialist delta

Use a compact machine-readable or Markdown-equivalent delta after specialist work. Do not repeat the brief, unchanged facts, or full rule bodies.

```text
schema_version: 1
role:
status:
task:
files_changed: []
criteria_completed: []
criteria_blocked: []
rule_ids_applied: []
approved_exceptions: []
dependencies_added: []
dependencies_removed: []
commands: [{ command:, result:, evidence: }]
runtime_evidence: []
known_gaps: []
handoff:
```

An ordinary delta targets roughly 300–800 approximate tokens. Material findings, migrations, security, and failures may require more detail. Exact commands, actual outcomes, blockers, and uncertainty must remain intact.
