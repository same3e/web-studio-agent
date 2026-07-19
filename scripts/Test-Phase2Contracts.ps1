[CmdletBinding()]
param([Parameter(Mandatory)][string]$ProjectRoot)

$ErrorActionPreference = 'Stop'
. (Join-Path $PSScriptRoot 'security/Test-PotentialSecret.ps1')
$studio = Join-Path ((Resolve-Path $ProjectRoot).Path) '.studio'
$failures = [System.Collections.Generic.List[string]]::new()
function Text([string]$name) { $path=Join-Path $studio $name; if(Test-Path $path){Get-Content -Raw $path}else{''} }
$env = Text 'ENVIRONMENT_CONTRACT.md'
if($env -match '(?im)^\|[^\n]*\|[^\n]*\|[^\n]*\|[^\n]*\|\s*client\s*\|[^\n]*(?:secret|private)'){ $failures.Add('Client-visible environment variable is marked secret/private.') }
if((Test-PotentialSecret -Text $env -Path (Join-Path $studio 'ENVIRONMENT_CONTRACT.md')).detected){ $failures.Add('Environment contract appears to contain an actual secret value.') }
$integration = Text 'INTEGRATION_SPEC.md'
if($integration -match '(?i)webhook' -and -not ($integration -match '(?i)(signature|verification|verify)')){ $failures.Add('Webhook integration lacks verification behavior.') }
if($integration -match '(?i)(production|live)' -and $integration -match '(?i)(form success|fake success|no delivery)'){ $failures.Add('Integration claims production success without delivery behavior.') }
$security = Text 'reports/SECURITY_REPORT.md'
if($security -match '(?i)Severity:\s*(critical|high)' -and -not ($security -match '(?i)Evidence:\s*[^\s]')){ $failures.Add('Critical/high security finding lacks evidence.') }
if($security -match '(?i)Severity:\s*critical' -and $security -match '(?i)Status:\s*complete' -and -not ($security -match '(?i)Recheck evidence:\s*[^\s]')){ $failures.Add('Critical finding marked complete without recheck evidence.') }
if($failures.Count){throw ($failures -join [Environment]::NewLine)}
Write-Host 'Phase 2 contract validation passed.'
