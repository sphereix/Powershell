#Date Format has to be exactly as displayed including the time

New-MailboxExportRequest -ContentFilter "(Received -lt '11/12/2015 23:59:59') -and (Received -gt '11/12/2010 00:00:00')" -isarchive "paulbark" -Name paulbarkExport2 -FilePath \\enc-exch01\c$\temp\pbark.pst