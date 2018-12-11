$File = "c:\temp\userlist.txt"

ForEach ($User in (Get-Content $File))
{
Get-AdUser $User | Remove-AdObject -Recursive -Confirm:$False
}
