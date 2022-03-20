Get-CimInstance -ClassName Win32_OperatingSystem | Select-Object -Property DataExecutionPrevention_SupportPolicy
Get-Module -ListAvailable