[CmdletBinding()]
param([Parameter(Mandatory)][string]$AgentHome,[switch]$RebuildIndexes)
. (Join-Path $PSScriptRoot '../ReferenceLibrary.ps1')
Test-ReferenceLibraryIntegrity -AgentHome $AgentHome -RebuildIndexes:$RebuildIndexes
