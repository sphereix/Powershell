schtasks /create /tn "start" /sc onstart /delay 0000:30 /rl highest /ru system /tr "powershell.exe -file <<The powershell script path>> 

