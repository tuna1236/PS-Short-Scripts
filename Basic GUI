#https://theitbros.com/powershell-gui-for-scripts/


#Adds the System form
Add-Type -assembly System.Windows.Forms
$main_form = New-Object System.Windows.Forms.Form


#Sets the size of the GUI and the Title
$main_form.Text ='GUI for my PoSh script'
$main_form.Width = 600
$main_form.Height = 400


#Allows you to change the size
$main_form.AutoSize = $true


#Adds Text to the gui
$Label = New-Object System.Windows.Forms.Label
$Label.Text = "AD users"
$Label.Location  = New-Object System.Drawing.Point(0,10)
$Label.AutoSize = $true
$main_form.Controls.Add($Label)

#Shows Ad users in drop down box
$ComboBox = New-Object System.Windows.Forms.ComboBox
$ComboBox.Width = 300
$Users = get-aduser -filter * -Properties SamAccountName
Foreach ($User in $Users)
{$ComboBox.Items.Add($User.SamAccountName);}
$ComboBox.Location  = New-Object System.Drawing.Point(60,10)
$main_form.Controls.Add($ComboBox)


#Adds time and lass password change
$Label2 = New-Object System.Windows.Forms.Label
$Label2.Text = "Last Password Set:"
$Label2.Location  = New-Object System.Drawing.Point(0,40)
$Label2.AutoSize = $true
$main_form.Controls.Add($Label2)
$Label3 = New-Object System.Windows.Forms.Label
$Label3.Text = ""
$Label3.Location  = New-Object System.Drawing.Point(110,40)
$Label3.AutoSize = $true
$main_form.Controls.Add($Label3)

#Adds Button
$Button = New-Object System.Windows.Forms.Button
$Button.Location = New-Object System.Drawing.Size(400,10)
$Button.Size = New-Object System.Drawing.Size(120,23)
$Button.Text = "Check"
$main_form.Controls.Add($Button)

#Code for Button
$Button.Add_Click(
{$Label3.Text =  [datetime]::FromFileTime((Get-ADUser -identity $ComboBox.selectedItem -Properties pwdLastSet).pwdLastSet).ToString('MM dd yy : hh ss')}
)



#Hides lables on screen
$Label3.Text.Visible = $false
# or $True if you want to show it

#Notification Message Box
[void] [System.Windows.MessageBox]::Show( "All changes have been implemented successfully ", "Script completed", "OK", "Information" )

#Answser Message Box
$answer = [System.Windows.MessageBox]::Show( "Dou you want to remove this user?", " Removal Confirmation", "YesNoCancel", "Warning" )


#Ask For creds
#$creds = Get-Credential $UserName
#$getUsername = $creds.GetNetworkCredential( ).UserName
#$getPassword = $creds.GetNetworkCredential( ).Password





#Makes the screen show
$main_form.ShowDialog()
