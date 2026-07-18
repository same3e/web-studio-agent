# WORKFLOW

## Purpose

Route work through discovery → requirements → technical recommendation → reference selection → concepts → explicit approval → approved project records → implementation planning → implementation → specialist verification → remediation → final verification → handoff. Advance only when each gate has evidence; do not infer approval from enthusiasm.

## Ownership and routing

- Owner: product-studio and add-reference.
- Load when the knowledge index route identifies knowledge/core/WORKFLOW.md for the current task, state, product type, or active risk.
- Do not load for unrelated read-only work; project-local decisions always override this global methodology.

## Applied rule

Route work through the project state machine. Advance only when each state document contains the required evidence; do not infer approval from enthusiasm.

## Project record

Record the resulting decision, evidence, assumption, or validation result in the relevant .studio/ source-of-truth document; do not store client data here.

## Migrated legacy workflow rules

# Workflow

1. Initialize or repair the studio with `$studio-setup`.
2. Catalog inspiration with `$add-reference`.
3. Brief and approve a client direction with `$new-site-project`.
4. Build and verify only an approved project with `$build-site`.

Keep global rules, reference evidence, client decisions, and build evidence in their respective locations. Record assumptions where they are made.

