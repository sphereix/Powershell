# Load System.Windows.Forms Assembly
Add-Type -AssemblyName System.Windows.Forms

# Clearing Cached Credentials
cmdkey /list | ForEach-Object {
    if ($_ -like "*target=MicrosoftOffice*") {
        $target = $_ -replace " ","" -replace "Target:",""
        cmdkey /del:$target
    }
}

# Resetting Outlook Profiles
# Note: This script removes Outlook profiles. You should notify users to backup their data as necessary.
Get-ChildItem -Path HKCU:\Software\Microsoft\Office\16.0\Outlook\Profiles -Recurse | Remove-Item -Force -Recurse

# Sign-out from OneDrive (Requires OneDrive version 17.3.7294.0108 or later)
Start-Process "C:\Program Files (x86)\Microsoft OneDrive\OneDrive.exe" -ArgumentList "/reset"
Start-Sleep -Seconds 5 # Wait for OneDrive reset
Start-Process "C:\Program Files (x86)\Microsoft OneDrive\OneDrive.exe"

# Clear Teams Cache
$teamsPath = "$env:APPDATA\Microsoft\Teams"
if (Test-Path $teamsPath) {
    Get-ChildItem -Path $teamsPath -Recurse | Remove-Item -Force -Recurse
    Write-Host "Teams cache cleared."
} else {
    Write-Host "Teams cache directory not found."
}

# Final Step: Prompt the user to sign in again
[System.Windows.MessageBox]::Show('Please sign in to Outlook, OneDrive, and Teams with your new account credentials.')
