[CmdletBinding()]param([Parameter(Mandatory)][string]$AgentHome)
. (Join-Path $PSScriptRoot 'ReferenceLibrary.ps1')
$lib=Test-ReferenceLibraryIntegrity -AgentHome $AgentHome
Write-Host "Reference library validation passed: $lib"
