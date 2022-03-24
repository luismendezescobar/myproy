$stream_reader = New-Object System.IO.StreamReader{C:\repos\others\myproy\powershell\list_compute.txt}
$line_number = 1
while (($current_line =$stream_reader.ReadLine()) -ne $null)
{
Write-Host "$line_number  $current_line"
$line_number++


}



 foreach ($server in (Get-Content C:\temp\servers.txt)) {
     $test = Get-ADComputer -Filter { Name -eq $server }
     if ($test) {
         Write-Output "$server,Yes" | Out-File C:\temp\AD_result.txt -Append
     }
     else {
         Write-Output "$server,Not" | Out-File C:\temp\AD_result.txt -Append
     }
 }


    