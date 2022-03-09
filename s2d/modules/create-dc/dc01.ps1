$op = Get-LocalUser | where-Object Name -eq "localvmadmin" | Measure
if ($op.Count -eq 0) {
   Write-Host "User localvmadmin does not exist. The full script is going to be executed."
} else {
	Write-Host "User exist localvmadmin exit"
	exit 0
}




Install-WindowsFeature -Name AD-Domain-Services -IncludeManagementTools

net user /add localvmadmin Passw0rd12345! 
net localgroup administrators localvmadmin /add

net user Administrator Passw0rd12345!
net user Administrator /active:yes


  
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





