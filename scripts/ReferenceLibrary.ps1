Set-StrictMode -Version Latest

function Resolve-ReferenceLibraryRoot {
  param([string]$AgentHome = $env:WEB_STUDIO_AGENT_HOME)
  if (-not $AgentHome) { $AgentHome = if ($IsWindows) { Join-Path $env:USERPROFILE '.web-studio-agent' } else { Join-Path $HOME '.web-studio-agent' } }
  $homePath = [IO.Path]::GetFullPath($AgentHome)
  if ($homePath -match '(?i)[\\/]plugins[\\/]cache(?:[\\/]|$)') { throw 'Reference library may not be inside plugin cache.' }
  Join-Path $homePath 'reference-library'
}

function Initialize-TasteProfile {
  param([string]$AgentHome = $env:WEB_STUDIO_AGENT_HOME,[string]$TemplatePath)
  if (-not $AgentHome) { $AgentHome = if ($IsWindows) { Join-Path $env:USERPROFILE '.web-studio-agent' } else { Join-Path $HOME '.web-studio-agent' } }
  $taste = Join-Path ([IO.Path]::GetFullPath($AgentHome)) 'taste'; New-Item -ItemType Directory -Force -Path $taste | Out-Null
  $profile = Join-Path $taste 'PROFILE.md'
  if (-not (Test-Path -LiteralPath $profile) -and $TemplatePath) { Copy-Item -LiteralPath $TemplatePath -Destination $profile }
  $profile
}

function Initialize-ReferenceLibrary {
  param([string]$AgentHome = $env:WEB_STUDIO_AGENT_HOME)
  $library = Resolve-ReferenceLibraryRoot -AgentHome $AgentHome
  foreach ($directory in @('references','indexes','schemas','migrations','reports')) { New-Item -ItemType Directory -Force -Path (Join-Path $library $directory) | Out-Null }
  $schema = Join-Path $library 'schemas/metadata-v1.json'
  if (-not (Test-Path -LiteralPath $schema)) { '{"schemaVersion":1,"required":["schemaVersion","id","title","sourceType","addedDate","industries","platforms","styleFamilies","visualModifiers","primaryRole","secondaryRoles","projectTypes","strongSections","supportedSurfaces","interactionEvidenceStatus","responsiveEvidenceStatus","status","confidence","noCopy","analysisLimitations"]}' | Set-Content -LiteralPath $schema -Encoding utf8 }
  $library
}

function ConvertTo-NormalizedReferenceUrl {
  param([Parameter(Mandatory)][string]$Url)
  $uri = [Uri]$Url
  $builder = [UriBuilder]::new($uri)
  $builder.Scheme = $builder.Scheme.ToLowerInvariant(); $builder.Host = $builder.Host.ToLowerInvariant(); $builder.Fragment = ''
  if (($builder.Scheme -eq 'https' -and $builder.Port -eq 443) -or ($builder.Scheme -eq 'http' -and $builder.Port -eq 80)) { $builder.Port = -1 }
  $path = $builder.Path.TrimEnd('/'); if (-not $path) { $path = '/' }; $builder.Path = $path
  $builder.Uri.AbsoluteUri.TrimEnd('/')
}

function Get-ReferenceItems {
  param([Parameter(Mandatory)][string]$Library)
  $references = Join-Path $Library 'references'
  if (-not (Test-Path -LiteralPath $references)) { return @() }
  @(Get-ChildItem -LiteralPath $references -Directory | ForEach-Object { $metadata = Join-Path $_.FullName 'metadata.json'; if (Test-Path -LiteralPath $metadata) { Get-Content -Raw -LiteralPath $metadata | ConvertFrom-Json } } | Where-Object { $_ })
}

function Write-ReferenceIndexes {
  param([Parameter(Mandatory)][string]$Library)
  $items = @(Get-ReferenceItems -Library $Library | Sort-Object id)
  $indexes = Join-Path $Library 'indexes'; New-Item -ItemType Directory -Force -Path $indexes | Out-Null
  $definitions = [ordered]@{
    'REFERENCE_INDEX' = { param($m) @($m.id) }
    'STYLE_INDEX' = { param($m) @($m.styleFamilies) }
    'INDUSTRY_INDEX' = { param($m) @($m.industries) }
    'ROLE_INDEX' = { param($m) @($m.primaryRole) + @($m.secondaryRoles) }
    'PROJECT_TYPE_INDEX' = { param($m) @($m.projectTypes) }
    'SECTION_INDEX' = { param($m) @($m.strongSections) }
    'PATTERN_INDEX' = { param($m) @($m.supportedSurfaces) }
    'VISUAL_MODIFIER_INDEX' = { param($m) @($m.visualModifiers) }
  }
  foreach ($entry in $definitions.GetEnumerator()) {
    $map = [ordered]@{}
    foreach ($item in $items) { foreach ($value in @(& $entry.Value $item | Where-Object { $_ })) { if (-not $map.Contains($value)) { $map[$value] = @() }; if ($map[$value] -notcontains $item.id) { $map[$value] += $item.id } } }
    $json = if ($entry.Key -eq 'REFERENCE_INDEX') { @($items) | ConvertTo-Json -Depth 8 } else { $map | ConvertTo-Json -Depth 8 }
    Set-Content -LiteralPath (Join-Path $indexes ($entry.Key + '.json')) -Value $json -Encoding utf8
    $markdown = '# ' + ($entry.Key -replace '_',' ').ToLowerInvariant() + "`n`n"
    if ($entry.Key -eq 'REFERENCE_INDEX') { $markdown += "| ID | Title | Source type |`n| --- | --- | --- |`n"; foreach ($item in $items) { $markdown += "| $($item.id) | $($item.title) | $($item.sourceType) |`n" } }
    else { foreach ($key in $map.Keys) { $markdown += "- **$key**: $($map[$key] -join ', ')`n" } }
    Set-Content -LiteralPath (Join-Path $indexes ($entry.Key + '.md')) -Value $markdown -Encoding utf8
  }
}

function Ensure-ReferenceProjectRecords {
  param([Parameter(Mandatory)][string]$ProjectRoot)
  $dir = Join-Path $ProjectRoot '.studio/references'; New-Item -ItemType Directory -Force -Path $dir | Out-Null
  foreach ($name in @('SELECTED_REFERENCES','PROJECT_REFERENCE_INDEX','REFERENCE_USAGE','REFERENCE_CONFLICTS','REFERENCE_GAPS')) { $path = Join-Path $dir ($name + '.md'); if (-not (Test-Path -LiteralPath $path)) { "# $($name -replace '_',' ')`n`n- Status: `optional` `n- Reason: project-specific reference selection has not been approved." | Set-Content -LiteralPath $path -Encoding utf8 } }
  $dir
}

function Add-ReferenceProjectLink {
  param([Parameter(Mandatory)][string]$ProjectRoot,[Parameter(Mandatory)][string]$ReferenceId,[string]$Role='unassigned',[string]$Reason='Linked from permanent library; approval required before use.')
  $dir = Ensure-ReferenceProjectRecords -ProjectRoot $ProjectRoot
  Add-Content -LiteralPath (Join-Path $dir 'PROJECT_REFERENCE_INDEX.md') -Value "- `$ReferenceId` — role: $Role; reason: $Reason" -Encoding utf8
}

function Add-ReferenceLibraryItem {
  param([Parameter(Mandatory)][string]$AgentHome,[string]$FilePath,[string]$Url,[string]$Title='Untitled reference',[string]$ProjectRoot,[string[]]$Industries=@(),[string[]]$Platforms=@('web'),[string[]]$StyleFamilies=@(),[string[]]$VisualModifiers=@(),[string]$PrimaryRole='visual',[string[]]$SecondaryRoles=@(),[string[]]$ProjectTypes=@(),[string[]]$StrongSections=@(),[string[]]$SupportedSurfaces=@())
  if (($FilePath -and $Url) -or (-not $FilePath -and -not $Url)) { throw 'Provide exactly one local file or URL metadata record.' }
  $library = Initialize-ReferenceLibrary -AgentHome $AgentHome; $items = @(Get-ReferenceItems -Library $library)
  $hash = $null; $normalizedUrl = $null; $sourceType = if ($FilePath) { 'local-file' } else { 'url' }
  if ($FilePath) { if (-not (Test-Path -LiteralPath $FilePath -PathType Leaf)) { throw "Source file does not exist: $FilePath" }; $hash = (Get-FileHash -Algorithm SHA256 -LiteralPath $FilePath).Hash.ToLowerInvariant(); $existing = $items | Where-Object { $_.contentHash -eq $hash } }
  else { $normalizedUrl = ConvertTo-NormalizedReferenceUrl -Url $Url; $existing = $items | Where-Object { $_.normalizedUrl -eq $normalizedUrl } }
  if ($existing) { if ($ProjectRoot) { Add-ReferenceProjectLink -ProjectRoot $ProjectRoot -ReferenceId $existing[0].id -Role $PrimaryRole }; return [pscustomobject]@{ Outcome = if($FilePath){'exact duplicate'}else{'normalized URL duplicate'}; Id=$existing[0].id; Library=$library } }
  $seed = if ($hash) { $hash } else { (Get-FileHash -InputStream ([IO.MemoryStream]::new([Text.Encoding]::UTF8.GetBytes($normalizedUrl))) -Algorithm SHA256).Hash.ToLowerInvariant() }
  $id = 'ref-' + $seed.Substring(0,12); $folder = Join-Path $library ('references/' + $id); $source = Join-Path $folder 'source'; New-Item -ItemType Directory -Force -Path $source | Out-Null
  $originalFilename = $null
  if ($FilePath) { $originalFilename = Split-Path -Leaf $FilePath; Copy-Item -LiteralPath $FilePath -Destination (Join-Path $source $originalFilename) }
  else { $originalFilename = 'SOURCE_URL.txt'; $Url | Set-Content -LiteralPath (Join-Path $source $originalFilename) -Encoding utf8 }
  $metadata = [ordered]@{ schemaVersion=1; id=$id; title=$Title; sourceType=$sourceType; originalFilename=$originalFilename; originalUrl=$Url; normalizedUrl=$normalizedUrl; capturedDate=$null; addedDate=[DateTime]::UtcNow.ToString('o'); sourceDimensions=$null; industries=@($Industries); platforms=@($Platforms); styleFamilies=@($StyleFamilies); visualModifiers=@($VisualModifiers); primaryRole=$PrimaryRole; secondaryRoles=@($SecondaryRoles); projectTypes=@($ProjectTypes); strongSections=@($StrongSections); supportedSurfaces=@($SupportedSurfaces); interactionEvidenceStatus='unknown'; responsiveEvidenceStatus='unknown'; status='active'; confidence='unclassified'; noCopy='Do not copy source text, asset, layout, or interaction implementation; use only documented principles.'; analysisLimitations='Static evidence does not verify hover, sticky behavior, responsiveness, animation, accessibility, or runtime interactions.'; contentHash=$hash }
  $metadata | ConvertTo-Json -Depth 8 | Set-Content -LiteralPath (Join-Path $folder 'metadata.json') -Encoding utf8
  "# Source`n`n- ID: `$id``n- Type: `$sourceType``n- Original URL: $(if($Url){$Url}else{'not applicable'})`n- Content hash: $(if($hash){$hash}else{'not applicable'})" | Set-Content -LiteralPath (Join-Path $folder 'SOURCE.md') -Encoding utf8
  "# Analysis`n`n## Observed evidence`n- Pending evidence-based analysis.`n`n## Interpretation`n- Unclassified; do not infer runtime behavior.`n`n## Reusable principles`n- Pending.`n`n## Active-project use`n- Requires project approval.`n`n## Strengths, weaknesses, risks, and anti-patterns`n- Pending.`n`n## Suitable / unsuitable projects`n- Pending.`n`n## Evidence locations and limitations`n- Source captured under `source/`; static evidence cannot verify interaction, responsiveness, animation, or accessibility.`n`n## No-copy boundaries`n- Do not copy source text, assets, exact layout, or implementation.`n`n## Confidence`n- unclassified." | Set-Content -LiteralPath (Join-Path $folder 'ANALYSIS.md') -Encoding utf8
  Write-ReferenceIndexes -Library $library; if ($ProjectRoot) { Add-ReferenceProjectLink -ProjectRoot $ProjectRoot -ReferenceId $id -Role $PrimaryRole }
  [pscustomobject]@{ Outcome='new reference'; Id=$id; Library=$library }
}

function Find-ReferenceLibraryMatch {
  param([Parameter(Mandatory)][string]$AgentHome,[string[]]$Industries=@(),[string[]]$ProjectTypes=@(),[string[]]$StyleFamilies=@(),[string[]]$Roles=@('industry','visual','product','structural','UX'),[string[]]$Sections=@(),[string[]]$Surfaces=@(),[string[]]$VisualModifiers=@(),[string[]]$Platforms=@('web'))
  $library = Initialize-ReferenceLibrary -AgentHome $AgentHome; $items = @(Get-ReferenceItems -Library $library); $results = foreach($item in $items){$matched=@();foreach($pair in @(@('industry',$Industries,@($item.industries)),@('project type',$ProjectTypes,@($item.projectTypes)),@('style',$StyleFamilies,@($item.styleFamilies)),@('section',$Sections,@($item.strongSections)),@('surface',$Surfaces,@($item.supportedSurfaces)),@('visual modifier',$VisualModifiers,@($item.visualModifiers)),@('platform',$Platforms,@($item.platforms)))){if(@($pair[1] | Where-Object {$pair[2] -contains $_}).Count){$matched += $pair[0]}};$role=@($item.primaryRole)+@($item.secondaryRoles);if(@($Roles|Where-Object{$role -contains $_}).Count){$matched+='role'};[pscustomobject]@{id=$item.id;title=$item.title;score=$matched.Count;matchedDimensions=@($matched|Select-Object -Unique);proposedProjectRole=($role|Where-Object{$Roles -contains $_}|Select-Object -First 1);confidence=if($matched.Count -ge 4){'high'}elseif($matched.Count -ge 2){'medium'}else{'low'}}}
  $ranked=@($results|Where-Object{$_.score -gt 0}|Sort-Object @{e='score';Descending=$true},id);$selected=@();foreach($role in $Roles){$selectedIds=@($selected|ForEach-Object id);$candidate=$ranked|Where-Object{$_.proposedProjectRole -eq $role -and $selectedIds -notcontains $_.id}|Select-Object -First 1;if($candidate){$selected+=$candidate}};[pscustomobject]@{Library=$library;Matches=$ranked;BalancedSelection=$selected;MissingRoleGaps=@($Roles|Where-Object{@($selected|ForEach-Object proposedProjectRole) -notcontains $_})}
}

function Test-ReferenceLibraryIntegrity {
  param([Parameter(Mandatory)][string]$AgentHome)
  $library=Initialize-ReferenceLibrary -AgentHome $AgentHome;$seenHash=@{};$seenUrl=@{};foreach($item in @(Get-ReferenceItems -Library $library)){if($item.schemaVersion -ne 1 -or -not $item.id -or -not $item.noCopy -or (-not (@('industry','visual','product','structural','UX','interaction','content','overlap') -contains $item.primaryRole))){throw "Invalid metadata: $($item.id)"};$folder=Join-Path $library ('references/'+$item.id);foreach($name in @('metadata.json','SOURCE.md','ANALYSIS.md','source')){if(-not(Test-Path -LiteralPath (Join-Path $folder $name))){throw "Missing $name for $($item.id)"}};$analysis=Get-Content -Raw -LiteralPath (Join-Path $folder 'ANALYSIS.md');if($analysis -match '(?i)(?:verified|confirmed)\s+(?:hover|sticky|responsive|animation|accessibility|runtime interaction)' -and $analysis -notmatch '(?i)(?:inference|unknown|limitation)'){throw "Unsupported interaction claim: $($item.id)"};if($item.contentHash){if($seenHash[$item.contentHash]){throw "Duplicate content hash: $($item.contentHash)"};$seenHash[$item.contentHash]=$true};if($item.normalizedUrl){if($seenUrl[$item.normalizedUrl]){throw "Duplicate normalized URL: $($item.normalizedUrl)"};$seenUrl[$item.normalizedUrl]=$true}}
  Write-ReferenceIndexes -Library $library; $library
}

function Test-ReferenceProjectLinks {
  param([Parameter(Mandatory)][string]$AgentHome,[Parameter(Mandatory)][string]$ProjectRoot)
  $library=Initialize-ReferenceLibrary -AgentHome $AgentHome;$known=@(Get-ReferenceItems -Library $library|ForEach-Object id);$index=Join-Path $ProjectRoot '.studio/references/PROJECT_REFERENCE_INDEX.md';if(Test-Path $index){foreach($match in [regex]::Matches((Get-Content -Raw $index),'ref-[a-zA-Z0-9_-]+')){if($known -notcontains $match.Value){throw "Project link points to unknown global ID: $($match.Value)"}}}
}
