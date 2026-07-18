[CmdletBinding()]
param([Parameter(Mandatory)][string]$ProjectRoot)

$ErrorActionPreference = 'Stop'
$project = (Resolve-Path -LiteralPath $ProjectRoot).Path
$studio = Join-Path $project '.studio'
$root = (Resolve-Path (Join-Path $PSScriptRoot '..')).Path
if(-not (Test-Path -LiteralPath (Join-Path $studio 'APPROVED_CONCEPT.md'))) { throw 'Cannot derive approved records without .studio/APPROVED_CONCEPT.md.' }
$created = [System.Collections.Generic.List[string]]::new()
foreach($name in @('COPY','DESIGN_SYSTEM','IMPLEMENTATION_PLAN','ACCEPTANCE_CRITERIA')) {
  $target = Join-Path $studio "$name.md"
  if(-not (Test-Path -LiteralPath $target)) { Copy-Item -LiteralPath (Join-Path $root "templates/studio/$name.template.md") -Destination $target; $created.Add(".studio/$name.md") }
}
Write-Host "Approved project records initialized: $(if($created.Count){$created -join ', '}else{'none; all records already existed'})"
