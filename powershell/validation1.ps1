function get-counterdata
{
Param(
    $Data,
    $MaxSamples=1,
    $SampleInterval=1
)
    Switch($Data)
    {
        1 {$counter="\Processor(_total)\% Processor Time"}
        2 {$counter="\PhysicalDisk(0*)\% Disk Time"}
        3 {$counter="\Memory\Page Faults/sec"}
    }
    Get-counter -Counter $counter -MaxSamples $MaxSamples -SampleInterval $SampleInterval

}