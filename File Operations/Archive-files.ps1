##Delete on Disk backups Older than 7 DAYS

Get-ChildItem –Path  "E:\ISeries Archive" –Recurse | Where-Object CreationTime –lt (Get-Date).AddDays(-7) | Remove-Item

## Move Previous backup files to archive folder and attach a date stamp

move-item "E:\ISeries Backup\Backup.zip" ("E:\ISeries Archive\Backup.zip{0:ddMMyyyy}.zip" -f (get-date))

##Collect file ISereries FTP folder and Zip ready to be sent to server at FL

[Reflection.Assembly]::LoadWithPartialName( "System.IO.Compression.FileSystem" )
$src_folder = "e:\iseries"
$destfile = "E:\ISeries Backup\backup.zip"
$compressionLevel = [System.IO.Compression.CompressionLevel]::Optimal
$includebasedir = $false
[System.IO.Compression.ZipFile]::CreateFromDirectory($src_folder,$destfile,$compressionLevel, $includebasedir )

##Copy Latest Iseries backup from TEV-DC01 to TEV-DC02, and write log file

robocopy "e:\iseries backup" "\\TEV-DC01\ISeriesBackup" /NP /log:"E:\Iseries\RC_Log.txt" 

##Collect Log file and Email to OPs Support 

$fromaddress = "backup@tevlimited.com"
$toaddress = "backup.reports@frontline-consultancy.co.uk"
$BCCaddress = "ianworthington@tevlimited.com"
$Subject = "TEV ISERIES BACKUP"
$attachment1 = "E:\Iseries\RC_Log.txt"
$smtpserver = "tev-exch01.tevlimited.com"

$message = new-object System.Net.Mail.MailMessage
$message.From = $fromaddress
$message.To.Add($toaddress)
$message.BCC.Add($BCCaddress)
$message.IsBodyHtml = $True
$message.Subject = $Subject
$attach = new-object Net.Mail.Attachment($attachment1)
$message.Attachments.Add($attach)
$smtp = new-object Net.Mail.SmtpClient($smtpserver)
$smtp.Send($message) 
