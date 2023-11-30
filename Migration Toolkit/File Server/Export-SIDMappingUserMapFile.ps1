#-MapFile is the output mapfile - this needs to be called SIDMap.csv for the Convert-SIDHistoryNTFS module to work - Convert-SIDHistoryNTFS is ran
# from this directory when all 3 files are in place - see "Convert-SharePermissionsSIDS.ps1"

cd C:\SIDHistoryUsers
Export-SIDMappingCustom -ObjectType User -Property samAccountName -OldCSV .\DOMAIN1.org-users.csv -NewCSV .\DOMAIN2.org-users.csv -MapFile SIDMap.csv
Get-Content .\SIDMap.csv
Get-Content .\SIDMap.csv | Measure-Object