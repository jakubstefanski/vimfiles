$ErrorActionPreference = "Stop"

$RepoDir = (Resolve-Path -LiteralPath $PSScriptRoot).Path
$RuntimeDir = Join-Path $HOME "vimfiles"

function Test-SamePath {
    param(
        [Parameter(Mandatory)]
        [string] $Left,

        [Parameter(Mandatory)]
        [string] $Right
    )

    return [StringComparer]::OrdinalIgnoreCase.Equals(
        [IO.Path]::GetFullPath($Left).TrimEnd("\"),
        [IO.Path]::GetFullPath($Right).TrimEnd("\")
    )
}

if (-not (Test-SamePath $RepoDir $RuntimeDir)) {
    if (Test-Path -LiteralPath $RuntimeDir) {
        $Existing = Get-Item -LiteralPath $RuntimeDir -Force
        $ExistingTarget = [string] $Existing.Target
        if (-not $ExistingTarget -or
            -not (Test-SamePath $ExistingTarget $RepoDir)) {
            throw "$RuntimeDir already exists; move or merge it first"
        }
    }
    else {
        New-Item -ItemType Junction -Path $RuntimeDir -Target $RepoDir | Out-Null
        Write-Host "linked $RuntimeDir -> $RepoDir"
    }
}

$StartupFiles = @{
    "_vimrc" = "vimrc"
    "_gvimrc" = "gvimrc"
}

foreach ($Entry in $StartupFiles.GetEnumerator()) {
    $Destination = Join-Path $HOME $Entry.Key
    $Source = "~/vimfiles/$($Entry.Value)"
    $Content = "execute 'source' fnameescape(expand('$Source'))"

    if (Test-Path -LiteralPath $Destination) {
        $Existing = (Get-Content -LiteralPath $Destination -Raw).Trim()
        if ($Existing -ne $Content) {
            throw "$Destination already exists; move or merge it first"
        }
        continue
    }

    Set-Content -LiteralPath $Destination -Value $Content -Encoding ascii
    Write-Host "created $Destination"
}

Write-Host "Vim configuration installed successfully."
