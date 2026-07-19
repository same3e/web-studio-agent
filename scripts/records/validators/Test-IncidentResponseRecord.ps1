. (Join-Path $PSScriptRoot 'RecordValidatorDefinitions.ps1')

function Get-incident-responseValidatorContract {
  return Get-StudioValidatorContract 'incident-response'
}

function Test-IncidentResponseRecord {
  param($Data, $Errors, [string]$Path, [string[]]$RequiredSurfaces = @())
  Invoke-StudioRecordTypeValidation -RecordType 'incident-response' -Data $Data -Errors $Errors -Path $Path -RequiredSurfaces $RequiredSurfaces
}
