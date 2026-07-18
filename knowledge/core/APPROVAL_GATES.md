# APPROVAL_GATES

## Purpose

Implementation requires an explicit selection of a concept or explicit requested modifications. Vague praise is not approval; after approval, update the record and continue unless the user says stop. Do not request a second approval when the user already explicitly approved the concept and requested implementation.

## Ownership and routing

- Owner: product-studio and add-reference.
- Load when the knowledge index route identifies knowledge/core/APPROVAL_GATES.md for the current task, state, product type, or active risk.
- Do not load for unrelated read-only work; project-local decisions always override this global methodology.

## Applied rule

After explicit approval, automatically create or update `APPROVED_CONCEPT.md`, `COPY.md`, `DESIGN_SYSTEM.md`, `IMPLEMENTATION_PLAN.md`, `ACCEPTANCE_CRITERIA.md`, and `IMPLEMENTATION_PREFLIGHT.md`; mark each required, optional, or not applicable with reason before implementation.

## Project record

Record the resulting decision, evidence, assumption, or validation result in the relevant .studio/ source-of-truth document; do not store client data here.
