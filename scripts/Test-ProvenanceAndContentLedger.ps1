[CmdletBinding()]
param([Parameter(Mandatory)][string]$ProjectRoot)

$ErrorActionPreference = 'Stop'
$project = (Resolve-Path -LiteralPath $ProjectRoot).Path
$studio = Join-Path $project '.studio'
$failures = [System.Collections.Generic.List[string]]::new()
function Rows([string]$path) { if(Test-Path $path){ (Get-Content -LiteralPath $path | Where-Object { $_ -match '^\|.+\|$' } | Select-Object -Skip 1) } else { @() } }

$artifactRows = Rows (Join-Path $studio 'ARTIFACT_LEDGER.md')
$browserCount = 0
foreach($row in $artifactRows) {
  $cells = @($row.Trim('|').Split('|') | ForEach-Object { $_.Trim() })
  if($cells.Count -lt 9 -or $cells[0] -eq '---') { continue }
  if($cells[1] -eq 'browser screenshot') { $browserCount++; foreach($i in @(3,4,5,6,7)){ if([string]::IsNullOrWhiteSpace($cells[$i])){$failures.Add("Browser screenshot '$($cells[0])' is missing provenance field index $i.")} } }
}
$final = Join-Path $studio 'VERIFICATION_REPORT.md'
if(Test-Path $final) {
  $report = Get-Content -Raw -LiteralPath $final
  if($browserCount -eq 0 -and $report -match '(?im)^- Browser-verification status:\s*(?:passed|complete|verified)\b') { $failures.Add('Browser verification is claimed without a browser screenshot ledger entry.') }
  if($report -match '(?im)^- (?:Concept|Source-code|Build|Browser-verification) status:\s*$') { $failures.Add('Verification report does not separate all required status fields.') }
}

$contentRows = Rows (Join-Path $studio 'CONTENT_LEDGER.md')
foreach($row in $contentRows) {
  $cells = @($row.Trim('|').Split('|') | ForEach-Object { $_.Trim() })
  if($cells.Count -lt 5 -or $cells[0] -eq '---') { continue }
  $text = $cells[0]; $classification = $cells[1]; $approved = $cells[3]; $notes = $cells[4]
  if($classification -notin @('confirmed user input','trusted project material','explicit placeholder','approved provisional statement')) { $failures.Add("Unknown content classification for '$text'.") }
  if(($text -match '(?i)(github\.com|\b[\d,]+\s*stars?\b|form success|messenger)') -and $classification -notin @('confirmed user input','trusted project material','explicit placeholder')) { $failures.Add("Unsupported public claim or action: '$text'.") }
  if($text -match '(?i)(form success|messenger|policy)' -and $notes -notmatch '(?i)(placeholder|unavailable|not functional|production blocker)') { $failures.Add("Unsafe placeholder behavior for '$text'.") }
  if($classification -eq 'explicit placeholder' -and $approved -notmatch '(?i)^(?:yes|no|placeholder)$') { $failures.Add("Explicit placeholder '$text' has unclear approval state.") }
}
if($failures.Count){ throw ($failures -join [Environment]::NewLine) }
Write-Host "Provenance and content-ledger validation passed. Browser screenshots: $browserCount."
