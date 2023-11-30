cd C:\SIDHistoryGroups
Export-SIDMappingCustom -ObjectType User -Property samAccountName -OldCSV .\2SFG-Groups.csv -NewCSV .\hollandspies.org-Groups.csv -MapFile SIDMap.csv
Get-Content .\SIDMap.csv
Get-Content .\SIDMap.csv | Measure-Object