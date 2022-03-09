$op = Get-LocalUser | where-Object Name -eq "localvmadmin" | Measure
if ($op.Count -eq 0) {
   Write-Host "User localvmadmin does not exist. The full script is going to be executed."
} else {
	Write-Host "User exist localvmadmin exiting"
	exit 0
}

net user /add localvmadmin Passw0rd12345! 
net localgroup administrators localvmadmin /add

add-windowsfeature FS-FileServer

$DNSPrimary = "10.0.0.12"
netsh interface ip set dns Ethernet static $DNSPrimary


$dcfull="example.net"
$pw = (ConvertTo-SecureString -String "Passw0rd12345!"  -AsPlainText -Force)
$usr = 'example\localvmadmin'
$creds = New-Object System.Management.Automation.PSCredential($usr,$pw)
Add-Computer -DomainName $dcfull -Credential $creds -restart -force -verbose
shutdown -r -t 5
exit 0

