$stream_reader = New-Object System.IO.StreamReader{C:\repos\others\myproy\powershell\list_compute.txt}
$line_number = 1
while (($current_line =$stream_reader.ReadLine()) -ne $null)
{
Write-Host "$line_number  $current_line"
$line_number++


}



 foreach ($server in (Get-Content C:\Scripts\servers.txt)) {
     $test = Get-ADComputer -Filter { Name -eq $server }
     if ($test) {
         Write-Output "Server object $server exists in AD" | Out-File C:\Scripts\AD_result.txt -Append
     }
     else {
         Write-Output "Server object $server does not exist in AD" | Out-File C:\Scripts\AD_result.txt -Append
     }
 }