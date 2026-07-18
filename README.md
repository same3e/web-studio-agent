# Web Studio Agent

Web Studio Agent is a product and design workflow for coding agents. It turns an idea into an approved and implemented website or application while keeping project decisions in files.

## Two skills

- `product-studio` inspects an existing project or initializes `.studio/`, performs adaptive discovery, recommends scope and a technical approach, presents up to three concepts, waits for explicit approval, then orchestrates only the relevant frontend, backend, database, integration, test, review, security, and browser-verification work for the approved active scope.
- `add-reference` analyzes URLs, screenshots, application screens, and flows. It records reusable visual, product, UX, and interaction evidence in `.studio/references/`.

They exchange information through project-local `.studio/`; the installed plugin never stores client facts, screenshots, concepts, or copy.

## Workflow

```text
idea → adaptive audit → product requirements → technical recommendation
→ references → concepts → approval → implementation → verification
```

## Why use it

- Uses inference before asking only the necessary product questions.
- Explains technical options through cost, speed, reliability, maintenance, and user outcomes.
- Separates active, deferred, and rejected scope around one first complete journey.
- Supports marketing sites, web apps, SaaS, dashboards, PWA, internal tools, mobile planning, and redesigns.
- Keeps fact-based copy, reference no-copy boundaries, approval gates, ownership boundaries, and verification beyond a passing build.
- Skips backend, database, integration, and full security-audit work when a project has no relevant surface.
- Works with existing repositories rather than forcing one stack.

General UI/UX knowledge systems provide shared design rules, palettes, patterns, and best practices. Web Studio Agent manages the surrounding workflow: discovery, scope, stack, references, concepts, approval, implementation, and verification. They can be complementary.

Opinionated starter repositories provide a predefined engineering stack. Web Studio Agent first determines what should be built and then selects a suitable starter profile. That is more flexible, but requires stronger routing and validation; the included profiles improve reproducibility.

## Examples

- **Landing page:** clarify offer and CTA, request industry/visual references, approve a conversion direction, then verify the inquiry journey.
- **SaaS dashboard:** define roles, workspace entities, task flow, states, and a managed-backend MVP recommendation before UI work.
- **AI web application:** define review boundaries, privacy, background jobs, model failure handling, and MVP scope before implementation.

See [QUICKSTART.md](QUICKSTART.md), [INSTALL.md](INSTALL.md), and [docs/HOW_IT_WORKS.md](docs/HOW_IT_WORKS.md).

## Limitations

The plugin does not provide hosting or paid APIs, and cannot guarantee production readiness without external service configuration. Native mobile builds may require platform accounts and tooling. Quality still depends on user input and review. References are evidence, not material for direct copying.
