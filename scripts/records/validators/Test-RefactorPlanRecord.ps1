. (Join-Path $PSScriptRoot 'RecordValidatorDefinitions.ps1')

function Get-refactor-planValidatorContract {
  return Get-StudioValidatorContract 'refactor-plan'
}

function Test-RefactorPlanRecord {
  param($Data, $Errors, [string]$Path, [string[]]$RequiredSurfaces = @())
  Invoke-StudioRecordTypeValidation -RecordType 'refactor-plan' -Data $Data -Errors $Errors -Path $Path -RequiredSurfaces $RequiredSurfaces
}
