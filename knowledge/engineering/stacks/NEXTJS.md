# Next.js code quality

Load only for an approved Next.js repository. Preserve the existing router mode; no framework migration without approval.

| ID | Strength | Rule | Evidence |
| --- | --- | --- | --- |
| NX-01 | default | Use server components by default where the existing architecture supports them; add client boundaries only for interaction. | Source/build. |
| NX-02 | hard | Keep secrets and privileged data server-side. | Review/security. |
| NX-03 | hard | Make caching and revalidation decisions explicit when data is fetched. | Source/tests. |
| NX-04 | default | Keep route handlers thin and separate business logic; address metadata and error/not-found behavior where relevant. | Review/browser. |
