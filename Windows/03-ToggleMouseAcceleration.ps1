# Toggle-MouseAccel.ps1
Add-Type @"
using System;
using System.Runtime.InteropServices;
public class Mouse {
    [DllImport("user32.dll")]
    public static extern bool SystemParametersInfo(uint action, uint param, int[] vparam, uint winIni);
}
"@

$SPI_GETMOUSE = 0x0003
$SPI_SETMOUSE = 0x0004
$m = New-Object int[] 3   # [threshold1, threshold2, speed]
[Mouse]::SystemParametersInfo($SPI_GETMOUSE, 0, $m, 0) | Out-Null

if ($m[2] -eq 0) { $m = @(6, 10, 1); $state = 'ON' } else { $m = @(0, 0, 0); $state = 'OFF' }

# 3 = save to registry + notify apps
[Mouse]::SystemParametersInfo($SPI_SETMOUSE, 0, $m, 3) | Out-Null
"Mouse acceleration: $state"
