# Builds a release zip of the addon: <OutDir>\ForeverNews-<version>.zip containing ForeverNews\... (without tools\).
# Packed: .toc, .lua and .png files (the .png is the icon shown in the game's AddOn list).
# Usage: powershell -File tools\Package.ps1 [-OutDir path]
param(
    [string]$OutDir = (Join-Path ([Environment]::GetFolderPath('MyDocuments')) "ForeverNews-Releases")
)
$ErrorActionPreference = "Stop"

$addonDir = (Resolve-Path (Join-Path $PSScriptRoot "..\ForeverNews")).Path
$toc      = Join-Path $addonDir "ForeverNews.toc"
$version  = ([regex]::Match((Get-Content $toc -Raw), '(?m)^## Version:\s*(\S+)')).Groups[1].Value
if (-not $version) { throw "Keine ## Version: in $toc gefunden" }

New-Item -ItemType Directory -Force $OutDir | Out-Null
$zip   = Join-Path $OutDir "ForeverNews-$version.zip"
$stage = Join-Path ([System.IO.Path]::GetTempPath()) ("ForeverNews-stage-" + [guid]::NewGuid().ToString("N"))
$pkg   = Join-Path $stage "ForeverNews"
New-Item -ItemType Directory -Force $pkg | Out-Null

# only what players need: .toc and .lua files (no tools\, no dev leftovers)
Get-ChildItem $addonDir -File | Where-Object { $_.Extension -in '.toc', '.lua', '.png' } | Copy-Item -Destination $pkg

if (Test-Path $zip) { Remove-Item $zip -Force }
Compress-Archive -Path $pkg -DestinationPath $zip
Remove-Item $stage -Recurse -Force
Write-Host "Paket gebaut: $zip"
Get-Item $zip | Select-Object Name, Length
