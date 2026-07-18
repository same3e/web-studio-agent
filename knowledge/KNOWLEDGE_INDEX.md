# Knowledge index

## Routing protocol

1. Identify task, project state, product type, active risk, and requested outcome.
2. Read this index, then load only the listed relevant documents.
3. Project-local facts, scope, approval, and technical decisions override global methodology.
4. Record the applied knowledge set in .studio/VERIFICATION_REPORT.md or .studio/BUILD_REPORT.md when it affected a material decision.

## Phase 1 specialist routes

| Document | Owner | Load when | Project record |
| --- | --- | --- | --- |
| `knowledge/business/CONTENT_LEDGER.md` | product-studio | public copy, placeholders, forms, claims, or legal-link state | `.studio/CONTENT_LEDGER.md` |
| `knowledge/verification/ARTIFACT_PROVENANCE.md` | product-studio | any concept image, asset, screenshot, browser QA, or final report | `.studio/ARTIFACT_LEDGER.md` |
| `knowledge/engineering/API_BOUNDARIES.md` | product-studio | active API or server surface | `.studio/API_CONTRACT.md` |
| `knowledge/engineering/SERVER_RELIABILITY.md` | product-studio | backend implementation | `.studio/BACKEND_SPEC.md` |
| `knowledge/engineering/WEBHOOKS_AND_IDEMPOTENCY.md` | product-studio | webhook or retried write | `.studio/INTEGRATION_SPEC.md` |
| `knowledge/engineering/BACKEND_OBSERVABILITY.md` | product-studio | backend logging or operations | `.studio/BACKEND_SPEC.md` |
| `knowledge/engineering/DATABASE_DECISIONS.md` | product-studio | persistence decision | `.studio/DATABASE_DECISION.md` |
| `knowledge/engineering/DATA_INTEGRITY.md` | product-studio | data model or schema | `.studio/DATA_MODEL.md` |
| `knowledge/engineering/MIGRATIONS_AND_RETENTION.md` | product-studio | migrations or retention | `.studio/MIGRATION_PLAN.md` |
| `knowledge/engineering/DATABASE_ACCESS.md` | product-studio | database access or tenancy | `.studio/SECURITY_MODEL.md` |
| `knowledge/engineering/INTEGRATION_BOUNDARIES.md` | product-studio | external provider | `.studio/INTEGRATION_SPEC.md` |
| `knowledge/engineering/INTEGRATION_RELIABILITY.md` | product-studio | retry, timeout, webhook, mock | `.studio/INTEGRATION_SPEC.md` |
| `knowledge/engineering/PROVIDER_SECURITY.md` | product-studio | provider auth or secrets | `.studio/ENVIRONMENT_CONTRACT.md` |
| `knowledge/safety/SECURITY_REVIEW.md` | product-studio | material security surface | `.studio/THREAT_MODEL.md` |
| `knowledge/safety/APPLICATION_SECURITY.md` | product-studio | app security control | `.studio/SECURITY_MODEL.md` |
| `knowledge/safety/SECURITY_OPERATIONS.md` | product-studio | secrets, data, dependencies | `.studio/SECURITY_MODEL.md` |
| `knowledge/engineering/REFACTORING.md` | product-studio | approved refactor | `.studio/REFACTOR_PLAN.md` |
| `knowledge/engineering/PERFORMANCE_AUDIT.md` | product-studio | performance budget or regression | `.studio/PERFORMANCE_BUDGET.md` |
| `knowledge/engineering/RELEASE_READINESS.md` | product-studio | release or deployment planning | `.studio/RELEASE_PLAN.md` |
| `knowledge/engineering/OPERATIONS.md` | product-studio | persistent operational surface | `.studio/OPERATIONS_PLAN.md` |

| Document | Owner | Load when | Do not load when | Project stage | Product types | Related project documents |
| --- | --- | --- | --- | --- | --- |
| `knowledge/core/PROJECT_STATE.md` | both | relevant core task or risk | unrelated read-only task | routed state | relevant products | relevant .studio/ record |
| `knowledge/core/SOURCE_OF_TRUTH.md` | both | relevant core task or risk | unrelated read-only task | routed state | relevant products | relevant .studio/ record |
| `knowledge/core/APPROVAL_GATES.md` | both | relevant core task or risk | unrelated read-only task | routed state | relevant products | relevant .studio/ record |
| `knowledge/core/DECISION_HIERARCHY.md` | both | relevant core task or risk | unrelated read-only task | routed state | relevant products | relevant .studio/ record |
| `knowledge/core/WORKFLOW.md` | both | relevant core task or risk | unrelated read-only task | routed state | relevant products | relevant .studio/ record |
| `knowledge/core/USER_INTERACTION.md` | both | relevant core task or risk | unrelated read-only task | routed state | relevant products | relevant .studio/ record |
| `knowledge/core/PROJECT_FILE_RULES.md` | both | relevant core task or risk | unrelated read-only task | routed state | relevant products | relevant .studio/ record |
| `knowledge/business/MVP_SCOPING.md` | product-studio | relevant business task or risk | unrelated read-only task | routed state | relevant products | relevant .studio/ record |
| `knowledge/business/SUCCESS_METRICS.md` | product-studio | relevant business task or risk | unrelated read-only task | routed state | relevant products | relevant .studio/ record |
| `knowledge/business/BUSINESS_AUDIT.md` | product-studio | relevant business task or risk | unrelated read-only task | routed state | relevant products | relevant .studio/ record |
| `knowledge/business/PROJECT_DISCOVERY.md` | product-studio | relevant business task or risk | unrelated read-only task | routed state | relevant products | relevant .studio/ record |
| `knowledge/business/AUDIENCE_ANALYSIS.md` | product-studio | relevant business task or risk | unrelated read-only task | routed state | relevant products | relevant .studio/ record |
| `knowledge/business/VALUE_PROPOSITION.md` | product-studio | relevant business task or risk | unrelated read-only task | routed state | relevant products | relevant .studio/ record |
| `knowledge/business/CONFIRMED_FACTS.md` | product-studio | relevant business task or risk | unrelated read-only task | routed state | relevant products | relevant .studio/ record |
| `knowledge/product/INFORMATION_ARCHITECTURE.md` | product-studio | relevant product task or risk | unrelated read-only task | routed state | relevant products | relevant .studio/ record |
| `knowledge/product/PRODUCT_REQUIREMENTS.md` | product-studio | relevant product task or risk | unrelated read-only task | routed state | relevant products | relevant .studio/ record |
| `knowledge/product/ONBOARDING.md` | product-studio | relevant product task or risk | unrelated read-only task | routed state | relevant products | relevant .studio/ record |
| `knowledge/product/SCREEN_ARCHITECTURE.md` | product-studio | relevant product task or risk | unrelated read-only task | routed state | relevant products | relevant .studio/ record |
| `knowledge/product/USER_ROLES.md` | product-studio | relevant product task or risk | unrelated read-only task | routed state | relevant products | relevant .studio/ record |
| `knowledge/product/STATES_AND_EDGE_CASES.md` | product-studio | relevant product task or risk | unrelated read-only task | routed state | relevant products | relevant .studio/ record |
| `knowledge/product/FEATURE_PRIORITIZATION.md` | product-studio | relevant product task or risk | unrelated read-only task | routed state | relevant products | relevant .studio/ record |
| `knowledge/product/AI_FEATURES.md` | product-studio | relevant product task or risk | unrelated read-only task | routed state | relevant products | relevant .studio/ record |
| `knowledge/product/ADMIN_PANELS.md` | product-studio | relevant product task or risk | unrelated read-only task | routed state | relevant products | relevant .studio/ record |
| `knowledge/product/USER_FLOWS.md` | product-studio | relevant product task or risk | unrelated read-only task | routed state | relevant products | relevant .studio/ record |
| `knowledge/ux/DESKTOP_UX.md` | product-studio | relevant ux task or risk | unrelated read-only task | routed state | relevant products | relevant .studio/ record |
| `knowledge/ux/NAVIGATION.md` | product-studio | relevant ux task or risk | unrelated read-only task | routed state | relevant products | relevant .studio/ record |
| `knowledge/ux/CONVERSION.md` | product-studio | relevant ux task or risk | unrelated read-only task | routed state | relevant products | relevant .studio/ record |
| `knowledge/ux/MOBILE_UX.md` | product-studio | relevant ux task or risk | unrelated read-only task | routed state | relevant products | relevant .studio/ record |
| `knowledge/ux/ERROR_PREVENTION.md` | product-studio | relevant ux task or risk | unrelated read-only task | routed state | relevant products | relevant .studio/ record |
| `knowledge/ux/FORMS.md` | product-studio | relevant ux task or risk | unrelated read-only task | routed state | relevant products | relevant .studio/ record |
| `knowledge/ux/UX_RULES.md` | product-studio | relevant ux task or risk | unrelated read-only task | routed state | relevant products | relevant .studio/ record |
| `knowledge/ux/ACCESSIBILITY.md` | product-studio | relevant ux task or risk | unrelated read-only task | routed state | relevant products | relevant .studio/ record |
| `knowledge/ux/FEEDBACK_AND_STATUS.md` | product-studio | relevant ux task or risk | unrelated read-only task | routed state | relevant products | relevant .studio/ record |
| `knowledge/ux/CORE_USER_JOURNEYS.md` | product-studio | relevant ux task or risk | unrelated read-only task | routed state | relevant products | relevant .studio/ record |
| `knowledge/ui/IMAGERY.md` | product-studio | relevant ui task or risk | unrelated read-only task | routed state | relevant products | relevant .studio/ record |
| `knowledge/ui/MOTION.md` | product-studio | relevant ui task or risk | unrelated read-only task | routed state | relevant products | relevant .studio/ record |
| `knowledge/ui/ICONS.md` | product-studio | relevant ui task or risk | unrelated read-only task | routed state | relevant products | relevant .studio/ record |
| `knowledge/ui/LAYOUT.md` | product-studio | relevant ui task or risk | unrelated read-only task | routed state | relevant products | relevant .studio/ record |
| `knowledge/ui/APPLICATION_UI.md` | product-studio | relevant ui task or risk | unrelated read-only task | routed state | relevant products | relevant .studio/ record |
| `knowledge/ui/MARKETING_SITES.md` | product-studio | relevant ui task or risk | unrelated read-only task | routed state | relevant products | relevant .studio/ record |
| `knowledge/ui/VISUAL_DIRECTION.md` | product-studio | relevant ui task or risk | unrelated read-only task | routed state | relevant products | relevant .studio/ record |
| `knowledge/ui/TYPOGRAPHY.md` | product-studio | relevant ui task or risk | unrelated read-only task | routed state | relevant products | relevant .studio/ record |
| `knowledge/ui/RESPONSIVE_DESIGN.md` | product-studio | relevant ui task or risk | unrelated read-only task | routed state | relevant products | relevant .studio/ record |
| `knowledge/ui/COLOR.md` | product-studio | relevant ui task or risk | unrelated read-only task | routed state | relevant products | relevant .studio/ record |
| `knowledge/ui/DASHBOARDS.md` | product-studio | relevant ui task or risk | unrelated read-only task | routed state | relevant products | relevant .studio/ record |
| `knowledge/ui/DESIGN_SYSTEM.md` | product-studio | relevant ui task or risk | unrelated read-only task | routed state | relevant products | relevant .studio/ record |
| `knowledge/ui/SPACING.md` | product-studio | relevant ui task or risk | unrelated read-only task | routed state | relevant products | relevant .studio/ record |
| `knowledge/ui/FRONTEND_QUALITY.md` | product-studio | approved visible frontend direction | unrelated read-only task | implementation-planning | web products | `.studio/DESIGN_SYSTEM.md` |
| `knowledge/ui/STYLE_LAYOUT_RULES.md` | product-studio | approved named visual direction | no visual direction | concepts or implementation-planning | relevant products | `.studio/DESIGN_SYSTEM.md` |
| `knowledge/ui/HOUSE_TASTE_DEFAULTS.md` | product-studio | no stronger approved or user/project taste rule | stronger rule applies | concepts or implementation-planning | relevant products | `.studio/TASTE_OVERRIDES.md` |
| `knowledge/copy/COPY_RULES.md` | product-studio | relevant copy task or risk | unrelated read-only task | routed state | relevant products | relevant .studio/ record |
| `knowledge/copy/PRODUCT_UI_COPY.md` | product-studio | relevant copy task or risk | unrelated read-only task | routed state | relevant products | relevant .studio/ record |
| `knowledge/copy/ERROR_MESSAGES.md` | product-studio | relevant copy task or risk | unrelated read-only task | routed state | relevant products | relevant .studio/ record |
| `knowledge/copy/EMPTY_STATES.md` | product-studio | relevant copy task or risk | unrelated read-only task | routed state | relevant products | relevant .studio/ record |
| `knowledge/copy/LANDING_PAGE_COPY.md` | product-studio | relevant copy task or risk | unrelated read-only task | routed state | relevant products | relevant .studio/ record |
| `knowledge/copy/FACT_BASED_COPY.md` | product-studio | relevant copy task or risk | unrelated read-only task | routed state | relevant products | relevant .studio/ record |
| `knowledge/copy/CTA.md` | product-studio | relevant copy task or risk | unrelated read-only task | routed state | relevant products | relevant .studio/ record |
| `knowledge/copy/TONE_OF_VOICE.md` | product-studio | relevant copy task or risk | unrelated read-only task | routed state | relevant products | relevant .studio/ record |
| `knowledge/copy/POSITIONING.md` | product-studio | relevant copy task or risk | unrelated read-only task | routed state | relevant products | relevant .studio/ record |
| `knowledge/copy/SEO.md` | product-studio | relevant copy task or risk | unrelated read-only task | routed state | relevant products | relevant .studio/ record |
| `knowledge/references/REFERENCE_WORKFLOW.md` | add-reference | relevant references task or risk | unrelated read-only task | routed state | all reference tasks | relevant .studio/ record |
| `knowledge/references/REFERENCE_SELECTION.md` | add-reference | relevant references task or risk | unrelated read-only task | routed state | all reference tasks | relevant .studio/ record |
| `knowledge/references/REFERENCE_ANALYSIS.md` | add-reference | relevant references task or risk | unrelated read-only task | routed state | all reference tasks | relevant .studio/ record |
| `knowledge/references/REFERENCE_ROLES.md` | add-reference | relevant references task or risk | unrelated read-only task | routed state | all reference tasks | relevant .studio/ record |
| `knowledge/references/NO_COPY.md` | add-reference | relevant references task or risk | unrelated read-only task | routed state | all reference tasks | relevant .studio/ record |
| `knowledge/references/REFERENCE_APPLICATION.md` | add-reference | relevant references task or risk | unrelated read-only task | routed state | all reference tasks | relevant .studio/ record |
| `knowledge/references/UX_PATTERN_CLASSIFICATION.md` | add-reference | relevant references task or risk | unrelated read-only task | routed state | all reference tasks | relevant .studio/ record |
| `knowledge/references/STYLE_CLASSIFICATION.md` | add-reference | relevant references task or risk | unrelated read-only task | routed state | all reference tasks | relevant .studio/ record |
| `knowledge/references/PRODUCT_PATTERN_CLASSIFICATION.md` | add-reference | relevant references task or risk | unrelated read-only task | routed state | all reference tasks | relevant .studio/ record |
| `knowledge/engineering/PERFORMANCE.md` | product-studio | relevant engineering task or risk | unrelated read-only task | routed state | relevant products | relevant .studio/ record |
| `knowledge/engineering/ARCHITECTURE.md` | product-studio | relevant engineering task or risk | unrelated read-only task | routed state | relevant products | relevant .studio/ record |
| `knowledge/engineering/FILE_UPLOADS.md` | product-studio | relevant engineering task or risk | unrelated read-only task | routed state | relevant products | relevant .studio/ record |
| `knowledge/engineering/PRIVACY.md` | product-studio | relevant engineering task or risk | unrelated read-only task | routed state | relevant products | relevant .studio/ record |
| `knowledge/engineering/STACK_SELECTION.md` | product-studio | relevant engineering task or risk | unrelated read-only task | routed state | relevant products | relevant .studio/ record |
| `knowledge/engineering/AUTHENTICATION.md` | product-studio | relevant engineering task or risk | unrelated read-only task | routed state | relevant products | relevant .studio/ record |
| `knowledge/engineering/PAYMENTS.md` | product-studio | relevant engineering task or risk | unrelated read-only task | routed state | relevant products | relevant .studio/ record |
| `knowledge/engineering/BACKEND.md` | product-studio | relevant engineering task or risk | unrelated read-only task | routed state | relevant products | relevant .studio/ record |
| `knowledge/engineering/TESTING.md` | product-studio | relevant engineering task or risk | unrelated read-only task | routed state | relevant products | relevant .studio/ record |
| `knowledge/engineering/AUTHORIZATION.md` | product-studio | relevant engineering task or risk | unrelated read-only task | routed state | relevant products | relevant .studio/ record |
| `knowledge/engineering/DATABASE.md` | product-studio | relevant engineering task or risk | unrelated read-only task | routed state | relevant products | relevant .studio/ record |
| `knowledge/engineering/SECURITY.md` | product-studio | relevant engineering task or risk | unrelated read-only task | routed state | relevant products | relevant .studio/ record |
| `knowledge/engineering/API_DESIGN.md` | product-studio | relevant engineering task or risk | unrelated read-only task | routed state | relevant products | relevant .studio/ record |
| `knowledge/engineering/REALTIME.md` | product-studio | relevant engineering task or risk | unrelated read-only task | routed state | relevant products | relevant .studio/ record |
| `knowledge/engineering/DEPLOYMENT.md` | product-studio | relevant engineering task or risk | unrelated read-only task | routed state | relevant products | relevant .studio/ record |
| `knowledge/engineering/NOTIFICATIONS.md` | product-studio | relevant engineering task or risk | unrelated read-only task | routed state | relevant products | relevant .studio/ record |
| `knowledge/engineering/FRONTEND.md` | product-studio | relevant engineering task or risk | unrelated read-only task | routed state | relevant products | relevant .studio/ record |
| `knowledge/engineering/OFFLINE.md` | product-studio | relevant engineering task or risk | unrelated read-only task | routed state | relevant products | relevant .studio/ record |
| `knowledge/engineering/refactoring/PLANNING.md` | product-studio | approved refactor or structural remediation | normal feature work | implementation-planning | existing implementation | `.studio/REFACTOR_PLAN.md` |
| `knowledge/engineering/refactoring/VERIFICATION.md` | product-studio | approved refactor verification | no refactor | specialist-verification | existing implementation | `.studio/REFACTOR_VERIFICATION.md` |
| `knowledge/engineering/performance/MEASUREMENT.md` | product-studio | performance criterion or regression | trivial/documentation scope | specialist-verification | relevant products | `.studio/PERFORMANCE_REPORT.md` |
| `knowledge/engineering/performance/SURFACES.md` | product-studio | heavy frontend/backend/data/media/job surfaces | no material surface | implementation | relevant products | `.studio/PERFORMANCE_PLAN.md` |
| `knowledge/engineering/release/READINESS.md` | product-studio | CI, release, deployment, domain, handoff | local-only prototype | handoff | relevant products | `.studio/RELEASE_PLAN.md` |
| `knowledge/engineering/release/DEPLOYMENT.md` | product-studio | authorized deployment preparation | no release scope | handoff | relevant products | `.studio/DEPLOYMENT_MATRIX.md` |
| `knowledge/engineering/operations/OBSERVABILITY.md` | product-studio | persistent runtime or material integration | static site | handoff | relevant products | `.studio/OBSERVABILITY_PLAN.md` |
| `knowledge/engineering/operations/RECOVERY.md` | product-studio | production data/jobs/recovery needs | static site | handoff | relevant products | `.studio/BACKUP_RECOVERY.md` |
| `knowledge/platforms/LANDING_PAGE.md` | product-studio | relevant platforms task or risk | unrelated read-only task | routed state | landing page | relevant .studio/ record |
| `knowledge/platforms/ANDROID_APP.md` | product-studio | relevant platforms task or risk | unrelated read-only task | routed state | android app | relevant .studio/ record |
| `knowledge/platforms/CROSS_PLATFORM_MOBILE.md` | product-studio | relevant platforms task or risk | unrelated read-only task | routed state | cross platform mobile | relevant .studio/ record |
| `knowledge/platforms/SAAS.md` | product-studio | relevant platforms task or risk | unrelated read-only task | routed state | saas | relevant .studio/ record |
| `knowledge/platforms/WEBSITE.md` | product-studio | relevant platforms task or risk | unrelated read-only task | routed state | website | relevant .studio/ record |
| `knowledge/platforms/WEB_APP.md` | product-studio | relevant platforms task or risk | unrelated read-only task | routed state | web app | relevant .studio/ record |
| `knowledge/platforms/INTERNAL_TOOL.md` | product-studio | relevant platforms task or risk | unrelated read-only task | routed state | internal tool | relevant .studio/ record |
| `knowledge/platforms/PWA.md` | product-studio | relevant platforms task or risk | unrelated read-only task | routed state | pwa | relevant .studio/ record |
| `knowledge/platforms/IOS_APP.md` | product-studio | relevant platforms task or risk | unrelated read-only task | routed state | ios app | relevant .studio/ record |
| `knowledge/platforms/DASHBOARD.md` | product-studio | relevant platforms task or risk | unrelated read-only task | routed state | dashboard | relevant .studio/ record |
| `knowledge/verification/VERIFICATION_WORKFLOW.md` | product-studio | relevant verification task or risk | unrelated read-only task | routed state | relevant products | relevant .studio/ record |
| `knowledge/verification/RESPONSIVE_QA.md` | product-studio | relevant verification task or risk | unrelated read-only task | routed state | relevant products | relevant .studio/ record |
| `knowledge/verification/COPY_AUDIT.md` | product-studio | relevant verification task or risk | unrelated read-only task | routed state | relevant products | relevant .studio/ record |
| `knowledge/verification/FACT_AUDIT.md` | product-studio | relevant verification task or risk | unrelated read-only task | routed state | relevant products | relevant .studio/ record |
| `knowledge/verification/VISUAL_FIDELITY.md` | product-studio | relevant verification task or risk | unrelated read-only task | routed state | relevant products | relevant .studio/ record |
| `knowledge/verification/ACCESSIBILITY_QA.md` | product-studio | relevant verification task or risk | unrelated read-only task | routed state | relevant products | relevant .studio/ record |
| `knowledge/verification/PERFORMANCE_QA.md` | product-studio | relevant verification task or risk | unrelated read-only task | routed state | relevant products | relevant .studio/ record |
| `knowledge/verification/REQUIREMENTS_AUDIT.md` | product-studio | relevant verification task or risk | unrelated read-only task | routed state | relevant products | relevant .studio/ record |
| `knowledge/verification/NO_COPY_AUDIT.md` | product-studio | relevant verification task or risk | unrelated read-only task | routed state | relevant products | relevant .studio/ record |
| `knowledge/verification/FUNCTIONAL_QA.md` | product-studio | relevant verification task or risk | unrelated read-only task | routed state | relevant products | relevant .studio/ record |
| `knowledge/verification/BUILD_REPORT.md` | product-studio | relevant verification task or risk | unrelated read-only task | routed state | relevant products | relevant .studio/ record |
| `knowledge/safety/EXTERNAL_CONTENT.md` | both | relevant safety task or risk | unrelated read-only task | routed state | all | relevant .studio/ record |
| `knowledge/safety/USER_DATA.md` | both | relevant safety task or risk | unrelated read-only task | routed state | all | relevant .studio/ record |
| `knowledge/safety/DESTRUCTIVE_ACTIONS.md` | both | relevant safety task or risk | unrelated read-only task | routed state | all | relevant .studio/ record |
| `knowledge/safety/THIRD_PARTY_SERVICES.md` | both | relevant safety task or risk | unrelated read-only task | routed state | all | relevant .studio/ record |
| `knowledge/safety/LEGAL_BOUNDARIES.md` | both | relevant safety task or risk | unrelated read-only task | routed state | all | relevant .studio/ record |
| `knowledge/safety/PROMPT_INJECTION.md` | both | relevant safety task or risk | unrelated read-only task | routed state | all | relevant .studio/ record |
| `knowledge/safety/SECRETS.md` | both | relevant safety task or risk | unrelated read-only task | routed state | all | relevant .studio/ record |
| `knowledge/starters/STATIC_MARKETING_SITE.md` | product-studio | technical-decision | reference-only task | technical-decision | relevant products | `.studio/TECH_DECISION.md` |
| `knowledge/starters/CONTENT_SEO_WEBSITE.md` | product-studio | technical-decision | reference-only task | technical-decision | relevant products | `.studio/TECH_DECISION.md` |
| `knowledge/starters/NEXTJS_MANAGED_BACKEND_MVP.md` | product-studio | technical-decision | reference-only task | technical-decision | relevant products | `.studio/TECH_DECISION.md` |
| `knowledge/starters/FULL_STACK_TYPESCRIPT_APPLICATION.md` | product-studio | technical-decision | reference-only task | technical-decision | relevant products | `.studio/TECH_DECISION.md` |
| `knowledge/starters/PYTHON_AI_APPLICATION.md` | product-studio | technical-decision | reference-only task | technical-decision | relevant products | `.studio/TECH_DECISION.md` |
| `knowledge/starters/DASHBOARD_INTERNAL_TOOL.md` | product-studio | technical-decision | reference-only task | technical-decision | relevant products | `.studio/TECH_DECISION.md` |
| `knowledge/starters/PWA.md` | product-studio | technical-decision | reference-only task | technical-decision | relevant products | `.studio/TECH_DECISION.md` |
| `knowledge/starters/EXPO_CROSS_PLATFORM_MOBILE.md` | product-studio | technical-decision | reference-only task | technical-decision | relevant products | `.studio/TECH_DECISION.md` |
| `knowledge/starters/EXISTING_PROJECT_INTEGRATION.md` | product-studio | technical-decision | reference-only task | technical-decision | relevant products | `.studio/TECH_DECISION.md` |
