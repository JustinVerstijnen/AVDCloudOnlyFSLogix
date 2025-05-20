# PARAMETERS
# Change these 3 settings to your own settings

# Storage account FQDN
$fileServer = "yourstorageaccounthere.file.core.windows.net"

# Share name
$profilesharename = "yoursharehere"

# Storage access key 1 or 2
$storageaccesskey = "yourkeyhere"

# END PARAMETERS

# Don't change anything under this line ---------------------------------

# Formatting user input to script
$profileShare="\\$($fileServer)\$profilesharename"
$fileServerShort = $fileServer.Split('.')[0]
$user="localhost\$fileServerShort"

# Insert credentials in profile
New-Item -Path "HKLM:\Software\Policies\Microsoft" -Name "AzureADAccount" -ErrorAction Ignore
New-ItemProperty -Path "HKLM:\Software\Policies\Microsoft\AzureADAccount" -Name "LoadCredKeyFromProfile" -Value 1 -force

# Create the credentials for the storage account
cmdkey.exe /add:$fileServer /user:$($user) /pass:$($storageaccesskey)
New-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Lsa" -Name "LsaCfgFlags" -Value 0 -force