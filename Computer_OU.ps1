$ComputerName = '%PCNAME%'
$ComputerOURaw = Get-ADComputer -Filter "Name -like '$ComputerName'" | Select DistinguishedName
$ComputerOUSel = $ComputerOURaw.DistinguishedName
$ComputerOUSel
