. (Join-Path $PSScriptRoot 'RecordValidatorDefinitions.ps1')

function Get-deployment-matrixValidatorContract {
  return Get-StudioValidatorContract 'deployment-matrix'
}

function Test-DeploymentMatrixRecord {
  param($Data, $Errors, [string]$Path, [string[]]$RequiredSurfaces = @())
  Invoke-StudioRecordTypeValidation -RecordType 'deployment-matrix' -Data $Data -Errors $Errors -Path $Path -RequiredSurfaces $RequiredSurfaces
}
