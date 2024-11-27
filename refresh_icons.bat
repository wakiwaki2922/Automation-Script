@echo off

:: Check for administrator privileges
net session >nul 2>&1
if %errorlevel% == 0 (
  echo Running as administrator...
) else (
  echo Error: This script requires administrator privileges.
  echo Please run this script as administrator.
  pause
  exit /b 1
)

:: Kill explorer.exe process
echo Killing explorer.exe process...
taskkill /IM explorer.exe /F

:: Delete icon cache files
echo Deleting icon cache files...
DEL /A /Q "%localappdata%\IconCache.db" 2>nul
DEL /A /F /Q "%localappdata%\Microsoft\Windows\Explorer\iconcache*" 2>nul

:: Restart the computer
echo Restarting the computer...
shutdown /r /t 0