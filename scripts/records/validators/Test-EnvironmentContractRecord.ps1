. (Join-Path $PSScriptRoot 'RecordValidatorDefinitions.ps1')

function Get-environment-contractValidatorContract {
  return Get-StudioValidatorContract 'environment-contract'
}

function Test-EnvironmentContractRecord {
  param($Data, $Errors, [string]$Path, [string[]]$RequiredSurfaces = @())
  Invoke-StudioRecordTypeValidation -RecordType 'environment-contract' -Data $Data -Errors $Errors -Path $Path -RequiredSurfaces $RequiredSurfaces
}
