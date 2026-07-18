[CmdletBinding()]
param(
  [Parameter(Mandatory)][string]$ProjectRoot,
  [string]$OutputPath
)

$ErrorActionPreference = 'Stop'
$project = (Resolve-Path -LiteralPath $ProjectRoot).Path
$statePath = Join-Path $project '.studio/PROJECT_STATE.md'
$state = if (Test-Path -LiteralPath $statePath) { Get-Content -Raw -LiteralPath $statePath } else { '' }
$hasExistingFrontend = (Test-Path (Join-Path $project 'package.json')) -or (Test-Path (Join-Path $project 'src')) -or (Test-Path (Join-Path $project 'app'))
$documentationOnly = $state -match '(?im)^\s*-?\s*(?:Change type|Active surface):\s*.*(?:documentation-only|content-only)'

$selected = [System.Collections.Generic.List[string]]::new()
$skipped = [System.Collections.Generic.List[string]]::new()
if ($documentationOnly) {
  foreach($role in @('repo-explorer','frontend-builder','test-engineer','code-reviewer','browser-qa')) { $skipped.Add($role) }
} else {
  if ($hasExistingFrontend) { $selected.Add('repo-explorer') } else { $skipped.Add('repo-explorer') }
  foreach($role in @('frontend-builder','test-engineer','code-reviewer','browser-qa')) { $selected.Add($role) }
}

$report = @(
  '# Specialist plan',
  '',
  ('- Project root: `' + $project + '`'),
  ('- Existing frontend detected: `' + $hasExistingFrontend + '`'),
  ('- Documentation-only change: `' + $documentationOnly + '`'),
  '- Execution fallback: `sequential if platform subagents are unavailable`',
  '',
  '## Selected specialists',
  ($selected | ForEach-Object { '- `' + $_ + '`' }),
  '',
  '## Skipped specialists',
  ($skipped | ForEach-Object { '- `' + $_ + '`' }),
  '',
  '## Rule sources',
  '- `skills/product-studio/SKILL.md` — select only relevant internal roles; read-heavy work may be parallel only when safe.',
  '- `docs/architecture/SPECIALIST_SYSTEM.md` — selection matrix and sequential fallback.'
) -join [Environment]::NewLine

if ($OutputPath) {
  $dir = Split-Path -Parent $OutputPath
  if ($dir) { New-Item -ItemType Directory -Force -Path $dir | Out-Null }
  Set-Content -LiteralPath $OutputPath -Value $report -Encoding utf8
}
[pscustomobject]@{ Selected = @($selected); Skipped = @($skipped); ExistingFrontend = $hasExistingFrontend; DocumentationOnly = $documentationOnly; Report = $report }
