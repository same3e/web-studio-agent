. (Join-Path $PSScriptRoot 'Test-StudioRecord.ps1')
. (Join-Path $PSScriptRoot 'Get-SurfaceRegistry.ps1')

function Get-RecordContractRegistry {
  $root = (Resolve-Path (Join-Path $PSScriptRoot '../..')).Path
  return (Get-Content -Raw (Join-Path $root 'schemas/studio-records/record-contract-registry.json') | ConvertFrom-Json).contracts
}

function Get-StudioRequirements {
  param([Parameter(Mandatory)][string]$ProjectRoot)

  $statePath = Get-StudioRecordPath $ProjectRoot 'PROJECT_STATE.md'
  $state = Test-StudioRecord -Path $statePath -ExpectedRecordType 'project-state' -Required
  if (-not $state.valid) {
    return [pscustomobject]@{ state = $state; required = @(); surfaces = @(); productType = ''; workflowMode = ''; runnable = $false; unknownSurfaces = @() }
  }

  $data = $state.record.metadata.data
  $surfaces = @($data.surfaces)
  $surfaceRegistry = Get-SurfaceRegistry -Surface $surfaces
  if (@($surfaceRegistry.unknown).Count) {
    return [pscustomobject]@{ state = $state; required = @(); surfaces = $surfaces; productType = $data.productType; workflowMode = $data.workflowMode; runnable = $false; unknownSurfaces = @($surfaceRegistry.unknown) }
  }

  $contracts = Get-RecordContractRegistry
  $requirements = @($contracts | Where-Object { $_.baseRequirement })
  foreach ($surface in $surfaceRegistry.selected) {
    foreach ($name in @($surface.requiredRecords)) {
      $contract = @($contracts | Where-Object { $_.fileName -eq $name }) | Select-Object -First 1
      if ($null -eq $contract) {
        $requirements += [pscustomobject]@{ fileName = $name; recordType = $null }
      } else {
        $requirements += $contract
      }
    }
  }
  $deploymentScopeActive = $data.PSObject.Properties['deploymentScope'] -and $data.deploymentScope -eq 'active'
  $multipleEnvironments = $data.PSObject.Properties['environments'] -and @($data.environments).Count -gt 1
  if ($surfaces -contains 'release' -and ($deploymentScopeActive -or $multipleEnvironments)) {
    $requirements += @($contracts | Where-Object recordType -eq 'deployment-matrix')
  }
  $persistentProductionData = $data.PSObject.Properties['persistentProductionData'] -and $data.persistentProductionData -is [bool] -and $data.persistentProductionData
  if ($surfaces -contains 'operations' -and $persistentProductionData) {
    $requirements += @($contracts | Where-Object recordType -eq 'backup-recovery')
  }
  $resolvedRequirements = @($requirements | Group-Object fileName | ForEach-Object {
    $contract = $_.Group[0]
    [pscustomobject]@{ name = $contract.fileName; type = $contract.recordType; contract = $contract }
  })
  return [pscustomobject]@{ state = $state; required = $resolvedRequirements; surfaces = $surfaces; productType = $data.productType; workflowMode = $data.workflowMode; runnable = [bool]$data.runnable; unknownSurfaces = @() }
}

function Test-RequiredProjectRecords {
  param([Parameter(Mandatory)][string]$ProjectRoot)
  $requirements = Get-StudioRequirements $ProjectRoot
  $checks = @($requirements.state)
  foreach ($surface in @($requirements.unknownSurfaces)) {
    $checks += [pscustomobject]@{ valid = $false; errors = @([pscustomobject]@{ blockingReason = "UNKNOWN_SURFACE: $surface" }) }
  }
  foreach ($requirement in @($requirements.required)) {
    if ([string]::IsNullOrWhiteSpace([string]$requirement.type)) {
      $checks += [pscustomobject]@{ valid = $false; errors = @([pscustomobject]@{ blockingReason = 'REQUIRED_RECORD_UNKNOWN' }) }
      continue
    }
    $checks += Test-StudioRecord -Path (Get-StudioRecordPath $ProjectRoot $requirement.name) -ExpectedRecordType $requirement.type -Required -RequiredSurfaces $requirements.surfaces
  }
  return [pscustomobject]@{ valid = @($checks | Where-Object { -not $_.valid }).Count -eq 0; requirements = $requirements; checks = $checks; errors = @($checks | ForEach-Object errors) }
}
