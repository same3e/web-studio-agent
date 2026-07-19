function Test-PotentialSecret {
  [CmdletBinding()]
  param([Parameter(Mandatory)][string]$Text, [string]$Path = '', [int]$Line = 0)
  $patterns = @(
    @{ category = 'PRIVATE_KEY'; pattern = '-----BEGIN (?:RSA |EC |OPENSSH )?PRIVATE KEY-----'; confidence = 'high' },
    @{ category = 'DATABASE_CONNECTION'; pattern = '(?i)(?:postgres|mysql|mongodb(?:\+srv)?|redis)://[^\s"'']+'; confidence = 'high' },
    @{ category = 'JWT'; pattern = '\beyJ[A-Za-z0-9_-]+\.[A-Za-z0-9_-]+\.[A-Za-z0-9_-]+\b'; confidence = 'high' },
    @{ category = 'BEARER_TOKEN'; pattern = '(?i)bearer\s+[A-Za-z0-9._-]{12,}'; confidence = 'high' },
    @{ category = 'CLOUD_CREDENTIAL'; pattern = '\b(?:AKIA|ASIA)[A-Z0-9]{16}\b'; confidence = 'high' },
    @{ category = 'SECRET_ASSIGNMENT'; pattern = '(?i)\b(?:api[_-]?key|secret|token|password|session|cookie)\b\s*[:=]\s*["'']?[A-Za-z0-9._/-]{12,}'; confidence = 'medium' }
  )
  foreach ($candidate in $patterns) {
    $match = [regex]::Match($Text, $candidate.pattern)
    if ($match.Success) {
      $value = $match.Value
      $preview = if ($value.Length -le 8) { '***' } else { $value.Substring(0, 4) + '…' + $value.Substring($value.Length - 2) }
      return [pscustomobject]@{ detected = $true; category = $candidate.category; path = $Path; line = $Line; redactedPreview = $preview; confidence = $candidate.confidence; reason = 'Potential credential value matched a category-specific pattern.' }
    }
  }
  [pscustomobject]@{ detected = $false; category = ''; path = $Path; line = $Line; redactedPreview = ''; confidence = ''; reason = '' }
}
