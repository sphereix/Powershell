$path = "C:\Users"
$child_path = "\CTI\CORRPLAN\"
$files_filter = "*.log"

Get-ChildItem $path -Directory -Exclude Default*,Public | foreach {

    $joined_path = Join-Path -Path $_.FullName -ChildPath $child_path
    If (test-path $joined_path) {
        Remove-Item "$joined_path\$files_filter" -Force
    }
}