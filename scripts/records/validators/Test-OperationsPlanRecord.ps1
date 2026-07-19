. (Join-Path $PSScriptRoot 'RecordValidatorDefinitions.ps1')

function Get-operations-planValidatorContract {
  return Get-StudioValidatorContract 'operations-plan'
}

function Test-OperationsPlanRecord {
  param($Data, $Errors, [string]$Path, [string[]]$RequiredSurfaces = @())
  Invoke-StudioRecordTypeValidation -RecordType 'operations-plan' -Data $Data -Errors $Errors -Path $Path -RequiredSurfaces $RequiredSurfaces
}
