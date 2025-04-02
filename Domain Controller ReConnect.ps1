#Fixes Group Policy Conection
$DCConection = Test-ComputerSecureChannel
if($DCConection -eq $False){Nltest.exe /sc_change_pwd:domain.local}
Else{write-host "Domain Conected"}
