# This script will read the list of servers from a .txt file, then export the groups that exist on the server then query active directory to see the users in those groups, including nested groups

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
    $groups = Get-ADGroup -Server $server -Recursive

    # Export the groups to a text file
    Export-Csv "C:\Path\To\Groups.csv" -InputObject $groups

    # Query Active Directory to see the users in those groups
    $users = Get-ADUser -Filter * -Properties MemberOf -ResultSetSize Unlimited

    # For each user in Active Directory
    foreach ($user in $users) {

        # Check if the user is a member of any of the groups on the server
        $isMember = $groups | ForEach-Object { $_ -Contains $user.SamAccountName }

        # If the user is a member of any of the groups on the server
        if ($isMember) {

            # Write the user's name to the console
            Write-Host $user.SamAccountName
        }
    }
}
