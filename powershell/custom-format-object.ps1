function get-osinfo
{
    function new-osobject
    {
        $obj=New-Object -TypeName psobject -Property @{
            caption=$Null
            totalvm=$Null
            maxprocessorms=$Null
            installdate=$Null
            locale=$Null
            language=$Null
            creationclass=$Null
            ostype=$Null
        }
        $obj.psobject.typenames.insert(0,'OSInfo')
        Write-Output $obj
    }

    #get the custom object
    $obj=new-osobject

    $os=get-ciminstance -ClassName win32_operatingsystem
    $obj.caption=$os.Caption
    $obj.totalvm=$os.TotalVirtualMemorySize
    $obj.maxprocessorms=$os.MaxProcessMemorySize
    $obj.installdate=$os.InstallDate
    $obj.locale=$os.Locale
    $obj.language=$os.OSLanguage
    $obj.creationclass=$os.CreationClassName
    $obj.ostype=$os.OSType

    Write-Output $obj

}





















