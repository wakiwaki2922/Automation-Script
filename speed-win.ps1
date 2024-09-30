# Create temp directory and download Speedtest CLI
$tempDir = Join-Path $env:TEMP "SpeedtestCLI"
New-Item -ItemType Directory -Force -Path $tempDir | Out-Null
$speedtestPath = Join-Path $tempDir "speedtest.exe"
Invoke-WebRequest -Uri "https://install.speedtest.net/app/cli/ookla-speedtest-1.2.0-win64.zip" -OutFile "$tempDir\speedtest.zip"
Expand-Archive -Path "$tempDir\speedtest.zip" -DestinationPath $tempDir -Force

# Run speed test
Write-Host "Running speed test..."
$speedtestOutput = & $speedtestPath --format=json --progress=no --accept-license --accept-gdpr

# Process and display results
try {
    $result = $speedtestOutput | ConvertFrom-Json
    
    # Convert speed to human-readable format
    function ConvertToHumanReadable($speedInMbps) {
        if ($speedInMbps -ge 1000) {
            return "$([math]::Round($speedInMbps / 1000, 2)) Gbps"
        } else {
            return "$([math]::Round($speedInMbps, 2)) Mbps"
        }
    }
    $downloadSpeed = ConvertToHumanReadable($result.download.bandwidth / 125000)
    $uploadSpeed = ConvertToHumanReadable($result.upload.bandwidth / 125000)

    # Output results
    Write-Host "`nSpeed Test Results:"
    Write-Host "Download: $downloadSpeed"
    Write-Host "Upload: $uploadSpeed"
    Write-Host "Ping: $($result.ping.latency) ms"
    Write-Host "ISP: $($result.isp)"
} catch {
    Write-Host "Failed to read speed test results. Error: $_"
}

# Delete temp directory
Remove-Item $tempDir -Recurse -Force -ErrorAction SilentlyContinue

# Clean up any speedtest-related files in %TEMP%
Get-ChildItem $env:TEMP -Recurse | Where-Object { $_.Name -like "*speedtest*" } | Remove-Item -Force -Recurse -ErrorAction SilentlyContinue

# Notify completion
Write-Host "`nCompleted and cleaned up."

# Note: Self-deletion of script skipped when using irm | iex
