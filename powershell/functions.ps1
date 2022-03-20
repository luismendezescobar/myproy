#dir function:
function Get-ProcessorInfo
{
    get-counter -counter "\Processor(_total)\% Processor Time" -ComputerName node-1,witness -MaxSamples 2 -SampleInterval 1 
}

function Get-DiskInfo
{
    get-counter -counter "\PhysicalDisk(0*)\% Disk Time" -ComputerName node-1,witness -MaxSamples 5 -SampleInterval 1
}

function Get-MemoryInfo
{
    get-counter -counter "\Memory\Page Faults/sec" -ComputerName node-1,witness -MaxSamples 2 -SampleInterval 2
}
