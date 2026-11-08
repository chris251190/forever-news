# Uploads the current addon version to CurseForge (project 1788357).
#
# SAFE BY DEFAULT: without -Upload this is a dry run (nothing is sent except read-only lookups).
# Only run with -Upload when the user has explicitly approved this release.
#
# Token: environment variable CURSEFORGE_API_TOKEN (user scope is read directly, a restart is not needed).
# The token is never printed.
#
# Usage:
#   powershell -File tools\Upload.ps1                                   # dry run
#   powershell -File tools\Upload.ps1 -ReleaseType beta -ChangelogFile CHANGELOG.md -Upload
param(
    [ValidateSet('release', 'beta', 'alpha')][string]$ReleaseType = 'release',
    [string]$ChangelogFile = '',
    [string]$Changelog = '',
    [string]$GameVersionName = '',          # default: newest version of the "WoW Forever" game version type
    [switch]$ManualRelease,                 # CurseForge: publish manually after approval
    [switch]$Force,                         # allow re-uploading a version that is already recorded
    [string]$PackagePath = '',              # upload this ready-made zip (used by the online data update; skips uploaded.json)
    [string]$DisplayName = '',              # file name shown on CurseForge (default: "Forever News <version>")
    [switch]$Upload
)
$ErrorActionPreference = 'Stop'

$ProjectId = 1788357
$Api       = 'https://wow.curseforge.com/api'
$TypeName  = 'WoW Forever'

$repoDir  = (Resolve-Path (Join-Path $PSScriptRoot '..')).Path
$addonDir = Join-Path $repoDir 'ForeverNews'
$toc      = Join-Path $addonDir 'ForeverNews.toc'
$version  = ([regex]::Match((Get-Content $toc -Raw), '(?m)^## Version:\s*(\S+)')).Groups[1].Value
if (-not $version) { throw "No '## Version:' in $toc" }

$token = $env:CURSEFORGE_API_TOKEN
if (-not $token) { $token = [Environment]::GetEnvironmentVariable('CURSEFORGE_API_TOKEN', 'User') }
if (-not $token) { throw 'CURSEFORGE_API_TOKEN is not set (setx CURSEFORGE_API_TOKEN "<token>")' }
$hdr = @{ 'X-Api-Token' = $token }

# ---- package
$stateFile = Join-Path $PSScriptRoot 'uploaded.json'
$state = @{}
if ($PackagePath) {
    # ready-made package (online data update): no rebuild, no version bookkeeping
    $zip = (Resolve-Path $PackagePath).Path
} else {
    # always rebuild so the zip matches the files on disk
    $outDir = Join-Path ([Environment]::GetFolderPath('MyDocuments')) 'ForeverNews-Releases'
    & powershell -NoProfile -ExecutionPolicy Bypass -File (Join-Path $PSScriptRoot 'Package.ps1') -OutDir $outDir | Out-Null
    $zip = Join-Path $outDir "ForeverNews-$version.zip"
    if (-not (Test-Path $zip)) { throw "Package not found: $zip" }

    # ---- already uploaded?
    if (Test-Path $stateFile) { (Get-Content $stateFile -Raw | ConvertFrom-Json).PSObject.Properties | ForEach-Object { $state[$_.Name] = $_.Value } }
    if ($state.ContainsKey($version) -and -not $Force) {
        throw "Version $version was already uploaded ($($state[$version])). Bump '## Version:' in the .toc or use -Force."
    }
}

# ---- game version id (read-only lookup)
# Windows PowerShell 5.1 returns a JSON array as ONE object; unroll it explicitly.
$rawTypes = Invoke-RestMethod -Uri "$Api/game/version-types" -Headers $hdr -TimeoutSec 30
$types    = @(foreach ($t in $rawTypes) { $t })
$type  = $types | Where-Object { $_.name -eq $TypeName } | Select-Object -First 1
if (-not $type) { throw "Game version type '$TypeName' not found" }
$rawVers = Invoke-RestMethod -Uri "$Api/game/versions" -Headers $hdr -TimeoutSec 30
$allVers = @(foreach ($v in $rawVers) { $v })
# default name comes from the .toc Interface number: 16001 -> 1.60.1
if (-not $GameVersionName) {
    $iface = [int]([regex]::Match((Get-Content $toc -Raw), '(?m)^## Interface:\s*(\d+)').Groups[1].Value)
    if (-not $iface) { throw "No '## Interface:' in $toc" }
    $GameVersionName = '{0}.{1}.{2}' -f [math]::Floor($iface / 10000), ([math]::Floor($iface / 100) % 100), ($iface % 100)
}
$gv = $allVers | Where-Object { $_.name -eq $GameVersionName -and [int]$_.gameVersionTypeID -eq [int]$type.id } | Select-Object -First 1
if (-not $gv) { throw "Game version '$GameVersionName' not found in type '$TypeName'. Pass -GameVersionName if Forever moved to a newer client version." }

# ---- changelog
if ($ChangelogFile) { $Changelog = Get-Content (Join-Path $repoDir $ChangelogFile) -Raw -Encoding UTF8 }
if (-not $Changelog) { $Changelog = "Release $version" }

$metadata = [ordered]@{
    changelog     = $Changelog
    changelogType = 'markdown'
    displayName   = $(if ($DisplayName) { $DisplayName } else { "Forever News $version" })
    gameVersions  = @([int]$gv.id)
    releaseType   = $ReleaseType
}
if ($ManualRelease) { $metadata['isMarkedForManualRelease'] = $true }
$json = $metadata | ConvertTo-Json -Depth 5 -Compress

Write-Host "Project:      $ProjectId"
Write-Host "File:         $zip ($([math]::Round((Get-Item $zip).Length / 1KB, 1)) KB)"
Write-Host "Display name: $($metadata.displayName)"
Write-Host "Game version: $($gv.name) (id $($gv.id), type $TypeName)"
Write-Host "Release type: $ReleaseType$(if ($ManualRelease) { ', manual release after approval' })"
Write-Host "Changelog:    $(($Changelog -replace '\s+', ' ').Substring(0, [Math]::Min(100, ($Changelog -replace '\s+', ' ').Length)))..."

if (-not $Upload) { Write-Host "`nDRY RUN - nothing was uploaded. Add -Upload after the user approved this release."; return }

# ---- upload (multipart: metadata + file)
Add-Type -AssemblyName System.Net.Http
$client = New-Object System.Net.Http.HttpClient
$client.DefaultRequestHeaders.Add('X-Api-Token', $token)
$form = New-Object System.Net.Http.MultipartFormDataContent
$form.Add((New-Object System.Net.Http.StringContent($json, [System.Text.Encoding]::UTF8)), 'metadata')
$fs = [System.IO.File]::OpenRead($zip)
$fileContent = New-Object System.Net.Http.StreamContent($fs)
$fileContent.Headers.ContentType = [System.Net.Http.Headers.MediaTypeHeaderValue]::Parse('application/zip')
$form.Add($fileContent, 'file', [System.IO.Path]::GetFileName($zip))
try {
    $resp = $client.PostAsync("$Api/projects/$ProjectId/upload-file", $form).GetAwaiter().GetResult()
    $body = $resp.Content.ReadAsStringAsync().GetAwaiter().GetResult()
} finally { $fs.Dispose(); $client.Dispose() }
if (-not $resp.IsSuccessStatusCode) { throw "Upload failed: HTTP $([int]$resp.StatusCode) $body" }

if (-not $PackagePath) {
    $state[$version] = "uploaded $(Get-Date -Format 'yyyy-MM-dd HH:mm') via API, response $body"
    ($state | ConvertTo-Json) | Set-Content $stateFile -Encoding UTF8
}
Write-Host "Uploaded $version. Response: $body"
