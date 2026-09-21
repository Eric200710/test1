@echo off
title Auto Installer and Project Setup
cd /d "%~dp0"

REM Check if setup.ps1 exists locally; if not, download from GitHub
if not exist "%~dp0setup.ps1" (
    echo [Info] setup.ps1 not found locally. Downloading from GitHub...
    powershell.exe -NoProfile -ExecutionPolicy Bypass -Command "[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; (New-Object System.Net.WebClient).DownloadFile('https://raw.githubusercontent.com/Eric200710/test1/main/setup.ps1', '%~dp0setup.ps1')"
    if not exist "%~dp0setup.ps1" (
        echo [Error] Failed to download setup.ps1 from GitHub.
        echo Please check your internet connection and try again.
        pause
        exit /b 1
    )
    echo [OK] setup.ps1 downloaded successfully.
    echo.
)

powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%~dp0setup.ps1"

echo.
pause
