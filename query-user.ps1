# This script will read the list of servers from a .txt file, 
# then export the groups that exist on the server 
# then query active directory to see the users in those groups, including nested groups 

# Import the required modules 
Import-Module csv 
Import-Module activedirectory 

# Get the path to the .txt file 
$txtPath = "C:\Path\To\Servers.txt" 

# Read in the .txt file 
$servers = Get-Content $txtPath 

# For each server in the .txt file 
foreach ($server in $servers) { 
    # Get the groups that exist on the server 
    $groups = Get-ADGroup -Server $server -Recursive | Select-Object Name, DistinguishedName

    # Export the groups to a text file 
    Export-Csv "C:\Path\To\Groups_$($server).csv" -InputObject $groups -NoTypeInformation

    # For each group on the server
    foreach ($group in $groups) {
        # Get the list of users in the group (including nested groups)
        $users = Get-ADGroupMember -Identity $group.DistinguishedName -Recursive | Where-Object { $_.objectClass -eq 'user' } | Select-Object SamAccountName

        # For each user in the group
        foreach ($user in $users) {
            # Write the user's name to the console 
            Write-Host $user.SamAccountName
        }
    }
}
