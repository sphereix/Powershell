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
