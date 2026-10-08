param(
    [string]$InputPath = "$PSScriptRoot/../playlists/tv.m3u",
    [string]$OutputPath = "$PSScriptRoot/../playlists/tv.m3u"
)

$ErrorActionPreference = 'Stop'

function Get-Attributes([string]$line) {
    $attrs = @{}
    foreach ($match in [regex]::Matches($line, '([\w-]+)="([^"]*)"')) {
        $attrs[$match.Groups[1].Value.ToLowerInvariant()] = $match.Groups[2].Value
    }
    return $attrs
}

function Get-EntryName([string]$extinf) {
    $quoted = $false
    for ($i = 0; $i -lt $extinf.Length; $i++) {
        if ($extinf[$i] -eq '"') { $quoted = -not $quoted }
        if ($extinf[$i] -eq ',' -and -not $quoted) { return $extinf.Substring($i + 1).Trim() }
    }
    return ''
}

function Get-EntryUrl($entry) {
    foreach ($line in $entry.Lines) {
        $trimmed = $line.Trim()
        if ($trimmed -and -not $trimmed.StartsWith('#')) { return $trimmed }
    }
    return ''
}

function Escape-Attribute([string]$value) {
    return ($value -replace '"', '&quot;' -replace "`r", ' ' -replace "`n", ' ')
}

function Get-CanonicalName([string]$name) {
    $value = $name.ToLowerInvariant()
    $value = $value -replace '\[[^\]]*(yedek|backup|geo|not 24/7)[^\]]*\]', ' '
    $value = $value -replace '\((backup|source backup|onlineup|dup|pc/mob init|browser[^)]*|1080p|720p|576p|480p|360p|1440p|turkiye|türkiye|geo-blocked|not 24/7)[^)]*\)', ' '
    $value = $value -replace '\b(yedek|backup|source backup|dup)\b', ' '
    $value = $value -replace '\b(uhd|fhd|hd|sd|4k|1080p|720p|576p|480p|360p|1440p)\b', ' '
    $value = $value -replace '[^a-z0-9çğıöşü]+', ' '
    $value = $value.Trim() -replace '\s+', ''
    return $value
}

function Is-BackupEntry($entry) {
    return $entry.Name -match '(?i)\byedek\b|\(backup\)|source backup|\bbackup\b'
}

function Backup-Line($entry) {
    $attrs = Get-Attributes $entry.Ext
    $parts = @(
        'name="' + (Escape-Attribute $entry.Name) + '"',
        'url="' + (Escape-Attribute (Get-EntryUrl $entry)) + '"'
    )
    foreach ($key in @('tvg-id', 'tvg-logo', 'group-title', 'http-user-agent', 'http-referrer', 'http-referer', 'http-origin')) {
        if ($attrs.ContainsKey($key) -and $attrs[$key]) {
            $parts += $key + '="' + (Escape-Attribute $attrs[$key]) + '"'
        }
    }
    foreach ($line in $entry.Lines) {
        if ($line -match '^#EXTVLCOPT:http-user-agent=(.+)$') { $parts += 'http-user-agent="' + (Escape-Attribute $Matches[1].Trim()) + '"' }
        if ($line -match '^#EXTVLCOPT:http-referr?er=(.+)$') { $parts += 'http-referrer="' + (Escape-Attribute $Matches[1].Trim()) + '"' }
        if ($line -match '^#EXTVLCOPT:http-origin=(.+)$') { $parts += 'http-origin="' + (Escape-Attribute $Matches[1].Trim()) + '"' }
    }
    return '#EXT-X-MP-BACKUP:' + ($parts -join ' ')
}

$lines = [IO.File]::ReadAllLines((Resolve-Path $InputPath))
$header = [System.Collections.Generic.List[string]]::new()
$entries = [System.Collections.Generic.List[object]]::new()
$current = $null

foreach ($line in $lines) {
    if ($line.StartsWith('#EXTINF', [StringComparison]::OrdinalIgnoreCase)) {
        if ($null -ne $current) { $entries.Add([pscustomobject]$current) }
        $current = @{
            Ext = $line
            Name = Get-EntryName $line
            Lines = [System.Collections.Generic.List[string]]::new()
        }
        $current.Lines.Add($line)
    } elseif ($null -ne $current) {
        if (-not $line.StartsWith('#EXT-X-MP-BACKUP:', [StringComparison]::OrdinalIgnoreCase)) {
            $current.Lines.Add($line)
        }
    } else {
        if ($line -notmatch '^# Turkish-channel filter:' -and $line -notmatch '^# MP TV managed backups:') {
            $header.Add($line)
        }
    }
}
if ($null -ne $current) { $entries.Add([pscustomobject]$current) }

$primary = [System.Collections.Generic.List[object]]::new()
$backupsByKey = @{}

foreach ($entry in $entries) {
    if (Is-BackupEntry $entry) {
        $key = Get-CanonicalName $entry.Name
        if (-not $backupsByKey.ContainsKey($key)) { $backupsByKey[$key] = [System.Collections.Generic.List[object]]::new() }
        $backupsByKey[$key].Add($entry)
    } else {
        $primary.Add($entry)
    }
}

$primaryKeys = @{}
foreach ($entry in $primary) { $primaryKeys[(Get-CanonicalName $entry.Name)] = $true }

$output = [System.Collections.Generic.List[string]]::new()
$output.AddRange($header)
$output.Add('# Turkish-channel filter: non-Turkish channels removed; backup streams are hidden behind their primary channel.')
$output.Add('# MP TV managed backups: #EXT-X-MP-BACKUP lines are tried automatically by MP TV and ignored by ordinary M3U players.')

$attached = 0
$attachedKeys = @{}
foreach ($entry in $primary) {
    $key = Get-CanonicalName $entry.Name
    $output.Add($entry.Lines[0])
    $matchingKeys = @($backupsByKey.Keys | Where-Object {
        -not $attachedKeys.ContainsKey($_) -and (
            $_ -eq $key -or
            ($key -eq 'tlc' -and $_ -eq 'tlctr') -or
            ($key.Length -ge 4 -and $_.Length -ge 4 -and ($_.StartsWith($key) -or $key.StartsWith($_)))
        )
    })
    foreach ($matchKey in $matchingKeys) {
        $seen = @{}
        foreach ($backup in $backupsByKey[$matchKey]) {
            $url = Get-EntryUrl $backup
            if ($url -and -not $seen.ContainsKey($url)) {
                $output.Add((Backup-Line $backup))
                $seen[$url] = $true
                $attached++
            }
        }
        $attachedKeys[$matchKey] = $true
    }
    for ($i = 1; $i -lt $entry.Lines.Count; $i++) { $output.Add($entry.Lines[$i]) }
}

foreach ($key in $backupsByKey.Keys) {
    if (-not $attachedKeys.ContainsKey($key)) {
        foreach ($orphan in $backupsByKey[$key]) {
            foreach ($line in $orphan.Lines) { $output.Add($line) }
        }
    }
}

[IO.File]::WriteAllLines((Resolve-Path $OutputPath), [string[]]$output, [Text.UTF8Encoding]::new($false))
Write-Output "Primary=$($primary.Count) AttachedBackups=$attached OrphanBackupGroups=$(($backupsByKey.Keys | Where-Object { -not $primaryKeys.ContainsKey($_) }).Count)"
