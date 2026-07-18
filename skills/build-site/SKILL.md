---
name: build-site
description: Implement, test, and document an approved client website inside a web-studio project folder. Use after a concept is approved, or when continuing, fixing, or verifying a site that has its project AGENTS.md and docs.
---

# Build site

## Gate and preparation

1. Work in the requested `projects/<slug>/` folder. Read its `AGENTS.md` and all `docs/` files before changing code. Confirm an approved concept and Hero Copy Score record exist. Read the approved style family, style tags, visual modifiers, selected reference roles, and visual guardrails from `docs/APPROVED_CONCEPT.md` and `docs/UI_SYSTEM.md`. The hero begins directly with H1 unless a user-approved exception is documented.
2. Confirm an approved concept exists. If not, stop and use `$new-site-project`; do not infer approval.
3. Use only approved copy. Do not replace a concrete H1 with an abstract slogan for visual reasons or shorten the offer until it is unclear. Adapt the layout to multilingual text length instead of cutting commercial meaning. Do not render internal placeholders, test figures, unverified figures, guarantees, ratings, technologies, or other claims.
4. Preserve approved proof points close to the CTA, but do not turn each proof point into a separate card: use the visual form approved by the concept. Signal and document any design decision that makes the offer, first-step result, CTA, or proof less clear.
5. Resolve missing noncritical detail with a documented, reversible decision. Ask one precise question only for a critical blocker.

## Delivery loop

Implement in order: tokens, global styles, layout, header, hero, remaining sections, mobile treatment, motion, and optimization. Respect the approved concept; preserve its style family, tags, modifiers, and industry conversion patterns through the implementation. Explain and document any necessary deviation. Use supplied assets, not random placeholders. Do not create a small text line above H1 on your own; remove an unapproved eyebrow, overline, kicker, pretitle, pre-heading, hero label, or category label if found. Do not confuse this rule with logos, navigation, card tags, or labels inside non-hero sections.

For maintainable page styling, keep global tokens, reset, and site-wide defaults in `app/globals.css`; keep header-only rules in `app/header.module.css`; and keep the entire first screen in `app/hero.module.css`. At the top of each hero stylesheet, create one `HERO SETTINGS` block with only three matching locale profiles (EN, RU, KA). Each profile must expose title desktop/mobile size, title line-height, title letter-spacing, title-to-body gap, body size, body line-height, and body-to-buttons gap. Place shared image controls beside them: desktop/mobile height, radius, focal position, and mobile top gap. Derive hero styles from these variables and keep media queries structural; do not reintroduce hidden offsets, duplicate locale values, or visual values that require searching through the file.

Before publication, compare every production claim with approved copy and documented confirmed facts. Stop publication if any interface claim is unconfirmed, including a medical or regulated-service claim; return it for confirmation or remove it. Do not apply a visual treatment blindly when it weakens readability, accessibility, mobile layout, performance, offer clarity, trust, or conversion. Adapt, simplify, or omit the affected treatment and document the reason. Run TypeScript checks, lint, and a production build. Start the local app and inspect desktop and mobile with an available browser. Check offer clarity, CTA/result alignment, visible proof points, overflow, images, typography wrapping in every supported language, console errors, navigation, forms, accessibility, performance, reduced motion, and fidelity to the approved style system. Fix issues found, then write `docs/BUILD_REPORT.md` with commands/results, changes, assumptions, style-preservation decisions, deviations, and remaining limits.
