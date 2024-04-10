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

# Define the path to the Outlook profiles registry key
$registryPath = "HKCU:\Software\Microsoft\Office\16.0\Outlook\Profiles"

# Check if the Outlook profiles registry key exists
if (Test-Path $registryPath) {
    try {
        # Attempt to remove the Outlook profiles registry key and its subkeys
        Get-ChildItem -Path $registryPath -Recurse | Remove-Item -Force -Recurse
        Write-Host "Outlook profiles registry keys have been successfully cleared."
    } catch {
        # Handle errors that occur during the removal of the registry key
        Write-Host "An error occurred while attempting to clear the Outlook profiles registry keys: $_"
        pause
    }
} else {
    # Handle the case where the registry key does not exist
    Write-Host "The Outlook profiles registry key does not exist or has already been removed."
}




# Clear OneDrive Setup in Registry - Use with caution!
# This step removes OneDrive setup info from the Windows Registry, potentially prompting a setup on next start.
# Make sure to back up the registry or specific keys before making changes.
try {
    Remove-Item -Path "HKCU:\Software\Microsoft\OneDrive" -Recurse -Force
    Write-Host "OneDrive registry settings cleared."
} catch {
    Write-Host "Failed to clear OneDrive registry settings. $_"
    pause
}

# Optional: Delete OneDrive local data - Use with caution!
# This step deletes local OneDrive sync folders. Ensure data is backed up or fully synced online before proceeding.
#try {
#    $oneDriveDataPath = "$env:USERPROFILE\OneDrive"
#    if (Test-Path $oneDriveDataPath) {
#        Remove-Item -Path $oneDriveDataPath -Recurse -Force
#        Write-Host "OneDrive local data cleared."
#    }
#} catch {
#    Write-Host "Failed to clear OneDrive local data. $_"
#}


# Reset OneDrive
$oneDrivePath = "$env:LOCALAPPDATA\Microsoft\OneDrive\OneDrive.exe"
if (Test-Path $oneDrivePath) {
    Start-Process $oneDrivePath -ArgumentList "/reset"
    Start-Sleep -Seconds 5 # Wait for OneDrive reset
} else {
    Write-Host "OneDrive executable not found."
    pause
}



# Clear Teams Cache
$teamsPath = "$env:APPDATA\Microsoft\Teams"
if (Test-Path $teamsPath) {
    Get-ChildItem -Path $teamsPath -Recurse | Remove-Item -Force -Recurse
    Write-Host "Teams cache cleared."
} else {
    Write-Host "Teams cache directory not found."
    pause
}

# Final Step: Prompt the user to sign in again
write-host 'Please sign in to Outlook, OneDrive, and Teams with your new account credentials.'
pause
