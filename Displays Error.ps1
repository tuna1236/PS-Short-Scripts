Try{
  Write-host "Code here"
}
Catch{
  Write-Host "`nError Message: " $_.Exception.Message
	Write-Host "`nError in Line: " $_.InvocationInfo.Line
	Write-Host "`nError in Line Number: "$_.InvocationInfo.ScriptLineNumber
	Write-Host "`nError Item Name: "$_.Exception.ItemName
}
