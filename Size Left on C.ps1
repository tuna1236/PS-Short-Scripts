PreSize = Get-Volume -DriveLetter C
$Size = $PreSize.SizeRemaining/1Gb
[math]::Round($Size)
