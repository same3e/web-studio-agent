. (Join-Path $PSScriptRoot 'RecordValidatorDefinitions.ps1')

function Get-threat-modelValidatorContract {
  return Get-StudioValidatorContract 'threat-model'
}

function Test-ThreatModelRecord {
  param($Data, $Errors, [string]$Path, [string[]]$RequiredSurfaces = @())
  Invoke-StudioRecordTypeValidation -RecordType 'threat-model' -Data $Data -Errors $Errors -Path $Path -RequiredSurfaces $RequiredSurfaces
}
