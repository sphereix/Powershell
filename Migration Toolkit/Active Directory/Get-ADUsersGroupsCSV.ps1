function initialize {
# Import the Active Directory module if not already loaded
if (-not (Get-Module -Name ActiveDirectory)) {
    Import-Module ActiveDirectory
}

# Define the output CSV file path
$global:csvFilePath = ".\AD-GroupsReport.csv"

#Define Seach OU, Replace 'OU=Users,OU=COMPANY,DC=DOMAIN,DC=net' with the DN (Distinguished Name) of your target OU
$global:ouDistinguishedName = 'OU=Users,OU=COMPANY,DC=DOMAIN,DC=net'

}

function getusers {
# Retrieve user information using Get-ADUser and select the required attributes
$users = Get-ADUser -Filter * -Properties SamAccountName, GivenName, Surname, EmailAddress |
    Where-Object { $_.DistinguishedName -like "*,$ouDistinguishedName" } |
    Select-Object SamAccountName, GivenName, Surname, EmailAddress, UserPrincipalName

# Export the user information to a CSV file
$users | Export-Csv -Path $csvFilePath -NoTypeInformation -Encoding UTF8

Write-Host "Gathering List of Users & Groups, Please Wait...."
}

function getgroups{
# Load the CSV data
$csvData = Import-Csv -Path $csvFilePath

# Create an empty array to store the results
$results = @()

# Loop through each row in the CSV
foreach ($row in $csvData) {
    # Get the SamAccountName from the CSV row
    $samAccountName = $row.SamAccountName

    # Get the user's group membership
    $userGroups = Get-ADPrincipalGroupMembership -Identity $samAccountName | Select-Object -ExpandProperty Name

    # Append the groups to the CSV row
    $row | Add-Member -MemberType NoteProperty -Name "Groups" -Value ($userGroups -join ", ")
    $results += $row
}

# Export the updated CSV with the "Groups" column
$results | Export-Csv -Path $csvFilePath -NoTypeInformation
Write-Host "User information exported to $csvFilePath"
}


initialize
getusers
getgroups
