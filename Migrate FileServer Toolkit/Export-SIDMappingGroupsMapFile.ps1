cd C:\SIDHistoryGroups
Export-SIDMappingCustom -ObjectType User -Property samAccountName -OldCSV .\2SFG-Groups.csv -NewCSV .\domain1.org-Groups.csv -MapFile SIDMap.csv
Get-Content .\SIDMap.csv
Get-Content .\SIDMap.csv | Measure-Object
