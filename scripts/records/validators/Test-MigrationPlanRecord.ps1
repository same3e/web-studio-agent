. (Join-Path $PSScriptRoot 'RecordValidatorDefinitions.ps1')

function Get-migration-planValidatorContract {
  return Get-StudioValidatorContract 'migration-plan'
}

function Test-MigrationPlanRecord {
  param($Data, $Errors, [string]$Path, [string[]]$RequiredSurfaces = @())
  Invoke-StudioRecordTypeValidation -RecordType 'migration-plan' -Data $Data -Errors $Errors -Path $Path -RequiredSurfaces $RequiredSurfaces
}
