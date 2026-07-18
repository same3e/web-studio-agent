[CmdletBinding()]param([string]$AgentHome=$env:WEB_STUDIO_AGENT_HOME,[string]$FilePath,[string]$Url,[string]$Title='Untitled reference',[string]$ProjectRoot,[string[]]$Industries=@(),[string[]]$Platforms=@('web'),[string[]]$StyleFamilies=@(),[string[]]$VisualModifiers=@(),[string]$PrimaryRole='visual',[string[]]$SecondaryRoles=@(),[string[]]$ProjectTypes=@(),[string[]]$StrongSections=@(),[string[]]$SupportedSurfaces=@())
. (Join-Path $PSScriptRoot 'ReferenceLibrary.ps1')
Add-ReferenceLibraryItem @PSBoundParameters
