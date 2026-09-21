[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

Write-Host "========================================================" -ForegroundColor Cyan
Write-Host "      Auto Installer & Project Resource Sync" -ForegroundColor Cyan
Write-Host "========================================================" -ForegroundColor Cyan
Write-Host ""

# Check winget
if (-not (Get-Command winget -ErrorAction SilentlyContinue)) {
    Write-Host "[Error] winget not found. Please ensure Windows 10/11 is updated." -ForegroundColor Red
    exit 1
}

# 1. Git
Write-Host "[1/5] Checking Git..." -ForegroundColor Yellow
$gitInstalled = Get-Command git -ErrorAction SilentlyContinue
if ($gitInstalled) {
    Write-Host "  [OK] Git is installed: $(git --version)" -ForegroundColor Green
} else {
    Write-Host "  -> Installing Git..." -ForegroundColor Cyan
    winget install --id Git.Git -e --accept-package-agreements --accept-source-agreements
}

# 2. GitHub CLI
Write-Host "[2/5] Checking GitHub CLI..." -ForegroundColor Yellow
$ghInstalled = Get-Command gh -ErrorAction SilentlyContinue
if ($ghInstalled) {
    $ghVer = (gh --version | Select-Object -First 1)
    Write-Host "  [OK] GitHub CLI is installed: $ghVer" -ForegroundColor Green
} else {
    Write-Host "  -> Installing GitHub CLI..." -ForegroundColor Cyan
    winget install --id GitHub.cli -e --accept-package-agreements --accept-source-agreements
}

# 3. Antigravity 2.0
Write-Host "[3/5] Checking Antigravity 2.0..." -ForegroundColor Yellow
$agyCheck = winget list --id Google.Antigravity 2>$null
if ($agyCheck -match "Google.Antigravity") {
    Write-Host "  [OK] Antigravity 2.0 Desktop is installed." -ForegroundColor Green
} else {
    Write-Host "  -> Installing Antigravity 2.0..." -ForegroundColor Cyan
    winget install --id Google.Antigravity -e --accept-package-agreements --accept-source-agreements
}

# 4. ChatGPT Desktop
Write-Host "[4/5] Checking ChatGPT Desktop..." -ForegroundColor Yellow
$chatGptCheck = winget list --id 9PLM9XGG6VKS 2>$null
if ($chatGptCheck -match "ChatGPT") {
    Write-Host "  [OK] ChatGPT Desktop is installed." -ForegroundColor Green
} else {
    Write-Host "  -> Installing ChatGPT Desktop..." -ForegroundColor Cyan
    winget install --id 9PLM9XGG6VKS -s msstore --accept-package-agreements --accept-source-agreements
}

# 5. Download / Sync Repository to Downloads\test1
Write-Host "[5/5] Syncing repository to Downloads\test1..." -ForegroundColor Yellow
$env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")
$targetDir = Join-Path $HOME "Downloads\test1"
$repoUrl = "https://github.com/Eric200710/test1.git"

if (-not (Test-Path $targetDir)) {
    Write-Host "  -> Directory does not exist, cloning repository..." -ForegroundColor Cyan
    git clone $repoUrl $targetDir
} else {
    Write-Host "  -> Directory exists: $targetDir" -ForegroundColor Cyan
    if (Test-Path (Join-Path $targetDir ".git")) {
        Write-Host "  -> Pulling latest commits..." -ForegroundColor Cyan
        git -C $targetDir pull origin main
    } else {
        Write-Host "  -> Syncing files..." -ForegroundColor Cyan
        git clone $repoUrl "$targetDir`_temp"
        Copy-Item "$targetDir`_temp\*" -Destination $targetDir -Recurse -Force
        Remove-Item "$targetDir`_temp" -Recurse -Force
    }
}
Write-Host "  [OK] Repository sync completed!" -ForegroundColor Green

Write-Host ""
Write-Host "========================================================" -ForegroundColor Cyan
Write-Host "           All tasks completed successfully!" -ForegroundColor Green
Write-Host "========================================================" -ForegroundColor Cyan
Write-Host ""