Set-StrictMode -Version Latest

function Write-TypedStudioRecord {
 param([string]$ProjectRoot,[string]$Name,[string]$RecordType,[hashtable]$Data,[string]$Status='ready',[string[]]$Surfaces=@(),[string]$Body='Fixture record with synthetic regression evidence.')
 $meta=[ordered]@{schemaVersion=1;recordType=$RecordType;status=$Status;owner='test-fixture';updatedAt='2026-07-19T00:00:00Z';applicability=@{productTypes=@('web-app');surfaces=@($Surfaces)};sources=@(@{type='fixture-authorization';path='.studio/APPROVED_CONCEPT.md'});data=$Data}
 "<!-- studio-record`n$($meta|ConvertTo-Json -Depth 12)`n-->`n# Fixture $RecordType`n$Body"|Set-Content -LiteralPath (Join-Path $ProjectRoot ('.studio/'+$Name)) -Encoding utf8
}

function New-TypedStudioFixture {
 [CmdletBinding()]param([Parameter(Mandatory)][string]$RootPath,[Parameter(Mandatory)][string]$Name,[string]$CurrentState='implementation-planning',[string]$ProductType='web-app',[ValidateSet('lean','standard','thorough')][string]$WorkflowMode='standard',[string[]]$Surfaces=@('frontend-visible'),[bool]$Runnable=$true,[object[]]$ActiveScope=@(),[object[]]$AcceptanceCriteria=@(),[switch]$Approved,[switch]$ExistingRepository,[switch]$MissingApproval,[string[]]$MissingRecords=@())
 $p=Join-Path $RootPath $Name;New-Item -ItemType Directory -Force -Path (Join-Path $p '.studio')|Out-Null
 if(-not $ActiveScope.Count){$ActiveScope=@(@{id='SCOPE-01';title='Synthetic scoped behavior';surfaces=$Surfaces;acceptanceCriteria=@('AC-01')})};if(-not $AcceptanceCriteria.Count){$AcceptanceCriteria=@(@{id='AC-01';behavior='Synthetic behavior is verified';surface=$Surfaces[0];evidenceTypes=@('source-review');status='ready'})}
 Write-TypedStudioRecord $p 'PROJECT_STATE.md' 'project-state' @{currentState=$CurrentState;productType=$ProductType;workflowMode=$WorkflowMode;surfaces=$Surfaces;runnable=$Runnable;risks=@();nextRequiredTransition='implementation';activeScope=@($ActiveScope|ForEach-Object id)} -Surfaces $Surfaces
 Write-TypedStudioRecord $p 'ACTIVE_AND_DEFERRED_SCOPE.md' 'active-scope' @{active=$ActiveScope;deferred=@();rejected=@()} -Surfaces $Surfaces
 if($Approved -and -not $MissingApproval){Write-TypedStudioRecord $p 'APPROVED_CONCEPT.md' 'approved-concept' @{conceptId='FIXTURE-01';approval=@{status='approved';approvedAt='2026-07-19T00:00:00Z';approvedBy='test-fixture';source='synthetic regression fixture'};approvedModifications=@();rejectedAlternatives=@()} 'approved' $Surfaces}
 Write-TypedStudioRecord $p 'TECH_DECISION.md' 'technical-decision' @{selectedOptionId='fixture';stack=@();alternativesConsidered=@('fixture');rationale='Synthetic fixture';tradeoffs=@();approvedDeviations=@()} -Surfaces $Surfaces
 Write-TypedStudioRecord $p 'IMPLEMENTATION_PLAN.md' 'implementation-plan' @{tasks=@(@{id='TASK-01';owner='test-fixture';surfaces=$Surfaces;affectedPaths=@('src/fixture.txt');acceptanceCriteria=@($AcceptanceCriteria|ForEach-Object id);scopeIds=@($ActiveScope|ForEach-Object id);dependencies=@()});validationCommands=@('pwsh');approvedExceptions=@();knownDebt=@()} -Surfaces $Surfaces
 Write-TypedStudioRecord $p 'ACCEPTANCE_CRITERIA.md' 'acceptance-criteria' @{criteria=$AcceptanceCriteria} -Surfaces $Surfaces
 if($Surfaces -contains 'frontend-visible'){Write-TypedStudioRecord $p 'DESIGN_SYSTEM.md' 'design-system' @{designThesis='Synthetic clear hierarchy';signatureElement=@{status='active';description='Synthetic signature';reason=''};gridStrategy=@{columnModel='12-column';containers=@('standard');gutters='24px';alignmentAnchors=@('content');breakpoints=@('768px');intentionalGridBreaks=@()};compositionMap=@(@{section='hero'});responsivePlan=@{mobile='stack'};tasteResolution=@{appliedRuleIds=@();approvedExceptions=@()}} -Surfaces $Surfaces}
 if($Surfaces -contains 'backend-api'){Write-TypedStudioRecord $p 'BACKEND_SPEC.md' 'backend-spec' @{} -Surfaces $Surfaces;Write-TypedStudioRecord $p 'API_CONTRACT.md' 'api-contract' @{} -Surfaces $Surfaces}
 if($Surfaces -contains 'database'){Write-TypedStudioRecord $p 'DATABASE_DECISION.md' 'database-decision' @{} -Surfaces $Surfaces;Write-TypedStudioRecord $p 'DATA_MODEL.md' 'data-model' @{} -Surfaces $Surfaces}
 if($Surfaces -contains 'integration'){Write-TypedStudioRecord $p 'INTEGRATION_SPEC.md' 'integration-spec' @{} -Surfaces $Surfaces;Write-TypedStudioRecord $p 'EXTERNAL_SERVICES.md' 'external-services' @{} -Surfaces $Surfaces;Write-TypedStudioRecord $p 'ENVIRONMENT_CONTRACT.md' 'environment-contract' @{} -Surfaces $Surfaces}
 if($ExistingRepository){New-Item -ItemType Directory -Force -Path (Join-Path $p 'src')|Out-Null;'{}'|Set-Content (Join-Path $p 'package.json')};$p
}
