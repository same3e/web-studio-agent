[CmdletBinding()]param([string]$AgentHome=$env:WEB_STUDIO_AGENT_HOME,[string[]]$Industries=@(),[string[]]$ProjectTypes=@(),[string[]]$StyleFamilies=@(),[string[]]$Roles=@('industry','visual','product','structural','UX'),[string[]]$Sections=@(),[string[]]$Surfaces=@(),[string[]]$VisualModifiers=@(),[string[]]$Platforms=@('web'))
. (Join-Path $PSScriptRoot 'ReferenceLibrary.ps1')
Find-ReferenceLibraryMatch @PSBoundParameters
