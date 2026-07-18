# Context package benchmark (approximate)

The compiler counts embedded non-code context as UTF-8 characters divided by four. Source paths are referenced and not counted as embedded source files. These are representative package targets, not provider measurements.

| Scenario | Mode | Records | Rule summaries | Detail sources | Cards | Approx. embedded tokens | Excluded |
| --- | --- | ---: | ---: | ---: | ---: | ---: | --- |
| Simple landing | lean | 6 | 4–6 | 2 | 1–3 | under 8,000 target | backend, data, history |
| Next.js marketing site | standard | 7 | 6–9 | 3 | 3–5 | under 16,000 target | unrelated operations |
| SaaS active surfaces | thorough | 9–14 | 8–12 | 4–6 | as needed | under 30,000 target | rejected history |
| Isolated frontend fix | lean | 5–6 | 4–6 | 2–3 | 0–2 | under 8,000 target | data/operations |
| Small diff review | standard | 5–6 | 4–7 | 2–3 | 0 | under 16,000 target | full repository |
| Browser QA | standard | 6–7 | 3–6 | 2–3 | 1–5 | under 16,000 target | backend methodology |

Largest contributors are normally project records, selected reference cards, and previous evidence. The manifest reports actual approximate selected tokens and warning/exceeded state for a concrete run.
