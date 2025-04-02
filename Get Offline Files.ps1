param($computer=”localhost”, $help)


function funline ($strIN)
{
 $num = $strIN.length
 for($i=1 ; $i -le $num ; $i++)
  { $funline += “=” }
    Write-Host -ForegroundColor yellow $strIN 
    Write-Host -ForegroundColor darkYellow $funline
}


function funHelp()
{
$helpText=@”
DESCRIPTION:
NAME: GetOffLineFiles.ps1 
Prints the offline files config on a local or remote machine.

PARAMETERS: 
-computer Specifies name of the computer upon which to run the script
-help     prints help file
SYNTAX:
GetOffLineFiles.ps1 -computer localhost
Lists offline files config on a computer named localhost

GetOffLineFiles.ps1 

Lists offline files config on local computer

GetOffLineFiles.ps1 -help ?

Displays the help topic for the script
“@
$helpText
exit
}



if($help){ funline(“Obtaining help …”) ; funhelp }
$outtxt = Get-WmiObject -Class win32_OfflineFilesCache `
    -computername $computer

funline(“Offline files configuration $env:computername”)
format-table -Property active, enabled,location -autosize `
    -inputobject $outtxt
