function Get-SurfaceRegistry {
 [CmdletBinding()]param([string[]]$Surface=@(),[switch]$RequireKnown)
 $root=(Resolve-Path (Join-Path $PSScriptRoot '../..')).Path
 $registry=Get-Content -Raw (Join-Path $root 'schemas/studio-records/surface-registry.json')|ConvertFrom-Json
 $known=@($registry.surfaces|ForEach-Object id)
 $unknown=@($Surface|Where-Object{$_ -notin $known})
 if($RequireKnown -and $unknown.Count){throw "Unknown surface: $($unknown -join ', ')."}
 [pscustomobject]@{schemaVersion=$registry.schemaVersion;surfaces=@($registry.surfaces);known=$known;selected=@($registry.surfaces|Where-Object{$Surface -contains $_.id});unknown=$unknown}
}
