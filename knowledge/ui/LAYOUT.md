# LAYOUT

## Purpose

Choose layout from content relationships and task order; define breakpoints by failure of the composition, not device names alone.

## Ownership and routing

- Owner: product-studio.
- Load when the knowledge index route identifies knowledge/ui/LAYOUT.md for the current task, state, product type, or active risk.
- Do not load for unrelated read-only work; project-local decisions always override this global methodology.

## Applied rules

Every visible page defines a grid strategy before source changes: column model, limited container system (narrow reading, standard, wide, full bleed), outer gutters, internal gaps, alignment anchors, reading measures, breakpoint behavior, and deliberate grid breaks. Major elements share anchors; full-bleed media, signature composition, controlled overlap, hierarchy emphasis, and editorial interruption are valid breaks. Accidental misalignment, arbitrary negative margins, and overflow are not.

Use content-driven breakpoints. Each major section records a composition type (split, editorial, centered statement, asymmetric media/text, modular grid, horizontal sequence, full-bleed visual, or dense application surface), dominant element, and intentional transition. Do not repeat a composition without an information-architecture reason. Use a limited vertical rhythm for element, component, block, section, and major-transition gaps; height normally follows content.

Responsive composition changes order, alignment, emphasis, media, and overlap while preserving logical DOM order. Verify complex visible layouts at 360–390px, about 430px, about 768px, 1024–1280px, 1440px+, and any material composition change.

| ID | Strength | Rule |
| --- | --- | --- |
| LG-01 | hard | Define a grid strategy before visible source changes. |
| LG-02 | hard | Record columns, containers, gutters, gaps, anchors, breakpoints, and grid breaks. |
| LG-03 | hard | Align major elements to shared structural anchors. |
| LG-04 | hard | Permit grid breaks only for full bleed, signature composition, controlled overlap, hierarchy, or editorial interruption. |
| LG-05 | hard | Use narrow, standard, wide, and full-bleed containers rather than arbitrary widths. |
| LG-06 | hard | Change gutters systematically with available space. |
| LG-07 | hard | Give every major region a declared composition type. |
| LG-08 | hard | Do not repeat composition types without an information-architecture reason. |
| LG-09 | hard | Give every section a deliberate dominant element. |
| LG-10 | hard | Match composition complexity to content complexity. |
| LG-11 | hard | Treat empty space as intentional layout. |
| LG-12 | hard | Use limited vertical rhythm levels. |
| LG-13 | hard | Keep equivalent content levels consistently spaced. |
| LG-14 | hard | Make section transitions deliberate. |
| LG-15 | hard | Let height follow content unless documented otherwise. |
| LG-16 | hard | Recompose responsive order, alignment, media, and overlap. |
| LG-17 | hard | Preserve logical DOM order without visual-only reordering. |
| LG-18 | hard | Use content-failure breakpoints and representative-width verification. |

## Project record

Record the resulting decision, evidence, assumption, or validation result in the relevant .studio/ source-of-truth document; do not store client data here.
