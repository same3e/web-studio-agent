. (Join-Path $PSScriptRoot 'RecordValidatorDefinitions.ps1')

function Get-integration-specValidatorContract {
  return Get-StudioValidatorContract 'integration-spec'
}

function Test-IntegrationSpecRecord {
  param($Data, $Errors, [string]$Path, [string[]]$RequiredSurfaces = @())
  Invoke-StudioRecordTypeValidation -RecordType 'integration-spec' -Data $Data -Errors $Errors -Path $Path -RequiredSurfaces $RequiredSurfaces
}
