cd C:\SIDHistoryGroups
Export-SIDMappingCustom -ObjectType User -Property samAccountName -OldCSV .\DOMAIN1.org-Groups.csv -NewCSV .\DOMAIN2.org-Groups.csv -MapFile SIDMap.csv
Get-Content .\SIDMap.csv
Get-Content .\SIDMap.csv | Measure-Object