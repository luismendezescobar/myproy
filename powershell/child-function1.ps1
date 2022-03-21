function do-math
{
Param (
    $Num1,
    $Num2,
    $Operation
)
    Switch ($Operation)
    {
        "Add" {$Num1+$Num2}
        "Substract" {$Num1-$Num2}
        "Multiply" {$Num1*$Num2}
        "Divide" {$Num1/$Num2}
    }
}