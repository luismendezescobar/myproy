# Installing IIS
Import-Module servermanager
Install-WindowsFeature Web-Server -IncludeAllSubFeature
netsh advfirewall firewall add rule name="Allow IIS" dir=in action=allow protocol=TCP localport=80