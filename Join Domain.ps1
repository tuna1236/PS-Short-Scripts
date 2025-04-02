<#
.SYNOPSIS
Performs first configuration steps for a pre-deployment workstation.

.DESCRIPTION
Activates Windows, sets password and enables local admin. Renames computer and joins to domain. Restarts computer when finished.

# 
# Switch         Function
# ---------------------------
# [No switches]  Sets up admin account and joins domain using current machine name.
# -SkipAdmin     Don't change admin password
# -ChangeName    Sets up admin account, renames computer using supplied name, and joins domain.
#
#>

# Written By: Michael W. Lewis
# Date: 2020.02.14

param (
	[string[]]$ChangeName,
	[switch]$SkipAdmin
)
if (((Get-WmiObject win32_computersystem).Domain) -eq "Domain.local") {
    Write-Host "Already part of domain. Please login as domain admin and rerun script."
	$continue = Read-Host -prompt "Continue script?"
	if(($continue -eq "n") -or ($continue -eq "no")) {
		Pause
		Exit
	}
}


# Rename computer and add to domain
Write-Host "Rename Computer"
if(!$ChangeName) { [string]$changename = Read-Host "Enter Computer Name:" }
write-host $changename
rename-Computer -NewName $changename
if (((Get-WmiObject win32_computersystem).Domain) -ne "coascada.local") { Add-Computer -DomainName "coascada.local" }


# Modify Default Users
if (!$SkipAdmin) {
	Write-Host "Configure Administrator account"
	$a=0
	[string]$b=""
	do {
		$a++
		if( $a -gt 1 ) { $b = "Passwords did not match." }
		$Password1 = Read-Host -prompt "$b Enter New Admin Password" -AsSecureString
		$pwd1 = [Runtime.InteropServices.Marshal]::PtrToStringAuto([Runtime.InteropServices.Marshal]::SecureStringToBSTR($Password1))
		$Password2 = Read-Host -prompt "Verify Admin Password" -AsSecureString
		$pwd2 = [Runtime.InteropServices.Marshal]::PtrToStringAuto([Runtime.InteropServices.Marshal]::SecureStringToBSTR($Password2))
		$pwd1, $pwd2 = $null
	} while( $pwd1 -ne $pwd2 )

	$setadmin = Get-LocalUser -Name "Administrator"
	$setadmin | Set-LocalUser -Password $Password1
	$setadmin | Enable-LocalUser
}


$restart = Read-Host "Restart Computer?"
if(($restart -eq "yes") -or ($restart -eq "y")) { Write-Host "Restarting Computer..."; Restart-Computer }
else { Write-Host "Please restart computer as soon as possible." }

