[void][System.Reflection.Assembly]::LoadWithPartialName(‘Microsoft.VisualBasic’) 
# [microsoft.visualbasic.interaction]::Msgbox($message,"$button,$icon",$title)
[Microsoft.VisualBasic.Interaction]::MsgBox(“Password for $env:username will expire in 2 days, would you like to change your password now?”, ‘YesNoCancel,Information’, “Consider changing your password”)