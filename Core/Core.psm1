Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$Class = @(Get-ChildItem -File -Recurse -Filter *.ps1 -Path (Join-Path -Path $PSScriptRoot -ChildPath 'class') -ErrorAction SilentlyContinue)

$Public = @(Get-ChildItem -File -Recurse -Filter *.ps1 -Path (Join-Path -Path $PSScriptRoot -ChildPath 'public') -ErrorAction SilentlyContinue)

$Private = @(Get-ChildItem -File -Recurse -Filter *.ps1 -Path (Join-Path -Path $PSScriptRoot -ChildPath 'private') -ErrorAction SilentlyContinue)

foreach ($function in @($Class + $Public + $Private)) {

    try {

        . $function.Fullname

    }

    catch {

        Write-Error -ErrorAction Stop -Message "Failed to import function '$($function.fullname)': $_"

    }
}
