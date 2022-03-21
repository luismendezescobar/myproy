function get-counterdata
{
Param(
    [parameter(Mandatory=$true)]
    [ValidateSet("Processor","Disk","Memory")] #this will display disk , memory in the commmand 
    [string]
    $Data,
    [ValidateRange(1,10)]
    [int]$MaxSamples=1,
    [ValidateRange(1,10)]
    [int]$SampleInterval=1
)
    Switch($Data)
    {
        "Processor" {$counter="\Processor(_total)\% Processor Time"}
        "Disk" {$counter="\PhysicalDisk(0*)\% Disk Time"}
        "Memory" {$counter="\Memory\Page Faults/sec"}
    }
    Get-counter -Counter $counter -MaxSamples $MaxSamples -SampleInterval $SampleInterval

}