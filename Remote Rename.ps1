$ComputerName = "Current Name"
[string]$name = "New Name"
Rename-Computer -ComputerName $ComputerName -NewName $name -DomainCredential $cred -Force
