. (Join-Path $PSScriptRoot 'RecordValidatorDefinitions.ps1')

function Get-database-decisionValidatorContract {
  return Get-StudioValidatorContract 'database-decision'
}

function Test-DatabaseDecisionRecord {
  param($Data, $Errors, [string]$Path, [string[]]$RequiredSurfaces = @())
  Invoke-StudioRecordTypeValidation -RecordType 'database-decision' -Data $Data -Errors $Errors -Path $Path -RequiredSurfaces $RequiredSurfaces
}
