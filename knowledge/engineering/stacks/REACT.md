# React code quality

Load only for an approved React repository. Do not impose a universal component-size limit.

| ID | Strength | Rule | Evidence |
| --- | --- | --- | --- |
| RE-01 | hard | Keep render pure and derive values during render unless state is genuinely needed. | Review/tests. |
| RE-02 | default | Keep state minimal with deliberate ownership; avoid effect-driven state synchronization without need. | Review. |
| RE-03 | default | Use effects for external synchronization, control async work deliberately, and prevent stale completion where applicable. | Tests/runtime. |
| RE-04 | recommendation | Prefer composition over excessive prop plumbing and premature memoization. | Review. |
| RE-05 | hard | Keep semantic UI and testable domain logic outside components where proportionate; provide loading and error boundaries for active scope. | Tests/browser. |
