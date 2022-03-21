function do-math
{
Param (
    $Num1,
    $Num2,
    $Operation
)
    function addition
    {
        param($N1,$N2)
        Write-Output ($N1+$N2)
    }
    function subs
    {
        param($N1,$N2)
        Write-Output ($N1-$N2)
    }
    function mult
    {
        param($N1,$N2)
        Write-Output ($N1*$N2)
    }
    function div
    {
        param($N1,$N2)
        Write-Output ($N1/$N2)
    }

    Switch ($Operation)
    {
        "Add"       {$Data=addition -N1 $Num1 -N2 $Num2}
        "Substract" {$Data=subs -N1 $Num1 -N2 $Num2}
        "Multiply"  {$Data=mult -N1 $Num1 -N2 $Num2}
        "Divide"    {$Data=div -N1 $Num1 -N2 $Num2}
    }
    Write-Output $Data
}