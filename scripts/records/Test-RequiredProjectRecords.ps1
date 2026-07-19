. (Join-Path $PSScriptRoot 'Test-StudioRecord.ps1')
function Get-StudioRequirements {
 param([Parameter(Mandatory)][string]$ProjectRoot)
 $state=Test-StudioRecord -Path (Get-StudioRecordPath $ProjectRoot 'PROJECT_STATE.md') -ExpectedRecordType 'project-state' -Required
 if(-not $state.valid){return [pscustomobject]@{state=$state;required=@();surfaces=@();productType='';workflowMode='';runnable=$false}}
 $d=$state.record.metadata.data;$s=@($d.surfaces);$r=@(@{name='ACTIVE_AND_DEFERRED_SCOPE.md';type='active-scope'},@{name='APPROVED_CONCEPT.md';type='approved-concept'},@{name='IMPLEMENTATION_PLAN.md';type='implementation-plan'},@{name='ACCEPTANCE_CRITERIA.md';type='acceptance-criteria'},@{name='TECH_DECISION.md';type='technical-decision'})
 if($s -contains 'frontend-visible'){$r+=@{name='DESIGN_SYSTEM.md';type='design-system'}}
 if($s -contains 'backend-api'){$r+=@(@{name='BACKEND_SPEC.md';type='backend-spec'},@{name='API_CONTRACT.md';type='api-contract'})}
 if($s -contains 'database'){$r+=@(@{name='DATABASE_DECISION.md';type='database-decision'},@{name='DATA_MODEL.md';type='data-model'})}
 if($s -contains 'integration'){$r+=@(@{name='INTEGRATION_SPEC.md';type='integration-spec'},@{name='EXTERNAL_SERVICES.md';type='external-services'},@{name='ENVIRONMENT_CONTRACT.md';type='environment-contract'})}
 [pscustomobject]@{state=$state;required=@($r);surfaces=$s;productType=$d.productType;workflowMode=$d.workflowMode;runnable=[bool]$d.runnable}
}
function Test-RequiredProjectRecords {
 param([Parameter(Mandatory)][string]$ProjectRoot)
 $requirements=Get-StudioRequirements $ProjectRoot;$checks=@($requirements.state);foreach($r in $requirements.required){$checks+=Test-StudioRecord -Path (Get-StudioRecordPath $ProjectRoot $r.name) -ExpectedRecordType $r.type -Required -RequiredSurfaces $requirements.surfaces}
 [pscustomobject]@{valid=(@($checks|Where-Object{-not $_.valid}).Count -eq 0);requirements=$requirements;checks=$checks;errors=@($checks|ForEach-Object errors)}
}
