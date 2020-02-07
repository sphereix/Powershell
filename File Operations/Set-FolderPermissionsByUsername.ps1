$Folders = Get-childItem -Path "<path to folder>"
$InheritanceFlag = [System.Security.AccessControl.InheritanceFlags]::ContainerInherit -bor [System.Security.AccessControl.InheritanceFlags]::ObjectInherit
$PropagationFlag = [System.Security.AccessControl.PropagationFlags]::None
$objType = [System.Security.AccessControl.AccessControlType]::Allow 

foreach ($TempFolder in $Folders)
{
Write-Output -InputObject "Loop Iteration"
$Folder = $TempFolder.FullName
$UserFolder = $TempFolder

$acl = Get-Acl -Path $Folder
Write-Output -InputObject "<domain short name>\$UserFolder"
$permission = "<domain short name>\$UserFolder","FullControl", $InheritanceFlag, $PropagationFlag, $objType
$accessRule = New-Object System.Security.AccessControl.FileSystemAccessRule $permission

$acl.SetAccessRule($accessRule)
Set-Acl -Path $Folder -AclObject $acl
}