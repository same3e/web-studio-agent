function Get-StudioValidatorContract {
  param([string]$RecordType)
  $rules = Get-StudioValidatorRules $RecordType
  $conditional = if ($rules.ContainsKey('conditional')) { @($rules['conditional']) } else { @() }
  return [pscustomobject]@{ RecordType = $RecordType; CoveredDataFields = @($rules.required); ConditionalDataFields = $conditional }
}

function Get-StudioValidatorRules {
  param([string]$RecordType)
  $rules = @{
    'project-state' = @{ required=@('currentState','productType','workflowMode','surfaces','runnable','risks','nextRequiredTransition'); text=@('currentState','productType','nextRequiredTransition'); arrays=@('surfaces','risks','activeScope'); booleans=@('runnable'); enums=@{workflowMode=@('lean','standard','thorough')} }
    'active-scope' = @{ required=@('active','deferred','rejected'); arrays=@('active','deferred','rejected'); ids=@('active','deferred','rejected') }
    'approved-concept' = @{ required=@('conceptId','approval','approvedModifications','rejectedAlternatives'); text=@('conceptId'); arrays=@('approvedModifications','rejectedAlternatives'); objects=@('approval') }
    'technical-decision' = @{ required=@('selectedOptionId','stack','alternativesConsidered','rationale','tradeoffs','approvedDeviations'); text=@('selectedOptionId','rationale'); arrays=@('stack','alternativesConsidered','tradeoffs','approvedDeviations'); nonEmpty=@('stack') }
    'design-system' = @{ required=@('designThesis','signatureElement','gridStrategy','compositionMap','responsivePlan','tasteResolution'); text=@('designThesis'); arrays=@('compositionMap'); objects=@('signatureElement','gridStrategy','responsivePlan','tasteResolution'); conditional=@('designThesis','signatureElement','gridStrategy','compositionMap','responsivePlan','tasteResolution') }
    'implementation-plan' = @{ required=@('tasks','validationCommands','approvedExceptions','knownDebt'); arrays=@('tasks','validationCommands','approvedExceptions','knownDebt'); ids=@('tasks'); nonEmpty=@('tasks') }
    'acceptance-criteria' = @{ required=@('criteria'); arrays=@('criteria'); ids=@('criteria'); nonEmpty=@('criteria') }
    'copy' = @{ required=@('sections','contentLedgerPath','status'); arrays=@('sections'); text=@('contentLedgerPath','status'); nonEmpty=@('sections') }
    'backend-spec' = @{ required=@('capabilities','routesOrJobs','validationStrategy','errorStrategy','loggingStrategy','rateLimitStrategy','testStrategy'); arrays=@('capabilities','routesOrJobs'); text=@('validationStrategy','errorStrategy','loggingStrategy','rateLimitStrategy','testStrategy') }
    'api-contract' = @{ required=@('operations'); arrays=@('operations'); ids=@('operations'); nonEmpty=@('operations') }
    'database-decision' = @{ required=@('persistenceRequired','storageModel','classification','ownershipModel','backupRequirement','migrationRequired','rejectedAlternatives'); booleans=@('persistenceRequired','migrationRequired'); text=@('storageModel','classification','ownershipModel','backupRequirement'); arrays=@('rejectedAlternatives') }
    'data-model' = @{ required=@('entities'); arrays=@('entities'); ids=@('entities'); nonEmpty=@('entities') }
    'migration-plan' = @{ required=@('required','source','target','steps','dataImpact','rollback','destructiveRisk','owner','verification'); booleans=@('required'); text=@('source','target','dataImpact','rollback','destructiveRisk','owner','verification'); arrays=@('steps'); nonEmpty=@('steps') }
    'data-retention' = @{ required=@('dataClasses','retentionDecision','deletionBehavior','owner','basis','verificationMethod'); arrays=@('dataClasses'); text=@('retentionDecision','deletionBehavior','owner','basis','verificationMethod'); nonEmpty=@('dataClasses') }
    'integration-spec' = @{ required=@('provider','purpose','dataFlow','secretBoundary','clientServerBoundary','retryStrategy','timeout','idempotency','failureBehavior','environment'); text=@('provider','purpose','dataFlow','secretBoundary','clientServerBoundary','retryStrategy','timeout','idempotency','failureBehavior','environment') }
    'external-services' = @{ required=@('services'); arrays=@('services'); ids=@('services'); nonEmpty=@('services'); entryFields=@{services=@('id','provider','purpose','owner','dataExchanged','authSecretBoundary','failureBehavior','replacementStrategy','environment')} }
    'environment-contract' = @{ required=@('variables'); arrays=@('variables') }
    'threat-model' = @{ required=@('assets','trustBoundaries','actors','threats','controls','verificationOwners','unresolvedRisks'); arrays=@('assets','trustBoundaries','actors','threats','controls','verificationOwners','unresolvedRisks') }
    'security-model' = @{ required=@('assets','trustBoundaries','actors','threats','controls','verificationOwners','unresolvedRisks'); arrays=@('assets','trustBoundaries','actors','threats','controls','verificationOwners','unresolvedRisks') }
    'refactor-plan' = @{ required=@('approvedReason','behaviorInvariants','ownedPaths','forbiddenFeatureChanges','regressionChecks','rollbackStrategy'); text=@('approvedReason','rollbackStrategy'); arrays=@('behaviorInvariants','ownedPaths','forbiddenFeatureChanges','regressionChecks') }
    'behavior-invariants' = @{ required=@('invariants','owner'); arrays=@('invariants'); ids=@('invariants'); text=@('owner'); nonEmpty=@('invariants'); entryFields=@{invariants=@('id','observableBehavior','relatedSurfaces','regressionEvidenceType','forbiddenChanges','owner')} }
    'performance-budget' = @{ required=@('measuredTarget','measurementMethod','relevantSurface','evidenceType','acceptedLimitation'); text=@('measuredTarget','measurementMethod','relevantSurface','evidenceType','acceptedLimitation') }
    'performance-plan' = @{ required=@('measuredTarget','measurementMethod','relevantSurface','evidenceType','acceptedLimitation'); text=@('measuredTarget','measurementMethod','relevantSurface','evidenceType','acceptedLimitation') }
    'release-plan' = @{ required=@('targetEnvironment','buildArtifact','dependencies','releaseSteps','verificationGates','blockers','rollbackReference'); text=@('targetEnvironment','buildArtifact','rollbackReference'); arrays=@('dependencies','releaseSteps','verificationGates','blockers'); nonEmpty=@('releaseSteps') }
    'release-checklist' = @{ required=@('items'); arrays=@('items'); ids=@('items'); nonEmpty=@('items'); entryFields=@{items=@('id','owner','status','evidenceType','blockingClassification')} }
    'rollback-plan' = @{ required=@('trigger','target','procedure','dataMigrationImplications','owner','verification','maxInterruption'); text=@('trigger','target','procedure','dataMigrationImplications','owner','verification','maxInterruption') }
    'deployment-matrix' = @{ required=@('environments'); arrays=@('environments'); ids=@('environments'); nonEmpty=@('environments'); entryFields=@{environments=@('id','buildArtifact','configSource','promotionMethod','migrationDependency','verificationGates','rollbackTarget')} }
    'operations-plan' = @{ required=@('ownedRuntime','operationalOwner','serviceDependencies','healthStrategy','incidentPath','ongoingResponsibilities'); text=@('ownedRuntime','operationalOwner','healthStrategy','incidentPath'); arrays=@('serviceDependencies','ongoingResponsibilities') }
    'observability-plan' = @{ required=@('signals','logs','metricsEvents','alertOwner','privacyBoundaries','unavailableEvidence'); arrays=@('signals','logs','metricsEvents','unavailableEvidence'); text=@('alertOwner','privacyBoundaries') }
    'health-checks' = @{ required=@('checks'); arrays=@('checks'); ids=@('checks'); nonEmpty=@('checks'); entryFields=@{checks=@('id','target','method','expectedResult','failureMeaning','owner')} }
    'incident-response' = @{ required=@('severityModel','detectionPath','responder','escalationPath','containment','recovery','postIncidentEvidence'); text=@('severityModel','detectionPath','responder','escalationPath','containment','recovery','postIncidentEvidence') }
    'runbook' = @{ required=@('procedure','prerequisites','actions','stopCondition','owner','verificationResult'); text=@('procedure','stopCondition','owner','verificationResult'); arrays=@('prerequisites','actions'); nonEmpty=@('actions') }
    'backup-recovery' = @{ required=@('protectedState','backupMethod','frequency','retention','owner','restoreProcedure','restoreVerification','recoveryObjective'); text=@('protectedState','backupMethod','frequency','retention','owner','restoreProcedure','restoreVerification','recoveryObjective') }
  }
  if (-not $rules.ContainsKey($RecordType)) { return $null }
  return $rules[$RecordType]
}

function Invoke-StudioRecordTypeValidation {
  param([string]$RecordType, $Data, $Errors, [string]$Path, [string[]]$RequiredSurfaces)
  $rules = Get-StudioValidatorRules $RecordType
  if ($null -eq $rules) { Add-StudioError $Errors $Path $RecordType 'recordType' $RecordType 'VALIDATOR_MISSING'; return }
  $textFields = if ($rules.ContainsKey('text')) { @($rules['text']) } else { @() }
  $arrayFields = if ($rules.ContainsKey('arrays')) { @($rules['arrays']) } else { @() }
  $nonEmptyFields = if ($rules.ContainsKey('nonEmpty')) { @($rules['nonEmpty']) } else { @() }
  $objectFields = if ($rules.ContainsKey('objects')) { @($rules['objects']) } else { @() }
  $booleanFields = if ($rules.ContainsKey('booleans')) { @($rules['booleans']) } else { @() }
  $idFields = if ($rules.ContainsKey('ids')) { @($rules['ids']) } else { @() }
  foreach ($field in @($rules.required)) { Test-RequiredProperty $Data $field $Errors $Path $RecordType | Out-Null }
  foreach ($field in $textFields) { if ($Data.PSObject.Properties[$field] -and -not (Test-MeaningfulText $Data.$field)) { Add-StudioError $Errors $Path $RecordType "data.$field" 'invalid' 'MEANINGFUL_TEXT_REQUIRED' } }
  foreach ($field in $arrayFields) { if ($Data.PSObject.Properties[$field] -and $Data.$field -isnot [array]) { Add-StudioError $Errors $Path $RecordType "data.$field" 'wrong-type' 'ARRAY_REQUIRED' } }
  foreach ($field in $nonEmptyFields) { if ($Data.PSObject.Properties[$field] -and -not (Test-NonEmptyArray $Data.$field)) { Add-StudioError $Errors $Path $RecordType "data.$field" 'empty' 'NON_EMPTY_ARRAY_REQUIRED' } }
  foreach ($field in $objectFields) { if ($Data.PSObject.Properties[$field] -and -not (Test-ObjectValue $Data.$field)) { Add-StudioError $Errors $Path $RecordType "data.$field" 'wrong-type' 'OBJECT_REQUIRED' } }
  foreach ($field in $booleanFields) { if ($Data.PSObject.Properties[$field] -and -not (Test-BooleanValue $Data.$field)) { Add-StudioError $Errors $Path $RecordType "data.$field" 'wrong-type' 'BOOLEAN_REQUIRED' } }
  foreach ($field in $idFields) { if ($Data.PSObject.Properties[$field] -and @($Data.$field).Count -gt 0 -and -not (Test-UniqueIds $Data.$field)) { Add-StudioError $Errors $Path $RecordType "data.$field" 'invalid' 'UNIQUE_IDS_REQUIRED' } }
  if ($rules.ContainsKey('entryFields')) {
    foreach ($entryCollection in $rules['entryFields'].Keys) {
      if (-not $Data.PSObject.Properties[$entryCollection]) { continue }
      foreach ($entry in @($Data.$entryCollection)) {
        foreach ($field in @($rules['entryFields'][$entryCollection])) {
          if (-not $entry.PSObject.Properties[$field] -or -not (Test-MeaningfulText $entry.$field)) { Add-StudioError $Errors $Path $RecordType "data.$entryCollection.$field" 'invalid' 'ENTRY_FIELD_REQUIRED' }
        }
      }
    }
  }
  if ($RecordType -eq 'project-state' -and $Data.PSObject.Properties['workflowMode']) { Get-RemediationLoopLimit $Data.workflowMode | Out-Null }
  if ($RecordType -eq 'design-system' -and $RequiredSurfaces -contains 'frontend-visible') {
    $grid = if ($Data.PSObject.Properties['gridStrategy']) { $Data.gridStrategy } else { $null }
    $gridComplete = (Test-ObjectValue $grid) -and (Test-MeaningfulText $grid.columnModel) -and (Test-MeaningfulText $grid.gutters) -and (Test-NonEmptyArray $grid.containers) -and (Test-NonEmptyArray $grid.breakpoints)
    if (-not $gridComplete) { Add-StudioError $Errors $Path $RecordType 'data.gridStrategy' 'incomplete' 'DESIGN_SYSTEM_GRID_INVALID' }
  }
  if ($RecordType -eq 'technical-decision' -and $RequiredSurfaces.Count -gt 0 -and (-not $Data.PSObject.Properties['stack'] -or -not (Test-NonEmptyArray $Data.stack))) { Add-StudioError $Errors $Path $RecordType 'data.stack' 'empty' 'TECHNICAL_DECISION_STACK_REQUIRED' }
}
