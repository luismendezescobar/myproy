${my var}="Hello var with space"

$myvar="hello with no spaces"
${my var}

Write-Output $myvar

[string]$myname="jason"
[int]$oops=10
$x=[int]"5"
$x

[int]$x="20"
$x

$d="12/25/2013"
$d
#$d.PadLeft(100)


[datetime]$d="12/25/2013"
$d.day
$d.Month
$d.Year
$d.DayOfWeek
$d.DayOfYear



[string]$computename=read-host "Enter computer name"
Write-Output $computename


$p=get-process lsass
$p

#how to evaluate a subexpression
"process id=$($p.id)"
"process id = $(Read-Host -Prompt "What should I give them?")"


#double quotes resolve the variable
$i="PowerShell"
"this is the variable $i, and $i rocks!"

$mycomputer="LAPTOP-JTQDNU48"
Get-Service -name bits -ComputerName $mycomputer |select machinename,name,status

########################
#object members and variables
#variables are very flexible
$service=get-service -name bits
$service|Get-Member
$service.Status
$service.MachineName
$service.DisplayName
$service.start()
$service.Status
$service.Stop()
$service.Status
$msg="service name is $($service.name.ToUpper())"
$msg

#working with multiple objects
$services=get-service
$services[0]
$services[0].Status
$services[-1].Name

"service name is $($services[4].DisplayName)"
"service name is $($services[4].name.ToUpper())"
$services.Count
$services[0..5].displayname

#############################################################
#parenthesis help!

#create a txt and csv vile
'LAPTOP-JTQDNU48'|out-file C:\temp\computers.txt
"computer_name,ipaddress"|out-file C:\temp\computers.csv
"LAPTOP-JTQDNU48,192.168.1.10"|out-file C:\temp\computers.csv -Append
"client01,192.168.1.20"|out-file C:\temp\computers.csv -Append

#getting names from a txt file
Get-Content C:\temp\computers.txt
get-service -Name BITS -ComputerName (Get-Content C:\temp\computers.txt)

#getting names from a csv file
Import-Csv C:\temp\computers.csv
Import-Csv C:\temp\computers.csv | select -ExpandProperty computer_name
get-service -ComputerName (Import-Csv C:\temp\computers.csv | select -ExpandProperty computer_name)


Import-Csv C:\temp\computers.csv|Get-Member
Import-Csv C:\temp\computers.csv|select computer_name|gm
Import-Csv C:\temp\computers.csv|select -ExpandProperty computer_name|gm
Import-Csv C:\temp\computers.csv|select -ExpandProperty computer_name


(Import-Csv C:\temp\computers.csv).computer_name
get-service -ComputerName (Import-Csv C:\temp\computers.csv).computer_name

#using with active directory
Invoke-Command -ComputerName (get-adcomputer -filter "name -like '*c*'" |
    select -ExpandProperty name) -ScriptBlock {get-service -name bits}
###################################################################
#          conditionals if               ##########################
###################################################################

$status=(get-service -name bits).Status
if ($status -eq "Running"){
    clear-host
    Write-Output "Service is running"
}else{
    clear-host
    Write-Output "Service is not running"
}


$x=if($false){1} else{2}
$x




$status=3
switch($status){
    0 {$result_test='ok'}
    1 {$result_test='error'}
    2 {$result_test='jammed'}
    3 {$result_test='overheated'}
    4 {$result_test='empty'}
    default {$result_test='unknown'}
}

$result_test

#this code will give the same result as above but is cleaner
$status=3

$result_test=switch($status){
    0 {'ok'}
    1 {'error'}
    2 {'jammed'}
    3 {'overheated'}
    4 {'empty'}
    default {'unknown'}
}

$result_test

################################################################################
#  loops                                               #########################
################################################################################
#do loop
$i=1
do {
    Write-Output "Powershell is great! $i"
    $i=$i+1 #i++
}while($i -le 5)

#while loop
$i=5
while($i -ge 1) {
    Write-Output "Scripting is great! $i"
    $i--
}

#for each
$services =Get-Service
foreach($s in $services){
    $s.DisplayName
}

#for loop
for($i=0;$i -lt 5;$i++){
    $i
}
#another way
$i=0
1..3|ForEach-Object -Process{
    start calc
    $i++
    $i
}

###############################################################
##           set a tag in vmware powercli  ##########################
###############################################################
#interesting commmand to format table
Get-folder | Sort-Object|Format-Table -AutoSize
#connection to the other vcenter
#Connect-VIServer -Server ddc1-vb01vmvc01.dm.mckesson.com


Set-PowerCLIConfiguration -InvalidCertificateAction Ignore -Confirm:$false
Connect-VIServer -Server ndh1-vb01vmvc01.dm.mckesson.com

Get-folder | Sort-Object|Format-Table -AutoSize
#this is the ouput of previous command "Zerto DR Infrastructure"

Get-Folder "Zerto DR Infrastructure" | Get-TagAssignment
#output: it came in blank

get-tag |ft -autosize
Get-Folder   | New-TagAssignment -Tag "Excluded"
#assigned the tag
Get-Folder "Zerto DR Infrastructure" | Get-TagAssignment|ft -autosize
#output
#Name     Category                                 Description
#----     --------                                 -----------
#Excluded Backup Management (IBM Spectrum Protect) The object is excluded from scheduled backups by IBM Spectrum Protect