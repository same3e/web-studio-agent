. (Join-Path $PSScriptRoot 'RecordValidatorDefinitions.ps1')

function Get-security-modelValidatorContract {
  return Get-StudioValidatorContract 'security-model'
}

function Test-SecurityModelRecord {
  param($Data, $Errors, [string]$Path, [string[]]$RequiredSurfaces = @())
  Invoke-StudioRecordTypeValidation -RecordType 'security-model' -Data $Data -Errors $Errors -Path $Path -RequiredSurfaces $RequiredSurfaces
}
