mkdir C:\PermissionsCheck
$rootPath = "C:\" # Change this to your directory path
$logFile = "C:\PermissionsCheck\logfile.txt" # Change this to your log file path

function Check-Access {
    param (
        [string]$path
    )

    try {
        Get-ChildItem $path -ErrorAction Stop | Out-Null
        $true
    } catch {
        $false
    }
}

function Recurse-Directory {
    param (
        [string]$path
    )

    foreach ($item in Get-ChildItem $path) {
        $itemPath = Join-Path $path $item
        Write-Host "Checking: $itemPath"
        if (-not (Check-Access $itemPath)) {
            Add-Content -Path $logFile -Value $itemPath
        }

        if (Test-Path $itemPath -PathType Container) {
            Recurse-Directory -path $itemPath
        }
    }
}

Recurse-Directory -path $rootPath
