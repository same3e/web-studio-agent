. (Join-Path $PSScriptRoot 'RecordValidatorDefinitions.ps1')

function Get-behavior-invariantsValidatorContract {
  return Get-StudioValidatorContract 'behavior-invariants'
}

function Test-BehaviorInvariantsRecord {
  param($Data, $Errors, [string]$Path, [string[]]$RequiredSurfaces = @())
  Invoke-StudioRecordTypeValidation -RecordType 'behavior-invariants' -Data $Data -Errors $Errors -Path $Path -RequiredSurfaces $RequiredSurfaces
}
