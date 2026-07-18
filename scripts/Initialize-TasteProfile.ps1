[CmdletBinding()]
param([string]$AgentHome=$env:WEB_STUDIO_AGENT_HOME)
$root=(Resolve-Path (Join-Path $PSScriptRoot '..')).Path
. (Join-Path $PSScriptRoot 'ReferenceLibrary.ps1')
Initialize-TasteProfile -AgentHome $AgentHome -TemplatePath (Join-Path $root 'templates/taste/PROFILE.template.md')
