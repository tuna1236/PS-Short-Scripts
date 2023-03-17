echo "73 OneDrive process and explorer"
taskkill.exe /F /IM "OneDrive.exe"
taskkill.exe /F /IM "explorer.exe"

echo "Remove OneDrive"
if (Test-Path "$env:systemroot\System32\OneDriveSetup.exe") {
    & "$env:systemroot\System32\OneDriveSetup.exe" /uninstall
}
if (Test-Path "$env:systemroot\SysWOW64\OneDriveSetup.exe") {
    & "$env:systemroot\SysWOW64\OneDriveSetup.exe" /uninstall
}

echo "Disable OneDrive via Group Policies"
mkdir "HKLM:\SOFTWARE\Wow6432Node\Policies\Microsoft\Windows\OneDrive" -force
sp "HKLM:\SOFTWARE\Wow6432Node\Policies\Microsoft\Windows\OneDrive" "DisableFileSyncNGSC" 1

echo "Removing OneDrive leftovers trash"
rm "$env:localappdata\Microsoft\OneDrive" -Recurse -Force -ErrorAction SilentlyContinue
rm "$env:programdata\Microsoft OneDrive" -Recurse -Force -ErrorAction SilentlyContinue
rm "C:\OneDriveTemp" -Recurse -Force -ErrorAction SilentlyContinue

echo "Remove Onedrive from explorer sidebar"
New-PSDrive -PSProvider "Registry" -Root "HKEY_CLASSES_ROOT" -Name "HKCR"
mkdir "HKCR:\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" -Force
sp "HKCR:\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" "System.IsPinnedToNameSpaceTree" 0
mkdir "HKCR:\Wow6432Node\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" -Force
sp "HKCR:\Wow6432Node\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" "System.IsPinnedToNameSpaceTree" 0
Remove-PSDrive "HKCR"

echo "Removing run option for new users"
reg load "hku\Default" "C:\Users\Default\NTUSER.DAT"
reg delete "HKEY_USERS\Default\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "OneDriveSetup" /f
reg unload "hku\Default"

echo "Removing startmenu junk entry"
rm "$env:userprofile\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\OneDrive.lnk" -Force -ErrorAction SilentlyContinue

echo "Restarting explorer..."
start "explorer.exe"

echo "Wait for EX reload.."
sleep 15

echo "Removing additional OneDrive leftovers"
foreach ($item in (ls "$env:WinDir\WinSxS\*onedrive*")) {
    #Takeown-Folder $item.FullName
    rm $item.FullName -Recurse -Force -ErrorAction SilentlyContinue
}
