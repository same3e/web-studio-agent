[CmdletBinding()]param()
$ErrorActionPreference='Stop';$root=(Resolve-Path (Join-Path $PSScriptRoot '..')).Path;$work=Join-Path ([IO.Path]::GetTempPath()) ('web-studio-frontend-rules-'+[guid]::NewGuid().ToString('N'));New-Item -ItemType Directory -Force $work|Out-Null
function Expect-Failure([scriptblock]$Action,[string]$Name){try{&$Action;throw "Expected failure: $Name"}catch{if($_.Exception.Message -match '^Expected failure:'){throw};Write-Host "Expected failure: $Name"}}
function New-Project([string]$Name,[string]$State){$p=Join-Path $work $Name;$s=Join-Path $p '.studio';New-Item -ItemType Directory -Force $s|Out-Null;foreach($record in @('PROJECT_BRIEF','CONFIRMED_FACTS','ASSUMPTIONS','TECH_DECISION','APPROVED_CONCEPT','COPY','DESIGN_SYSTEM','IMPLEMENTATION_PLAN','ACCEPTANCE_CRITERIA')){"# $record"|Set-Content (Join-Path $s "$record.md")};$State|Set-Content (Join-Path $s 'PROJECT_STATE.md');$p}
function Set-VisibleDesign([string]$Project,[string]$Override=''){$s=Join-Path $Project '.studio';@'
# Design system
- Design thesis: Editorial clarity for a fictional product.
- Signature element: shifted headline and full-bleed media.
- Column model: twelve-column desktop, four-column mobile.
- Container system and reading measures: narrow, standard, wide, full bleed.
| Section / region | Purpose | Dominant element | Composition | Container | Reference principle | Mobile recomposition |
| --- | --- | --- | --- | --- | --- | --- |
| Hero | orient | headline | editorial | wide | hierarchy | stack media after copy |
'@|Set-Content (Join-Path $s 'DESIGN_SYSTEM.md');$Override|Set-Content (Join-Path $s 'TASTE_OVERRIDES.md')}
try {
  # Structural/state-machine fixtures: grid strategy, metadata eyebrow, card soup, grid breaks, recomposition, precedence, long copy, and evidence boundaries.
  $marketing=New-Project 'marketing-missing-grid' "- Visible frontend required: yes`n- Marketing page required: yes";Expect-Failure {& (Join-Path $root 'scripts/Test-ImplementationPreflight.ps1') -ProjectRoot $marketing} 'marketing page without design thesis/grid/composition map';Set-VisibleDesign $marketing '| HT-01 | square control | approved brutalist concept | hero | APPROVED_CONCEPT | desktop and mobile |';& (Join-Path $root 'scripts/Test-ImplementationPreflight.ps1') -ProjectRoot $marketing
  $invalid=New-Project 'invalid-override' '- Visible frontend required: yes';Set-VisibleDesign $invalid '| HT-99 | invalid | fixture | hero | user | browser |';Expect-Failure {& (Join-Path $root 'scripts/Test-ImplementationPreflight.ps1') -ProjectRoot $invalid} 'invalid taste rule ID'
  $profileHome=Join-Path $work 'agent-home';$profile=& (Join-Path $root 'scripts/Initialize-TasteProfile.ps1') -AgentHome $profileHome;$first=Get-Content -Raw $profile; if($first -notmatch 'Personal taste profile'){throw 'Taste profile template missing'};'# User profile`nDo not overwrite.'|Set-Content $profile;& (Join-Path $root 'scripts/Initialize-TasteProfile.ps1') -AgentHome $profileHome|Out-Null;if((Get-Content -Raw $profile) -notmatch 'Do not overwrite'){throw 'Personal taste profile was overwritten'}
  $quality=Get-Content -Raw (Join-Path $root 'knowledge/ui/FRONTEND_QUALITY.md');$layout=Get-Content -Raw (Join-Path $root 'knowledge/ui/LAYOUT.md');$house=Get-Content -Raw (Join-Path $root 'knowledge/ui/HOUSE_TASTE_DEFAULTS.md');foreach($id in @('FQ-01','FQ-25','HT-01','HT-25')){if(($quality+$house) -notmatch $id){throw "Missing canonical rule: $id"}};foreach($term in @('column model','full-bleed','content-driven breakpoints','360–390px')){if($layout -notmatch $term){throw "Missing layout rule: $term"}}
  $wrapper=Get-Content -Raw (Join-Path $root 'platforms/codex/agents/frontend-builder.toml');if($wrapper -match 'FQ-01|HT-01'){throw 'Frontend wrapper duplicates canonical rule inventory'};$browser=Get-Content -Raw (Join-Path $root 'specialists/contracts/browser-qa.md');if($browser -notmatch 'rule ID' -or $browser -notmatch 'route, viewport'){throw 'Browser QA report lacks material finding evidence fields'}
  Write-Host 'Frontend-rule fixtures passed: structural/state-machine checks only; no fixture claims a real browser test.'
} finally {if(Test-Path $work){Remove-Item -LiteralPath $work -Recurse -Force}}
