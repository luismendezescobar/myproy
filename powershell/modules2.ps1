function get-biosinfo
{
    Get-CimInstance -classname win32_bios
}
function get-osinfo
{
    Get-CimInstance -ClassName win32_operatingsystem
}
