. (Join-Path $PSScriptRoot 'Read-StudioRecord.ps1')
. (Join-Path $PSScriptRoot 'RecordValidationHelpers.ps1')
. (Join-Path $PSScriptRoot 'validators/RecordValidatorDefinitions.ps1')
. (Join-Path $PSScriptRoot '../security/Test-PotentialSecret.ps1')

function Add-StudioError {
  param($List, [string]$Path, [string]$Type, [string]$Field, [string]$Value, [string]$Reason)
  $List.Add([pscustomobject][ordered]@{ path = $Path; recordType = $Type; missingField = $Field; invalidValue = $Value; status = ''; blockingReason = $Reason })
}

function Test-StudioRecord {
  [CmdletBinding()]
  param([Parameter(Mandatory)][string]$Path, [string]$ExpectedRecordType, [switch]$Required, [string[]]$RequiredSurfaces = @())

  $record = Read-StudioRecord -Path $Path
  $errors = [Collections.Generic.List[object]]::new()
  $type = $ExpectedRecordType
  if (-not $record.exists) {
    if ($Required) { Add-StudioError $errors $Path $type 'record' 'missing' 'REQUIRED_RECORD_MISSING' }
    return [pscustomobject]@{ valid = $false; record = $record; errors = @($errors); status = 'missing' }
  }
  if ($null -eq $record.metadata) {
    Add-StudioError $errors $Path $type 'metadata' 'invalid' (($record.errors | Select-Object -First 1).blockingReason)
    return [pscustomobject]@{ valid = $false; record = $record; errors = @($errors); status = 'invalid' }
  }

  $metadata = $record.metadata
  $type = [string]$metadata.recordType
  foreach ($field in @('schemaVersion', 'recordType', 'status', 'owner', 'updatedAt', 'applicability', 'sources', 'data')) {
    if ($null -eq $metadata.$field) { Add-StudioError $errors $Path $type $field 'missing' 'ENVELOPE_FIELD_MISSING' }
  }
  if ($metadata.schemaVersion -ne 1) { Add-StudioError $errors $Path $type 'schemaVersion' ([string]$metadata.schemaVersion) 'SCHEMA_VERSION_UNSUPPORTED' }
  if ($ExpectedRecordType -and $type -ne $ExpectedRecordType) { Add-StudioError $errors $Path $type 'recordType' $type 'RECORD_TYPE_MISMATCH' }
  if ($Required -and $metadata.status -in @('draft', 'blocked', 'superseded')) { Add-StudioError $errors $Path $type 'status' $metadata.status 'REQUIRED_RECORD_NOT_READY' }
  if ($Required -and $metadata.status -eq 'not-applicable') { Add-StudioError $errors $Path $type 'status' 'not-applicable' 'ROUTED_RECORD_NOT_APPLICABLE' }
  if (-not (Test-MeaningfulText $metadata.owner)) { Add-StudioError $errors $Path $type 'owner' ([string]$metadata.owner) 'OWNER_INVALID' }
  if (-not (Test-ObjectValue $metadata.applicability) -or $null -eq $metadata.applicability.productTypes -or $null -eq $metadata.applicability.surfaces) { Add-StudioError $errors $Path $type 'applicability' 'missing' 'APPLICABILITY_INVALID' }
  if ($metadata.status -eq 'not-applicable' -and -not (Test-MeaningfulText $metadata.data.reason)) { Add-StudioError $errors $Path $type 'data.reason' 'missing' 'NOT_APPLICABLE_REASON_REQUIRED' }
  if (-not (Test-MeaningfulText $record.body)) { Add-StudioError $errors $Path $type 'body' 'empty-or-template' 'RECORD_BODY_INVALID' }

  if ($metadata.status -ne 'not-applicable') {
    Invoke-StudioRecordTypeValidation -RecordType $type -Data $metadata.data -Errors $errors -Path $Path -RequiredSurfaces $RequiredSurfaces
    if ($type -eq 'environment-contract') {
      $potentialSecret = Test-PotentialSecret -Text ($metadata.data | ConvertTo-Json -Depth 20 -Compress) -Path $Path
      if ($potentialSecret.detected) { Add-StudioError $errors $Path $type 'data.variables' $potentialSecret.category 'ENVIRONMENT_CONTRACT_SECRET_VALUE' }
    }
  }
  return [pscustomobject]@{ valid = $errors.Count -eq 0; record = $record; errors = @($errors); status = if ($errors.Count) { 'invalid' } else { 'valid' } }
}
