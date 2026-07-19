Set-StrictMode -Version Latest

function Get-StudioRecordPath {
  param([Parameter(Mandatory)][string]$ProjectRoot,[Parameter(Mandatory)][string]$Name)
  Join-Path (Join-Path $ProjectRoot '.studio') $Name
}

function Read-StudioRecord {
  [CmdletBinding()]
  param([Parameter(Mandatory)][string]$Path)
  $result=[ordered]@{path=$Path;exists=(Test-Path -LiteralPath $Path);metadata=$null;body='';errors=@();legacy=$false}
  if(-not $result.exists){ return [pscustomobject]$result }
  $text=Get-Content -Raw -LiteralPath $Path -Encoding utf8
  $match=[regex]::Match($text,'(?s)\A\s*<!--\s*studio-record\s*(\{.*?\})\s*-->')
  if(-not $match.Success){ $result.legacy=$true;$result.body=$text;$result.errors=@([ordered]@{field='metadata';invalidValue='missing';blockingReason='Missing canonical studio-record JSON block.'});return [pscustomobject]$result }
  try { $result.metadata=$match.Groups[1].Value|ConvertFrom-Json -ErrorAction Stop } catch { $result.errors=@([ordered]@{field='metadata';invalidValue='invalid-json';blockingReason=$_.Exception.Message});return [pscustomobject]$result }
  $result.body=$text.Substring($match.Index+$match.Length).Trim()
  [pscustomobject]$result
}
