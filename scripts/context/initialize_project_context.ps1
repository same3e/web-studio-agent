[CmdletBinding()]
param([Parameter(Mandatory)][string]$ProjectRoot)

$ErrorActionPreference='Stop';$project=(Resolve-Path -LiteralPath $ProjectRoot).Path;$root=(Resolve-Path (Join-Path $PSScriptRoot '../..')).Path;$studio=Join-Path $project '.studio';New-Item -ItemType Directory -Force -Path $studio,(Join-Path $studio 'references/cards')|Out-Null
foreach($pair in @(@('PROJECT_SNAPSHOT.md','templates/studio/PROJECT_SNAPSHOT.template.md'),@('CONTEXT_INDEX.md','templates/studio/CONTEXT_INDEX.template.md'))){$target=Join-Path $studio $pair[0];if(-not(Test-Path $target)){Copy-Item -LiteralPath (Join-Path $root $pair[1]) -Destination $target;Write-Host "Initialized .studio/$($pair[0])"}}
& (Join-Path $PSScriptRoot 'build_repo_map.ps1') -ProjectRoot $project|Out-Null
