$isOutlookOpen = Get-Process outlook*
if($isOutlookOpen = $null){
    # Outlook is already closed run code here:
    }
else {
     $isOutlookOpen = Get-Process outlook*

     # while loop makes sure all outlook windows are closed before moving on to other code:
         while($isOutlookOpen -ne $null){
            Get-Process outlook* | ForEach-Object {$_.CloseMainWindow() | Out-Null }
            sleep 5
            If(($isOutlookOpen = Get-Process outlook*) -ne $null){
            Write-Host "Outlook is Open.......Closing Outlook"
                $wshell = new-object -com wscript.shell
                $wshell.AppActivate("Microsoft Outlook")
                $wshell.Sendkeys("%(Y)")
            $isOutlookOpen = Get-Process outlook*
            }
        }
        #Outlook has been closed run code here:
    }
