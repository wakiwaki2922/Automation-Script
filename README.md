# Automation Script Repository

A collection of automation scripts to assist with daily tasks. These scripts are designed to save time and increase work efficiency.

## Scripts

### 1. Speed Test Script (speed-win.ps1)

**Description:** Automatically downloads and runs Speedtest CLI, displaying network speed results.

**Usage:**
```powershell
irm https://raw.githubusercontent.com/wakiwaki2922/Automation-Script/main/speed-win.ps1 | iex
```

**Key Features:**
- Downloads Speedtest CLI
- Runs speed test
- Shows results (Download, Upload, Ping, ISP)
- Auto-cleans temporary files

### 2. System Information Script (sysinfo-win.ps1)

**Description:** Collects and displays detailed system information in a colorful, easy-to-read format.

**Usage:**
```powershell
irm https://raw.githubusercontent.com/wakiwaki2922/Automation-Script/main/sysinfo-win.ps1 | iex
```

**Key Features:**
- Displays OS information (Name, Version, Build, Uptime)
- Shows hardware details (CPU, GPU, Memory)
- Presents storage information for all drives
- Uses color-coded output for better readability
- Includes progress bars for memory and disk usage

## Contributing

To contribute new scripts or improve existing ones, please create a pull request with details of your changes.

## Notes

- Understand the script content before running.
- Some scripts may require admin rights.
- Keep scripts updated for the latest and safest versions.

## Contact

For questions or suggestions, please create an issue in this repository.

---

*Note: This repository is maintained as a personal project. Use scripts with caution and understanding of their impact on your system.*
