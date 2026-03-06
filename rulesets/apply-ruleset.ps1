param(
    [Parameter(Mandatory = $true)]
    [ValidateSet('main', 'develop', 'main-template', 'develop-template')]
    [string]$Ruleset,

    [Parameter()]
    [string]$Repo = 'Neocmd/Space-PostMan',

    [switch]$DryRun
)

$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path

$mapping = @{
    'main' = 'main-ruleset.json'
    'develop' = 'develop-ruleset.json'
    'main-template' = 'main-ruleset.admin-bypass.template.json'
    'develop-template' = 'develop-ruleset.admin-bypass.template.json'
}

$fileName = $mapping[$Ruleset]
$filePath = Join-Path $scriptDir $fileName

if (-not (Test-Path $filePath)) {
    throw "Ruleset file not found: $filePath"
}

$gh = Get-Command gh -ErrorAction SilentlyContinue
if (-not $gh) {
    throw 'GitHub CLI (gh) is not installed or not available in PATH.'
}

Write-Host "Repository : $Repo"
Write-Host "Ruleset    : $Ruleset"
Write-Host "Payload    : $filePath"

if ($DryRun) {
    Write-Host ''
    Write-Host 'Dry run enabled. Payload content:'
    Get-Content -Path $filePath
    exit 0
}

& gh api "repos/$Repo/rulesets" --method POST --input $filePath
if ($LASTEXITCODE -ne 0) {
    exit $LASTEXITCODE
}
