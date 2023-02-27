$dn = Get-Aduser -Filter {SamAccountName -eq "%Username%"} | Select DistinguishedName
$to = $dn.DistinguishedName
$OU = $to.Split(',')[1].Split('=')[1]

#Output = Techical Support
