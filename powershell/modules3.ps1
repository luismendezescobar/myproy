#Create a manifest for your module
$Path="$env:UserProfile\Documents\WindowsPowerShell\Modules\Mycode\MyCode.psd1"

New-ModuleManifest  -Path $Path `
                    -Author "Luis a Yoder" `
                    -CompanyName "PowerIT" `
                    -Description "My powershell module" `
                    -RootModule "Mycode.psm1" `
                    -ModuleVersion 1.0


Test-ModuleManifest -path $Path |select *
