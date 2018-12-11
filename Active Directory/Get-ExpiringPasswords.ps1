function exportadcsv {

# Script including out-file #

Get-ADUser -filter * –Properties "Name", "msDS-UserPasswordExpiryTimeComputed", "LastLogonDate", "whencreated" |


Select-Object -Property @{Name="User";Expression={$_.Name}},@{Name="Expires";Expression={[datetime]::FromFileTime($_."msDS-UserPasswordExpiryTimeComputed")}},@{Name="LastLogon";Expression={$_.Lastlogondate}}, @{Name="Created";Expression={$_.whencreated}} |
Sort-Object User | Export-CSV C:\Powershell\ADReport\ActiveDirectoryReport.csv


$csv=Import-Csv 'C:\Powershell\ADReport\ActiveDirectoryReport.csv' 
$csv | %{
    if($_.Expires -eq "01/01/1601 00:00:00") {$_.Expires="  Disabled Account"}
    if($_.Lastlogon -eq "") {$_.Lastlogon="Never Logged In"}
    if($_.Expires -eq "") {$_.Expires="  Never Expires"}
    
} 
$csv|export-csv 'C:\Powershell\ADReport\ActiveDirectoryReport.csv' -NoTypeInformation 


}

function exporthtml {


# Stylesheet #

$Header = @"
<h1>Active Directory Report - Premier Paper</h1>
<style>
TABLE {border-width: 1px; border-style: solid; border-color: black; border-collapse: collapse;}
TH {border-width: 1px; padding: 3px; border-style: solid; border-color: black; background-color: #6495ED;}
TD {border-width: 1px; padding: 3px; border-style: solid; border-color: black;}
</style>
"@


#script to convert to html

Import-Csv 'C:\Powershell\ADReport\ActiveDirectoryReport.csv' | ConvertTo-Html -head $Header | Out-File C:\Powershell\ADReport\ActiveDirectoryReport.html

}

exportadcsv
exporthtml