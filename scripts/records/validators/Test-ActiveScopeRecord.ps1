. (Join-Path $PSScriptRoot 'RecordValidatorDefinitions.ps1')

function Get-active-scopeValidatorContract {
  return Get-StudioValidatorContract 'active-scope'
}

function Test-ActiveScopeRecord {
  param($Data, $Errors, [string]$Path, [string[]]$RequiredSurfaces = @())
  Invoke-StudioRecordTypeValidation -RecordType 'active-scope' -Data $Data -Errors $Errors -Path $Path -RequiredSurfaces $RequiredSurfaces
}
