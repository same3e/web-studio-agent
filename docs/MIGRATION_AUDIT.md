# Migration audit: four web-site skills to two product-studio skills

**Audit scope:** the live studio system in this repository, its archived migration copy, public-release distribution copy, project example, knowledge, templates, reference catalog, scripts, and manifests. This is a planning-only artifact. No migration is performed here.

## 1. Current architecture

### Live workflow

The live system is a four-stage, website-first pipeline:

1. `studio-setup` creates or repairs the workspace and its shared folders.
2. `add-reference` catalogs supplied websites, screenshots, or inbox images into a canonical reference folder and global index.
3. `new-site-project` gathers business facts, selects references, presents three concepts, and writes project documents only after explicit approval.
4. `build-site` implements an approved project, verifies it, and records a build report.

The root `AGENTS.md` reinforces the split: global rules live in `knowledge/`, reusable reference evidence in `references/`, and client state in `projects/<slug>/`. The Noma Dental sample confirms the intended hand-off: `CLIENT_BRIEF.md` and `docs/` hold project decisions; `docs/APPROVED_CONCEPT.md` gates implementation; `docs/COPY.md`, `docs/UI_SYSTEM.md`, and `docs/IMPLEMENTATION_PLAN.md` constrain the build; `docs/BUILD_REPORT.md` holds evidence.

### Current sources and hand-offs

| Stage | Current skill | Reads | Writes / passes forward | Limitation for the target direction |
| --- | --- | --- | --- | --- |
| Workspace | `studio-setup` | root rules, knowledge, templates, references, projects, workspace contract | missing studio folders/files; global index | User-facing setup stage; says “five” knowledge files although seven exist. |
| Reference intake | `add-reference` | style index, analysis format, inbox processing, inbox manifest | `references/<category>/<id>/source/`, `analysis.md`, reference index, manifest | Designed around visual website references; no explicit app screen, flow, interaction, or reanalysis state model. |
| Discovery and concepts | `new-site-project` | all applicable knowledge, client material, style/reference indexes, selected analyses, concept format | `projects/<slug>/CLIENT_BRIEF.md`, then seven `docs/` files and project `AGENTS.md` after approval | Website-only language; discovery does not model product roles, journeys, MVP, surface inventory, or technical alternatives. |
| Build and verification | `build-site` | project `AGENTS.md`, all `docs/`, verification checklist | code and `docs/BUILD_REPORT.md` | Hard-codes Next.js App Router, CSS-module file names, a hero, and EN/RU/KA locale profiles. |

### Repository observations

- Four live `SKILL.md` files were inspected, each with YAML frontmatter and an `agents/openai.yaml` UI descriptor.
- There are seven live knowledge documents, nine project templates, 25 reference analyses, and 25 matching index rows. All 25 analyses contain every required heading from the current analysis format.
- `add-reference` has one read-only Python inventory script. No system-level test suite or validator exists; the only application package belongs to the Noma Dental example.
- `public-release/` is a byte-for-byte duplicate of 24 live skills/knowledge/templates/assets. It is an intentional distribution copy but a high drift risk. The current public-release README describes `.codex-plugin/` and `.claude-plugin/` manifests; neither is present in this repository or its public-release directory.
- The public-release skill support files do exist. Its reference index deliberately points at reference analyses that are not shipped in public-release, so a standalone public install cannot use the bundled index as written.
- `migration-backup-2026-07-17/` is an archive of the earlier scaffold. It is not part of the live workflow and should not become an ownership source during migration.
- No `CLAUDE.md`, Codex plugin manifest, Claude plugin manifest, or marketplace manifest was found. The root `.git` directory does not contain usable Git metadata (`git status` reports that the folder is not a repository), so a clean-worktree check is unavailable.
- No rule or active skill contains a local absolute path. Absolute paths appear only in the Noma Dental development log and must not move into product knowledge or distribution files.

## 2. Rule inventory

The table inventories 47 meaningful responsibilities and guardrails. “Target knowledge document” is a proposed Phase 2 destination, not a file created by this audit.

| Rule or responsibility | Current source file | Current owning skill | Target owning skill | Target knowledge document | Action | Notes and risks |
| --- | --- | --- | --- | --- | --- | --- |
| Workspace folders, separation of global/client/reference truth | `AGENTS.md`; workspace contract | `studio-setup` | `product-studio`, `add-reference` | `core/WORKSPACE_CONTRACT.md` | Expand | Replace `projects/<slug>` assumptions with project roots plus `.studio/`. |
| Preserve user data; backup before material rewrite | `AGENTS.md`; `studio-setup/SKILL.md` | `studio-setup` | `product-studio`, `add-reference` | `safety/DATA_PRESERVATION.md` | Keep unchanged | Applies to all product types and reference intake. |
| Keep records in Markdown; agent maintains them | `AGENTS.md` | all | `product-studio`, `add-reference` | `core/RECORDKEEPING.md` | Expand | Add project-local source-of-truth rules. |
| Avoid duplicated facts | `AGENTS.md` | all | `product-studio` | `core/RECORDKEEPING.md` | Expand | Define single owners for facts, assumptions, and decisions. |
| Explicit concept approval before final copy or implementation | `AGENTS.md`; new-project skill | `new-site-project` | `product-studio` | `safety/APPROVAL_GATES.md` | Keep unchanged | Must gate app as well as website implementation. |
| Build only from approved documents and verify before reporting | `AGENTS.md`; build skill | `build-site` | `product-studio` | `verification/RELEASE_GATE.md` | Expand | Add platform-specific verification matrices. |
| H1-first hero rule | `AGENTS.md`; design, UX, copy rules; templates; both site skills | `new-site-project`, `build-site` | `product-studio` | `ui/HERO_HIERARCHY.md` | Merge | Website/landing-only conditional rule; never apply to non-hero app screens. |
| Automatic studio initialization/repair | `studio-setup/SKILL.md` | `studio-setup` | `product-studio`, `add-reference` | `core/WORKSPACE_INITIALIZATION.md` | Merge | Internal prerequisite; no separate user-facing skill. |
| Ask only persistent-default questions during setup | `studio-setup/SKILL.md` | `studio-setup` | `product-studio` | `core/DISCOVERY_PROTOCOL.md` | Expand | Merge with adaptive discovery; distinguish critical blockers from useful questions. |
| Modern, commercially useful visual defaults | `studio-setup/SKILL.md`; design rules | `studio-setup` | `product-studio` | `ui/DESIGN_PRINCIPLES.md` | Merge | Preserve, but not as a substitute for product usability. |
| Default technical stack, documented exceptions | setup and design rules | `studio-setup`, `build-site` | `product-studio` | `engineering/TECHNICAL_DECISIONS.md` | Expand | Next.js becomes a recommendation, not a global default for every product. |
| Workflow stage ordering | `knowledge/WORKFLOW.md` | all | `product-studio`, `add-reference` | `core/WORKFLOW.md` | Rewrite | Collapse four user-facing stages into two skills with internal stages. |
| Inbox batch, explicit group, URL, screenshot, fragment modes | `add-reference/SKILL.md` | `add-reference` | `add-reference` | `references/INTAKE_MODES.md` | Expand | Include application screens, design files, flow recordings, and existing product URLs. |
| Reference asset grouping threshold | inbox processing | `add-reference` | `add-reference` | `references/INTAKE_AND_GROUPING.md` | Keep unchanged | Explicit grouping wins; uncertain assets remain separate. |
| SHA-256 duplicate detection and versioning | add-reference skill; scanner | `add-reference` | `add-reference` | `references/REFERENCE_STORAGE.md` | Keep unchanged | Keep manifest written only after successful cataloging. |
| Safe original deletion after verified cataloging | add-reference skill; inbox processing | `add-reference` | `add-reference` | `safety/REFERENCE_ASSET_HANDLING.md` | Keep unchanged | Preserve originals on any failure; never overwrite user material. |
| Canonical reference storage, one source once | add-reference skill | `add-reference` | `add-reference` | `references/REFERENCE_STORAGE.md` | Expand | Add reference role and application-flow grouping metadata. |
| Evidence-based classification and uncertainty | add-reference skill; analysis format | `add-reference` | `add-reference` | `references/ANALYSIS_STANDARD.md` | Expand | Add product, UX, interaction, and state evidence; retain “do not guess.” |
| Style family and canonical style tags | style index | `add-reference`, `new-site-project` | both | `ui/STYLE_VOCABULARY.md` | Expand | Retain controlled vocabulary; separate visual tags from product-pattern tags. |
| Reference analysis headings | analysis format; 25 analyses | `add-reference` | `add-reference` | `references/ANALYSIS_STANDARD.md` | Expand | Add flows, screen purpose, user state, interaction, empty/error/loading states, and accessibility evidence. |
| Reference index as discovery entry point | reference index | `add-reference`, `new-site-project` | both | `references/REFERENCE_INDEX_RULES.md` | Expand | Use a project-local index for selected references; do not ship private analyses publicly. |
| Never copy assets, claims, coordinates, or expression | design rules; analyses; project docs | all | both | `safety/NO_COPY_AND_PROVENANCE.md` | Merge | Keep clear distinction between adaptable principles and protected expression. |
| Conversion-first versus brand-led copy modes | copy rules; new-project skill | `new-site-project` | `product-studio` | `copy/COPY_STRATEGY.md` | Expand | Add product onboarding, transactional, empty-state, and system-copy modes. |
| Offer facts, confirmed/reasonable/unverified classification | new-project skill | `new-site-project` | `product-studio` | `business/FACTS_AND_ASSUMPTIONS.md` | Expand | Split into `.studio/CONFIRMED_FACTS.md` and `.studio/ASSUMPTIONS.md`. |
| Fact gate before public-facing copy | new-project skill; copy rules | `new-site-project`, `build-site` | `product-studio` | `safety/FACTUAL_COPY_GATE.md` | Keep unchanged | Must cover product labels, pricing, integrations, metrics, and capability claims. |
| Hero offer structure, specific CTA, proof limits | copy rules | `new-site-project` | `product-studio` | `copy/CONVERSION_COPY.md` | Expand | Keep as landing/marketing module, not dashboard default. |
| Anti-template commercial copy | copy rules | `new-site-project` | `product-studio` | `copy/CONVERSION_COPY.md` | Keep unchanged | Preserve niche-specific variation. |
| Medical/regulated claim limitations | copy rules | `new-site-project`, `build-site` | `product-studio` | `safety/REGULATED_CLAIMS.md` | Expand | Generalize to finance, legal, security, and privacy claims. |
| Multilingual copy fidelity and layout adaptation | copy rules; build skill | `new-site-project`, `build-site` | `product-studio` | `copy/LOCALIZATION.md` | Expand | Remove fixed EN/RU/KA assumption; derive supported locales from project state. |
| Hero Copy Score and 8/10 threshold | copy rules; new-project skill | `new-site-project` | `product-studio` | `copy/CONVERSION_COPY.md` | Keep conditional | Only applies to conversion-first marketing heroes. |
| Adaptive discovery of business, audience, conversion, constraints | new-project skill | `new-site-project` | `product-studio` | `business/DISCOVERY.md` | Expand | Add product type, existing system audit, success metrics, operational constraints, and risk. |
| User roles and journeys | absent | none | `product-studio` | `product/ROLES_AND_JOURNEYS.md` | Add | Required for apps, SaaS, dashboards, PWA, internal tools, and mobile planning. |
| Information architecture, screen architecture, feature priority, MVP | partial page/sitemap templates | `new-site-project` | `product-studio` | `product/INFORMATION_ARCHITECTURE.md`; `product/MVP_SCOPE.md` | Expand | Turn page-only templates into surface and feature models. |
| Reference selection by industry/style/both and synthesis | new-project skill | `new-site-project` | `product-studio` | `references/REFERENCE_SELECTION.md` | Expand | Add product/UX/interaction reference roles and no-copy synthesis. |
| Three distinct concepts | new-project skill; concept format | `new-site-project` | `product-studio` | `product/CONCEPTS.md` | Expand | Concepts must include product scope and delivery implications, not only visual character. |
| Post-approval documentation | new-project skill; templates | `new-site-project` | `product-studio` | `core/PROJECT_STATE.md` | Merge | Replace `docs/` set with `.studio/` sources of truth. |
| Approved visual system and tokens | UI system template | `new-site-project`, `build-site` | `product-studio` | `ui/DESIGN_SYSTEM.md` | Expand | Preserve tokens, focus, reduced motion; remove mandatory CSS Modules file paths. |
| Fixed hero CSS layout and EN/RU/KA settings | build skill; UI template | `build-site` | `product-studio` | `platforms/WEB_IMPLEMENTATION.md` | Restrict | Website-specific optional recipe; not global product policy. Template repeats this block twice. |
| Implement in ordered delivery loop | build skill | `build-site` | `product-studio` | `engineering/IMPLEMENTATION_WORKFLOW.md` | Expand | Plan by approved surfaces, dependencies, states, and platform. |
| Use supplied assets; no production placeholders | build skill; copy rules | `build-site` | `product-studio` | `safety/ASSET_AND_CONTENT_GATES.md` | Expand | Add explicit development fixtures and demo-data labelling. |
| Document reversible decisions and deviations | build skill; project agents template | `build-site` | `product-studio` | `core/DECISIONS.md` | Expand | Keep an explicit technical-decision record. |
| Accessibility, responsive, motion, and performance safeguards | UX rules; build checklist | `build-site` | `product-studio` | `verification/QUALITY_CHECKS.md` | Expand | Add keyboard flows, app states, PWA/offline, contrast, and platform testing. |
| Browser verification and production build | build skill; checklist | `build-site` | `product-studio` | `verification/BROWSER_AND_BUILD.md` | Expand | Browser checks remain conditional on web runtime; mobile planning has no fake runtime proof. |
| Build reporting with commands, evidence, assumptions, limits | build skill; build-report template | `build-site` | `product-studio` | `verification/BUILD_REPORTING.md` | Expand | Report only checks actually run and distinguish unavailable checks. |
| Public/private distribution boundary | public-release README | none | `product-studio` (governance) | `safety/PRIVATE_MATERIALS.md` | Expand | Prevent projects, client references, logs, and `.studio/` facts from entering public release. |
| Plugin/marketplace compatibility | public-release README | none | Phase 2 packaging work | `core/DISTRIBUTION.md` | Add | README claims absent manifests; decide Codex/Claude packaging deliberately. |
| Read-only inbox inventory script | `scan_inbox.py` | `add-reference` | `add-reference` | `references/TOOLING.md` | Keep unchanged | Retain read-only contract; add tests only in a later implementation phase. |

## 3. Target ownership

### `product-studio`

`product-studio` is the single project lifecycle skill. It automatically establishes missing workspace/project-local state, inspects repositories and existing materials, runs adaptive discovery, audits business and existing product context, records confirmed facts and assumptions, models audiences, roles, journeys, information architecture, screen architecture, features and MVP scope, recommends a stack and architecture, requests references when useful, creates concepts, waits for explicit approval, then implements and verifies the approved concept.

It owns all requested product, copy, concept, documentation, implementation, testing, browser/responsive/accessibility/performance, factual/no-copy, and final reporting responsibilities. It must select a relevant loading profile rather than indiscriminately load all knowledge. It may inspect or request reference work, but it does not own reference catalog mutation.

### `add-reference`

`add-reference` owns URLs, screenshots, images, inbox processing, duplicate detection, reanalysis, canonical storage, analyses, and indexes. It classifies visual direction plus product, UX, and interaction patterns; captures reusable principles and non-copy boundaries; and keeps uncertainty visible. It automatically initializes only the minimal workspace/reference structures needed for safe intake.

It does not choose a project’s final concept, invent business facts, or implement product code. It can create evidence that `product-studio` later selects and synthesizes.

## 4. Proposed knowledge architecture

The following is the Phase 2 plan only. Each proposed file has one job and is loaded only by the identified stage/profile.

| Proposed file | Purpose and source rules | Loaded by / stages | Relevant product types | Do not load when |
| --- | --- | --- | --- | --- |
| `knowledge/KNOWLEDGE_INDEX.md` | Routing map, profiles, precedence, and lightweight summaries. | Both; every task first. | All. | Never skip. |
| `core/WORKSPACE_CONTRACT.md` | Workspace/project/reference separation; UTF-8; recordkeeping. Moves workspace contract and root organization rules. | Both; initialization. | All. | Never skip during mutations. |
| `core/WORKFLOW.md` | Internal stages and stop conditions for two-skill workflow. Moves `WORKFLOW.md`. | Both; every task. | All. | Never skip. |
| `core/RECORDKEEPING.md` | Facts, decisions, assumptions, source-of-truth and no-duplication discipline. | `product-studio`; discovery through reporting. | All. | Read-only answer with no project work. |
| `core/DISCOVERY_PROTOCOL.md` | Adaptive questions, existing-material reuse, blocker policy. Moves setup/new-project question rules. | `product-studio`; discovery. | All. | Post-approval implementation absent new ambiguity. |
| `core/DISTRIBUTION.md` | Public release boundary and Codex/Claude packaging rules. | `product-studio`; packaging work only. | Studio distribution. | Client product delivery. |
| `business/DISCOVERY.md` | Goals, offer, market, stakeholders, constraints, success metrics. | `product-studio`; discovery. | All. | Pure reference intake. |
| `business/FACTS_AND_ASSUMPTIONS.md` | Confirmed/contextual/unverified facts and fact gate. Moves offer facts rules. | `product-studio`; discovery, copy, verification. | All. | Purely visual reference analysis. |
| `product/PRODUCT_TYPES.md` | Scope profiles for marketing sites, web apps, SaaS, dashboards, PWA, internal tools, mobile planning, and redesigns. | `product-studio`; triage. | All. | Never after type is already known unless scope changes. |
| `product/ROLES_AND_JOURNEYS.md` | Roles, needs, jobs, scenarios, journeys, permissions. | `product-studio`; app discovery/concepts. | Apps, SaaS, dashboards, internal tools, PWA, redesigns. | Simple brochure/landing pages without role complexity. |
| `product/INFORMATION_ARCHITECTURE.md` | Navigation, pages, screens, routes, surfaces. Moves sitemap/page structure intent. | `product-studio`; concepts to plan. | All. | Single isolated visual fragment. |
| `product/MVP_SCOPE.md` | Feature priority, active/deferred surfaces, acceptance criteria. | `product-studio`; concepts, approval, plan. | All, especially products. | Reference intake. |
| `product/CONCEPTS.md` | Concept format, distinctness, product/UX/copy/technical implications and approval record. | `product-studio`; pre-approval. | All. | Implementation after approval. |
| `ux/USABILITY.md` | Navigation, forms, feedback, touch targets, error prevention. Moves UX rules. | `product-studio`; concepts, build, verification. | All interactive products. | Static visual-only task. |
| `ux/INTERACTION_AND_STATES.md` | Loading, empty, error, success, permission and offline states. | `product-studio`, `add-reference`; app analysis/build. | Apps, SaaS, dashboards, PWA, internal tools. | Static marketing site with no interactive states. |
| `ux/ACCESSIBILITY.md` | Semantics, focus, keyboard, labels, contrast, reduced motion. | `product-studio`; concepts to verification. | All implemented interfaces. | Mobile planning without a runtime; record as planned criteria instead. |
| `ui/DESIGN_PRINCIPLES.md` | Distinctive commercial design, whitespace, hierarchy, purposeful motion. Moves design defaults. | `product-studio`; concepts/build. | All visual products. | Pure business discovery. |
| `ui/HERO_HIERARCHY.md` | H1-first default and approved exception. Moves repeated hero rule. | `product-studio`; marketing hero only. | Marketing websites, landings, redesigns with a hero. | Dashboards, internal tools, native-screen planning. |
| `ui/STYLE_VOCABULARY.md` | Style families, tags, aliases, risks. Moves style index. | Both; reference analysis/concepts. | All visual products. | No visual direction work. |
| `ui/DESIGN_SYSTEM.md` | Tokens, responsive system, components, motion, content density. Moves useful UI-system template rules. | `product-studio`; approved concept/build. | All implemented interfaces. | Before visual direction is approved. |
| `copy/COPY_STRATEGY.md` | Conversion-first, brand-led, product and transactional copy modes. | `product-studio`; discovery/concepts. | All products with copy. | Visual-only reference cataloging. |
| `copy/CONVERSION_COPY.md` | Offer, CTA, proof, anti-template, Hero Copy Score. Moves copy rules/examples. | `product-studio`; marketing concepts/verification. | Marketing websites and landings. | Product screen/system copy. |
| `copy/PRODUCT_COPY.md` | Onboarding, labels, empty/error/success, capability clarity. | `product-studio`; app concepts/build. | Web apps, SaaS, dashboards, PWA, internal tools. | Pure marketing hero. |
| `copy/LOCALIZATION.md` | Meaning-preserving localisation and variable locale layout. | `product-studio`; relevant concepts/build. | Any multilingual product. | Single-language scope. |
| `references/INTAKE_AND_GROUPING.md` | Modes, grouping thresholds, inbox handling. Moves inbox-processing. | `add-reference`; intake. | All references. | `product-studio` selecting already indexed references. |
| `references/REFERENCE_STORAGE.md` | IDs, canonical source, SHA-256, manifest, reanalysis. | `add-reference`; intake/reanalysis. | All references. | Project implementation. |
| `references/ANALYSIS_STANDARD.md` | Analysis schema including visual, product, UX, interaction and no-copy evidence. Moves analysis format. | `add-reference`; analysis. | All reference types. | Product concept generation. |
| `references/REFERENCE_INDEX_RULES.md` | Index fields, link integrity, privacy boundary. | `add-reference`; indexing; `product-studio`; selection. | All. | No reference work. |
| `references/REFERENCE_SELECTION.md` | Industry/style/product/UX/interaction roles and synthesis. | `product-studio`; concepts. | All. | Intake-only work. |
| `engineering/TECHNICAL_DECISIONS.md` | Stack/architecture recommendations, trade-offs and rationale. | `product-studio`; discovery, approval, implementation. | All implemented products. | Pure design concept with no build scope. |
| `engineering/IMPLEMENTATION_WORKFLOW.md` | Surface-based sequencing, reusable decisions, supplied assets, deviations. | `product-studio`; post-approval. | All implemented products. | Before explicit approval. |
| `platforms/WEB_IMPLEMENTATION.md` | Web-specific routing, responsive, browser/build concerns; optional Next.js guidance. | `product-studio`; web implementation. | Sites, web apps, SaaS, PWA. | Mobile-only planning. |
| `platforms/PWA.md` | Installability, offline, update and device constraints. | `product-studio`; PWA work. | PWA. | Non-PWA work. |
| `platforms/MOBILE_PLANNING.md` | Native/mobile planning boundaries and hand-off artifacts. | `product-studio`; mobile planning. | Mobile planning. | Web implementation. |
| `verification/QUALITY_CHECKS.md` | Usability, a11y, responsive, performance and visual checks. | `product-studio`; post-approval. | Implemented products. | Pre-approval concept work. |
| `verification/BROWSER_AND_BUILD.md` | Browser/runtime/build verification and unavailable-check reporting. Moves checklist. | `product-studio`; web verification. | Web products. | No runnable web product. |
| `verification/BUILD_REPORTING.md` | Evidence, commands, deviations, limits, outcome. Moves build report template. | `product-studio`; reporting. | Implemented products. | Pre-approval. |
| `safety/APPROVAL_GATES.md` | Explicit approval boundary. | `product-studio`; every lifecycle stage. | All. | Never skip. |
| `safety/FACTUAL_COPY_GATE.md` | Claim verification and unsupported-claim removal. | `product-studio`; copy/build. | All public-facing products. | Pure reference analysis. |
| `safety/REGULATED_CLAIMS.md` | Medical/regulated risk limits. | `product-studio`; relevant discovery through verification. | Regulated industries. | Non-regulated scope. |
| `safety/NO_COPY_AND_PROVENANCE.md` | No-copy boundaries and reference attribution. | Both; reference/concept/build. | All. | Never skip when references are used. |
| `safety/DATA_PRESERVATION.md` | Backups, destructive-action constraints, private materials. | Both; mutations. | All. | Read-only work. |
| `safety/PRIVATE_MATERIALS.md` | Public-release exclusion rules for client materials and logs. | `product-studio`; packaging. | Distribution. | Normal client work. |

## 5. Project-local state

Every target project uses `<project-root>/.studio/`. It replaces the scattered `CLIENT_BRIEF.md` plus `docs/` hand-off with explicit sources of truth; implementation code remains outside `.studio/`.

```text
<project-root>/.studio/
├── PROJECT_BRIEF.md
├── CONFIRMED_FACTS.md
├── ASSUMPTIONS.md
├── AUDIENCE.md
├── USER_ROLES.md
├── USER_JOURNEYS.md
├── PRODUCT_SPEC.md
├── TECH_DECISION.md
├── ACTIVE_SURFACES.md
├── DEFERRED_SURFACES.md
├── references/
│   ├── INBOX.md
│   ├── INDEX.md
│   └── analyses/
├── concepts/
│   └── CONCEPTS.md
├── APPROVED_CONCEPT.md
├── COPY.md
├── DESIGN_SYSTEM.md
├── IMPLEMENTATION_PLAN.md
├── ACCEPTANCE_CRITERIA.md
├── VERIFICATION_REPORT.md
└── BUILD_REPORT.md
```

| Document | Source-of-truth status |
| --- | --- |
| `PROJECT_BRIEF.md` | Current brief and business/project framing; not a substitute for facts or product scope. |
| `CONFIRMED_FACTS.md` | Sole source for factual claims eligible for public-facing copy. |
| `ASSUMPTIONS.md` | Sole list of provisional, reversible decisions; never a factual-copy source. |
| `AUDIENCE.md`, `USER_ROLES.md`, `USER_JOURNEYS.md` | Current research/specification sources for user needs and flows. Empty/omitted only when genuinely irrelevant. |
| `PRODUCT_SPEC.md` | Sole source for agreed product behavior, IA, surfaces, features, states, and MVP boundary. |
| `TECH_DECISION.md` | Sole source for approved technical approach, alternatives, constraints, and rationale. |
| `ACTIVE_SURFACES.md`, `DEFERRED_SURFACES.md` | Sole scope boundary; every screen/page/flow belongs to exactly one list. |
| `references/INDEX.md` and `analyses/` | Project-local selected-reference evidence and synthesis links. The global catalog remains owned by `add-reference`. |
| `concepts/CONCEPTS.md` | Pre-approval options and comparison; historical, not authority once approval exists. |
| `APPROVED_CONCEPT.md` | Sole authority for selected concept and approved visual/copy direction. |
| `COPY.md`, `DESIGN_SYSTEM.md` | Approved detailed copy and interface-system sources, constrained by facts/spec/concept. |
| `IMPLEMENTATION_PLAN.md`, `ACCEPTANCE_CRITERIA.md` | Execution and testable completion agreement. |
| `VERIFICATION_REPORT.md`, `BUILD_REPORT.md` | Evidence and hand-off record; never retroactively override approved scope. |

The reference inbox under `.studio/` is a project selection/request queue, not a duplicate global asset catalog. `add-reference` owns any canonical asset storage, global analysis, duplicate detection, and reanalysis.

## 6. Decision hierarchy

Phase 2 must implement this exact priority order:

1. Latest explicit user instruction.
2. Safety and critical correctness.
3. `.studio/APPROVED_CONCEPT.md`.
4. `.studio/PRODUCT_SPEC.md`.
5. `.studio/TECH_DECISION.md`.
6. Other project-local `.studio/` documents.
7. Global knowledge rules.
8. Model defaults.

When a lower-priority document conflicts with a higher-priority source, do not silently “fix” the higher-priority source. Record the conflict in the appropriate project decision/assumption record and ask only when the resolution materially changes the approved scope, claim, safety, or technical decision.

## 7. Migration risks and controls

| Risk | Evidence in current system | Phase 2 control |
| --- | --- | --- |
| Lost commercial/factual guardrails | Copy rules are distributed across root rules, copy rules, new-project skill, build skill, templates. | Migrate each inventory row before retiring any source; add a traceability checklist. |
| Premature implementation | Approval gate is currently split across root rules and two skills. | Put one non-bypassable approval gate in `product-studio`; pre-approval files may not create application code. |
| Website-only behavior leaks into products | Website, hero, CSS Modules, Next.js, and fixed locale assumptions occur in build/template rules. | Route by product type; make hero and Next recipes conditional platform guidance. |
| Incomplete product discovery | No roles, journeys, states, feature priorities, MVP, or technical decision document exists. | Add dedicated product documents and require relevant discovery profile before concepts. |
| Excessive context loading | New-project skill says to read every applicable knowledge file, with no routing index. | Create `KNOWLEDGE_INDEX.md` with stage/type loading profiles and narrow references. |
| Reference expression or assets copied | Existing analyses contain good no-copy boundaries, but application patterns are not classified. | Preserve no-copy rules; add product/UX/interaction classification and provenance. |
| User reference overwrite/deletion | Inbox deletion is safe only when full catalog verification succeeds. | Retain the current manifest-before-delete gate unchanged and test it during implementation. |
| Project data enters plugin/public release | Live workspace includes project, reference assets, logs, and a public-release copy. | Define public/private allowlists; never package projects, `.studio/`, inbox, source assets, logs, or private index links. |
| Distribution incompatibility | README claims absent Codex/Claude manifests; current root has no manifest. | Audit target plugin schemas before packaging and make README claims only after manifests validate. |
| Duplicate/instruction drift | 24 files are exact live/public duplicates; `UI_SYSTEM.template.md` repeats two rule blocks. | Establish one authored source plus generated/copied release artifact; deduplicate template blocks. |
| Missing runtime safety evidence | No system test suite; Python scanner has no tests; project build evidence is example-specific. | Add focused validators/tests in a later phase; do not count historical Noma evidence as product-studio proof. |
| Hidden absolute local paths | Paths occur in a checked-in development log. | Exclude logs/cache artifacts from migration and public release. |
| Archive contamination | `migration-backup-2026-07-17` duplicates old rules. | Treat archive as read-only evidence; exclude it from active lookup and packaging. |

## Phase 2 change set (planned, not executed)

Expected created or changed paths:

- Create the `product-studio` skill, its UI descriptor, and its targeted support material.
- Update `add-reference` skill, analysis schema, inbox/reanalysis support, and descriptor for application/product references.
- Create the modular `knowledge/` tree listed in section 4 and its `KNOWLEDGE_INDEX.md`.
- Create the `.studio/` project-state templates and a migration map from current `CLIENT_BRIEF.md`/`docs/` templates.
- Update root operating rules and the workflow to expose only `product-studio` and `add-reference`.
- Replace or remove the three retired skill entry points only after their responsibilities are traceably represented in `product-studio`.
- Repair distribution packaging: add/validate only the manifests actually supported, revise README, and ensure public-release excludes private content and broken reference links.
- Add focused validation for skill frontmatter/descriptors, link integrity, template completeness, reference manifest handling, and approval-gate behavior.

Do **not** migrate the Noma Dental implementation, reference assets, inbox assets, logs, or the legacy archive as part of Phase 2 unless separately approved.

## Audit validation record

- Inspected all four live skills, their YAML descriptors, all helper files referenced by those skills, and the mirrored public-release skill set.
- Inspected root and project `AGENTS.md`; no `CLAUDE.md` was found.
- Inspected all seven live knowledge files, all nine live templates, the public-release README, the manifest/path claims, the inbox state, the only system script, and the application package metadata.
- Validated every one of the 25 reference analyses against all 18 required analysis headings and confirmed 25 corresponding index rows with valid live analysis links.
- Inventoried 47 meaningful responsibilities/guardrails in the table above. Found 24 exact live/public duplicate files, two duplicated blocks within `UI_SYSTEM.template.md`, and three material configuration conflicts: stale “five knowledge files” wording, README claims for missing plugin manifests, and public index links to analyses not shipped in the public release.
- No publishing, pushing, delete, rename, move, or migration was performed. The only repository artifact created by this audit is this file.
