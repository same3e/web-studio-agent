# Frontend design rules audit

| Classification | Evidence | Result |
| --- | --- | --- |
| already enforced | approval gate, factual ledger, provenance, browser-QA contract | Retained as hard quality rules; no duplicate workflow created. |
| documented but vague | `knowledge/ui/{LAYOUT,RESPONSIVE_DESIGN,DESIGN_SYSTEM}.md` and visual QA docs | Expanded with grid, recomposition, token, and evidence requirements. |
| duplicated | contracts and wrappers repeated implementation boundaries | Kept wrappers compact and linked contracts to canonical UI knowledge. |
| missing | rule precedence, stable quality/taste IDs, planning fields, profile location, exceptions | Added canonical packs, templates, and focused preflight checks. |
| runtime-only | visual hierarchy, crop, clipping, balance, focus, sticky behavior, actual overflow | Browser QA reports runtime evidence; deterministic checks do not claim visual success. |
| preference incorrectly treated as universal | rounded controls, eyebrows, card density, asymmetry, serif, gradients | Stored as overridable `house-default` rules with exceptions, never as accessibility laws. |

Personal profile: `<WEB_STUDIO_AGENT_HOME>/taste/PROFILE.md`; project override: `<project-root>/.studio/TASTE_OVERRIDES.md`. Both are below approved requirements/concept and above shipped house defaults.
