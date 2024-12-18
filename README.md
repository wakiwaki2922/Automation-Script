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

### 3. Docker and Portainer Installation Script (docker&port-linux.sh)

**Description:** Automates the installation of Docker and Portainer on Linux systems, specifically tailored for Ubuntu.

**Usage:**
```bash
curl -sSL https://raw.githubusercontent.com/wakiwaki2922/Automation-Script/main/docker%26port-linux.sh | sudo bash
```

**Key Features:**
- Checks for root privileges
- Adds Docker GPG key and repository
- Installs Docker and its dependencies
- Creates a Docker volume for Portainer
- Installs and runs Portainer
- Includes error handling and progress messages
- Adds delays between commands for stability

### 4. Refresh Icons Script (refresh_icons.bat)

**Description:** Refreshes the Windows icon cache by killing the explorer process and deleting the icon cache files. This can resolve issues with corrupted or outdated icons.

**Usage:**
```batch
Right-click refresh_icons.bat and select "Run as administrator".
```

**Key Features:**
- Requires administrator privileges.
- Kills the `explorer.exe` process.
- Deletes `IconCache.db` and `iconcache*` files.
- Restarts the computer to apply changes.
- Includes error handling for administrator privileges check.


## Contributing

To contribute new scripts or improve existing ones, please create a pull request with details of your changes.

## Notes

- Understand the script content before running.
- Some scripts require admin rights (e.g., `refresh_icons.bat`).
- Keep scripts updated for the latest and safest versions.
- The Docker and Portainer installation script is designed for Ubuntu. Modifications may be needed for other Linux distributions.
- **Save all your work before running `refresh_icons.bat` as it restarts the explorer process.**


## Contact

For questions or suggestions, please create an issue in this repository.

---

*Note: This repository is maintained as a personal project. Use scripts with caution and understanding of their impact on your system.*
