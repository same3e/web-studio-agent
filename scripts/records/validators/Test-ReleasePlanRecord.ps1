. (Join-Path $PSScriptRoot 'RecordValidatorDefinitions.ps1')

function Get-release-planValidatorContract {
  return Get-StudioValidatorContract 'release-plan'
}

function Test-ReleasePlanRecord {
  param($Data, $Errors, [string]$Path, [string[]]$RequiredSurfaces = @())
  Invoke-StudioRecordTypeValidation -RecordType 'release-plan' -Data $Data -Errors $Errors -Path $Path -RequiredSurfaces $RequiredSurfaces
}
