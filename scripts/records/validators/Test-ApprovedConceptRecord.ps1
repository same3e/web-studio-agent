. (Join-Path $PSScriptRoot 'RecordValidatorDefinitions.ps1')

function Get-approved-conceptValidatorContract {
  return Get-StudioValidatorContract 'approved-concept'
}

function Test-ApprovedConceptRecord {
  param($Data, $Errors, [string]$Path, [string[]]$RequiredSurfaces = @())
  Invoke-StudioRecordTypeValidation -RecordType 'approved-concept' -Data $Data -Errors $Errors -Path $Path -RequiredSurfaces $RequiredSurfaces
}
