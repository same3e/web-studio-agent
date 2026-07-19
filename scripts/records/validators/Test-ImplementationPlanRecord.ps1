. (Join-Path $PSScriptRoot 'RecordValidatorDefinitions.ps1')

function Get-implementation-planValidatorContract {
  return Get-StudioValidatorContract 'implementation-plan'
}

function Test-ImplementationPlanRecord {
  param($Data, $Errors, [string]$Path, [string[]]$RequiredSurfaces = @())
  Invoke-StudioRecordTypeValidation -RecordType 'implementation-plan' -Data $Data -Errors $Errors -Path $Path -RequiredSurfaces $RequiredSurfaces
}
