1. Create a file with the encrypted server password:
 
In Powershell, enter the following command (replace myPassword with your actual password):
 
"myPassword" | ConvertTo-SecureString -AsPlainText -Force | ConvertFrom-SecureString | Out-File "C:\Powershell\Capacity\EmailPassword.txt"
 
 
2. Create a powershell script
 
$User = "usernameForEmailPassword@gmail.com"
$File = "C:\EmailPassword.txt"
$cred=New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $User, (Get-Content $File | ConvertTo-SecureString)
$EmailTo = "emailTo@OUTLOOK.com"
$EmailFrom = "emailFrom@OUTLOOK.com"
$Subject = "Email Subject"
$Body = "Email body text"
$SMTPServer ="smtp.gmail.com"
$filenameAndPath = "C:\fileIwantToSend.csv"
$SMTPMessage = New-Object System.Net.Mail.MailMessage($EmailFrom,$EmailTo,$Subject,$Body)
$attachment = New-Object System.Net.Mail.Attachment($filenameAndPath)
$SMTPMessage.Attachments.Add($attachment)
$SMTPClient = New-Object Net.Mail.SmtpClient($SmtpServer, 587)
$SMTPClient.EnableSsl = $true
$SMTPClient.Credentials = New-Object System.Net.NetworkCredential($cred.UserName, $cred.Password);
$SMTPClient.Send($SMTPMessage)
 
3. Automate with Task Scheduler
Create a batch file with the following:
 
powershell -ExecutionPolicy ByPass -File "C:\Powershell\Capacity\SendEmail.ps1"
 
Create a task to run the batch file. Note: you must have the task run with the same user account that you used to encrypted the password! 
 
