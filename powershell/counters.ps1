get-counter -counter "\Processor(_total)\% Processor Time" -ComputerName node-1,witness -MaxSamples 2 -SampleInterval 1
get-counter -counter "\PhysicalDisk(0*)\% Disk Time" -ComputerName node-1,witness -MaxSamples 5 -SampleInterval 1
get-counter -counter "\Memory\Page Faults/sec" -ComputerName node-1,witness -MaxSamples 2 -SampleInterval 2