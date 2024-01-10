#By Cole Patterson
#Version 1
#01/04/2024
$Folder = "C:\Local_Admin1"
if (Test-Path -Path $Folder) {
} else {New-Item -Path "C:\Local_Admin1" -ItemType Directory | out-null}
		
Start-Transcript -Path "C:\Local_Admin1\Local Admins.log";

$FileLocation = Read-Host -Prompt 'Enter file location of computers to scan Exzample (C:\ScanList.txt)'

$FileLocation = Get-Content -Path $FileLocation

#Creates List
$NoLocaladminlist = @()
$Localadminlist = @()

$CountNumber = 0

$Totalcount = $FileLocation.count

ForEach ($ComputerName in $FileLocation) {
	try {
		$CountNumber += 1
		Write-Host "Working on $CountNumber of $Totalcount"
		$testSession = Test-Connection -ComputerName $ComputerName -ErrorAction 'stop'
		
		try{
			
			#Get Local Admin List
			$LocalAdminUserslist1 = Invoke-Command -ComputerName $ComputerName -ScriptBlock{Get-LocalGroupMember -Name 'Administrators'}

			$LocalAdminUserslist1 = [System.Collections.ArrayList]$LocalAdminUserslist1.name
			$LocalAdminUserslist = $LocalAdminUserslist1.replace("ODF\","").replace("$($ComputerName)\","")
			$LocalAdminUserslist = [System.Collections.ArrayList]$LocalAdminUserslist
			
			[System.Collections.ArrayList]$LocalAdminUserslist = $LocalAdminUserslist
			try{
				#Write-host "Online: $ComputerName"
				$LocalAdminUserslist.remove("CONTROLLER$")
				$LocalAdminUserslist.remove("CoordAdmins")
				$LocalAdminUserslist.remove("Domain Admins")
				$LocalAdminUserslist.remove("GISAdmins")
				$LocalAdminUserslist.remove("Lansweeper_Svc")
				$LocalAdminUserslist.remove("SECSCAN")
				$LocalAdminUserslist.remove("Administrator")
				$LocalAdminUserslist.remove("LCadmin")
				$LocalAdminUserslist.remove("vboxuser")
				$LocalAdminUserslist.remove("secscan")
				$LocalAdminUserslist.remove("lcadmin")
				
			}
			Catch{write-host ""}
			
			if([string]::IsNullOrEmpty($LocalAdminUserslist)){
				Write-host "Local Admin Empty: $ComputerName"
				$NoLocaladminlist += $ComputerName
				Add-Content -Path "C:\Local_Admin1\No Local Admins.txt" -Value $ComputerName
			}
			else{
				Write-host "Local Admin Detected: $ComputerName"
				$Localadminlist += "$ComputerName , $LocalAdminUserslist"
				Add-Content -Path "C:\Local_Admin1\Local Admins.txt" -Value "$ComputerName , $LocalAdminUserslist"
			}	
		}
		catch{
			Write-host "Win-RM Fail: $ComputerName"
			Add-Content -Path "C:\Local_Admin1\Win-RM Fail.txt" -Value $ComputerName
		}

	}
	catch{
		write-host "Offline: $($ComputerName)"
		Add-Content -Path "C:\Local_Admin1\Offline.txt" -Value $ComputerName
	}
	Write-host " "
}

Stop-Transcript

#Exports No Local Admin File
Write-host "Exporting No Local Admin List"
$NoLocaladminlist | Out-File -Append "C:\Local_Admin1\No Local Admins.csv" -Encoding UTF8
	
#Exports Local Admin File
write-host "Exporting Local Admin List"
$Localadminlist | Out-File -Append "C:\Local_Admin1\Local Admins.csv" -Encoding UTF8

Write-host "Program Finished"
Pause


