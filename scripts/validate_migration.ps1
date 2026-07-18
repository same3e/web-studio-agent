[CmdletBinding()]
param()

$ErrorActionPreference = 'Stop'
$failures = [System.Collections.Generic.List[string]]::new()
function Assert-True([bool]$condition, [string]$message) { if (-not $condition) { $script:failures.Add($message) } }
function Read-Utf8([string]$path) { Get-Content -Raw -LiteralPath $path -Encoding utf8 }

$root = (Resolve-Path (Join-Path $PSScriptRoot '..')).Path
Set-Location $root

# Two active skills: valid frontmatter, unique names, deliberately separate scopes.
$skillFiles = @(Get-ChildItem 'skills' -Recurse -Filter SKILL.md | Sort-Object FullName)
Assert-True ($skillFiles.Count -eq 2) 'Expected exactly two active SKILL.md files under skills/.'
$names = @()
foreach ($file in $skillFiles) {
  $text = Read-Utf8 $file.FullName
  Assert-True ($text -match '(?s)^---\s*\r?\nname:\s*([a-z][a-z-]+)\s*\r?\ndescription:\s*(.+?)\s*\r?\n---') "Invalid frontmatter: $($file.FullName)"
  if ($text -match '(?m)^name:\s*(.+)$') { $names += $Matches[1].Trim() }
}
Assert-True (($names | Select-Object -Unique).Count -eq 2) 'Active skill names are not unique.'
$product = Read-Utf8 'skills/product-studio/SKILL.md'
$reference = Read-Utf8 'skills/add-reference/SKILL.md'
Assert-True ($product -match 'not for isolated fixes' -and $product -match 'Use `add-reference`') 'Product-studio scope boundary is incomplete.'
Assert-True ($reference -match 'does not select a technical stack' -and $reference -match 'does not.*implement') 'Add-reference scope boundary is incomplete.'

# Knowledge index must list every new modular file and never point at a missing file.
$index = Read-Utf8 'knowledge/KNOWLEDGE_INDEX.md'
$modular = @(Get-ChildItem 'knowledge' -Directory | ForEach-Object { Get-ChildItem $_.FullName -Recurse -Filter *.md } | Where-Object { $_.FullName -notmatch '\\knowledge\\$' })
foreach ($file in $modular) {
  $relative = $file.FullName.Substring($root.Length + 1).Replace('\','/')
  Assert-True ($index.Contains(('`' + $relative + '`'))) "Knowledge index is missing $relative"
}
$pathsInIndex = [regex]::Matches($index, '`(knowledge/[^`]+\.md)`') | ForEach-Object { $_.Groups[1].Value.Replace('/','\') } | Select-Object -Unique
foreach ($path in $pathsInIndex) { Assert-True (Test-Path -LiteralPath $path) "Knowledge index points to missing file: $path" }

# Active plugin folders must not contain absolute machine paths, secret values, or user reference assets.
$activeRoots = @('skills','knowledge','templates','.codex-plugin','.claude-plugin')
$activeFiles = @($activeRoots | Where-Object { Test-Path $_ } | ForEach-Object { Get-ChildItem $_ -Recurse -File })
foreach ($file in $activeFiles) {
  $text = Read-Utf8 $file.FullName
  Assert-True ($text -notmatch '(?i)(?:[a-z]:[\\/]|/Users/|/home/)') "Accidental absolute path: $($file.FullName)"
  Assert-True ($text -notmatch '(?i)(?:api[_-]?key|secret|token|password)\s*[:=]\s*["'']?[A-Za-z0-9_\-]{12,}') "Possible secret value: $($file.FullName)"
  foreach ($match in [regex]::Matches($text, '\]\(([^)]+)\)')) {
    $link = $match.Groups[1].Value.Trim()
    if ($link -and $link -notmatch '^(?:https?:|#|mailto:)') {
      $target = Join-Path $file.DirectoryName $link
      Assert-True (Test-Path -LiteralPath $target) "Broken relative link in $($file.FullName): $link"
    }
  }
}
try { Get-Content -Raw '.codex-plugin/plugin.json' | ConvertFrom-Json | Out-Null; Get-Content -Raw '.claude-plugin/plugin.json' | ConvertFrom-Json | Out-Null } catch { $failures.Add('Plugin manifest JSON is invalid.') }
$codex = Get-Content -Raw '.codex-plugin/plugin.json' | ConvertFrom-Json
Assert-True ($codex.name -eq 'web-studio-agent' -and $codex.version -match '^\d+\.\d+\.\d+$' -and $codex.skills -eq './skills/') 'Codex manifest identity, version, or skills path is invalid.'
foreach ($field in @('displayName','shortDescription','longDescription','developerName','category','capabilities','defaultPrompt')) { Assert-True ($null -ne $codex.interface.$field) "Codex manifest interface is missing $field." }
try { $marketplace = Get-Content -Raw '.claude-plugin/marketplace.json' | ConvertFrom-Json } catch { $marketplace = $null; $failures.Add('Claude marketplace JSON is invalid.') }
Assert-True ($null -ne $marketplace -and $marketplace.name -eq 'web-studio-agent' -and $marketplace.plugins.Count -eq 1 -and $marketplace.plugins[0].name -eq 'web-studio-agent' -and $marketplace.plugins[0].source -eq './') 'Claude marketplace manifest is incomplete.'
Assert-True (-not (Test-Path 'references')) 'Legacy global references directory is still active.'
Assert-True (-not (Test-Path 'inbox')) 'Legacy global inbox directory is still active.'

# Templates encode safe project-local initialization and preserve existing files by only creating absent targets.
$requiredTemplates = @('PROJECT_STATE','PROJECT_BRIEF','CONFIRMED_FACTS','ASSUMPTIONS','AUDIENCE','USER_ROLES','USER_FLOWS','PRODUCT_SPEC','TECH_DECISION','ACTIVE_AND_DEFERRED_SCOPE','CONTENT_REQUIREMENTS','APPROVED_CONCEPT','COPY','DESIGN_SYSTEM','IMPLEMENTATION_PLAN','IMPLEMENTATION_PREFLIGHT','ACCEPTANCE_CRITERIA','VERIFICATION_REPORT','BUILD_REPORT','CONTENT_LEDGER','ARTIFACT_LEDGER','BACKEND_SPEC','API_CONTRACT','DATABASE_DECISION','DATA_MODEL','MIGRATION_PLAN','DATA_RETENTION','INTEGRATION_SPEC','EXTERNAL_SERVICES','ENVIRONMENT_CONTRACT','THREAT_MODEL','SECURITY_MODEL','REFACTOR_PLAN','BEHAVIOR_INVARIANTS','PERFORMANCE_BUDGET','PERFORMANCE_PLAN','RELEASE_PLAN','DEPLOYMENT_MATRIX','RELEASE_CHECKLIST','ROLLBACK_PLAN','CHANGELOG_PLAN','OPERATIONS_PLAN','OBSERVABILITY_PLAN','HEALTH_CHECKS','INCIDENT_RESPONSE','RUNBOOK','BACKUP_RECOVERY','REFACTOR_REPORT','REFACTOR_VERIFICATION','PERFORMANCE_REPORT','PERFORMANCE_RECHECK','RELEASE_REPORT','DEPLOYMENT_VERIFICATION','OPERATIONS_READINESS','references/REFERENCE_INDEX','references/STYLE_INDEX','references/INDUSTRY_INDEX','references/PRODUCT_PATTERN_INDEX','references/UX_PATTERN_INDEX')
foreach ($name in $requiredTemplates) { Assert-True (Test-Path -LiteralPath "templates/studio/$name.template.md") "Missing studio template: $name" }
$fixture = Join-Path ([System.IO.Path]::GetTempPath()) ('web-studio-migration-' + [guid]::NewGuid().ToString('N'))
New-Item -ItemType Directory -Path $fixture | Out-Null
try {
  $existing = Join-Path $fixture '.studio/PROJECT_BRIEF.md'
  New-Item -ItemType Directory -Force -Path (Split-Path $existing) | Out-Null
  Set-Content -LiteralPath $existing -Value '# Existing user brief' -Encoding utf8
  Get-ChildItem 'templates/studio' -Recurse -Filter '*.template.md' | ForEach-Object {
    $relative = $_.FullName.Substring((Resolve-Path 'templates/studio').Path.Length + 1).Replace('.template.md','.md')
    $target = Join-Path $fixture ".studio/$relative"
    if (-not (Test-Path $target)) { New-Item -ItemType Directory -Force -Path (Split-Path $target) | Out-Null; Copy-Item $_.FullName $target }
  }
  Assert-True ((Read-Utf8 $existing) -match '^# Existing user brief') 'Automatic initialization overwrote an existing project document.'
  Assert-True (Test-Path (Join-Path $fixture '.studio/PROJECT_STATE.md')) 'Automatic initialization did not create project state.'
} finally { Remove-Item -LiteralPath $fixture -Recurse -Force }

# State, approval, factual/no-copy, and product-type workflow coverage.
foreach ($state in @('uninitialized','discovery','requirements','technical-decision','references-needed','concepts','awaiting-approval','approved','implementation','verification','complete')) { Assert-True ($product -match [regex]::Escape($state)) "State missing from product-studio: $state" }
Assert-True ($product -match 'Stop for explicit approval' -and $product -match 'If approval also requested implementation') 'Approval gate or continuation is missing.'
Assert-True ($product -match 'IMPLEMENTATION_PREFLIGHT' -and $product -match 'specialists/specs') 'Phase 1 preflight or specialist orchestration is missing.'
foreach ($role in @('repo-explorer','frontend-builder','test-engineer','code-reviewer','browser-qa')) {
  Assert-True (Test-Path "specialists/specs/$role.md") "Missing canonical specialist spec: $role"
  Assert-True (Test-Path "specialists/contracts/$role.md") "Missing canonical specialist contract: $role"
  Assert-True (Test-Path "platforms/codex/agents/$role.toml") "Missing Codex wrapper template: $role"
  Assert-True (Test-Path "platforms/claude/agents/$role.md") "Missing Claude wrapper template: $role"
}
foreach ($role in @('backend-builder','database-architect','integration-builder','security-auditor')) {
  Assert-True (Test-Path "specialists/specs/$role.md") "Missing Phase 2 specialist spec: $role"
  Assert-True (Test-Path "specialists/contracts/$role.md") "Missing Phase 2 specialist contract: $role"
  Assert-True (Test-Path "platforms/codex/agents/$role.toml") "Missing Phase 2 Codex wrapper: $role"
  Assert-True (Test-Path "platforms/claude/agents/$role.md") "Missing Phase 2 Claude wrapper: $role"
}
Assert-True (Test-Path 'specialists/contracts/FILE_OWNERSHIP.md') 'Missing canonical file ownership contract.'
Assert-True (Test-Path 'docs/architecture/CURRENT_STATE_AUDIT.md') 'Missing current-state architecture audit.'
Assert-True (Test-Path 'docs/architecture/SPECIALIST_SYSTEM.md') 'Missing specialist-system architecture.'
Assert-True (Test-Path 'docs/architecture/PLATFORM_AGENTS.md') 'Missing platform-agent documentation.'
Assert-True (Test-Path 'docs/architecture/MIGRATION_BACKLOG.md') 'Missing migration backlog.'
Assert-True ((Read-Utf8 'knowledge/verification/ARTIFACT_PROVENANCE.md') -match 'generated concept render') 'Artifact provenance rule missing.'
Assert-True ((Read-Utf8 'knowledge/business/CONTENT_LEDGER.md') -match 'Never invent') 'Content-ledger safeguard missing.'
Assert-True ((Read-Utf8 'knowledge/copy/FACT_BASED_COPY.md') -match 'Never invent') 'Factual-copy rule missing.'
Assert-True ((Read-Utf8 'knowledge/references/NO_COPY.md') -match 'not source text') 'No-copy rule missing.'
foreach ($platform in @('WEBSITE','SAAS','DASHBOARD','PWA','CROSS_PLATFORM_MOBILE')) { Assert-True (Test-Path "knowledge/platforms/$platform.md") "Missing product workflow: $platform" }
Assert-True (Test-Path 'knowledge/starters/EXISTING_PROJECT_INTEGRATION.md') 'Missing existing-project integration workflow.'
Assert-True ($reference -match 'public URLs' -and $reference -match 'screenshots' -and $reference -match 'duplicates') 'URL, screenshot, or duplicate reference workflow missing.'
foreach ($legacy in @('studio-setup','new-site-project','build-site','add-reference')) { Assert-True ((Read-Utf8 'docs/MIGRATION_FROM_FOUR_SKILLS.md') -match [regex]::Escape(('`' + $legacy + '`'))) "Migration mapping omits legacy skill: $legacy" }

# Release documents, templates, examples, and CI are part of the distributable product.
foreach ($path in @('README.md','INSTALL.md','QUICKSTART.md','CHANGELOG.md','LICENSE','CONTRIBUTING.md','docs/HOW_IT_WORKS.md','docs/PRODUCT_DISCOVERY.md','docs/PROJECT_STATE_MACHINE.md','docs/TECH_STACK_SELECTION.md','docs/ENGINEERING_STARTERS.md','docs/REFERENCE_WORKFLOW.md','docs/APPROVAL_AND_IMPLEMENTATION.md','docs/KNOWLEDGE_ROUTING.md','docs/PROJECT_FILES.md','docs/SECURITY_AND_PRIVACY.md','docs/TROUBLESHOOTING.md','templates/studio/references/ANALYSIS.template.md','templates/studio/concepts/CONCEPT.template.md','.github/workflows/validate.yml')) { Assert-True (Test-Path -LiteralPath $path) "Missing release artifact: $path" }
foreach ($path in @('examples/marketing-site/.studio/PROJECT_BRIEF.md','examples/saas-dashboard/.studio/USER_ROLES.md','examples/ai-web-application/.studio/TECH_DECISION.md')) { Assert-True (Test-Path -LiteralPath $path) "Missing synthetic example artifact: $path" }
Assert-True ((Read-Utf8 '.github/workflows/validate.yml') -match 'scripts/validate_migration.ps1') 'CI does not run migration validation.'
Assert-True (Test-Path 'scripts/test_phase1_behavioral.ps1') 'Missing Phase 1 behavioral test script.'
foreach ($path in @('scripts/Test-ImplementationPreflight.ps1','scripts/Initialize-ApprovedProjectRecords.ps1','scripts/Resolve-SpecialistPlan.ps1','scripts/Test-ProvenanceAndContentLedger.ps1','scripts/test_phase1_runtime.ps1','docs/architecture/PHASE1_TEST_AUDIT.md','docs/architecture/SPECIALIST_ROUTING_VERIFICATION.md')) { Assert-True (Test-Path $path) "Missing Phase 1.1 runtime artifact: $path" }
foreach ($path in @('scripts/test_phase2_contracts.ps1','docs/architecture/PHASE2_EXTENSION_AUDIT.md','docs/architecture/PHASE2_ARCHITECTURE.md')) { Assert-True (Test-Path $path) "Missing Phase 2 artifact: $path" }

if ($failures.Count -gt 0) {
  $failures | ForEach-Object { Write-Error $_ }
  exit 1
}
Write-Host "Migration validation passed: $($skillFiles.Count) active skills, $($modular.Count) modular knowledge files, $($requiredTemplates.Count) required state templates."
