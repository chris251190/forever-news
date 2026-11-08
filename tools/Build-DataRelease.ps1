# Builds the package for an ONLINE DATA UPDATE:
#   the addon code of the last RELEASED version (git tag "released")  +  the newest ForeverNews\News.lua.
# So unreleased code on the main branch never reaches players through a data update.
#
# Prints the path of the zip as its only output (log lines go to the console via Write-Host).
# Usage: $zip = & tools\Build-DataRelease.ps1 [-OutDir path] [-Tag released]
param(
    [string]$OutDir = (Join-Path $PSScriptRoot '..\build'),
    [string]$Tag    = 'released',
    [string]$DataVersion = ''   # e.g. 0.1.7.2: written into the toc and the file name, so apps see a NEW version
)
$ErrorActionPreference = 'Stop'

$repo = (Resolve-Path (Join-Path $PSScriptRoot '..')).Path
$news = Join-Path $repo 'ForeverNews\News.lua'
if (-not (Test-Path $news)) { throw "News.lua not found: $news" }

New-Item -ItemType Directory -Force $OutDir | Out-Null
$OutDir = (Resolve-Path $OutDir).Path
$stage  = Join-Path ([IO.Path]::GetTempPath()) ("fn-data-" + [guid]::NewGuid().ToString('N'))
New-Item -ItemType Directory -Force $stage | Out-Null

try {
    # code of the released version (git writes the zip itself, so binary files like icon.png stay intact)
    $codeZip = Join-Path $stage 'code.zip'
    Push-Location $repo
    try { git archive --format=zip -o $codeZip $Tag ForeverNews } finally { Pop-Location }
    if (-not (Test-Path $codeZip)) { throw "git archive of tag '$Tag' failed" }
    $unpacked = Join-Path $stage 'unpacked'
    Expand-Archive $codeZip $unpacked

    # only what players need, with the NEW News.lua
    $pkg = Join-Path $stage 'pack\ForeverNews'
    New-Item -ItemType Directory -Force $pkg | Out-Null
    Get-ChildItem (Join-Path $unpacked 'ForeverNews') -File |
        Where-Object { $_.Extension -in '.toc', '.lua', '.png' } | Copy-Item -Destination $pkg
    Copy-Item $news (Join-Path $pkg 'News.lua') -Force

    $version = ([regex]::Match((Get-Content (Join-Path $pkg 'ForeverNews.toc') -Raw), '(?m)^## Version:\s*(\S+)')).Groups[1].Value
    if (-not $version) { throw "No '## Version:' in the toc of tag '$Tag'" }
    if ($DataVersion) {
        # a data update gets its own, higher version number (the code itself stays that of the released version)
        $tocPath = Join-Path $pkg 'ForeverNews.toc'
        $tocText = [IO.File]::ReadAllText($tocPath)
        $tocNew  = [regex]::Replace($tocText, '(?m)^## Version:\s*\S+', "## Version: $DataVersion")
        [IO.File]::WriteAllText($tocPath, $tocNew, (New-Object System.Text.UTF8Encoding $false))
        $zip = Join-Path $OutDir "ForeverNews-$DataVersion.zip"
    } else {
        $stamp = Get-Date -Format 'yyyyMMdd-HHmm'
        $zip = Join-Path $OutDir "ForeverNews-$version-data-$stamp.zip"
    }
    if (Test-Path $zip) { Remove-Item $zip -Force }
    Compress-Archive -Path $pkg -DestinationPath $zip
    Write-Host "Data package: $zip (code of $version + newest News.lua)"
    Write-Output $zip
} finally {
    Remove-Item $stage -Recurse -Force -ErrorAction SilentlyContinue
}
