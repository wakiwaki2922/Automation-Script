function Show-ProgressBar {
    param ($value, $total)
    $percentage = [math]::Round(($value / $total) * 100)
    $filled = [math]::Round($percentage / 5)
    $empty = 20 - $filled
    $bar = ("[" + "#" * $filled + "-" * $empty + "]").PadRight(22)
    return "$bar $percentage%"
}

function Write-ColoredLine {
    param ($label, $value, $labelColor = "Cyan", $valueColor = "White")
    Write-Host $label -NoNewline -ForegroundColor $labelColor
    Write-Host $value -ForegroundColor $valueColor
}

# Get system info
$computerName = $env:COMPUTERNAME
$os = Get-CimInstance Win32_OperatingSystem
$osName = $os.Caption
$osVersion = $os.Version
$osBuild = $os.BuildNumber
$bootTime = $os.LastBootUpTime
$uptime = (Get-Date) - $bootTime
$uptimeStr = "{0} days, {1:D2} hours, {2:D2} minutes" -f $uptime.Days, $uptime.Hours, $uptime.Minutes
$resolution = (Get-CimInstance -ClassName Win32_VideoController | Select-Object -First 1).VideoModeDescription -replace ' x 4294967296 colors', ''
$cpu = Get-CimInstance Win32_Processor
$gpus = Get-CimInstance Win32_VideoController | Where-Object { $_.Name -notlike "*Microsoft Basic Display Adapter*" }
$totalMemory = [math]::Round((Get-CimInstance Win32_ComputerSystem).TotalPhysicalMemory / 1GB, 2)
$freeMemory = [math]::Round((Get-CimInstance Win32_OperatingSystem).FreePhysicalMemory / 1MB, 2)
$usedMemory = [math]::Round($totalMemory - $freeMemory, 2)
$memoryUsage = [math]::Round(($usedMemory / $totalMemory) * 100, 2)
$disks = Get-CimInstance Win32_LogicalDisk | Where-Object { $_.DriveType -eq 3 }

# Display system info
Clear-Host
Write-Host "`n=== System Information for $computerName ===`n" -ForegroundColor Yellow

Write-ColoredLine "OS:`t`t" $osName
Write-ColoredLine "Version:`t" "$osVersion (Build $osBuild)"
Write-ColoredLine "Uptime:`t`t" $uptimeStr
Write-ColoredLine "Resolution:`t" $resolution

Write-Host "`n--- Hardware ---`n" -ForegroundColor Green
Write-ColoredLine "CPU:`t`t" $cpu.Name
Write-ColoredLine "   Cores:`t" $cpu.NumberOfCores
Write-ColoredLine "   Threads:`t" $cpu.NumberOfLogicalProcessors
Write-ColoredLine "   Speed:`t" "$([math]::Round($cpu.MaxClockSpeed / 1000, 2)) GHz"

Write-Host "`nGPU:"
for ($i = 0; $i -lt $gpus.Count; $i++) {
    Write-ColoredLine "   $($i+1):" $gpus[$i].Name
    if ($gpus[$i].AdapterRAM -ne $null) {
        $vramGB = [math]::Round($gpus[$i].AdapterRAM / 1GB, 2)
        Write-ColoredLine "      VRAM:" "$vramGB GB"
    } else {
        Write-ColoredLine "      VRAM:" "Unknown"
    }
}

Write-Host "`n--- Memory ---`n" -ForegroundColor Green
Write-ColoredLine "Total:`t`t" "$totalMemory GB"
Write-ColoredLine "Used:`t`t" "$usedMemory GB"
Write-ColoredLine "Free:`t`t" "$freeMemory GB"
$memBar = Show-ProgressBar $usedMemory $totalMemory
Write-ColoredLine "Usage:`t`t" $memBar

Write-Host "`n--- Storage ---`n" -ForegroundColor Green
foreach ($disk in $disks) {
    $driveLetter = $disk.DeviceID
    $totalDisk = [math]::Round($disk.Size / 1GB, 2)
    $freeDisk = [math]::Round($disk.FreeSpace / 1GB, 2)
    $usedDisk = [math]::Round($totalDisk - $freeDisk, 2)
    
    Write-ColoredLine "Disk $driveLetter" ""
    Write-ColoredLine "   Total:`t" "$totalDisk GB"
    Write-ColoredLine "   Used:`t" "$usedDisk GB"
    Write-ColoredLine "   Free:`t" "$freeDisk GB"
    $diskBar = Show-ProgressBar $usedDisk $totalDisk
    Write-ColoredLine "   Usage:`t" $diskBar
    Write-Host ""
}

Read-Host "`nPress Enter to exit"
