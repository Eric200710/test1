@echo off
chcp 65001 >nul
title 自動安裝軟體與下載專案資源
echo ========================================================
echo   開始自動安裝工具與下載倉庫資源
echo ========================================================
echo.

:: 檢查系統是否有 winget
where winget >nul 2>&1
if %ERRORLEVEL% neq 0 (
    echo [錯誤] 系統中未找到 winget 套件管理工具。
    echo 請確認您的 Windows 系統為 Windows 10 (1809+) 或 Windows 11。
    pause
    exit /b 1
)

:: 1. 安裝 Git
echo [1/5] 正在安裝 / 更新 Git...
winget install --id Git.Git -e --accept-package-agreements --accept-source-agreements

:: 2. 安裝 GitHub CLI
echo.
echo [2/5] 正在安裝 / 更新 GitHub CLI...
winget install --id GitHub.cli -e --accept-package-agreements --accept-source-agreements

:: 3. 安裝 Antigravity 2.0
echo.
echo [3/5] 正在安裝 / 更新 Antigravity 2.0...
winget install --id Google.Antigravity -e --accept-package-agreements --accept-source-agreements

:: 4. 安裝 ChatGPT 桌面版
echo.
echo [4/5] 正在安裝 / 更新 ChatGPT 桌面版...
winget install --id 9PLM9XGG6VKS -s msstore --accept-package-agreements --accept-source-agreements

:: 重新補充當前工作階段的 PATH，確保可立即呼叫 git 指令
set "PATH=%PATH%;%ProgramFiles%\Git\cmd;%ProgramFiles%\Git\bin;%LOCALAPPDATA%\Programs\Git\cmd;%ProgramFiles%\GitHub CLI"

:: 5. 下載/同步倉庫資源至 Downloads\test1
echo.
echo [5/5] 下載倉庫資源至 Downloads\test1...
set "TARGET_DIR=%USERPROFILE%\Downloads\test1"
set "REPO_URL=https://github.com/Eric200710/test1.git"

if not exist "%TARGET_DIR%" (
    echo 目標資料夾不存在，正在為您 Clone 倉庫...
    git clone %REPO_URL% "%TARGET_DIR%"
) else (
    echo 目標資料夾已存在: %TARGET_DIR%
    if exist "%TARGET_DIR%\.git" (
        echo 正在同步最新版本 (git pull)...
        cd /d "%TARGET_DIR%"
        git pull origin main
    ) else (
        echo 正在複製倉庫內容至該資料夾...
        git clone %REPO_URL% "%TARGET_DIR%_temp"
        xcopy /s /e /y "%TARGET_DIR%_temp\*" "%TARGET_DIR%\"
        rmdir /s /q "%TARGET_DIR%_temp"
    )
)

echo.
echo ========================================================
echo   安裝與下載作業已順利完成！
echo ========================================================
echo.
pause
