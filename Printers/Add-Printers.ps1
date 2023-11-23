# Define the path to the CSV file
$csvPath = "C:\import\printerslist.csv"

# Import data from CSV
$printers = Import-Csv -Path $csvPath

# Loop through each row in the CSV
foreach ($printer in $printers) {
    $printerName = $printer."printer name"
    $driverName = "RICOH PCL6 UniversalDriver V4.37"
    $ip = $printer.IP

    # Add the TCP/IP port using Add-PrinterPort cmdlet
    Add-PrinterPort -Name $printerName -PrinterHostAddress $ip -PortNumber 9100

    # Add the printer using Add-Printer cmdlet
    Add-Printer -Name $printerName -DriverName $driverName -PortName $printerName -Comment "Added by PowerShell" 

    Write-Host "Printer '$printerName' added successfully."
}
