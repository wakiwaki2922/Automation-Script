# Tao thu muc tam thoi va tai Speedtest CLI
$tempDir = Join-Path $env:TEMP "SpeedtestCLI"
New-Item -ItemType Directory -Force -Path $tempDir | Out-Null
$speedtestPath = Join-Path $tempDir "speedtest.exe"

Invoke-WebRequest -Uri "https://install.speedtest.net/app/cli/ookla-speedtest-1.2.0-win64.zip" -OutFile "$tempDir\speedtest.zip"
Expand-Archive -Path "$tempDir\speedtest.zip" -DestinationPath $tempDir -Force

# Chay speed test
Write-Host "Dang chay speed test..."
$speedtestOutput = & $speedtestPath --format=json --progress=no --accept-license --accept-gdpr

# Xu ly va hien thi ket qua
try {
    $result = $speedtestOutput | ConvertFrom-Json
    
    function ConvertToHumanReadable($speedInMbps) {
        if ($speedInMbps -ge 1000) {
            return "$([math]::Round($speedInMbps / 1000, 2)) Gbps"
        } else {
            return "$([math]::Round($speedInMbps, 2)) Mbps"
        }
    }

    $downloadSpeed = ConvertToHumanReadable($result.download.bandwidth / 125000)
    $uploadSpeed = ConvertToHumanReadable($result.upload.bandwidth / 125000)

    Write-Host "`nKet qua Speed Test:"
    Write-Host "Download: $downloadSpeed"
    Write-Host "Upload: $uploadSpeed"
    Write-Host "Ping: $($result.ping.latency) ms"
    Write-Host "Nha mang: $($result.isp)"
} catch {
    Write-Host "Khong the doc ket qua speed test. Loi: $_"
}

# Xoa thu muc tam
Remove-Item $tempDir -Recurse -Force -ErrorAction SilentlyContinue

# Tu xoa script PowerShell hien tai
$scriptPath = $MyInvocation.MyCommand.Path
Start-Sleep -Seconds 2  # Cho mot khoang thoi gian ngan truoc khi xoa
Remove-Item -Path $scriptPath -Force -ErrorAction SilentlyContinue
