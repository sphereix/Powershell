

###Environmnent Discovery


Function Welcome
{
write-host "

  ██████  ▄▄▄       ███▄ ▄███▓ ██▓███   ██▓    ▓█████     ▒█████   ██▀███    ▄████  ▄▄▄       ███▄    █  ██▓▒███████▒▓█████  ██▀███  
▒██    ▒ ▒████▄    ▓██▒▀█▀ ██▒▓██░  ██▒▓██▒    ▓█   ▀    ▒██▒  ██▒▓██ ▒ ██▒ ██▒ ▀█▒▒████▄     ██ ▀█   █ ▓██▒▒ ▒ ▒ ▄▀░▓█   ▀ ▓██ ▒ ██▒
░ ▓██▄   ▒██  ▀█▄  ▓██    ▓██░▓██░ ██▓▒▒██░    ▒███      ▒██░  ██▒▓██ ░▄█ ▒▒██░▄▄▄░▒██  ▀█▄  ▓██  ▀█ ██▒▒██▒░ ▒ ▄▀▒░ ▒███   ▓██ ░▄█ ▒
  ▒   ██▒░██▄▄▄▄██ ▒██    ▒██ ▒██▄█▓▒ ▒▒██░    ▒▓█  ▄    ▒██   ██░▒██▀▀█▄  ░▓█  ██▓░██▄▄▄▄██ ▓██▒  ▐▌██▒░██░  ▄▀▒   ░▒▓█  ▄ ▒██▀▀█▄  
▒██████▒▒ ▓█   ▓██▒▒██▒   ░██▒▒██▒ ░  ░░██████▒░▒████▒   ░ ████▓▒░░██▓ ▒██▒░▒▓███▀▒ ▓█   ▓██▒▒██░   ▓██░░██░▒███████▒░▒████▒░██▓ ▒██▒
▒ ▒▓▒ ▒ ░ ▒▒   ▓▒█░░ ▒░   ░  ░▒▓▒░ ░  ░░ ▒░▓  ░░░ ▒░ ░   ░ ▒░▒░▒░ ░ ▒▓ ░▒▓░ ░▒   ▒  ▒▒   ▓▒█░░ ▒░   ▒ ▒ ░▓  ░▒▒ ▓░▒░▒░░ ▒░ ░░ ▒▓ ░▒▓░
░ ░▒  ░ ░  ▒   ▒▒ ░░  ░      ░░▒ ░     ░ ░ ▒  ░ ░ ░  ░     ░ ▒ ▒░   ░▒ ░ ▒░  ░   ░   ▒   ▒▒ ░░ ░░   ░ ▒░ ▒ ░░░▒ ▒ ░ ▒ ░ ░  ░  ░▒ ░ ▒░
░  ░  ░    ░   ▒   ░      ░   ░░         ░ ░      ░      ░ ░ ░ ▒    ░░   ░ ░ ░   ░   ░   ▒      ░   ░ ░  ▒ ░░ ░ ░ ░ ░   ░     ░░   ░ 
      ░        ░  ░       ░                ░  ░   ░  ░       ░ ░     ░           ░       ░  ░         ░  ░    ░ ░       ░  ░   ░     "
write-host ""
write-host "SampleOrganizer 1.0 - Created by Sphereix - https://www.soundcloud.com/sphereixproduction"#
write-host ""
write-host -ForegroundColor Green "The Next Screen will be a folder selection window, please specify your samples directory"
write-host ""


}

function input {
function Find-Folders1 {
    [Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms") | Out-Null
    [System.Windows.Forms.Application]::EnableVisualStyles()
    $browse = New-Object System.Windows.Forms.FolderBrowserDialog
    $browse.SelectedPath = "C:\"
    $browse.ShowNewFolderButton = $false
    $browse.Description = "Select a directory"

    $loop = $true
    while($loop)
    {
        if ($browse.ShowDialog() -eq "OK")
        {
        $loop = $false
		
		#Nothing required here as we only want the selected folder as a variable
		
        } else
        {
            $res = [System.Windows.Forms.MessageBox]::Show("You clicked Cancel. Would you like to try again or exit?", "Select a location", [System.Windows.Forms.MessageBoxButtons]::RetryCancel)
            if($res -eq "Cancel")
            {
                #Ends script
                return
            }
        }
    }
    $browse.SelectedPath
    $browse.Dispose()
} 

$folderinput = Find-Folders1

write-output $folderinput

}



function output {
function Find-Folders2 {
    [Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms") | Out-Null
    [System.Windows.Forms.Application]::EnableVisualStyles()
    $browse = New-Object System.Windows.Forms.FolderBrowserDialog
    $browse.SelectedPath = "C:\"
    $browse.ShowNewFolderButton = $false
    $browse.Description = "Select a directory"

    $loop = $true
    while($loop)
    {
        if ($browse.ShowDialog() -eq "OK")
        {
        $loop = $false
		
		#Nothing required here as we only want the selected folder as a variable
		
        } else
        {
            $res = [System.Windows.Forms.MessageBox]::Show("You clicked Cancel. Would you like to try again or exit?", "Select a location", [System.Windows.Forms.MessageBoxButtons]::RetryCancel)
            if($res -eq "Cancel")
            {
                #Ends script
                return
            }
        }
    }
    $browse.SelectedPath
    $browse.Dispose()
} 

$folderoutput = Find-Folders2
write-output  $folderoutput

}

###Confirm Environment

cls
Welcome
pause
$directory1 = input
write-host -ForegroundColor Yellow "Your Chosen Input Directory Is:" $directory1
write-host "Now, please select a destination directory to copy the samples to....."
$directory2 = output
write-host -ForegroundColor Yellow "Your Chosen Output Directory Is:" $directory2
write-host ""
write-host "Only Information is gathered on the first run and a log will be outputted on the screen..." - -ForegroundColor Green
pause

write-host ""

write-host "Getting list of kick samples...."
Get-ChildItem -Name -Path $folderinput -Recurse -Filter "*kick*" -File | Out-file $directory2\kickoutput.txt
write-host "Completed...."-ForegroundColor Green

write-host "Getting list of snare samples...."
Get-ChildItem -Name -Path $folderinput -Recurse -Filter "*snare*" -File | Out-file $directory2\snareoutput.txt
write-host "Completed...."-ForegroundColor Green

write-host "Getting list of hat samples...."
Get-ChildItem -Name -Path $folderinput -Recurse -Filter "*hat*" -File | Out-file $directory2\hatoutput.txt
write-host "Completed...."-ForegroundColor Green

write-host "Getting list of clap samples...."
Get-ChildItem -Name -Path $folderinput -Recurse -Filter "*clap*" -File | Out-file $directory2\clapoutput.txt
write-host "Completed...."-ForegroundColor Green

$kickcount = Get-Content -path C:\temp\kickoutput.txt | Measure-Object -Line | select-object -ExpandProperty lines
$snarecount = Get-Content -path C:\temp\snareoutput.txt | Measure-Object -Line | select-object -ExpandProperty lines
$hatcount = Get-Content -path C:\temp\hatoutput.txt | Measure-Object -Line | select-object -ExpandProperty lines
$clapcount = Get-Content -path C:\temp\clapoutput.txt | Measure-Object -Line | select-object -ExpandProperty lines

write-host "Total Kicks found:" $kickcount

write-host "Total Snares found:" $snarecount

write-host "Total Hats Found:" $hatcount

write-host "Total Claps Found:" $clapcount

