. (Join-Path $PSScriptRoot 'RecordValidatorDefinitions.ps1')

function Get-design-systemValidatorContract {
  return Get-StudioValidatorContract 'design-system'
}

function Test-DesignSystemRecord {
  param($Data, $Errors, [string]$Path, [string[]]$RequiredSurfaces = @())
  Invoke-StudioRecordTypeValidation -RecordType 'design-system' -Data $Data -Errors $Errors -Path $Path -RequiredSurfaces $RequiredSurfaces
}
