# Replace <RemoteServerName> with the name of the remote server you want to run the command on
$remoteServerName = "<RemoteServerName>"

# Replace <OutputFilePath> with the path and file name where you want to save the results
$outputFilePath = "<OutputFilePath>"

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
