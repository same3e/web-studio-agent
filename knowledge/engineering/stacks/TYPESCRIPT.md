# TypeScript code quality

Load only for an approved TypeScript repository. Preserve existing compiler strategy; do not alter `tsconfig` merely to satisfy a preference.

| ID | Strength | Rule | Evidence |
| --- | --- | --- | --- |
| TS-01 | default | Prefer strict compiler settings where the existing project supports them; document a constrained migration rather than flipping settings blindly. | Technical decision/build. |
| TS-02 | hard | Do not use unbounded `any`; use `unknown` at untrusted boundaries and narrow it with validation. | Source/tests. |
| TS-03 | default | Model meaningful states with discriminated unions and exhaustively handle important variants. | Review/tests. |
| TS-04 | hard | Non-null assertions and type assertions require an invariant; they do not replace validation. | Source/review. |
| TS-05 | default | Derive types from schemas/contracts when safe, expose narrow public types, and maintain stable import boundaries. | Contract/review. |
| TS-06 | recommendation | Prefer simpler runtime-safe alternatives before introducing runtime enums. | Review. |
