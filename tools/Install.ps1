# Copies the addon from this repository into the game folder (for testing). Only touches the ForeverNews addon folder.
# Note: the CurseForge app may later overwrite it with the released version - that is normal.
# Usage: powershell -File tools\Install.ps1
param(
    [string]$GameAddon = 'C:\Program Files (x86)\World of Warcraft\_forever_\Interface\AddOns\ForeverNews'
)
$ErrorActionPreference = 'Stop'
$src = (Resolve-Path (Join-Path $PSScriptRoot '..\ForeverNews')).Path
New-Item -ItemType Directory -Force $GameAddon | Out-Null
Get-ChildItem $src -File | Where-Object { $_.Extension -in '.toc', '.lua', '.png' } | Copy-Item -Destination $GameAddon -Force
$v = ([regex]::Match((Get-Content (Join-Path $GameAddon 'ForeverNews.toc') -Raw), '(?m)^## Version:\s*(\S+)')).Groups[1].Value
Write-Host "Installed version $v to $GameAddon. In game: /reload"
