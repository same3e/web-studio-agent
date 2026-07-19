$ErrorActionPreference = 'Stop'
$root = (Resolve-Path (Join-Path $PSScriptRoot '..')).Path
. (Join-Path $root 'scripts/records/Test-StudioRecord.ps1')
. (Join-Path $root 'scripts/records/Get-SurfaceRegistry.ps1')
. (Join-Path $root 'tests/helpers/TypedStudioFixture.ps1')

function Fail-Integrity {
  param([string]$Code, [string]$Detail)
  throw "${Code}: $Detail"
}

function Get-ValidatorFileName {
  param([string]$RecordType)
  $pascal = ($RecordType -split '-' | ForEach-Object { $_.Substring(0, 1).ToUpperInvariant() + $_.Substring(1) }) -join ''
  return "Test-$pascal`Record.ps1"
}

$registryPath = Join-Path $root 'schemas/studio-records/record-contract-registry.json'
$registry = Get-Content -Raw $registryPath | ConvertFrom-Json
$contracts = @($registry.contracts | Where-Object runtimeEnforced)
if ($contracts.Count -eq 0) { Fail-Integrity 'REQUIRED_RECORD_UNKNOWN' 'No runtime-enforced contracts were registered.' }

$fixtureRoot = Join-Path ([IO.Path]::GetTempPath()) ('record-integrity-' + [guid]::NewGuid().ToString('N'))
New-Item -ItemType Directory -Force -Path (Join-Path $fixtureRoot '.studio') | Out-Null
try {
  foreach ($contract in $contracts) {
    $schemaPath = Join-Path $root $contract.schemaPath
    if (-not (Test-Path -LiteralPath $schemaPath)) { Fail-Integrity 'SCHEMA_MISSING' $contract.recordType }
    try { $schema = Get-Content -Raw $schemaPath | ConvertFrom-Json } catch { Fail-Integrity 'SCHEMA_MISSING' "$($contract.recordType): invalid JSON" }
    $templatePath = Join-Path $root $contract.templatePath
    if (-not (Test-Path -LiteralPath $templatePath)) { Fail-Integrity 'TEMPLATE_MISSING' $contract.recordType }
    $template = Read-StudioRecord -Path $templatePath
    if ($null -eq $template.metadata -or $template.metadata.recordType -ne $contract.recordType -or $template.metadata.schemaVersion -ne 1) { Fail-Integrity 'TEMPLATE_RECORD_TYPE_MISMATCH' $contract.recordType }
    $validatorFile = Join-Path $root ('scripts/records/validators/' + (Get-ValidatorFileName $contract.validatorId))
    if (-not (Test-Path -LiteralPath $validatorFile) -or $null -eq (Get-StudioValidatorRules $contract.validatorId)) { Fail-Integrity 'VALIDATOR_MISSING' $contract.recordType }
    $requiredFields = @($schema.allOf[1].properties.data.required)
    $coverage = Get-StudioValidatorContract $contract.validatorId
    foreach ($field in $requiredFields) {
      if ($field -notin @($coverage.CoveredDataFields) -and $field -notin @($coverage.ConditionalDataFields)) { Fail-Integrity 'SCHEMA_FIELD_NOT_ENFORCED' "$($contract.recordType).$field" }
    }
    Write-TypedStudioRecord $fixtureRoot $contract.fileName $contract.recordType @{} -Surfaces @('frontend-visible')
    $empty = Test-StudioRecord -Path (Join-Path $fixtureRoot ('.studio/' + $contract.fileName)) -ExpectedRecordType $contract.recordType -Required -RequiredSurfaces @('frontend-visible')
    if ($empty.valid) { Fail-Integrity 'ENVELOPE_ONLY_REQUIRED_RECORD' $contract.recordType }
    Write-TypedStudioRecord $fixtureRoot $contract.fileName $contract.recordType (New-ValidStudioRecordData $contract.recordType) -Surfaces @('frontend-visible')
    $valid = Test-StudioRecord -Path (Join-Path $fixtureRoot ('.studio/' + $contract.fileName)) -ExpectedRecordType $contract.recordType -Required -RequiredSurfaces @('frontend-visible')
    if (-not $valid.valid) { Fail-Integrity 'VALIDATOR_MISSING' "$($contract.recordType): valid fixture rejected ($(@($valid.errors.blockingReason) -join ', '))" }
  }
  $contractsByFile = @{}
  foreach ($contract in $contracts) { $contractsByFile[$contract.fileName] = $contract }
  foreach ($surface in (Get-SurfaceRegistry).surfaces) {
    foreach ($fileName in @($surface.requiredRecords)) { if (-not $contractsByFile.ContainsKey($fileName)) { Fail-Integrity 'REQUIRED_RECORD_UNKNOWN' $fileName } }
  }
  $specialistRegistry = Get-Content -Raw (Join-Path $root 'specialists/SPECIALIST_REGISTRY.json') | ConvertFrom-Json
  foreach ($specialist in @($specialistRegistry.specialists)) {
    foreach ($property in @($specialist.PSObject.Properties.Name)) {
      $policy = $specialistRegistry.fieldPolicy.$property
      if ($policy -notin @('runtime', 'advisory', 'deprecated')) { Fail-Integrity 'REGISTRY_FIELD_POLICY_UNKNOWN' "$($specialist.id).$property" }
    }
    if ($specialist.mode -eq 'write' -and $specialist.requiresAssignedWritePaths -eq $false -and -not $specialist.noAssignedWritePathsReason) { Fail-Integrity 'REGISTRY_FIELD_POLICY_UNKNOWN' "$($specialist.id).noAssignedWritePathsReason" }
    if ($specialist.mode -eq 'read' -and $specialist.requiresAssignedWritePaths) { Fail-Integrity 'REGISTRY_FIELD_POLICY_UNKNOWN' "$($specialist.id).requiresAssignedWritePaths" }
  }
  Write-TypedStudioRecord $fixtureRoot 'BOM.md' 'technical-decision' (New-ValidStudioRecordData 'technical-decision') -WithBom
  $withBom = Read-StudioRecord -Path (Join-Path $fixtureRoot '.studio/BOM.md')
  Write-TypedStudioRecord $fixtureRoot 'NoBOM.md' 'technical-decision' (New-ValidStudioRecordData 'technical-decision')
  $withoutBom = Read-StudioRecord -Path (Join-Path $fixtureRoot '.studio/NoBOM.md')
  if ($null -eq $withBom.metadata -or $null -eq $withoutBom.metadata -or $withBom.metadata.recordType -ne $withoutBom.metadata.recordType -or $withBom.body -ne $withoutBom.body) { Fail-Integrity 'TEMPLATE_RECORD_TYPE_MISMATCH' 'UTF-8 BOM parser parity' }
} finally {
  if (Test-Path -LiteralPath $fixtureRoot) { Remove-Item -LiteralPath $fixtureRoot -Recurse -Force }
}
Write-Output "Record contract integrity passed: $($contracts.Count) runtime-enforced contracts; UTF-8 BOM parser parity verified."
