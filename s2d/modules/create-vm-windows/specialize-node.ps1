$ErrorActionPreference = "stop"

# Install required Windows features
Install-WindowsFeature Failover-Clustering -IncludeManagementTools
Install-WindowsFeature RSAT-AD-PowerShell

# Open firewall for WSFC
netsh advfirewall firewall add rule name="Allow SQL Server health check" dir=in action=allow protocol=TCP localport=59997

# Open firewall for SQL Server
netsh advfirewall firewall add rule name="Allow SQL Server" dir=in action=allow protocol=TCP localport=1433


$dcfull="example.net"
$pw = (ConvertTo-SecureString -String "Passw0rd12345!"  -AsPlainText -Force)
$usr = 'example\localvmadmin'
$creds = New-Object System.Management.Automation.PSCredential($usr,$pw)
Add-Computer -DomainName $dcfull -Credential $creds -restart -force -verbose
shutdown -r -t 5
exit 0

