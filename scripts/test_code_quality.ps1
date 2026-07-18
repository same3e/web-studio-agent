[CmdletBinding()]
param()

$ErrorActionPreference = 'Stop'
$root = (Resolve-Path (Join-Path $PSScriptRoot '..')).Path
Set-Location $root
$failures = [System.Collections.Generic.List[string]]::new()
function Assert-True([bool]$Condition, [string]$Message) { if (-not $Condition) { $script:failures.Add($Message) } }
function Read-Utf8([string]$Path) { Get-Content -Raw -LiteralPath $Path -Encoding utf8 }

$quality = Read-Utf8 'knowledge/engineering/CODE_QUALITY.md'
foreach ($id in 1..34) { Assert-True ($quality -match ("CQ-{0:D2}" -f $id)) "Missing canonical rule CQ-$('{0:D2}' -f $id)." }
foreach ($stack in @('TYPESCRIPT','REACT','NEXTJS','NODE','PYTHON')) { Assert-True (Test-Path "knowledge/engineering/stacks/$stack.md") "Missing applicable stack module $stack." }
$index = Read-Utf8 'knowledge/KNOWLEDGE_INDEX.md'
Assert-True ($index -match 'CODE_QUALITY.md' -and $index -match 'TypeScript is detected and approved') 'Knowledge routing does not bound code-quality stack modules.'

$contracts = @('frontend-builder','backend-builder','database-architect','integration-builder','refactor-engineer','test-engineer','code-reviewer')
foreach ($role in $contracts) { Assert-True ((Read-Utf8 "specialists/contracts/$role.md") -match 'CODE_QUALITY.md') "Contract does not load canonical code quality: $role." }
$review = Read-Utf8 'specialists/contracts/code-reviewer.md'
foreach ($field in @('Rule ID','Affected file and location','User or system impact','Runtime evidence needed')) { Assert-True ($review -match [regex]::Escape($field)) "Code-review finding schema is missing $field." }
$test = Read-Utf8 'specialists/contracts/test-engineer.md'
Assert-True ($test -match 'readability, architecture, or visual quality') 'Test engineer does not bound non-testable quality claims.'
$refactor = Read-Utf8 'specialists/contracts/refactor-engineer.md'
Assert-True ($refactor -match 'violated rule IDs' -and $refactor -match 'remaining debt') 'Refactor contract omits rule IDs or remaining debt.'

# Structural/state-machine fixture catalog. These cases exercise precedence and report-schema
# policy; they intentionally do not pretend to lint every language or execute a project runtime.
function Resolve-FixtureOutcome($Fixture) {
  if ($Fixture.missingRuleId) { return 'blocked' }
  if ($Fixture.strength -eq 'hard') { return 'blocked' }
  if ($Fixture.repositoryConvention -and $Fixture.strength -eq 'default') { return 'allowed' }
  return 'review'
}
$fixtures = @(
  @{ name='feature mixed with unrelated refactor'; rule='CQ-03'; strength='hard'; expected='blocked' },
  @{ name='new dependency without justification'; rule='CQ-23'; strength='hard'; expected='blocked' },
  @{ name='duplicated external contract'; rule='CQ-15'; strength='default'; expected='review' },
  @{ name='unsafe runtime input trusted through static typing'; rule='CQ-12'; strength='hard'; expected='blocked' },
  @{ name='swallowed error'; rule='CQ-20'; strength='hard'; expected='blocked' },
  @{ name='debug logging of a secret'; rule='CQ-22'; strength='hard'; expected='blocked' },
  @{ name='UI directly accessing privileged persistence'; rule='CQ-08'; strength='hard'; expected='blocked' },
  @{ name='derived state stored unnecessarily'; rule='CQ-16'; strength='default'; expected='review' },
  @{ name='effect-based synchronization loop'; rule='RE-02'; strength='default'; expected='review' },
  @{ name='server route mixes transport business persistence provider'; rule='CQ-06'; strength='hard'; expected='blocked' },
  @{ name='bug fix without regression coverage'; rule='CQ-25'; strength='hard'; expected='blocked' },
  @{ name='static inspection mislabeled runtime test'; rule='CQ-27'; strength='hard'; expected='blocked' },
  @{ name='code-review finding without rule ID'; rule='schema'; missingRuleId=$true; expected='blocked' },
  @{ name='approved repository convention overrides global default'; rule='precedence'; strength='default'; repositoryConvention=$true; expected='allowed' },
  @{ name='security rule overridden by style convenience'; rule='CQ-29'; strength='hard'; repositoryConvention=$true; expected='blocked' }
)
foreach ($fixture in $fixtures) { Assert-True ((Resolve-FixtureOutcome $fixture) -eq $fixture.expected) "Fixture policy outcome is wrong: $($fixture.name)." }

$templates = @('TECH_DECISION','IMPLEMENTATION_PLAN','BUILD_REPORT','VERIFICATION_REPORT')
foreach ($template in $templates) { Assert-True ((Read-Utf8 "templates/studio/$template.template.md") -match '(?i)(code-quality|validation commands|applicable modules)') "Project template lacks code-quality evidence: $template." }
if ($failures.Count) { $failures | ForEach-Object { Write-Error $_ }; exit 1 }
Write-Host 'Code-quality fixtures passed: structural/state-machine policy checks only; no fixture claims a universal lint or runtime proof.'
