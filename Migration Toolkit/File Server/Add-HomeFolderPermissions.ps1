$HomeFolders = Get-ChildItem G:\Userdata -Directory
foreach ($HomeFolder in $HomeFolders) {
    $Path = $HomeFolder.FullName
    $Acl = (Get-Item $Path).GetAccessControl('Access')
    $Username = $HomeFolder.Name
    $Ar = New-Object System.Security.AccessControl.FileSystemAccessRule("DOMAIN.org\$Username", 'Modify','ContainerInherit,ObjectInherit', 'None', 'Allow')
    $Acl.SetAccessRule($Ar)
       (Get-Item $HomeFolder.FullName).SetAccessControl($acl)
}
