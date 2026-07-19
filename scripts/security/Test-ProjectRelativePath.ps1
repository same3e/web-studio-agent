function Test-ProjectRelativePath {
 [CmdletBinding()]param([Parameter(Mandatory)][string]$ProjectRoot,[Parameter(Mandatory)][string]$Path,[switch]$AllowGlob)
 $result=[ordered]@{valid=$false;path=$Path;errorCode='';resolved=''}
 if([string]::IsNullOrWhiteSpace($Path) -or $Path.IndexOf([char]0) -ge 0){$result.errorCode='PATH_EMPTY_OR_NULL';return [pscustomobject]$result}
 if($Path -match '^(?:[A-Za-z]:|\\\\|/)' -or $Path -match '^[A-Za-z]:[^\\/]'){$result.errorCode='PATH_ABSOLUTE';return [pscustomobject]$result}
 if($Path -match '(^|[\\/])\.\.([\\/]|$)'){$result.errorCode='PATH_TRAVERSAL';return [pscustomobject]$result}
 if($Path -match '(^|[\\/])\.git([\\/]|$)' -or $Path -match '(?i)(^|[\\/])\.web-studio-agent([\\/]|$)'){$result.errorCode='PATH_FORBIDDEN';return [pscustomobject]$result}
 if($Path -match '[*?]' -and -not $AllowGlob){$result.errorCode='PATH_GLOB_FORBIDDEN';return [pscustomobject]$result}
 if($Path -match '^(?:\*\*|\*|[\\/]?\*\*)'){$result.errorCode='PATH_GLOB_BROAD';return [pscustomobject]$result}
 $root=[IO.Path]::GetFullPath((Resolve-Path -LiteralPath $ProjectRoot).Path);$candidate=[IO.Path]::GetFullPath((Join-Path $root ($Path -replace '[*?]','_glob_')))
 if(-not $candidate.StartsWith($root.TrimEnd([IO.Path]::DirectorySeparatorChar,[IO.Path]::AltDirectorySeparatorChar)+[IO.Path]::DirectorySeparatorChar,[StringComparison]::OrdinalIgnoreCase)){$result.errorCode='PATH_OUTSIDE_ROOT';return [pscustomobject]$result}
 $result.valid=$true;$result.resolved=$candidate;[pscustomobject]$result
}
