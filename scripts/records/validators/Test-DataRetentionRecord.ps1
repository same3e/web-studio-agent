. (Join-Path $PSScriptRoot 'RecordValidatorDefinitions.ps1')

function Get-data-retentionValidatorContract {
  return Get-StudioValidatorContract 'data-retention'
}

function Test-DataRetentionRecord {
  param($Data, $Errors, [string]$Path, [string[]]$RequiredSurfaces = @())
  Invoke-StudioRecordTypeValidation -RecordType 'data-retention' -Data $Data -Errors $Errors -Path $Path -RequiredSurfaces $RequiredSurfaces
}
