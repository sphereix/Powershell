Function stopservices { 

Get-Service | where{$_.Name –Like ‘utiPCi_service*’} | stop-Service –Force
}


function stop-processes {

stop-process -name 'Pc-iRoute File Converter'
stop-process -name 'Outlook'
stop-process -name 'FileConverterMonitor'
}

function start-services {

Get-Service | where{$_.Name –Like ‘utiPCi_service*’} | start-Service
}

stopservices
stop-processes
start-services
