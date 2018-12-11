###################################################################
#                                                                 #
# You can modify the $strState variable to also be "SoftDeleted"  #
#                                                                 #
###################################################################




$disabledmailboxes = @()
$disabledmailboxes = Get-MailboxStatistics -Database "Mailbox Database 0898296323" | where {$_.DisconnectReason -eq "Disabled"} 

foreach ($mailbox in $disabledmailboxes) {
#define variables
$strIdentity = $mailbox.DisplayName
$strDatabase = $mailbox.database
$strState = "Disabled"

Remove-StoreMailbox -Database $strDatabase -Identity $strIdentity -MailboxState $strState}

