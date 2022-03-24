
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
		###first check if the nodes are already in the domain
		$d = @("node-1","node-2")
		$a_result=@()
        $cont=0
		for (;;)
		{
			Foreach ($server in $d)
			{   Try {
					Get-ADComputer $server -ErrorAction Stop
					$a_result+="true"					
				}
				Catch {
					$a_result+="false"
				}				
			}				
			Foreach($element in $a_result)
			{
				if($element -eq "false"){			
					$Result="false"
					$a_result=@()
					break
				}
				else{
					$Result="true"
				}				
			}

			if($Result -eq "true"){
				break               #we may continue to the next step
			}
            else{
                $cont++
            }
            if ($cont -eq 10){
                Write-Host "Too many efforts with no success"
                break
            }

		}
		Write-Host "do something here in the server"
		
    }
	else{
		Write-Host "the script has been completed"
		exit 0
	}
}

$Folder = 'C:\Windows'
"Test to see if folder [$Folder]  exists"
if (Test-Path -Path $Folder) {
    "Path exists!"
} else {
    "Path doesn't exist."
}

$node1_found=$true
$node2_found=$false
			
if ($node1_found -and $node2_found){
    Write-Output "both nodes were found"
    write-output "Exiting"
}
else {
    Write-Output "the nodes were not found"
    write-output "Exiting"
}

if((Test-Path -Path "C:\QWitness") -eq $false){	
    Write-Output "File not found, we are going to create it"
}	