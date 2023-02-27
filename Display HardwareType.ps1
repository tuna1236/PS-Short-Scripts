$HardwareType = (Get-CimInstance -Class Win32_ComputerSystem -Property PCSystemType).PCSystemType
#If hardware is desktop do this if not skip
if ($HardwareType = 1) {
	write-host "Desktop"
	}
	else{
	write-host "Laptop"	
	}

