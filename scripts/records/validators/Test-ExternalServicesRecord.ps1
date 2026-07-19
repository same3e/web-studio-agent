. (Join-Path $PSScriptRoot 'RecordValidatorDefinitions.ps1')

function Get-external-servicesValidatorContract {
  return Get-StudioValidatorContract 'external-services'
}

function Test-ExternalServicesRecord {
  param($Data, $Errors, [string]$Path, [string[]]$RequiredSurfaces = @())
  Invoke-StudioRecordTypeValidation -RecordType 'external-services' -Data $Data -Errors $Errors -Path $Path -RequiredSurfaces $RequiredSurfaces
}
