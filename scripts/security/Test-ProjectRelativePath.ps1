. (Join-Path $PSScriptRoot 'Test-AuthorizedPath.ps1')
function Test-ProjectRelativePath {
  [CmdletBinding()]
  param([Parameter(Mandatory)][string]$ProjectRoot,[Parameter(Mandatory)][string]$Path,[switch]$AllowGlob)
  Test-AuthorizedPath -Root $ProjectRoot -Path $Path -AllowGlob:$AllowGlob
}
