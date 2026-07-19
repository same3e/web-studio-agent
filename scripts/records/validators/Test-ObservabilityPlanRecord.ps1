. (Join-Path $PSScriptRoot 'RecordValidatorDefinitions.ps1')

function Get-observability-planValidatorContract {
  return Get-StudioValidatorContract 'observability-plan'
}

function Test-ObservabilityPlanRecord {
  param($Data, $Errors, [string]$Path, [string[]]$RequiredSurfaces = @())
  Invoke-StudioRecordTypeValidation -RecordType 'observability-plan' -Data $Data -Errors $Errors -Path $Path -RequiredSurfaces $RequiredSurfaces
}
