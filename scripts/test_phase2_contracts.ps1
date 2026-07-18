[CmdletBinding()]
param()
$ErrorActionPreference='Stop'
$root=(Resolve-Path (Join-Path $PSScriptRoot '..')).Path
$out=Join-Path $root '.phase2-test-output/contracts'
if(Test-Path $out){Remove-Item -Recurse -Force $out}; New-Item -ItemType Directory $out | Out-Null
function New-Fixture([string]$name,[string]$state){$p=Join-Path $out $name;$s=Join-Path $p '.studio';New-Item -ItemType Directory -Force $s|Out-Null;foreach($r in @('PROJECT_BRIEF','CONFIRMED_FACTS','ASSUMPTIONS','TECH_DECISION','APPROVED_CONCEPT','COPY','DESIGN_SYSTEM','IMPLEMENTATION_PLAN','ACCEPTANCE_CRITERIA')){Set-Content (Join-Path $s "$r.md") "# $r"};Set-Content (Join-Path $s 'PROJECT_STATE.md') $state;return $p}
function Fail([scriptblock]$block,[string]$label){try{&$block;throw "Expected failure: $label"}catch{if($_.Exception.Message -match '^Expected failure'){throw};Write-Host "Expected failure: $label"}}
# F static landing: no Phase 2 records or roles required.
$f=New-Fixture 'F-static' "# State`n- Product type: static landing";& (Join-Path $root 'scripts/Test-ImplementationPreflight.ps1') -ProjectRoot $f
$pf=Get-Content -Raw (Join-Path $f '.studio/IMPLEMENTATION_PREFLIGHT.md');if($pf -match 'BACKEND_SPEC|DATABASE_DECISION'){throw 'Fixture F unnecessarily required Phase 2 records.'}
# G lead form: backend/integration/security records are required, database skipped.
$g=New-Fixture 'G-lead' "# State`n- Backend required: yes`n- External integration required: yes";Fail {& (Join-Path $root 'scripts/Test-ImplementationPreflight.ps1') -ProjectRoot $g} 'G missing active records';& (Join-Path $root 'scripts/Initialize-ApprovedProjectRecords.ps1') -ProjectRoot $g;& (Join-Path $root 'scripts/Test-ImplementationPreflight.ps1') -ProjectRoot $g
# H authenticated SaaS: all relevant records enforced.
$h=New-Fixture 'H-saas' "# State`n- Backend required: yes`n- Persistence required: yes`n- Authentication required: yes`n- External integration required: yes";Fail {& (Join-Path $root 'scripts/Test-ImplementationPreflight.ps1') -ProjectRoot $h} 'H missing SaaS records';& (Join-Path $root 'scripts/Initialize-ApprovedProjectRecords.ps1') -ProjectRoot $h;& (Join-Path $root 'scripts/Test-ImplementationPreflight.ps1') -ProjectRoot $h
# I contradiction: persistent data cannot declare database not applicable.
$i=New-Fixture 'I-contradiction' "# State`n- Persistence required: yes";& (Join-Path $root 'scripts/Initialize-ApprovedProjectRecords.ps1') -ProjectRoot $i;Set-Content (Join-Path $i '.studio/DATABASE_DECISION.md') '# Database decision`n- Status: not applicable';Fail {& (Join-Path $root 'scripts/Test-ImplementationPreflight.ps1') -ProjectRoot $i} 'I contradictory persistence'
# J insecure client secret, K webhook without verification, L high finding without evidence.
$j=New-Fixture 'J-K-L-contracts' '# State';Set-Content (Join-Path $j '.studio/ENVIRONMENT_CONTRACT.md') '| API_KEY | x | x | yes | client | secret |';Fail {& (Join-Path $root 'scripts/Test-Phase2Contracts.ps1') -ProjectRoot $j} 'J client secret';Set-Content (Join-Path $j '.studio/ENVIRONMENT_CONTRACT.md') '# Environment';Set-Content (Join-Path $j '.studio/INTEGRATION_SPEC.md') 'webhook delivery';Fail {& (Join-Path $root 'scripts/Test-Phase2Contracts.ps1') -ProjectRoot $j} 'K webhook no verification';Set-Content (Join-Path $j '.studio/INTEGRATION_SPEC.md') 'webhook signature verification';New-Item -ItemType Directory (Join-Path $j '.studio/reports')|Out-Null;Set-Content (Join-Path $j '.studio/reports/SECURITY_REPORT.md') 'Severity: high';Fail {& (Join-Path $root 'scripts/Test-Phase2Contracts.ps1') -ProjectRoot $j} 'L high finding no evidence';Set-Content (Join-Path $j '.studio/reports/SECURITY_REPORT.md') "Severity: high`nEvidence: fixture";& (Join-Path $root 'scripts/Test-Phase2Contracts.ps1') -ProjectRoot $j
Write-Host "Phase 2 contract fixtures passed: F-L. Output: $out"
