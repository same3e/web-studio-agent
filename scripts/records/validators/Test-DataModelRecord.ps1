. (Join-Path $PSScriptRoot 'RecordValidatorDefinitions.ps1')

function Get-data-modelValidatorContract {
  return Get-StudioValidatorContract 'data-model'
}

function Test-DataModelRecord {
  param($Data, $Errors, [string]$Path, [string[]]$RequiredSurfaces = @())
  Invoke-StudioRecordTypeValidation -RecordType 'data-model' -Data $Data -Errors $Errors -Path $Path -RequiredSurfaces $RequiredSurfaces
}
