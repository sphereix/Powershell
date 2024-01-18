# Define the root folder
$rootFolder = "C:\test\"

# Define the user to be added
$user = "ALPHA\localadmin"

# Log file location
$logFile = "C:\NTFSPermissions\AddPermission-LogFile.txt"

# Max path length
$maxPathLength = 260

# Function to check if path exceeds MAX_PATH
function IsPathTooLong {
    param (
        [string]$itemPath
    )

    return $itemPath.Length -ge $maxPathLength
}

# Function to check if the script runner has modify permission
function HasModifyPermission {
    param (
        [string]$itemPath
    )

    try {
        $acl = Get-Acl $itemPath
        $accessControl = [System.Security.AccessControl.FileSystemRights]::Modify
        $currentUser = [System.Security.Principal.WindowsIdentity]::GetCurrent().Name
        foreach ($access in $acl.Access) {
            if ($access.IdentityReference -eq $currentUser -and ($access.FileSystemRights -band $accessControl) -eq $accessControl) {
                return $true
            }
        }
    } catch {
        # Unable to get ACL, assume no modify permission
        return $false
    }
    return $false
}

# Function to add user to an item (file or folder)
function Add-UserToItem {
    param (
        [string]$itemPath,
        [boolean]$isDirectory
    )

    try {
        # Add user with FullControl permission
        $acl = Get-Acl $itemPath
        $permission = "$user", "FullControl", "Allow"
        $accessRule = New-Object System.Security.AccessControl.FileSystemAccessRule $permission
        $acl.SetAccessRule($accessRule)
        Set-Acl -Path $itemPath -AclObject $acl

        # Log the change
        "$itemPath - User added" | Out-File -FilePath $logFile -Append

        # Output to console
        Write-Host "Permissions added to: $itemPath"

    } catch {
        # Log any errors
        "Error: $_" | Out-File -FilePath $logFile -Append
    }
}

# Process directories
Get-ChildItem -Path $rootFolder -Recurse -Directory | ForEach-Object {
    if (-not (HasModifyPermission $_.FullName)) {
        takeown /f $_.FullName /a
    }
    Add-UserToItem $_.FullName $true
}

# Process files
Get-ChildItem -Path $rootFolder -Recurse -File | ForEach-Object {
    if (IsPathTooLong $_.FullName) {
        "Long Path Skipped: $($_.FullName)" | Out-File -FilePath $logFile -Append
    }
    else {
        Add-UserToItem $_.FullName $false
    }
}

# Indicate completion
"Process completed. Check log for details." | Out-File -FilePath $logFile -Append
