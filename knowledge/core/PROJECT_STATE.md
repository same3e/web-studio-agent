# PROJECT_STATE

## Purpose

Derive state from `.studio/PROJECT_STATE.md` and linked evidence, not chat memory. The canonical sequence is discovery → requirements → technical recommendation → reference selection → concepts → explicit approval → approved records → implementation planning → implementation → specialist verification → remediation → final verification → handoff. Legacy state names remain readable for compatibility; implementation requires a passed `.studio/IMPLEMENTATION_PREFLIGHT.md`.

## Ownership and routing

- Owner: product-studio and add-reference.
- Load when the knowledge index route identifies knowledge/core/PROJECT_STATE.md for the current task, state, product type, or active risk.
- Do not load for unrelated read-only work; project-local decisions always override this global methodology.

## Applied rule

Use `uninitialized`, `discovery`, `requirements`, `technical-decision`, `references-needed`, `concepts`, `awaiting-approval`, `approved`, `implementation-planning`, `implementation`, `specialist-verification`, `remediation`, `final-verification`, `handoff`, and `complete` where relevant. Preserve legacy state values in existing projects rather than rewriting history.

## Project record

Record the resulting decision, evidence, assumption, or validation result in the relevant .studio/ source-of-truth document; do not store client data here.
