[CmdletBinding()]
param()

$ErrorActionPreference = 'Stop'
$failures = [System.Collections.Generic.List[string]]::new()
function Assert-True([bool]$condition, [string]$message) { if (-not $condition) { $script:failures.Add($message) } }
function Read-Utf8([string]$path) { Get-Content -Raw -LiteralPath $path -Encoding utf8 }

$root = (Resolve-Path (Join-Path $PSScriptRoot '..')).Path
Set-Location $root
$product = Read-Utf8 'skills/product-studio/SKILL.md'
$artifact = Read-Utf8 'knowledge/verification/ARTIFACT_PROVENANCE.md'
$ledger = Read-Utf8 'knowledge/business/CONTENT_LEDGER.md'
$preflight = Read-Utf8 'templates/studio/IMPLEMENTATION_PREFLIGHT.template.md'
$browser = Read-Utf8 'specialists/contracts/browser-qa.md'

# Fixture A: facts/placeholders, approval, unavailable delivery, and browser QA.
Assert-True (Test-Path 'tests/behavioral/fixtures/dental-landing/SCENARIO.md') 'Fixture A is missing.'
Assert-True ($product -match 'Missing branding, final photography') 'Fixture A: missing photos must not block preliminary concepts.'
Assert-True ($ledger -match 'non-functional form' -and $ledger -match 'placeholder messenger') 'Fixture A: unavailable delivery safeguards are missing.'
Assert-True ($product -match 'Never call a concept render browser output') 'Fixture A: concept/browser distinction is missing.'
Assert-True ($product -match 'browser-qa for runnable frontends') 'Fixture A: browser QA selection is missing.'

# Fixture B: discovery reuse, references, distinct concepts, technical decision, honest CTA, specialist selection.
Assert-True (Test-Path 'tests/behavioral/fixtures/open-source-developer-tool/SCENARIO.md') 'Fixture B is missing.'
Assert-True ($product -match 'reuse conversation and project-record answers') 'Fixture B: answered discovery facts may be repeated.'
Assert-True ($product -match 'up to three genuinely different concepts') 'Fixture B: distinct concepts are not required.'
Assert-True ($ledger -match 'GitHub URLs' -and $ledger -match 'stars') 'Fixture B: OSS claim safeguards are missing.'
Assert-True ((Read-Utf8 'templates/studio/TECH_DECISION.template.md') -match 'Local development, dependencies, deployment, and operations') 'Fixture B: technical decision lacks operational coverage.'

# Fixture C: a missing approval record blocks implementation.
Assert-True (Test-Path 'tests/behavioral/fixtures/missing-approval-record/SCENARIO.md') 'Fixture C is missing.'
Assert-True ($preflight -match 'Blocking gaps') 'Fixture C: preflight has no blocking-gaps field.'
Assert-True ($product -match 'blocks implementation on missing or inconsistent required evidence') 'Fixture C: preflight does not block implementation.'

# Fixture D: provenance labels cannot be conflated.
Assert-True (Test-Path 'tests/behavioral/fixtures/concept-render-provenance/SCENARIO.md') 'Fixture D is missing.'
Assert-True ($artifact -match 'generated concept render' -and $artifact -match 'never described as coded output') 'Fixture D: concept-render provenance is incomplete.'

# Fixture E: static inspection is not browser QA.
Assert-True (Test-Path 'tests/behavioral/fixtures/static-versus-browser/SCENARIO.md') 'Fixture E is missing.'
Assert-True ($browser -match 'CSS/source inspection as browser QA') 'Fixture E: browser contract permits static inspection as QA.'

if ($failures.Count -gt 0) { $failures | ForEach-Object { Write-Error $_ }; exit 1 }
Write-Host 'Phase 1 behavioral fixtures passed: A-E.'
