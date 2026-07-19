. (Join-Path $PSScriptRoot 'RecordValidatorDefinitions.ps1')

function Get-acceptance-criteriaValidatorContract {
  return Get-StudioValidatorContract 'acceptance-criteria'
}

function Test-AcceptanceCriteriaRecord {
  param($Data, $Errors, [string]$Path, [string[]]$RequiredSurfaces = @())
  Invoke-StudioRecordTypeValidation -RecordType 'acceptance-criteria' -Data $Data -Errors $Errors -Path $Path -RequiredSurfaces $RequiredSurfaces
}
