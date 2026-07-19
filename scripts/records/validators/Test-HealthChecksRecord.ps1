. (Join-Path $PSScriptRoot 'RecordValidatorDefinitions.ps1')

function Get-health-checksValidatorContract {
  return Get-StudioValidatorContract 'health-checks'
}

function Test-HealthChecksRecord {
  param($Data, $Errors, [string]$Path, [string[]]$RequiredSurfaces = @())
  Invoke-StudioRecordTypeValidation -RecordType 'health-checks' -Data $Data -Errors $Errors -Path $Path -RequiredSurfaces $RequiredSurfaces
}
