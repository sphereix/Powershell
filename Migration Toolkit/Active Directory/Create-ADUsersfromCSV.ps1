### This Script creates the users retreived from the Export-ADUsersandgroups CSV

# Define the path to your CSV file
$csvPath = "C:\path\to\your\csvfile.csv"

# Import the CSV file
$users = Import-Csv $csvPath

# Define the target OU
$ouPath = "OU=Users,OU=Company,DC=DOMAIN,DC=ORG"  # Update with your actual OU path

# Loop through the users in the CSV file and create them in Active Directory
foreach ($user in $users) {
    $samAccountName = $user.SamAccountName
    $givenName = $user.GivenName
    $surname = $user.Surname
    $password = $user.Password
    $newemailaddress = $user.NewEmailAddress

    # Create a new user
    New-ADUser -Name "$givenName $surname" -SamAccountName $samAccountName -GivenName $givenName -Surname $surname -UserPrincipalName "$samAccountName@hollandspies.org" -AccountPassword (ConvertTo-SecureString $password -AsPlainText -Force) -Enabled $true -Path $ouPath

    # You may need to set additional properties like email, department, etc.
    Set-ADUser -Identity $samAccountName -EmailAddress $user.NewEmailAddress

    Write-Host "User $samAccountName created."
}

Write-Host "User creation completed."
