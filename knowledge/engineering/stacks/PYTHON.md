# Python code quality

Load only for an approved Python repository.

| ID | Strength | Rule | Evidence |
| --- | --- | --- | --- |
| PY-01 | default | Preserve the existing formatter, linter, type-checker, packaging, and test conventions. | Manifests/commands. |
| PY-02 | hard | Validate untrusted input and handle optional, malformed, and external values explicitly. | Tests/review. |
| PY-03 | default | Keep I/O and framework glue at boundaries; make resource cleanup and error propagation explicit. | Tests/review. |
| PY-04 | hard | Do not log secrets or sensitive payloads; retryable writes need idempotency where applicable. | Review/tests. |
