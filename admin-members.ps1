$AdminMembers = @()
# Fetch out all the members of the local administrators group
$LocalAdminGroupMembers = Get-LocalGroupMember -Name Administrators

# Add all the user types to our final result
$AdminMembers += $LocalAdminGroupMembers | Where-Object {$_.ObjectClass -eq "User"} | Select -ExpandProperty Name

# Iterate through the group and fetch users using the net group command and add the same to final result
$LocalAdminGroupMembers | 
Where-Object {$_.ObjectClass -eq "Group"} | foreach {

    $netGroupResult = net group $(($_.Name -split "\\")[-1]) /domain
    $AdminMembers   += $netGroupResult[8..($netGroupResult.length -3)] -split "\s+" | Where-Object {$_}
}
                                

# Display out the final result
Write-Output "***********************************************************"
Write-Output "Following are the members of the local administrators group"
$LocalAdminGroupMembers

Write-Output "***********************************************************"
Write-Output "You have a total of $($AdminMembers.Count) admin user account present in the group, following are the details:"
$AdminMembers
