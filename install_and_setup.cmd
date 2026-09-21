@echo off
title Auto Installer and Project Setup
cd /d "%~dp0"

powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%~dp0setup.ps1"

echo.
pause
