. (Join-Path $PSScriptRoot 'RecordValidatorDefinitions.ps1')

function Get-copyValidatorContract {
  return Get-StudioValidatorContract 'copy'
}

function Test-CopyRecord {
  param($Data, $Errors, [string]$Path, [string[]]$RequiredSurfaces = @())
  Invoke-StudioRecordTypeValidation -RecordType 'copy' -Data $Data -Errors $Errors -Path $Path -RequiredSurfaces $RequiredSurfaces
}
