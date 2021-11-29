# Install required Windows features
Install-WindowsFeature RSAT-AD-PowerShell
Install-WindowsFeature -name Web-Server -IncludeManagementTools

# Open firewall for WSFC
netsh advfirewall firewall add rule name="Allow IIS" dir=in action=allow protocol=TCP localport=80



