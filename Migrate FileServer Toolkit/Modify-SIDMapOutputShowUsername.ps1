## this script is useful if you need to check who's who on the SIDMap output 


# Read CSV files
$csv1 = Import-Csv -Path 'C:\SIDHistoryGroups\hollandspies.org-Groups.csv'
$csv2 = Import-Csv -Path 'C:\SIDHistoryGroups\SIDMap.csv'

# Iterate through each row in csv1
foreach ($row1 in $csv1) {
    # Find matching row in csv2 based on 'objectsid'
    $matchingRow = $csv2 | Where-Object { $_.newsid -eq $row1.objectsid }

    # If a match is found, add 'samaccountname' to csv2
    if ($matchingRow) {
        $matchingRow | Add-Member -MemberType NoteProperty -Name 'samaccountname' -Value $row1.samaccountname
    }
}

# Export the modified csv2
$csv2 | Export-Csv -Path 'C:\SIDHistoryGroups\Modified-SIDMap.csv' -NoTypeInformation


# Specify the path for the output CSV file
$outputPath = 'C:\SIDHistoryGroups\Modified-SIDMap.csv'

# Write the CSV header manually
$csv2[0].psobject.properties.name -join ',' | Out-File -FilePath $outputPath -Encoding utf8 -Force

# Append data rows without quotes
$csv2 | ForEach-Object {
    $_.psobject.properties.value -join ',' | Add-Content -Path $outputPath -Encoding utf8
}

