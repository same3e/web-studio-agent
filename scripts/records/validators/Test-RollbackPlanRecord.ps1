. (Join-Path $PSScriptRoot 'RecordValidatorDefinitions.ps1')

function Get-rollback-planValidatorContract {
  return Get-StudioValidatorContract 'rollback-plan'
}

function Test-RollbackPlanRecord {
  param($Data, $Errors, [string]$Path, [string[]]$RequiredSurfaces = @())
  Invoke-StudioRecordTypeValidation -RecordType 'rollback-plan' -Data $Data -Errors $Errors -Path $Path -RequiredSurfaces $RequiredSurfaces
}
