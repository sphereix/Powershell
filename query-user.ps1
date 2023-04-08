$serversFile = "C:\Path\To\Servers.txt"
$outputFile = "C:\Path\To\GroupMembers.txt"

# Get list of remote servers from file
$servers = Get-Content $serversFile

# Loop through each server and get the list of administrators
$groupMembers = foreach ($server in $servers) {
    # Use Invoke-Command to run the Get-LocalGroupMember command on the remote server
    Invoke-Command -ComputerName $server -ScriptBlock {
        Get-LocalGroupMember -Group "administrators"
    }
}

# Save the list of group members to a file
$groupMembers | Out-File $outputFile

# Get list of groups from the output file
$groups = Get-Content $outputFile | Select-String -Pattern "^Group" | ForEach-Object { $_.Line -replace "Group\s+:\s+" }

# Loop through each group and get the list of members from Active Directory
foreach ($group in $groups) {
    Get-ADGroupMember -Identity $group | Select-Object -ExpandProperty SamAccountName
}
