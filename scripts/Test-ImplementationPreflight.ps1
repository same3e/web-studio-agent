[CmdletBinding()]
param([Parameter(Mandatory)][string]$ProjectRoot)

$ErrorActionPreference = 'Stop'
$project = (Resolve-Path -LiteralPath $ProjectRoot).Path
$studio = Join-Path $project '.studio'
if (-not (Test-Path -LiteralPath $studio)) { throw "Missing project-local state directory: $studio" }
$required = @('PROJECT_BRIEF.md','CONFIRMED_FACTS.md','ASSUMPTIONS.md','TECH_DECISION.md','APPROVED_CONCEPT.md','COPY.md','DESIGN_SYSTEM.md','IMPLEMENTATION_PLAN.md','ACCEPTANCE_CRITERIA.md')
$missing = @($required | Where-Object { -not (Test-Path -LiteralPath (Join-Path $studio $_)) })
$planPath = Join-Path $studio 'reports/specialist-plan.md'
$result = if ($missing.Count -eq 0) { 'passed' } else { 'blocked' }
$plan = $null
if ($result -eq 'passed') { $plan = & (Join-Path $PSScriptRoot 'Resolve-SpecialistPlan.ps1') -ProjectRoot $project -OutputPath $planPath }
$report = @(
  '# Implementation preflight', '', ('- Result: `' + $result + '`'), ('- Project root: `' + $project + '`'), ("- Required records: $($required -join ', ')"),
  "- Missing records: $(if($missing.Count){$missing -join ', '}else{'none'})", '- Optional or not-applicable records and reason: none declared by this validator.',
  '- Internal consistency checks: required approved-state records exist.', '- Approval evidence: `.studio/APPROVED_CONCEPT.md` must exist.',
  "- Specialist plan: $(if($plan){'.studio/reports/specialist-plan.md'}else{'not resolved because preflight is blocked'})", "- Decision and date: $([DateTime]::UtcNow.ToString('o'))"
) -join [Environment]::NewLine
Set-Content -LiteralPath (Join-Path $studio 'IMPLEMENTATION_PREFLIGHT.md') -Value $report -Encoding utf8
if ($result -ne 'passed') { throw "Implementation preflight blocked. Missing records: $($missing -join ', ')" }
Write-Host "Implementation preflight passed. Specialist plan: $planPath"
