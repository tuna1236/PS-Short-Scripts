##############################
#By Cole Patterson
#1/18/2023
#V1.1
##################################

#Adds the Forms Name and creates the form
$form = new-object Windows.forms.form
$form.text = "Script Selection Form"
#Sets Forms Window
$form.minimumSize = New-Object System.Drawing.Size(370,150)
$form.maximumSize = New-Object System.Drawing.Size(370,150)

#Adds a Text Box to the form to enter the computers name
$theName = New-Object system.Windows.Forms.Textbox
$theName.location = New-Object system.Drawing.Size(0,30)
$theName.size = New-Object System.Drawing.Size(100,20)
$form.controls.add($theName)
#Adds the Computers Name Label
$label = New-Object System.Windows.Forms.Label
$label.Location = New-Object System.Drawing.Point(0,10)
$label.Size = New-Object System.Drawing.Size(100,20)
$label.Text = 'Computer Name:'
$form.Controls.Add($label)

#Adds a Text Box to enter message
$theName1.text = "Script Selection Form"
$theName1 = New-Object system.Windows.Forms.Textbox
$theName1.location = New-Object system.Drawing.Size(100,30)
$theName1.size = New-Object System.Drawing.Size(200,20)
$form.controls.add($theName1)
#Adds the Text Input Label
$label1 = New-Object System.Windows.Forms.Label
$label1.Location = New-Object System.Drawing.Point(100,10)
$label1.Size = New-Object System.Drawing.Size(100,20)
$label1.Text = 'Message to Send'
$form.Controls.Add($label1)

#Adds a button to run the script
$Go_button = new-object windows.forms.button
$Go_button.text = "Send Message"
$Go_button.location = New-Object system.Drawing.Size(0,70)
$Go_button.size = New-Object System.Drawing.Size(120,30)
$form.controls.add($Go_button)

#You can customized the command on this button
#Example below will shutdown the selected computer
#Invoke-command for remote computer can also be used (imagination is your friend 😊 )
$Go_button.add_click({Invoke-WmiMethod -Class win32_process -ComputerName $theName.text -Name create -ArgumentList  "c:\windows\system32\msg.exe * $($theName1.text)" })

$form.Add_shown({$form.Activate()})

#Shows the Form untill its Closed
$form.ShowDialog()
