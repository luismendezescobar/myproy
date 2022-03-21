$env:PSModulePath -split ";"
Write-Output ""
$env:PSModulePath
Write-Output ""
Write-Output "$env:UserProfile\Documents\WindowsPowerShell\Modules\Mycode"
New-Item -Path "$env:UserProfile\Documents\WindowsPowerShell\Modules\Mycode" `
         -Type Directory