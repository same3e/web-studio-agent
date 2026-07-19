. (Join-Path $PSScriptRoot 'Test-StudioRecord.ps1')
. (Join-Path $PSScriptRoot 'Get-SurfaceRegistry.ps1')
function Get-StudioRequirements {
 param([Parameter(Mandatory)][string]$ProjectRoot)
 $state=Test-StudioRecord -Path (Get-StudioRecordPath $ProjectRoot 'PROJECT_STATE.md') -ExpectedRecordType 'project-state' -Required
 if(-not $state.valid){return [pscustomobject]@{state=$state;required=@();surfaces=@();productType='';workflowMode='';runnable=$false}}
 $d=$state.record.metadata.data;$s=@($d.surfaces);$registry=Get-SurfaceRegistry -Surface $s
 if($null -ne $registry.unknown){return [pscustomobject]@{state=$state;required=@();surfaces=$s;productType=$d.productType;workflowMode=$d.workflowMode;runnable=$false;unknownSurfaces=$registry.unknown}}
 $types=@{'BACKEND_SPEC.md'='backend-spec';'API_CONTRACT.md'='api-contract';'DATABASE_DECISION.md'='database-decision';'DATA_MODEL.md'='data-model';'MIGRATION_PLAN.md'='migration-plan';'DATA_RETENTION.md'='data-retention';'INTEGRATION_SPEC.md'='integration-spec';'EXTERNAL_SERVICES.md'='external-services';'ENVIRONMENT_CONTRACT.md'='environment-contract';'THREAT_MODEL.md'='threat-model';'SECURITY_MODEL.md'='security-model';'REFACTOR_PLAN.md'='refactor-plan';'BEHAVIOR_INVARIANTS.md'='behavior-invariants';'PERFORMANCE_BUDGET.md'='performance-budget';'PERFORMANCE_PLAN.md'='performance-plan';'RELEASE_PLAN.md'='release-plan';'RELEASE_CHECKLIST.md'='release-checklist';'ROLLBACK_PLAN.md'='rollback-plan';'DEPLOYMENT_MATRIX.md'='deployment-matrix';'OPERATIONS_PLAN.md'='operations-plan';'OBSERVABILITY_PLAN.md'='observability-plan';'HEALTH_CHECKS.md'='health-checks';'INCIDENT_RESPONSE.md'='incident-response';'RUNBOOK.md'='runbook';'BACKUP_RECOVERY.md'='backup-recovery';'DESIGN_SYSTEM.md'='design-system'}
 $r=@(@{name='ACTIVE_AND_DEFERRED_SCOPE.md';type='active-scope'},@{name='APPROVED_CONCEPT.md';type='approved-concept'},@{name='IMPLEMENTATION_PLAN.md';type='implementation-plan'},@{name='ACCEPTANCE_CRITERIA.md';type='acceptance-criteria'},@{name='TECH_DECISION.md';type='technical-decision'})
 foreach($surface in $registry.selected){foreach($name in @($surface.requiredRecords)){ $r+=@{name=$name;type=$types[$name]}}}
 $environments=if($d.PSObject.Properties['environments']){@($d.environments)}else{@()};$persistentData=if($d.PSObject.Properties['persistentProductionData']){[bool]$d.persistentProductionData}else{$false};if($s -contains 'release' -and (($d.PSObject.Properties['deploymentScope'] -and $d.deploymentScope -eq 'active') -or @($environments).Length -gt 1)){$r+=@{name='DEPLOYMENT_MATRIX.md';type='deployment-matrix'}}
 if($s -contains 'operations' -and $persistentData){$r+=@{name='BACKUP_RECOVERY.md';type='backup-recovery'}}
 [pscustomobject]@{state=$state;required=@($r|Group-Object name|ForEach-Object{$_.Group[0]});surfaces=$s;productType=$d.productType;workflowMode=$d.workflowMode;runnable=[bool]$d.runnable;unknownSurfaces=@()}
}
function Test-RequiredProjectRecords {
 param([Parameter(Mandatory)][string]$ProjectRoot)
 $requirements=Get-StudioRequirements $ProjectRoot;$checks=@($requirements.state);if(@($requirements.unknownSurfaces).Count){foreach($surface in $requirements.unknownSurfaces){$checks+=[pscustomobject]@{valid=$false;status='invalid';record=[pscustomobject]@{path=(Get-StudioRecordPath $ProjectRoot 'PROJECT_STATE.md')};errors=@([pscustomobject]@{blockingReason="UNKNOWN_SURFACE: $surface"})}}};foreach($r in $requirements.required){$checks+=Test-StudioRecord -Path (Get-StudioRecordPath $ProjectRoot $r.name) -ExpectedRecordType $r.type -Required -RequiredSurfaces $requirements.surfaces}
 [pscustomobject]@{valid=(@($checks|Where-Object{-not $_.valid}).Count -eq 0);requirements=$requirements;checks=$checks;errors=@($checks|ForEach-Object errors)}
}
