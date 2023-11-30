##RUN ON BOTH DOMAINS AND GET DOMAINNAME_users.csv for each domain
# place output from source domain into the same folder (C:\SIDHistoryUsers) with the domain name prefix, for example 2SFG_Users.csv


#define output folder location to  be created
$outfolderlocation = "C:\SIDHistoryUsers"

##define AD variables
$SearchBase = "OU=Users,DC=DOMAIN,DC=ORG"
$Domain = 'domain.org'


#create directory
write-host "Creating Folder $outfolderlocation"
mkdir $outfolderlocation
cd $outfolderlocation

#run AD script and export csv
write-host "Runinng Script....."
write-host "Script is being ran against.... $SearchBase"
Get-ADUser -LDAPFilter '(name=*)' -SearchBase $SearchBase -Properties objectSID, samAccountName -Server $Domain |
 Select-Object objectSID, samAccountName |
 Export-CSV .\$domain-users.csv -NoTypeInformation
write-host "Script completed and CSV Exported to $outfolderlocation"
