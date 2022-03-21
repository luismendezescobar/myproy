function do-anything
{
  
        $obj=New-Object -TypeName psobject -Property @{
            num1=5
            num2=10
        }
        $obj.psobject.typenames.insert(0,'FunStuff')
        Write-Output $obj
}

