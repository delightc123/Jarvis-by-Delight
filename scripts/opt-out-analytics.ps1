<#
.SYNOPSIS
    Opt-out helper script: sets [analytics] enabled = false in ~/.openjarvis/config.toml.
#>

[CmdletBinding()]
param()

$configDir = Join-Path $HOME '.openjarvis'
$configFile = Join-Path $configDir 'config.toml'

if (-not (Test-Path $configDir)) {
    New-Item -ItemType Directory -Path $configDir -Force | Out-Null
}

if (-not (Test-Path $configFile)) {
    $initialContent = @"
# Jarvis configuration
[analytics]
enabled = false
"@
    Set-Content -Path $configFile -Value $initialContent -Encoding UTF8
    Write-Host "[ok] Created $configFile with [analytics] enabled = false" -ForegroundColor Green
    exit 0
}

$raw = Get-Content -Path $configFile -Raw -Encoding UTF8

if ($raw -match '(?ms)\[analytics\].*?enabled\s*=\s*(true|false)') {
    $updated = $raw -replace '(?m)(?<=\[analytics\][\s\S]*?enabled\s*=\s*)true', 'false'
    Set-Content -Path $configFile -Value $updated -Encoding UTF8
    Write-Host "[ok] Updated [analytics] enabled = false in $configFile" -ForegroundColor Green
} elseif ($raw -match '\[analytics\]') {
    $updated = $raw -replace '\[analytics\]', "[analytics]`nenabled = false"
    Set-Content -Path $configFile -Value $updated -Encoding UTF8
    Write-Host "[ok] Added enabled = false under [analytics] in $configFile" -ForegroundColor Green
} else {
    $addition = @"

[analytics]
enabled = false
"@
    Add-Content -Path $configFile -Value $addition -Encoding UTF8
    Write-Host "[ok] Appended [analytics] enabled = false to $configFile" -ForegroundColor Green
}
