add-windowsfeature FS-FileServer

$dcfull="example.net"
$pw = (ConvertTo-SecureString -String "Passw0rd12345!"  -AsPlainText -Force)
$usr = 'example\localvmadmin'
$creds = New-Object System.Management.Automation.PSCredential($usr,$pw)
Add-Computer -DomainName $dcfull -Credential $creds -restart -force -verbose
shutdown -r -t 5
exit 0

