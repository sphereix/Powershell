$Sys32 = "$env:SystemRoot\System32"

Stop-Service -DisplayName 'System Event Notification Service' -Force
Stop-Service -DisplayName 'Background Intelligent Transfer Service' -Force
Stop-Service -DisplayName 'COM+ Event System' -Force
Stop-Service -DisplayName 'Volume Shadow Copy' -Force
Stop-Service -DisplayName 'Microsoft Software Shadow Copy Provider' -Force

$dllfiles = @("atl.dll","comsvcs.dll","credui.dll","dhcpqec.dll","dnssenh.dll","eapqec.dll","esscli.DLL","FastProx.DLL", `
                "FirewallAPI.DLL","kmsvc.DLL","lsmproxy.DLL","MSCTF.DLL","msi.dll","msxml3.dll","ncprov.dll","ole32.dll", `
                "oleacc.dll","oleaut32.dll","propsys.dll","qagent.dll","qagentrt.dll","qutil.dll","raschap.dll","rasqec.dll", `
                "rastls.dll","repdrvfs.dll","rpcrt4.dll","rsaenh.dll","shell32.dll","shsvcs.dll","swprv.dll","tschannel.dll", `
                "userenv.dll","vss_ps.dll","wbemcons.dll","wbemcore.dll","wbemess.dll","wbemsvc.dll","winhttp.dll","wintrust.dll", `
                "wmiprvsd.dll","wmisvc.dll","wmiutils.dll","wuaueng.dll")

foreach($dll in $dllfiles) {
    try {
        Start-Process regsvr32 -ArgumentList "/s $Sys32\$dll"
        }
    catch {
        Write-Host "File $dll not found. Skipping"
        }
    }

$sfcfiles = @("catsrv.dll","catsrvut.dll","CLBCatQ.dll")

foreach($file in $sfcfiles) {
    try {
        Start-Process sfc -ArgumentList "/SCANFILE=$Sys32\$file"
        }
    catch {
        Write-Host "File $file not found. Skipping"
        }
    }

Start-Service -DisplayName 'System Event Notification Service'
Start-Service -DisplayName 'Background Intelligent Transfer Service'
Start-Service -DisplayName 'COM+ Event System'
Start-Service -DisplayName 'Volume Shadow Copy'
Start-Service -DisplayName 'Microsoft Software Shadow Copy Provider'
