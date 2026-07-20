Set-StrictMode -Version Latest

function Write-TypedStudioRecord {
 param([string]$ProjectRoot,[string]$Name,[string]$RecordType,[hashtable]$Data,[string]$Status='ready',[string[]]$Surfaces=@(),[string]$Body='Fixture record with synthetic regression evidence.',[switch]$WithBom)
 $meta=[ordered]@{schemaVersion=1;recordType=$RecordType;status=$Status;owner='test-fixture';updatedAt='2026-07-19T00:00:00Z';applicability=@{productTypes=@('web-app');surfaces=@($Surfaces)};sources=@(@{type='fixture-authorization';path='.studio/APPROVED_CONCEPT.md'});data=$Data}
 $content = "<!-- studio-record`n$($meta|ConvertTo-Json -Depth 12)`n-->`n# Fixture $RecordType`n$Body"
 $encoding = if ($WithBom) { [Text.UTF8Encoding]::new($true) } else { [Text.UTF8Encoding]::new($false) }
 [IO.File]::WriteAllText((Join-Path $ProjectRoot ('.studio/' + $Name)), $content, $encoding)
}

function New-ValidStudioRecordData {
 param([Parameter(Mandatory)][string]$RecordType)
 . (Join-Path $PSScriptRoot '../../scripts/records/validators/RecordValidatorDefinitions.ps1')
 $rules = Get-StudioValidatorRules $RecordType
 if ($null -eq $rules) { throw "VALIDATOR_MISSING: $RecordType" }
 $data = [ordered]@{}
 foreach ($field in @($rules.required)) { $data[$field] = 'Synthetic approved evidence' }
 foreach ($field in $(if ($rules.ContainsKey('arrays')) { @($rules['arrays']) } else { @() })) { $data[$field] = @() }
 foreach ($field in $(if ($rules.ContainsKey('booleans')) { @($rules['booleans']) } else { @() })) { $data[$field] = $true }
 foreach ($field in $(if ($rules.ContainsKey('objects')) { @($rules['objects']) } else { @() })) { $data[$field] = @{ id = 'synthetic' } }
 foreach ($field in $(if ($rules.ContainsKey('ids')) { @($rules['ids']) } else { @() })) { $data[$field] = @(@{ id = 'SYN-01'; behavior = 'Synthetic observable behavior'; surface = 'fixture'; evidenceTypes = @('source-review'); owner = 'fixture' }) }
 foreach ($collection in $(if ($rules.ContainsKey('entryFields')) { @($rules['entryFields'].Keys) } else { @() })) {
   $entry = [ordered]@{}
   foreach ($field in @($rules['entryFields'][$collection])) { $entry[$field] = 'Synthetic approved evidence' }
   $entry['id'] = 'SYN-01'
   $data[$collection] = @($entry)
 }
 foreach ($field in $(if ($rules.ContainsKey('nonEmpty')) { @($rules['nonEmpty']) } else { @() })) { if (@($data[$field]).Count -eq 0) { $data[$field] = @('Synthetic approved evidence') } }
 switch ($RecordType) {
   'technical-decision' { $data.stack = @('fixture-stack'); $data.alternativesConsidered = @('fixture-option') }
   'approved-concept' { $data.approval = @{ status = 'approved'; approvedAt = '2026-07-19T00:00:00Z'; approvedBy = 'fixture'; source = 'synthetic evidence' } }
   'design-system' { $data.gridStrategy = @{ columnModel = '12-column'; gutters = '24px'; containers = @('standard'); breakpoints = @('768px') }; $data.signatureElement = @{ description = 'Synthetic signature' }; $data.responsivePlan = @{ mobile = 'stack' }; $data.tasteResolution = @{ appliedRuleIds = @() }; $data.compositionMap = @(@{ section = 'synthetic' }) }
   'project-state' { $data.workflowMode = 'standard'; $data.surfaces = @('frontend-visible'); $data.risks = @(); $data.runnable = $true }
   'active-scope' { $data.active = @(@{ id = 'SYN-01'; title = 'Synthetic scope'; surfaces = @('fixture'); acceptanceCriteria = @('AC-01') }); $data.deferred = @(); $data.rejected = @() }
 }
 return $data
}

function Set-StudioFixtureDataField {
 param([hashtable]$Data,[string]$Field,$Value)
 $Data[$Field] = $Value
 return $Data
}

function Remove-StudioFixtureDataField {
 param([hashtable]$Data,[string]$Field)
 $Data.Remove($Field)
 return $Data
}

function New-TypedStudioFixture {
 [CmdletBinding()]param([Parameter(Mandatory)][string]$RootPath,[Parameter(Mandatory)][string]$Name,[string]$CurrentState='implementation-planning',[string]$ProductType='web-app',[ValidateSet('lean','standard','thorough')][string]$WorkflowMode='standard',[string[]]$Surfaces=@('frontend-visible'),[bool]$Runnable=$true,[object[]]$ActiveScope=@(),[object[]]$AcceptanceCriteria=@(),[switch]$Approved,[switch]$ExistingRepository,[switch]$MissingApproval,[string[]]$MissingRecords=@())
 $p=Join-Path $RootPath $Name;New-Item -ItemType Directory -Force -Path (Join-Path $p '.studio')|Out-Null
 if(-not $ActiveScope.Count){$ActiveScope=@(@{id='SCOPE-01';title='Synthetic scoped behavior';surfaces=$Surfaces;acceptanceCriteria=@('AC-01')})};if(-not $AcceptanceCriteria.Count){$AcceptanceCriteria=@(@{id='AC-01';behavior='Synthetic behavior is verified';surface=$Surfaces[0];evidenceTypes=@('source-review');status='ready'})}
 Write-TypedStudioRecord $p 'PROJECT_STATE.md' 'project-state' @{currentState=$CurrentState;productType=$ProductType;workflowMode=$WorkflowMode;surfaces=$Surfaces;runnable=$Runnable;risks=@();nextRequiredTransition='implementation';activeScope=@($ActiveScope|ForEach-Object id)} -Surfaces $Surfaces
 Write-TypedStudioRecord $p 'ACTIVE_AND_DEFERRED_SCOPE.md' 'active-scope' @{active=$ActiveScope;deferred=@();rejected=@()} -Surfaces $Surfaces
 if($Approved -and -not $MissingApproval){Write-TypedStudioRecord $p 'APPROVED_CONCEPT.md' 'approved-concept' @{conceptId='FIXTURE-01';approval=@{status='approved';approvedAt='2026-07-19T00:00:00Z';approvedBy='test-fixture';source='synthetic regression fixture'};approvedModifications=@();rejectedAlternatives=@()} 'approved' $Surfaces}
 if($Surfaces -contains 'frontend-visible'){Write-TypedStudioRecord $p 'COPY.md' 'copy' @{approvedCopy=@('Synthetic approved copy');uiCopy=@('Synthetic UI copy');claims=@()} -Surfaces $Surfaces;Write-TypedStudioRecord $p 'API_CONTRACT.md' 'api-contract' @{operations=@(@{id='fixture';method='GET';path='/fixture';requestSchema='none';responseSchema='fixture';errorSchema='error';authentication='none';authorization='none';idempotency='n/a';rateLimit='none'})} -Surfaces $Surfaces}
 Write-TypedStudioRecord $p 'TECH_DECISION.md' 'technical-decision' @{selectedOptionId='fixture';stack=@('fixture-stack');alternativesConsidered=@('fixture');rationale='Synthetic implementation decision';tradeoffs=@();approvedDeviations=@()} -Surfaces $Surfaces
 Write-TypedStudioRecord $p 'IMPLEMENTATION_PLAN.md' 'implementation-plan' @{tasks=@(@{id='TASK-01';owner='test-fixture';surfaces=$Surfaces;affectedPaths=@('src/fixture.txt');acceptanceCriteria=@($AcceptanceCriteria|ForEach-Object id);scopeIds=@($ActiveScope|ForEach-Object id);dependencies=@()});validationCommands=@('pwsh');approvedExceptions=@();knownDebt=@()} -Surfaces $Surfaces
 Write-TypedStudioRecord $p 'ACCEPTANCE_CRITERIA.md' 'acceptance-criteria' @{criteria=$AcceptanceCriteria} -Surfaces $Surfaces
 if($Surfaces -contains 'frontend-visible'){Write-TypedStudioRecord $p 'DESIGN_SYSTEM.md' 'design-system' @{designThesis='Synthetic clear hierarchy';signatureElement=@{status='active';description='Synthetic signature';reason=''};gridStrategy=@{columnModel='12-column';containers=@('standard');gutters='24px';alignmentAnchors=@('content');breakpoints=@('768px');intentionalGridBreaks=@()};compositionMap=@(@{section='hero'});responsivePlan=@{mobile='stack'};tasteResolution=@{appliedRuleIds=@();approvedExceptions=@()}} -Surfaces $Surfaces}
 if($Surfaces -contains 'backend-api'){Write-TypedStudioRecord $p 'BACKEND_SPEC.md' 'backend-spec' @{capabilities=@('fixture');routesOrJobs=@('/fixture');validationStrategy='schema';errorStrategy='typed';loggingStrategy='structured';rateLimitStrategy='none';testStrategy='contract'} -Surfaces $Surfaces;Write-TypedStudioRecord $p 'API_CONTRACT.md' 'api-contract' @{operations=@(@{id='fixture';method='GET';path='/fixture';requestSchema='none';responseSchema='fixture';errorSchema='error';authentication='none';authorization='none';idempotency='n/a';rateLimit='none'})} -Surfaces $Surfaces}
 if($Surfaces -contains 'database'){Write-TypedStudioRecord $p 'DATABASE_DECISION.md' 'database-decision' @{persistenceRequired=$true;storageModel='relational';classification='internal';ownershipModel='app';backupRequirement='local';migrationRequired=$true;rejectedAlternatives=@('none')} -Surfaces $Surfaces;Write-TypedStudioRecord $p 'DATA_MODEL.md' 'data-model' @{entities=@(@{id='fixture';owner='app';fields=@('id');constraints=@('pk');accessRules=@('internal');lifecycle='active'})} -Surfaces $Surfaces;Write-TypedStudioRecord $p 'MIGRATION_PLAN.md' 'migration-plan' @{steps=@('fixture')} -Surfaces $Surfaces}
 if($Surfaces -contains 'integration'){Write-TypedStudioRecord $p 'INTEGRATION_SPEC.md' 'integration-spec' @{provider='fixture';purpose='delivery';dataFlow='server';secretBoundary='server';clientServerBoundary='server';retryStrategy='none';timeout='1s';idempotency='key';failureBehavior='fail';environment='sandbox'} -Surfaces $Surfaces;Write-TypedStudioRecord $p 'EXTERNAL_SERVICES.md' 'external-services' @{services=@('fixture')} -Surfaces $Surfaces;Write-TypedStudioRecord $p 'ENVIRONMENT_CONTRACT.md' 'environment-contract' @{variables=@(@{name='FIXTURE_URL';required=$true;visibility='server';secret=$false;purpose='fixture'})} -Surfaces $Surfaces}
 if($ExistingRepository){New-Item -ItemType Directory -Force -Path (Join-Path $p 'src')|Out-Null;'{}'|Set-Content (Join-Path $p 'package.json')};$p
}
