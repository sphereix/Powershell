# Define the path to your CSV file
$csvPath = "C:\path\to\your\csvfile.csv"

# Import the CSV file
$users = Import-Csv $csvPath

# Define the target OU for groups
$ouPath = "OU=Groups,OU=Company,DC=DOMAIN,DC=ORG"  # Update with your actual OU path

# Loop through the users in the CSV file
foreach ($user in $users) {
    $groupNames = $user.Groups -split ','  # Split groups by comma

    # Create groups and add users to them
    foreach ($groupName in $groupNames) {
        $groupName = $groupName.Trim()
        try {
            # Check if the group already exists
            $existingGroup = Get-ADGroup -Filter { Name -eq $groupName }

            if ($existingGroup -eq $null) {
                # If the group does not exist, create it
                New-ADGroup -Name $groupName -GroupCategory Security -GroupScope Global -Path $ouPath
                Write-Host "Group $groupName created."
            }

            # Add the user to the group
            Add-ADGroupMember -Identity $groupName -Members $user.SamAccountName
            Write-Host "User $($user.SamAccountName) added to group $groupName."
        } catch {
            Write-Host "Failed to create or add user to group $groupName."
        }
    }
}

Write-Host "Group creation and user assignment completed."
