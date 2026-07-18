# Frontend quality rules

## Rule schema and precedence

Every material frontend rule uses `id`, `category`, `strength`, `rule`, `rationale`, `applies_when`, `allow_when`, and `evidence_required`. Resolve rules in this order: hard universal quality; approved project requirements; approved concept/design system; project `TASTE_OVERRIDES.md`; user profile; house defaults; model defaults. Hard rules never yield to taste.

| ID | Category | Strength | Rule | Evidence required |
| --- | --- | --- | --- | --- |
| FQ-01 | hierarchy | hard | Distinguish primary content, primary action, and supporting content. | browser view |
| FQ-02 | decoration | hard | Decorative devices need visual, informational, or interaction purpose. | plan or QA finding |
| FQ-03 | grouping | hard | Use cards only for independent, grouped, actionable, or stateful entities. | composition map |
| FQ-04 | coherence | hard | Keep radius, borders, shadows, icons, surfaces, and motion coherent. | design system + browser |
| FQ-05 | tokens | hard | Tokenize recurring color, spacing, type, radius, elevation, and motion. | source review |
| FQ-06 | information | hard | Adjacent sections must not repeat one informational function. | composition map |
| FQ-07 | signature | hard | Give each visual direction one signature element; keep supporting UI disciplined. | design thesis |
| FQ-08 | typography | hard | Typography communicates hierarchy and personality, not decoration alone. | browser view |
| FQ-09 | content | hard | Label placeholders and assets so they cannot appear as verified facts. | content ledger |
| FQ-10 | factual | hard | Never invent testimonials, logos, metrics, ratings, users, awards, integrations, or public claims. | factual audit |
| FQ-11 | readability | hard | Keep text measures readable for their content role. | browser view |
| FQ-12 | resilient content | hard | Tolerate long, translated, and realistic copy. | long-copy QA |
| FQ-13 | actions | hard | Use action labels that describe the result in user language. | source/browser review |
| FQ-14 | mobile | hard | Recompose mobile; do not merely scale desktop. | multi-viewport QA |
| FQ-15 | overflow | hard | Forbid horizontal page overflow except approved contained horizontal interaction. | browser QA |
| FQ-16 | clipping | hard | Do not clip important content or actions for composition. | browser QA |
| FQ-17 | imagery | hard | Define focal position and crop behavior for images. | responsive plan + QA |
| FQ-18 | sticky | hard | Sticky/fixed UI must not cover reachable content or controls. | browser QA |
| FQ-19 | targets | hard | Keep interactive targets usable by pointer and touch. | browser QA |
| FQ-20 | async states | hard | Relevant asynchronous actions need loading, success, and error behavior. | functional QA |
| FQ-21 | forms | hard | Do not show delivery success without real confirmation or labeled mock mode. | integration evidence |
| FQ-22 | access | hard | Hover is not the only access path; focus is visible. | keyboard QA |
| FQ-23 | motion | hard | Motion explains state, hierarchy, continuity, or feedback. | motion rationale + QA |
| FQ-24 | evidence | hard | Claims of responsive, accessible, pixel-perfect, browser-tested, or visually verified need runtime evidence. | capture metadata |
| FQ-25 | scope | hard | Preserve approved copy, scope, and factual boundaries during frontend work. | review report |

Hard rules may be relaxed only where a stronger product requirement explicitly changes the interaction and its browser evidence demonstrates equivalent safety and accessibility.
