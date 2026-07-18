[CmdletBinding()]param([string]$AgentHome=$env:WEB_STUDIO_AGENT_HOME)
. (Join-Path $PSScriptRoot 'ReferenceLibrary.ps1')
Initialize-ReferenceLibrary -AgentHome $AgentHome
