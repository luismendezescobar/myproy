#Get-EventLog -LogName System -Newest 500 -after (get-date).AddDays(-24)
Get-CimInstance -ClassName Win32_ComputerSystem -ComputerName node-1,witness |Select-Object -Property manufacturer,model,pscomputername
Get-CimInstance -ClassName Win32_LogicalDisk -ComputerName node-1,witness
get-adcomputer -filter *
get-adcomputer -filter * -properties LastLogonDate |Select-Object -Property name,LastLogonDate