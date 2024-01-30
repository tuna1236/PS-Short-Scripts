$username = Get-WmiObject Win32_Process -Filter "Name='explorer.exe'" | ForEach-Object { $_.GetOwner() } | Select-Object -Unique -Expand User
$username
