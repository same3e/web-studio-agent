. (Join-Path $PSScriptRoot 'RecordValidatorDefinitions.ps1')

function Get-api-contractValidatorContract {
  return Get-StudioValidatorContract 'api-contract'
}

function Test-ApiContractRecord {
  param($Data, $Errors, [string]$Path, [string[]]$RequiredSurfaces = @())
  Invoke-StudioRecordTypeValidation -RecordType 'api-contract' -Data $Data -Errors $Errors -Path $Path -RequiredSurfaces $RequiredSurfaces
}
