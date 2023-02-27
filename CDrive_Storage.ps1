$PreSize = Get-Volume -DriveLetter C
$Size = $PreSize.size/1Gb
[math]::Round($Size)
