. (Join-Path $PSScriptRoot 'RecordValidatorDefinitions.ps1')

function Get-runbookValidatorContract {
  return Get-StudioValidatorContract 'runbook'
}

function Test-RunbookRecord {
  param($Data, $Errors, [string]$Path, [string[]]$RequiredSurfaces = @())
  Invoke-StudioRecordTypeValidation -RecordType 'runbook' -Data $Data -Errors $Errors -Path $Path -RequiredSurfaces $RequiredSurfaces
}
