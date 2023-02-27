	$RunningService = Get-Service
	
	#Adds The Items to the Drop Down List
	ForEach ($List12 in $RunningService.name) {
		$Siterefreshbutton.Items.Add($List12) | Out-Null
	}
	write-host = $RunningService
