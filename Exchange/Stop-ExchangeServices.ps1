Get-Service | where{$_.Name –Like ‘MSExchange*’} | set-Service –StartupType ‘Disabled’
Get-Service | where{$_.Name –Like ‘MSExchange*’} | stop-Service –Force

Get-Service | where{$_.Name –Like ‘MSExchange*’} | set-Service –StartupType ‘Automatic’
Get-Service | where{$_.Name –Like ‘MSExchange*’} | start-Service

