$User = "***EMAIL ADDRESS***"
$File = "C:\Powershell\Capacity\EmailPassword.txt"
$cred=New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $User, (Get-Content $File | ConvertTo-SecureString)
$EmailTo = "EMAIL ADDRESS"
$EmailFrom = "EMAIL ADDRESS"
$Subject = "Subject"
$Body = ""
$SMTPServer ="smtp.office365.com"
$filenameAndPath = "C:\Powershell\Capacity\DiskCapacity.html"
$SMTPMessage = New-Object System.Net.Mail.MailMessage($EmailFrom,$EmailTo,$Subject,$Body)
$attachment = New-Object System.Net.Mail.Attachment($filenameAndPath)
$SMTPMessage.Attachments.Add($attachment)
$SMTPClient = New-Object Net.Mail.SmtpClient($SmtpServer, 587)
$SMTPClient.EnableSsl = $true
$SMTPClient.Credentials = New-Object System.Net.NetworkCredential($cred.UserName, $cred.Password);
$SMTPClient.Send($SMTPMessage)