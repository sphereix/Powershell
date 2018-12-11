function checkdisk {

chkdsk E: > C:\temp\log.txt

}


write-host "Checking Disk for Errors........"

checkdisk

write-host "Disk Check Completed, Procsesing Results....."


function ProcessResults {

$Results = Get-Content C:\temp\log.txt | Select-String "Error"
write-host "Errors Detected on $env:COMPUTERNAME"

}

processresults
pause