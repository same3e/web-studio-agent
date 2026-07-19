. (Join-Path $PSScriptRoot 'RecordValidatorDefinitions.ps1')

function Get-backup-recoveryValidatorContract {
  return Get-StudioValidatorContract 'backup-recovery'
}

function Test-BackupRecoveryRecord {
  param($Data, $Errors, [string]$Path, [string[]]$RequiredSurfaces = @())
  Invoke-StudioRecordTypeValidation -RecordType 'backup-recovery' -Data $Data -Errors $Errors -Path $Path -RequiredSurfaces $RequiredSurfaces
}
