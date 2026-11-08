# Fetches WoW Forever PATCH NOTES from Blizzard and writes ForeverNews\News.lua.
# Sources:
#   1. Blizzard forum thread "WoW Forever Beta Development Notes" (one dated post = one patch)
#   2. Blizzard news articles whose slug contains "forever" and "hotfix" or "patch-notes"
# Notes are split into sections (group / class / spec) so the addon can filter by class.
#
# Usage:  powershell -File tools\Update-News.ps1 [-Locale en-us] [-OutFile path\to\News.lua]
param(
    [string]$Locale    = "en-us",
    [string]$ThreadUrl = "https://us.forums.blizzard.com/en/wow/t/wow-forever-beta-development-notes/2360696",
    [string]$OutFile   = "",
    [string[]]$Authors = @("Kaivax"),     # forum accounts whose posts count as official notes
    [int]$ForumDays    = 21               # how far back to look for staff announcements
)

$ErrorActionPreference = "Stop"
# Default: News.lua next to the addon (this script lives in <addon>\tools\).
if (-not $OutFile) { $OutFile = Join-Path $PSScriptRoot "..\ForeverNews\News.lua" }
# If this copy is not already inside the game folder, also update the installed addon there.
$GameAddon = "C:\Program Files (x86)\World of Warcraft\_forever_\Interface\AddOns\ForeverNews"
$newsBase = "https://worldofwarcraft.blizzard.com/$Locale/news"

$ClassNames = @('Druid','Hunter','Mage','Paladin','Priest','Rogue','Shaman','Warlock','Warrior')
$ClassRegex = '^(' + ($ClassNames -join '|') + ')\b'
$Months     = 'January|February|March|April|May|June|July|August|September|October|November|December'

function Get-Html([string]$url) {
    # Windows PowerShell 5.1 decodes as Latin-1 by default -> read raw bytes as UTF-8
    $r  = Invoke-WebRequest -Uri $url -UseBasicParsing -TimeoutSec 30
    $ms = New-Object System.IO.MemoryStream
    $r.RawContentStream.CopyTo($ms)
    return [System.Text.Encoding]::UTF8.GetString($ms.ToArray())
}

function Norm([string]$s) {
    $s = [System.Net.WebUtility]::HtmlDecode($s)
    $s = $s -replace [char]0x00A0, ' '
    return ([regex]::Replace($s, '\s+', ' ')).Trim()
}

function ConvertTo-LuaString([string]$s) {
    $s = $s.Replace('\', '\\').Replace('"', '\"').Replace("`r", '').Replace("`n", '\n').Replace("`t", ' ')
    return '"' + $s + '"'
}

# Parses nested <ul>/<li><strong>Heading</strong> structures and <p><strong>Heading</strong> blocks
# into a flat list of sections: @{ g; c; s; lines }
function ConvertFrom-NotesHtml([string]$html, [bool]$announce = $false) {
    $sections  = New-Object System.Collections.ArrayList
    $stack     = New-Object System.Collections.ArrayList   # open <li> frames
    $names     = New-Object System.Collections.ArrayList   # current heading path
    # $announce: short staff announcements - keep plain paragraphs and file lines by class mention
    $state     = @{ pStrong = ''; pPlain = ''; sdP = 0; dateLabel = ''; maxDate = $null; last = $null; byMention = $announce; keepParas = $announce }

    function Get-Key {
        $group = ''; $class = ''; $sub = @()
        foreach ($n in $names) {
            if ($n -match ($ClassRegex + '$')) { $class = $n.ToUpper(); $sub = @() }
            elseif ($class -eq '' -and $group -eq '') { $group = $n }
            else { $sub += $n }
        }
        if ($state.dateLabel -ne '') { $sub += $state.dateLabel }
        return @{ g = $group; c = $class; s = ($sub -join ' / ') }
    }

    function Add-Line([string]$text, [int]$indent) {
        if ($text -eq '') { return }
        $k = Get-Key
        if ($k.g -match 'Known Issues') { return }   # bug lists are not patch notes
        $classes = @($k.c)
        if ($k.c -eq '') {
            if ($state.byMention) {
                # announcements have no headings: file a line under every class it mentions
                # only classes named near the start of the line ("Hunter pets and Warlock Voidwalkers ..."),
                # not later side mentions ("... gear intended for Mages and Warlocks")
                $found = @([regex]::Matches($text, '\b(Druid|Hunter|Mage|Paladin|Priest|Rogue|Shaman|Warlock|Warrior)s?\b') |
                    Where-Object { $_.Index -lt 80 } |
                    ForEach-Object { $_.Groups[1].Value.ToUpper() } | Select-Object -Unique)
                if ($found.Count -gt 0) { $classes = $found }
            } elseif ($text -match ($ClassRegex + '\s*[-:]\s')) {
                $classes = @($Matches[1].ToUpper())
            }
        }
        foreach ($c in $classes) {
            $sec = $sections | Where-Object { $_.g -eq $k.g -and $_.c -eq $c -and $_.s -eq $k.s } | Select-Object -First 1
            if ($null -eq $sec) {
                $sec = [pscustomobject]@{ g = $k.g; c = $c; s = $k.s; lines = (New-Object System.Collections.ArrayList) }
                [void]$sections.Add($sec)
            }
            [void]$sec.lines.Add((' ' * (2 * $indent)) + $text)
        }
    }

    function Get-Indent {
        $n = 0
        for ($i = 0; $i -lt $stack.Count - 1; $i++) { if ($stack[$i].counts) { $n++ } }
        return $n
    }

    # any tag is tokenised (unknown ones such as <em>, <a>, <span> are simply ignored by the switch below)
    $tokens = [regex]::Matches($html, '<(/?)([a-zA-Z][a-zA-Z0-9]*)\b[^>]*>|([^<]+)')
    foreach ($tk in $tokens) {
        if ($tk.Groups[3].Success) {
            $t = $tk.Groups[3].Value
            if ($stack.Count -gt 0) {
                $f = $stack[$stack.Count - 1]
                if ($f.sd -gt 0) { $f.strong += $t } else { $f.plain += $t }
            } else {
                if ($state.sdP -gt 0) { $state.pStrong += $t } else { $state.pPlain += $t }
            }
            continue
        }
        $close = ($tk.Groups[1].Value -eq '/')
        $tag   = $tk.Groups[2].Value.ToLower()
        switch -Regex ($tag) {
            '^li$' {
                if (-not $close) {
                    [void]$stack.Add(@{ plain = ''; strong = ''; sd = 0; isHeading = $false; emitted = $false; counts = $false })
                } elseif ($stack.Count -gt 0) {
                    $f = $stack[$stack.Count - 1]
                    if (-not $f.emitted) {
                        $txt = Norm ($f.strong + ' ' + $f.plain)
                        $f.counts = ($txt -ne '')
                        Add-Line $txt (Get-Indent)
                    }
                    $stack.RemoveAt($stack.Count - 1)
                    if ($f.isHeading -and $names.Count -gt 0) { $names.RemoveAt($names.Count - 1) }
                }
            }
            '^(ul|ol)$' {
                if (-not $close -and $stack.Count -gt 0) {
                    $f = $stack[$stack.Count - 1]
                    if (-not $f.emitted) {
                        $s = Norm $f.strong; $p = Norm $f.plain
                        if ($s -ne '' -and $p -eq '') {
                            $f.isHeading = $true
                            [void]$names.Add($s)
                        } elseif ($s -ne '' -or $p -ne '') {
                            $f.counts = $true
                            Add-Line (Norm ($s + ' ' + $p)) (Get-Indent)
                        }
                        $f.emitted = $true
                    }
                }
            }
            '^(strong|b)$' {
                if ($stack.Count -gt 0) {
                    $f = $stack[$stack.Count - 1]
                    if ($close) { if ($f.sd -gt 0) { $f.sd-- } } else { $f.sd++ }
                } else {
                    if ($close) { if ($state.sdP -gt 0) { $state.sdP-- } } else { $state.sdP++ }
                }
            }
            '^(p|h[1-6])$' {
                if ($stack.Count -eq 0) {
                    if (-not $close) {
                        $state.pStrong = ''; $state.pPlain = ''; $state.sdP = 0
                    } else {
                        $ps = Norm $state.pStrong; $pp = Norm $state.pPlain
                        # a bold-only paragraph is a heading, unless it is a long announcement sentence
                        if ($ps -ne '' -and $pp -eq '' -and ($ps.Length -lt 60 -or -not $state.keepParas)) {
                            if ($ps -match ('^(' + $Months + ') \d{1,2}, \d{4}$')) {
                                $state.dateLabel = $ps
                                $names.Clear()
                                $d = [datetime]::ParseExact($ps, 'MMMM d, yyyy', [System.Globalization.CultureInfo]::InvariantCulture)
                                if ($null -eq $state.maxDate -or $d -gt $state.maxDate) { $state.maxDate = $d }
                            } else {
                                $names.Clear(); [void]$names.Add($ps)
                            }
                        } elseif ($state.keepParas -and $tag -eq 'p' -and ($ps + $pp) -ne '') {
                            Add-Line (Norm ($ps + ' ' + $pp)) 0
                        }
                    }
                }
            }
        }
    }
    return @{ sections = $sections; maxDate = $state.maxDate }
}

function Get-LineCount($sections) {
    $n = 0; foreach ($s in $sections) { $n += $s.lines.Count }; return $n
}

# returns the substring of the first balanced <ul> ... </ul>
function Get-FirstList([string]$html) {
    $start = $html.IndexOf('<ul')
    if ($start -lt 0) { return '' }
    $depth = 0
    foreach ($m in [regex]::Matches($html.Substring($start), '<(/?)ul\b[^>]*>')) {
        if ($m.Groups[1].Value -eq '/') { $depth-- } else { $depth++ }
        if ($depth -eq 0) { return $html.Substring($start, $m.Index + $m.Length) }
    }
    return $html.Substring($start)
}

$entries = New-Object System.Collections.ArrayList

# ---------------------------------------------------------------- 1. forum development notes
Write-Host "Forum-Thread: $ThreadUrl"
try {
    $thread = Get-Html $ThreadUrl
    # The forum renders each post as <div id='post_N' ...> ... itemprop="datePublished" datetime='...' ... <div class='post' itemprop="text"> body
    $starts = [regex]::Matches($thread, "<div id='post_\d+'")
    for ($i = 0; $i -lt $starts.Count; $i++) {
        $to   = if ($i + 1 -lt $starts.Count) { $starts[$i + 1].Index } else { $thread.Length }
        $post = $thread.Substring($starts[$i].Index, $to - $starts[$i].Index)
        $author = [regex]::Match($post, 'itemprop="name">([^<]+)<').Groups[1].Value
        $iso    = [regex]::Match($post, "datePublished""\s+datetime='(\d{4}-\d{2}-\d{2})").Groups[1].Value
        $pos    = [regex]::Match($post, 'itemprop="position">(\d+)<').Groups[1].Value
        $bodyAt = $post.IndexOf('itemprop="text">')
        if ($bodyAt -lt 0 -or -not $iso) { continue }
        if ($Authors -notcontains $author) { continue }
        $parsed = ConvertFrom-NotesHtml $post.Substring($bodyAt)
        $hasClasses = @($parsed.sections | Where-Object { $_.c -ne '' }).Count -gt 0
        $count = Get-LineCount $parsed.sections
        if (-not $hasClasses -and $count -lt 8) { Write-Host "  uebersprungen (#$pos, $iso): $count Zeilen, keine Klassen"; continue }
        $d = [datetime]::ParseExact($iso, 'yyyy-MM-dd', [System.Globalization.CultureInfo]::InvariantCulture)
        Write-Host ("  Patch {0} (#{1}): {2} Abschnitte, {3} Zeilen" -f $iso, $pos, $parsed.sections.Count, $count)
        [void]$entries.Add([pscustomobject]@{
            Id = [int]("$($d.ToString('yyyyMMdd'))") * 100 + [int]$pos
            Title = "Patch Notes - " + $d.ToString('MMMM d, yyyy', [System.Globalization.CultureInfo]::InvariantCulture)
            Date = $iso; Cat = 'Patch Notes'; Url = "$ThreadUrl/$pos"; Sections = $parsed.sections })
    }
} catch { Write-Warning "Forum-Thread nicht lesbar: $_" }

# ---------------------------------------------------------------- 2. news articles: hotfixes / patch notes
Write-Host "News: $newsBase"
$list = Get-Html $newsBase
$links = [regex]::Matches($list, 'news/(\d{6,})/([a-z0-9\-]+)') |
    ForEach-Object { [pscustomobject]@{ Id = [int]$_.Groups[1].Value; Slug = $_.Groups[2].Value } } |
    Sort-Object Id -Unique -Descending |
    Where-Object { $_.Slug -match 'forever' -and $_.Slug -match 'hotfix|patch' }
foreach ($l in $links) {
    $url = "$newsBase/$($l.Id)/$($l.Slug)"
    try { $html = Get-Html $url } catch { Write-Warning "uebersprungen: $url"; continue }
    $title = [regex]::Match($html, '<meta property="og:title" content="([^"]*)"').Groups[1].Value
    $title = (Norm $title) -replace '\s+-\s+WoW$', ''
    $m = [regex]::Match($html, '(?is)<div class="detail">(.*?)</div>\s*</div>\s*</div>')
    if (-not $m.Success) { $m = [regex]::Match($html, '(?is)<div class="detail">(.*)') }
    $parsed = ConvertFrom-NotesHtml $m.Groups[1].Value
    $pub = [regex]::Match($html, '"datePublished":"(\d{4}-\d{2}-\d{2})').Groups[1].Value
    $date = if ($parsed.maxDate) { $parsed.maxDate.ToString('yyyy-MM-dd') } else { $pub }
    $cat  = if ($l.Slug -match 'hotfix') { 'Hotfixes' } else { 'Patch Notes' }
    Write-Host ("  {0}: {1} Abschnitte, {2} Zeilen ({3})" -f $title, $parsed.sections.Count, (Get-LineCount $parsed.sections), $date)
    [void]$entries.Add([pscustomobject]@{ Id = $l.Id; Title = $title; Date = $date; Cat = $cat; Url = $url; Sections = $parsed.sections })
}

# ---------------------------------------------------------------- 3. staff announcements (forum topics started by Blizzard staff)
# e.g. "Class Tuning Incoming - November 10": its own forum topic, not part of the notes thread or the news site.
Write-Host "Forum-Ankuendigungen von: $($Authors -join ', ')"
try {
    $forumRoot = ($ThreadUrl -replace '/t/.*$', '')
    $devThreadId = [int]([regex]::Match($ThreadUrl, '/(\d+)/?$').Groups[1].Value)
    $since = (Get-Date).AddDays(-$ForumDays).ToString('yyyy-MM-dd')
    $hdr = @{ Accept = 'application/json' }
    foreach ($a in $Authors) {
        $q   = [uri]::EscapeDataString("@$a after:$since order:latest")
        $res = Invoke-RestMethod -Uri "$forumRoot/search.json?q=$q" -TimeoutSec 30 -Headers $hdr
        $titles = @{}; foreach ($t in $res.topics) { $titles[[int]$t.id] = $t.title }
        foreach ($p in $res.posts) {
            if ($p.username -ne $a -or $p.post_number -ne 1) { continue }   # only topics the staff member started
            $tid = [int]$p.topic_id
            if ($tid -eq $devThreadId) { continue }
            $title = $titles[$tid]
            if ($title -notmatch 'Class|Tuning|Hotfix|Patch|Notes|Update|Balance|Changes') { continue }
            if ($title -match 'Known Issues') { continue }   # bug lists are not patch notes
            if (@($entries | Where-Object { $_.Title -eq $title }).Count -gt 0) { continue }   # already covered (e.g. hotfix article)
            $topic = Invoke-RestMethod -Uri "$forumRoot/t/$tid.json" -TimeoutSec 30 -Headers $hdr
            $first = $topic.post_stream.posts[0]
            $parsed = ConvertFrom-NotesHtml $first.cooked $true
            $count = Get-LineCount $parsed.sections
            if ($count -eq 0) { continue }
            $when = [datetime]::Parse($first.updated_at, [System.Globalization.CultureInfo]::InvariantCulture, [System.Globalization.DateTimeStyles]::AdjustToUniversal).ToString('yyyy-MM-dd')
            Write-Host ("  Ankuendigung {0}: {1} Abschnitte, {2} Zeilen ({3})" -f $title, $parsed.sections.Count, $count, $when)
            [void]$entries.Add([pscustomobject]@{ Id = $tid; Title = $title; Date = $when; Cat = 'Announcement'; Url = "$forumRoot/t/$tid"; Sections = $parsed.sections })
        }
    }
} catch { Write-Warning "Forum-Ankuendigungen nicht lesbar: $_" }

# ---------------------------------------------------------------- write News.lua (newest first)
$sorted = $entries | Sort-Object @{ e = 'Date'; Descending = $true }, @{ e = 'Id'; Descending = $true }

$sb = New-Object System.Text.StringBuilder
[void]$sb.AppendLine("-- AUTO-GENERATED by tools/Update-News.ps1 - do not edit by hand.")
[void]$sb.AppendLine("ForeverNewsData = {")
[void]$sb.AppendLine("  generated = `"$(Get-Date -Format 'yyyy-MM-dd HH:mm')`",")
[void]$sb.AppendLine("  items = {")
foreach ($e in $sorted) {
    [void]$sb.AppendLine("    {")
    [void]$sb.AppendLine("      id = $($e.Id), date = $(ConvertTo-LuaString $e.Date), category = $(ConvertTo-LuaString $e.Cat),")
    [void]$sb.AppendLine("      title = $(ConvertTo-LuaString $e.Title),")
    [void]$sb.AppendLine("      url = $(ConvertTo-LuaString $e.Url),")
    [void]$sb.AppendLine("      sections = {")
    foreach ($s in $e.Sections) {
        $ls = ($s.lines | ForEach-Object { ConvertTo-LuaString $_ }) -join ', '
        [void]$sb.AppendLine("        { g = $(ConvertTo-LuaString $s.g), c = $(ConvertTo-LuaString $s.c), s = $(ConvertTo-LuaString $s.s), lines = { $ls } },")
    }
    [void]$sb.AppendLine("      },")
    [void]$sb.AppendLine("    },")
}
[void]$sb.AppendLine("  },")
[void]$sb.AppendLine("}")
[System.IO.File]::WriteAllText($OutFile, $sb.ToString(), (New-Object System.Text.UTF8Encoding($false)))
Write-Host "Fertig: $(@($sorted).Count) Eintraege -> $OutFile"

$outFull  = [System.IO.Path]::GetFullPath($OutFile)
$gameFile = Join-Path $GameAddon "News.lua"
if ((Test-Path $GameAddon) -and ($outFull -ne $gameFile)) {
    Copy-Item -Path $outFull -Destination $gameFile -Force
    Write-Host "Zusaetzlich ins Spiel kopiert: $gameFile"
}
