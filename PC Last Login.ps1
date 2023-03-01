$ComputerName = "Name"
$Server = Get-ADComputer -Identity  $ComputerName  -Properties * | Select-Object  lastLogon
[datetime]::FromFileTime($Server.lastLogon)
