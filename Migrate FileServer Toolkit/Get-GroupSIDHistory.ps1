##RUN ON BOTH DOMAINS AND MODIFY THE -SEARCHBASE AS REQUIRED, GET COMPANY_users.csv from each domain, edit the -server switch with the correct domain name
# place output from source domain into the same folder (C:\SIDHistoryGroups) with the domain name prefix, for example 2SFG_Groups.csv


#define output folder location to  be created
$outfolderlocation =  "C:\SIDHistoryGroups"

##define AD variables
$SearchBase = "OU=Groups,DC=DOMAIN,DC=ORG"
$Domain = 'domain.org'

#create directory
write-host "Creating Folder $outfolderlocation"
mkdir $outfolderlocation
cd $outfolderlocation

#run AD script and export csv
write-host "Runinng Script....."
write-host "Script is being ran against.... $SearchBase"
Get-ADgroup -SearchBase $SearchBase -LDAPFilter '(name=*)' -Properties objectSID, samAccountName -Server $Domain |
 Select-Object objectSID, samAccountName |
 Export-CSV .\$domain-Groups.csv -NoTypeInformation
write-host "Script completed and CSV Exported to $outputfolderlocation"
