Set-StrictMode -Version Latest

function Throw-ContextError { param([string]$Code) throw $Code }
function Get-ContextJson { param([string]$Path,[string]$MissingCode='CONTEXT_REQUIRED_RECORD_MISSING',[string]$InvalidCode='CONTEXT_RECORD_INVALID')
  if(-not(Test-Path -LiteralPath $Path)){Throw-ContextError $MissingCode}
  try{return Get-Content -Raw -LiteralPath $Path|ConvertFrom-Json}catch{Throw-ContextError $InvalidCode}
}
function Get-ContextRecord {
  param([string]$ProjectRoot,[string]$Name,[switch]$Required)
  $studio=Join-Path $ProjectRoot '.studio';if(-not(Test-Path -LiteralPath $studio -PathType Container)){Throw-ContextError 'CONTEXT_PROJECT_NOT_INITIALIZED'}
  $path=Join-Path $studio $Name;if(-not(Test-Path -LiteralPath $path)){if($Required){Throw-ContextError 'CONTEXT_REQUIRED_RECORD_MISSING'};return $null}
  . (Join-Path $PSScriptRoot '../records/Read-StudioRecord.ps1')
  $record=Read-StudioRecord -Path $path
  if($null -eq $record -or -not $record.exists -or $null -eq $record.metadata){Throw-ContextError 'CONTEXT_RECORD_INVALID'}
  if(-not $record.metadata.PSObject.Properties['data'] -or $null -eq $record.metadata.data){Throw-ContextError 'CONTEXT_RECORD_DATA_MISSING'}
  [pscustomobject]@{path=$path;record=$record;metadata=$record.metadata;data=$record.metadata.data}
}
function Require-ContextProperty { param($Object,[string]$Name,[string]$Code='CONTEXT_RECORD_INVALID') if($null -eq $Object -or -not $Object.PSObject.Properties[$Name] -or $null -eq $Object.$Name){Throw-ContextError $Code};$Object.$Name }
function Get-ContextArray { param($Object,[string]$Name) if($null -eq $Object -or -not $Object.PSObject.Properties[$Name] -or $null -eq $Object.$Name){return @()};return @($Object.$Name) }
function Get-ContextHash { param([object]$Value) $text=if($Value -is [string]){$Value}else{$Value|ConvertTo-Json -Depth 40 -Compress};$bytes=[Text.Encoding]::UTF8.GetBytes($text);(Get-FileHash -InputStream ([IO.MemoryStream]::new($bytes)) -Algorithm SHA256).Hash.ToLowerInvariant() }
function Get-ContextItem { param([string]$Path,[string]$Category,[string]$Reason,[string]$Id='') $content=Get-Content -Raw -LiteralPath $Path;[ordered]@{id=$Id;path=$Path;category=$Category;selectionReason=$Reason;estimatedTokens=[math]::Ceiling($content.Length/4);contentFingerprint=Get-ContextHash $content} }
function ConvertTo-ContextStable { param($Value) if($null -eq $Value){return $null};if($Value -is [array]){return @($Value|ForEach-Object{ConvertTo-ContextStable $_}|Sort-Object {($_|ConvertTo-Json -Depth 40 -Compress)})};if($Value -isnot [string] -and $Value -isnot [ValueType]){$out=[ordered]@{};foreach($p in @($Value.PSObject.Properties|Sort-Object Name)){$out[$p.Name]=ConvertTo-ContextStable $p.Value};return $out};$Value }
