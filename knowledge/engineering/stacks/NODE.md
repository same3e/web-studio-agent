# Node and server JavaScript quality

Load only for approved server-side JavaScript or TypeScript.

| ID | Strength | Rule | Evidence |
| --- | --- | --- | --- |
| ND-01 | hard | Validate input, set proportionate timeouts, and support abort/cancellation for external work where available. | Tests/runtime. |
| ND-02 | hard | Use structured safe errors and logging; provide graceful failure and cleanup. | Tests/review. |
| ND-03 | hard | Retried writes require proportionate idempotency. | Contract/tests. |
| ND-04 | default | Inject external boundaries where useful; do not use process-global state for request-specific data. | Review/tests. |
