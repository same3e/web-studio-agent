. (Join-Path $PSScriptRoot 'RecordValidatorDefinitions.ps1')

function Get-project-stateValidatorContract {
  return Get-StudioValidatorContract 'project-state'
}

function Test-ProjectStateRecord {
  param($Data, $Errors, [string]$Path, [string[]]$RequiredSurfaces = @())
  Invoke-StudioRecordTypeValidation -RecordType 'project-state' -Data $Data -Errors $Errors -Path $Path -RequiredSurfaces $RequiredSurfaces
}
