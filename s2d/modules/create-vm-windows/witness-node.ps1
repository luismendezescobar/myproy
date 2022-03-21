$op = Get-LocalUser | where-Object Name -eq "localvmadmin" | Measure
if ($op.Count -eq 0) {
   Write-Host "User localvmadmin does not exist. The full script is going to be executed."
   net user /add localvmadmin Passw0rd12345! 
   net localgroup administrators localvmadmin /add
} 
#else {
#	Write-Host "User exist localvmadmin exiting"
#	exit 0
#}
###########################################################################################
#after we add the user we indicate that we have completed the first step
$file = 'c:\temp\test\test.txt'
#If the file does not exist, create it.
if (-not(Test-Path -Path $file -PathType Leaf)) {
     try {
         $null = New-Item -ItemType File -Path $file -Force -ErrorAction Stop
         Set-Content $file 1
         Write-Host "The file [$file] has been created."
     }
     catch {
         throw $_.Exception.Message
     }
}
 else {
     $file_content=get-Content $file
     if($file_content -eq 1){        #in this part we assume that the server is already in the domain
        Write-Host "the content of the file is:$file_content"
        $res=[int]$file_content+1
        Set-Content $file $res

		New-Item "C:\QWitness" –type directory
		New-SmbShare `
  		-Name QWitness `
  		-Path "C:\QWitness" `
  		-Description "SQL File Share Witness" `
  		-FullAccess  $env:username,node-1$,node-2$,example\Administrator
     }
	 else{
		Write-Host "the script has been completed"
	 }
 }
##########################################################################################

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

