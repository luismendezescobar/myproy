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
    Switch ($Operation)
    {
        "Add" {$Data=addition -N1 $Num1 -N2 $Num2}
        "Substract" {$Num1-$Num2}
        "Multiply" {$Num1*$Num2}
        "Divide" {$Num1/$Num2}
    }
    Write-Output $Data
}