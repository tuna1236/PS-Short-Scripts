@echo Off

echo Starting Powershell Script
powershell.exe -ExecutionPolicy Unrestricted -Command; $i "3";while($True){
    $error.clear()
    $MappedDrives = Get-SmbMapping | where -property Status -Value Unavailable -EQ | select LocalPath,RemotePath
    foreach( $MappedDrive in $MappedDrives)
	
    {try {New-SmbMapping -LocalPath $MappedDrive.LocalPath -RemotePath $MappedDrive.RemotePath -Persistent $True} 
	catch {Write-Host "There was an error mapping $MappedDrive.RemotePath to $MappedDrive.LocalPath"}}
	
	$i = $i - 1
	
	if($error.Count -eq 0 -Or $i -eq 0) {break}
	Start-Sleep -Seconds 30
}



powershell.exe -ExecutionPolicy Unrestricted; $i=3 ;while($True){;$error.clear();$MappedDrives = Get-SmbMapping | where -property Status -Value Unavailable -EQ | select LocalPath,RemotePath;foreach( $MappedDrive in $MappedDrives){;try {New-SmbMapping -LocalPath $MappedDrive.LocalPath -RemotePath $MappedDrive.RemotePath -Persistent $True}catch {Write-Host "There was an error mapping $MappedDrive.RemotePath to $MappedDrive.LocalPath"}};$i = $i - 1;if($error.Count -eq 0 -Or $i -eq 0) {break};Start-Sleep -Seconds 30}



<# :
  @echo off
    powershell /nologo /noprofile /command ^
         "&{[ScriptBlock]::Create((cat """s0""") -join [Char[]]10).Invoke(@(&{$args}%*))}"
  exit /b
#>
Write-Host Hello, $args[0] -fo Green