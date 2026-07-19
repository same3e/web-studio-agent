. (Join-Path $PSScriptRoot 'RecordValidatorDefinitions.ps1')

function Get-backend-specValidatorContract {
  return Get-StudioValidatorContract 'backend-spec'
}

function Test-BackendSpecRecord {
  param($Data, $Errors, [string]$Path, [string[]]$RequiredSurfaces = @())
  Invoke-StudioRecordTypeValidation -RecordType 'backend-spec' -Data $Data -Errors $Errors -Path $Path -RequiredSurfaces $RequiredSurfaces
}
