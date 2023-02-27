#Battery Levels
$batt = (Get-WmiObject Win32_Battery)
$battlevel = $batt.EstimatedChargeRemaining
