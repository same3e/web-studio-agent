[CmdletBinding()]
param([Parameter(Mandatory)][string]$ProjectRoot)

$ErrorActionPreference = 'Stop'
$project = (Resolve-Path -LiteralPath $ProjectRoot).Path
$studio = Join-Path $project '.studio'
$root = (Resolve-Path (Join-Path $PSScriptRoot '..')).Path
if(-not (Test-Path -LiteralPath (Join-Path $studio 'APPROVED_CONCEPT.md'))) { throw 'Cannot derive approved records without .studio/APPROVED_CONCEPT.md.' }
$created = [System.Collections.Generic.List[string]]::new()
foreach($name in @('COPY','DESIGN_SYSTEM','IMPLEMENTATION_PLAN','ACCEPTANCE_CRITERIA')) {
  $target = Join-Path $studio "$name.md"
  if(-not (Test-Path -LiteralPath $target)) { Copy-Item -LiteralPath (Join-Path $root "templates/studio/$name.template.md") -Destination $target; $created.Add(".studio/$name.md") }
}
foreach($name in @('BACKEND_SPEC','API_CONTRACT','DATABASE_DECISION','DATA_MODEL','MIGRATION_PLAN','DATA_RETENTION','INTEGRATION_SPEC','EXTERNAL_SERVICES','ENVIRONMENT_CONTRACT','THREAT_MODEL','SECURITY_MODEL')) {
  $target = Join-Path $studio "$name.md"
  if(-not (Test-Path -LiteralPath $target)) { Copy-Item -LiteralPath (Join-Path $root "templates/studio/$name.template.md") -Destination $target; $created.Add(".studio/$name.md") }
}
foreach($name in @('REFACTOR_PLAN','BEHAVIOR_INVARIANTS','PERFORMANCE_BUDGET','PERFORMANCE_PLAN','RELEASE_PLAN','DEPLOYMENT_MATRIX','RELEASE_CHECKLIST','ROLLBACK_PLAN','CHANGELOG_PLAN','OPERATIONS_PLAN','OBSERVABILITY_PLAN','HEALTH_CHECKS','INCIDENT_RESPONSE','RUNBOOK','BACKUP_RECOVERY','REFACTOR_REPORT','REFACTOR_VERIFICATION','PERFORMANCE_REPORT','PERFORMANCE_RECHECK','RELEASE_REPORT','DEPLOYMENT_VERIFICATION','OPERATIONS_READINESS')) {
  $target = Join-Path $studio "$name.md"
  if(-not (Test-Path -LiteralPath $target)) { Copy-Item -LiteralPath (Join-Path $root "templates/studio/$name.template.md") -Destination $target; $created.Add(".studio/$name.md") }
}
Write-Host "Approved project records initialized: $(if($created.Count){$created -join ', '}else{'none; all records already existed'})"
