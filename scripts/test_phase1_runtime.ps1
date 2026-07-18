[CmdletBinding()]
param()

$ErrorActionPreference = 'Stop'
$root = (Resolve-Path (Join-Path $PSScriptRoot '..')).Path
$output = Join-Path $root '.phase1-test-output/runtime'
if(Test-Path $output){ Remove-Item -LiteralPath $output -Recurse -Force }
New-Item -ItemType Directory -Path $output | Out-Null
function New-Project([string]$name, [bool]$approved, [bool]$derived, [bool]$existing = $false, [bool]$documentationOnly = $false) {
  $project = Join-Path $output $name; $studio = Join-Path $project '.studio'; New-Item -ItemType Directory -Force -Path $studio | Out-Null
  foreach($record in @('PROJECT_BRIEF','CONFIRMED_FACTS','ASSUMPTIONS','TECH_DECISION')) { Set-Content -LiteralPath (Join-Path $studio "$record.md") -Value "# $record`nfixture evidence" -Encoding utf8 }
  $stateContent = if($documentationOnly){"# State`n- Change type: documentation-only"}else{"# State`n- Product type: landing page"}
  Set-Content -LiteralPath (Join-Path $studio 'PROJECT_STATE.md') -Value $stateContent -Encoding utf8
  if($approved){ Set-Content -LiteralPath (Join-Path $studio 'APPROVED_CONCEPT.md') -Value '# Approved concept`n## Explicit decision`nApproved fixture.' -Encoding utf8 }
  if($derived){ foreach($record in @('COPY','DESIGN_SYSTEM','IMPLEMENTATION_PLAN','ACCEPTANCE_CRITERIA')){ Copy-Item (Join-Path $root "templates/studio/$record.template.md") (Join-Path $studio "$record.md") } }
  if($existing){ Set-Content -LiteralPath (Join-Path $project 'package.json') -Value '{"name":"fixture"}' -Encoding utf8; New-Item -ItemType Directory -Path (Join-Path $project 'src') | Out-Null }
  return $project
}
function Expect-Failure([scriptblock]$action, [string]$name) { try { & $action; throw "Expected failure did not occur: $name" } catch { if($_.Exception.Message -match 'Expected failure did not occur'){ throw }; Write-Host "Expected failure: $name" } }

# Case A — approval missing: blocks and does not create application source.
$caseA = New-Project 'case-a-no-approval' $false $false
Expect-Failure { & (Join-Path $root 'scripts/Test-ImplementationPreflight.ps1') -ProjectRoot $caseA } 'Case A implementation without approval'
if(-not (Select-String -LiteralPath (Join-Path $caseA '.studio/IMPLEMENTATION_PREFLIGHT.md') -Pattern 'APPROVED_CONCEPT.md' -Quiet)){ throw 'Case A did not name APPROVED_CONCEPT.md.' }
if(Test-Path (Join-Path $caseA 'src')){ throw 'Case A created application source.' }

# Case B — approved but derived records missing: blocks, then initialization repairs only missing records.
$caseB = New-Project 'case-b-derived-records' $true $false
Expect-Failure { & (Join-Path $root 'scripts/Test-ImplementationPreflight.ps1') -ProjectRoot $caseB } 'Case B missing derived records'
& (Join-Path $root 'scripts/Initialize-ApprovedProjectRecords.ps1') -ProjectRoot $caseB
& (Join-Path $root 'scripts/Test-ImplementationPreflight.ps1') -ProjectRoot $caseB

# Case C — fully ready state passes and writes specialist plan.
$caseC = New-Project 'case-c-ready' $true $true
& (Join-Path $root 'scripts/Test-ImplementationPreflight.ps1') -ProjectRoot $caseC
if(-not (Test-Path (Join-Path $caseC '.studio/reports/specialist-plan.md'))){ throw 'Case C did not produce a specialist plan.' }

# Routing: landing, existing repository, and documentation-only change.
$existing = New-Project 'routing-existing' $true $true $true
$docs = New-Project 'routing-docs' $true $true $false $true
$landingPlan = & (Join-Path $root 'scripts/Resolve-SpecialistPlan.ps1') -ProjectRoot $caseC
$existingPlan = & (Join-Path $root 'scripts/Resolve-SpecialistPlan.ps1') -ProjectRoot $existing
$docsPlan = & (Join-Path $root 'scripts/Resolve-SpecialistPlan.ps1') -ProjectRoot $docs
if((@($landingPlan.Selected) -join ',') -ne 'frontend-builder,test-engineer,code-reviewer,browser-qa'){ throw 'Simple landing routing mismatch.' }
if(@($existingPlan.Selected) -notcontains 'repo-explorer'){ throw 'Existing frontend did not select repo-explorer.' }
if(@($docsPlan.Selected).Count -ne 0 -or @($docsPlan.Skipped).Count -ne 5){ throw 'Documentation-only routing mismatch.' }

# Provenance: no browser capture may not claim browser verification; complete capture passes.
$prov = New-Project 'provenance' $true $true
Copy-Item (Join-Path $root 'templates/studio/ARTIFACT_LEDGER.template.md') (Join-Path $prov '.studio/ARTIFACT_LEDGER.md')
Add-Content -LiteralPath (Join-Path $prov '.studio/ARTIFACT_LEDGER.md') -Value '| concept.png | generated concept render | prompt |  |  |  |  |  | concept only |'
Set-Content -LiteralPath (Join-Path $prov '.studio/VERIFICATION_REPORT.md') -Value "# Verification report`n- Concept status: approved`n- Source-code status: implemented`n- Build status: passed`n- Browser-verification status: passed`n- Production blockers: none" -Encoding utf8
Expect-Failure { & (Join-Path $root 'scripts/Test-ProvenanceAndContentLedger.ps1') -ProjectRoot $prov } 'Provenance false browser claim'
Add-Content -LiteralPath (Join-Path $prov '.studio/ARTIFACT_LEDGER.md') -Value '| home.png | browser screenshot | local runtime | fixture | pnpm dev | / 1440x900 | 2026-07-18T00:00:00Z | fixture | captured |'

# Content: unsupported and deceptive actions fail; explicit visible placeholder succeeds.
Copy-Item (Join-Path $root 'templates/studio/CONTENT_LEDGER.template.md') (Join-Path $prov '.studio/CONTENT_LEDGER.md')
Add-Content -LiteralPath (Join-Path $prov '.studio/CONTENT_LEDGER.md') -Value '| https://github.com/invented/repo | approved provisional statement | none | yes | live link |'
Add-Content -LiteralPath (Join-Path $prov '.studio/CONTENT_LEDGER.md') -Value '| 10,000 stars | approved provisional statement | none | yes | public proof |'
Add-Content -LiteralPath (Join-Path $prov '.studio/CONTENT_LEDGER.md') -Value '| form success | approved provisional statement | none | yes | live success |'
Add-Content -LiteralPath (Join-Path $prov '.studio/CONTENT_LEDGER.md') -Value '| messenger | approved provisional statement | none | yes | anchor |'
Add-Content -LiteralPath (Join-Path $prov '.studio/CONTENT_LEDGER.md') -Value '| policy | approved provisional statement | none | yes | working legal link |'
Expect-Failure { & (Join-Path $root 'scripts/Test-ProvenanceAndContentLedger.ps1') -ProjectRoot $prov } 'Content ledger unsafe claims'
Copy-Item (Join-Path $root 'templates/studio/CONTENT_LEDGER.template.md') (Join-Path $prov '.studio/CONTENT_LEDGER.md') -Force
Add-Content -LiteralPath (Join-Path $prov '.studio/CONTENT_LEDGER.md') -Value '| GitHub link coming soon | explicit placeholder | user request | placeholder | visible placeholder; unavailable in production |'
Add-Content -LiteralPath (Join-Path $prov '.studio/CONTENT_LEDGER.md') -Value '| Form unavailable | explicit placeholder | user request | placeholder | visible placeholder; not functional; production blocker |'
& (Join-Path $root 'scripts/Test-ProvenanceAndContentLedger.ps1') -ProjectRoot $prov

# Project-local wrapper fixture: templates are copied locally, never globally installed.
$agentFixture = New-Project 'agent-wrapper-readonly' $true $true
New-Item -ItemType Directory -Force -Path (Join-Path $agentFixture '.codex/agents') | Out-Null
Copy-Item (Join-Path $root 'platforms/codex/agents/repo-explorer.toml') (Join-Path $agentFixture '.codex/agents/repo-explorer.toml')
Copy-Item (Join-Path $root 'platforms/codex/agents/code-reviewer.toml') (Join-Path $agentFixture '.codex/agents/code-reviewer.toml')
Set-Content -LiteralPath (Join-Path $agentFixture 'protected-source.txt') -Value 'DO NOT EDIT — wrapper read-only fixture' -Encoding utf8

# Write-specialist fixture: only src/index.html is explicitly owned.
$builderFixture = New-Project 'frontend-builder-write' $true $true
New-Item -ItemType Directory -Force -Path (Join-Path $builderFixture 'src') | Out-Null
Set-Content -LiteralPath (Join-Path $builderFixture '.studio/COPY.md') -Value "# Copy`n## Approved text`nVerified fixture offer" -Encoding utf8
Set-Content -LiteralPath (Join-Path $builderFixture '.studio/DESIGN_SYSTEM.md') -Value "# Design system`nUse a simple accessible heading." -Encoding utf8
Set-Content -LiteralPath (Join-Path $builderFixture '.studio/IMPLEMENTATION_PLAN.md') -Value "# Implementation plan`n- Owned file: src/index.html`n- Do not modify backend.txt or .studio records." -Encoding utf8
Set-Content -LiteralPath (Join-Path $builderFixture 'src/index.html') -Value '<main><h1>Pending approved copy</h1></main>' -Encoding utf8
Set-Content -LiteralPath (Join-Path $builderFixture 'backend.txt') -Value 'Protected backend contract — do not edit.' -Encoding utf8

Write-Host "Phase 1.1 runtime verification passed. Output: $output"
