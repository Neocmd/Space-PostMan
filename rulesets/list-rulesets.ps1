param(
    [Parameter()]
    [string]$Repo = 'Neocmd/Space-PostMan'
)

$gh = Get-Command gh -ErrorAction SilentlyContinue
if (-not $gh) {
    throw 'GitHub CLI (gh) is not installed or not available in PATH.'
}

& gh api "repos/$Repo/rulesets"
if ($LASTEXITCODE -ne 0) {
    exit $LASTEXITCODE
}
