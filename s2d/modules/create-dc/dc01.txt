$LocalStaticIp = "10.0.0.12"
$DNSPrimary = "10.0.0.12"
$DefaultGateway = "10.0.0.1"

netsh interface ip set address name=Ethernet static `
    $LocalStaticIp 255.255.255.0 $DefaultGateway 1

netsh interface ip set dns Ethernet static $DNSPrimary

Install-WindowsFeature -Name AD-Domain-Services -IncludeManagementTools

net user /add localvmadmin Passw0rd12345! 
net localgroup administrators localvmadmin /add
  
Start-Sleep -Seconds 5

$Password = (ConvertTo-SecureString -String "Passw0rd12345!"  -AsPlainText -Force)

$Params = @{
CreateDnsDelegation = $false
DatabasePath = 'C:\Windows\NTDS'
DomainMode = '7'
DomainName = 'example.net'
DomainNetbiosName = 'example'
ForestMode = '7'
InstallDns = $true
LogPath = 'C:\Windows\NTDS'
NoRebootOnCompletion = $true
SafeModeAdministratorPassword = $Password
SysvolPath = 'C:\Windows\SYSVOL'
Force = $true
}

Install-ADDSForest @Params
Start-Sleep -Seconds 10
Restart-Computer






