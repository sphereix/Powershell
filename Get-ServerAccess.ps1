###########################################################################
# Get-ServerAcess - Script to remotely check all user access to a server  #
#                                  - -                                    #
#                    - Created by Thomas Hughes 2023 -                    #
########################################################################### 

# Replace <domain name> with the netbios domain name
$domainname = "DOMAIN"

# Replace <RemoteServerName> with the name of the remote server you want to run the command on
$remoteServerName = "SERVERNAME"

#make directory for servername
mkdir $pwd\$remoteServerName

# Replace <OutputFilePath> with the path and file name where you want to save the results
$outputFilePath = "$pwd\$remoteServerName\output.txt"

# Replace <Credential> with the credentials of an account that has permission to run the command on the remote server
$credential = Get-Credential

# Set up the session to connect to the remote server
$session = New-PSSession -ComputerName $remoteServerName -Credential $credential

# Run the command on the remote server and save the results to a variable
$remoteResult = Invoke-Command -Session $session -ScriptBlock { get-localgroupmember -group "administrators" | select name -expandproperty name }

# Close the session
Remove-PSSession $session

# Write the results to a text file
$remoteResult | Out-File $outputFilePath

# export local users from file
select-string -path $pwd\$remoteServerName\output.txt -Pattern "$remoteServerName" | Select-Object -ExpandProperty Line | out-file $pwd\$remoteServerName\localusers.txt

# export groups from file
select-string -path $pwd\$remoteServerName\output.txt -Pattern "$domainname" | Select-Object -ExpandProperty Line | out-file $pwd\$remoteServerName\groups.txt

# Read the list of group names from the file
$grouplist = get-content $pwd\$remoteServerName\groups.txt

# loop through each group in the list,
# Recursively checking each group for users and exporting to file
foreach ($groupname in $grouplist) 
{
$groupname = $groupname -replace "^$domainname\\", ""
Get-ADGroupMember $groupname -Recursive | select name -expandproperty name | out-file $pwd\$remoteServerName\usersingroups.txt
}


