$ErrorActionPreference = 'Stop'
$root = (Resolve-Path (Join-Path $PSScriptRoot '..')).Path
$readme = Get-Content -Raw (Join-Path $root 'README.md')
$audit = Get-Content -Raw (Join-Path $root 'docs/FINAL_RELEASE_AUDIT.md')
$skillCount = @(Get-ChildItem (Join-Path $root 'skills') -Recurse -Filter SKILL.md).Count
$knowledgeCount = @(
  Get-ChildItem (Join-Path $root 'knowledge') -Directory |
    ForEach-Object { Get-ChildItem $_.FullName -Recurse -Filter *.md }
).Count
$templateCount = @(Get-ChildItem (Join-Path $root 'templates/studio') -Recurse -Filter *.template.md).Count
$contractCount = @((Get-Content -Raw (Join-Path $root 'schemas/studio-records/record-contract-registry.json') | ConvertFrom-Json).contracts).Count
$version = (Get-Content -Raw (Join-Path $root '.codex-plugin/plugin.json') | ConvertFrom-Json).version
if ($skillCount -ne 2 -or $readme -notmatch 'product-studio' -or $readme -notmatch 'add-reference') { throw 'DOCUMENTATION_SKILL_COUNT_MISMATCH' }
if ($readme -notmatch 'PowerShell 7\.x \(`pwsh`\) is required' -or $audit -notmatch 'PowerShell 7\.x \(`pwsh`\) is required') { throw 'DOCUMENTATION_PWSH_PREREQUISITE_MISSING' }
if ($audit -notmatch [regex]::Escape("$knowledgeCount modular methodology files")) { throw 'DOCUMENTATION_KNOWLEDGE_COUNT_MISMATCH' }
if ($audit -notmatch 'runtime-unverified|runtime unverified|not verified|were not run') { throw 'DOCUMENTATION_RUNTIME_LIMITATIONS_MISSING' }
if ($version -notmatch '^\d+\.\d+\.\d+$' -or $templateCount -lt $contractCount) { throw 'DOCUMENTATION_RELEASE_METADATA_MISMATCH' }
Write-Output "Release documentation consistency passed: $skillCount skills, $knowledgeCount knowledge files, $templateCount templates, $contractCount record contracts, plugin $version."
