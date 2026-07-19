function Get-StudioPlaceholderReason {
  param($Value)

  if ($Value -isnot [string]) { return $null }
  $text = $Value.Trim()
  if ([string]::IsNullOrWhiteSpace($text)) { return 'PLACEHOLDER_EXACT' }
  if ($text -match '^(?i)(?:tbd|todo|unknown|placeholder|template|pending)(?:\s*[,:;.-]|$)') {
    return 'PLACEHOLDER_PREFIX'
  }
  if ($text -match '^\[[^\]]*(?i:insert|replace|enter|value|todo|tbd)[^\]]*\]$') {
    return 'PLACEHOLDER_BRACKETED'
  }
  if ($text -match '^(?i)(?:lorem\s+ipsum|ipsum\s+lorem)(?:\s+\w+){0,5}[.!]?$') {
    return 'PLACEHOLDER_FILLER'
  }
  return $null
}

function Test-NonEmptyString {
  param($Value)
  return $Value -is [string] -and -not [string]::IsNullOrWhiteSpace($Value)
}

function Test-MeaningfulText {
  param($Value)
  return (Test-NonEmptyString $Value) -and $null -eq (Get-StudioPlaceholderReason $Value)
}

function Test-BooleanValue { param($Value) return $Value -is [bool] }
function Test-NonEmptyArray { param($Value) return $Value -is [array] -and $Value.Count -gt 0 }
function Test-ObjectValue { param($Value) return $null -ne $Value -and $Value -isnot [string] -and $Value -isnot [array] -and $Value -isnot [bool] }

function Test-EnumValue {
  param($Value, [string[]]$Allowed)
  return $Value -is [string] -and $Allowed -contains $Value
}

function Test-UniqueIds {
  param($Items, [string]$IdProperty = 'id')
  if (-not (Test-NonEmptyArray $Items)) { return $false }
  $ids = @($Items | ForEach-Object { $_.$IdProperty })
  return @($ids | Where-Object { -not (Test-MeaningfulText $_) }).Count -eq 0 -and @($ids | Select-Object -Unique).Count -eq $ids.Count
}

function Test-ReferencedIds {
  param($ReferencedIds, $KnownIds)
  return $ReferencedIds -is [array] -and @($ReferencedIds | Where-Object { $_ -notin @($KnownIds) }).Count -eq 0
}

function Get-RemediationLoopLimit {
  param($WorkflowMode)
  if ($WorkflowMode -isnot [string] -or [string]::IsNullOrWhiteSpace($WorkflowMode)) { throw 'UNKNOWN_WORKFLOW_MODE' }
  switch ($WorkflowMode) {
    'lean' { return 1 }
    'standard' { return 2 }
    'thorough' { return 3 }
    default { throw 'UNKNOWN_WORKFLOW_MODE' }
  }
}

function Test-RequiredProperty {
  param($Data, [string]$Name, $Errors, [string]$Path, [string]$Type)
  if ($null -eq $Data -or -not $Data.PSObject.Properties[$Name]) {
    Add-StudioError $Errors $Path $Type "data.$Name" 'missing' 'REQUIRED_PROPERTY_MISSING'
    return $false
  }
  return $true
}
