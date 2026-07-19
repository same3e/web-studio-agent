. (Join-Path $PSScriptRoot 'RecordValidatorDefinitions.ps1')

function Get-release-checklistValidatorContract {
  return Get-StudioValidatorContract 'release-checklist'
}

function Test-ReleaseChecklistRecord {
  param($Data, $Errors, [string]$Path, [string[]]$RequiredSurfaces = @())
  Invoke-StudioRecordTypeValidation -RecordType 'release-checklist' -Data $Data -Errors $Errors -Path $Path -RequiredSurfaces $RequiredSurfaces
}
