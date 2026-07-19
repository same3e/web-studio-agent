. (Join-Path $PSScriptRoot 'RecordValidatorDefinitions.ps1')

function Get-technical-decisionValidatorContract {
  return Get-StudioValidatorContract 'technical-decision'
}

function Test-TechnicalDecisionRecord {
  param($Data, $Errors, [string]$Path, [string[]]$RequiredSurfaces = @())
  Invoke-StudioRecordTypeValidation -RecordType 'technical-decision' -Data $Data -Errors $Errors -Path $Path -RequiredSurfaces $RequiredSurfaces
}
