echo y | winrm quickconfig
Set-ItemProperty -Path HKLM:\SOFTWARE\Policies\Microsoft\Windows\WinRM\Service -Name IPv4Filter -Value * -Force
net stop WinRM
net start WinRM
