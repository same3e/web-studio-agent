. (Join-Path $PSScriptRoot 'RecordValidatorDefinitions.ps1')

function Get-performance-planValidatorContract {
  return Get-StudioValidatorContract 'performance-plan'
}

function Test-PerformancePlanRecord {
  param($Data, $Errors, [string]$Path, [string[]]$RequiredSurfaces = @())
  Invoke-StudioRecordTypeValidation -RecordType 'performance-plan' -Data $Data -Errors $Errors -Path $Path -RequiredSurfaces $RequiredSurfaces
}
