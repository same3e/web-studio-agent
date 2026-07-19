. (Join-Path $PSScriptRoot 'RecordValidatorDefinitions.ps1')

function Get-performance-budgetValidatorContract {
  return Get-StudioValidatorContract 'performance-budget'
}

function Test-PerformanceBudgetRecord {
  param($Data, $Errors, [string]$Path, [string[]]$RequiredSurfaces = @())
  Invoke-StudioRecordTypeValidation -RecordType 'performance-budget' -Data $Data -Errors $Errors -Path $Path -RequiredSurfaces $RequiredSurfaces
}
