# Get the typename of the object created by get-process 
Get-Process |gm|select -First 1 -ExpandProperty TypeName

#Open one of the powershell view files
notepad C:\Windows\System32\WindowsPowerShell\v1.0\DotNetTypes.format.ps1xml
Get-Process |Select-Object -First 1