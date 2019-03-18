###################################################
#                                                 #
#  Frontline 2019 - Thomas Hughes & Aaron Tulloch #
#                                                 #
###################################################

$retreivefolders = (Get-ChildItem -Path G:\Team_Drives -Recurse -Directory -Force -ErrorAction SilentlyContinue | Select-Object FullName | out-file "C:\temp\folderlist.txt")
$amendfiles = Get-Content "C:\temp\folderlist.txt"
$amendfiles | Foreach {$_.TrimEnd()} | Set-Content "C:\temp\folderlist2.txt"

Start-Transcript -path C:\temp\output5.txt -append
$folderlist = "C:\temp\folderlist2.txt"
$User = "first.surname"

ForEach ($Folder in (Get-Content $Folderlist))
{
$permission = (Get-Acl $Folder -ErrorAction SilentlyContinue).Access | ?{$_.IdentityReference -match $User} | Select IdentityReference,FileSystemRights
If ($permission){
$permission | % {Write-Host "$user ^ $folder ^ Full Access"}
}
Else {
Write-Host "$User ^ $Folder ^ No Access"
} 

}

Stop-Transcript

