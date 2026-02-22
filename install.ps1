Write-Host "Iniciando despliegue de entorno de desarrollo." -ForegroundColor Cyan


Write-Host "[1/5] Instalando Nerd Fonts.." -ForegroundColor Yellow
oh-my-posh font install Meslo


Write-Host "[2/5] Instalando aplicaciones desde apps.json.." -ForegroundColor Yellow
if (Test-Path "apps.json") {
    winget import -i apps.json --accept-package-agreements --accept-source-agreements
} else {
    Write-Host "Error: No se encontró apps.json" -ForegroundColor Red
}


Write-Host "[3/5] Restaurando archivos de configuracion (.wslconfig, .gitconfig)..." -ForegroundColor Yellow
Copy-Item ".wslconfig" -Destination "$HOME\" -Force
Copy-Item ".gitconfig" -Destination "$HOME\" -Force


Write-Host "[4/5] Configurando perfil de PowerShell..." -ForegroundColor Yellow
$PROFILE_DIR = Split-Path -Parent $PROFILE
if (!(Test-Path $PROFILE_DIR)) { New-Item -ItemType Directory -Path $PROFILE_DIR -Force }
Copy-Item "Microsoft.PowerShell_profile.ps1" -Destination $PROFILE -Force


Write-Host "[5/5] Restaurando extensiones de VS Code..." -ForegroundColor Yellow
if (Test-Path "vscode_extensions.txt") {
    Get-Content "vscode_extensions.txt" | ForEach-Object { code --install-extension $_ }
}

Write-Host "==========================================================" -ForegroundColor Green
Write-Host "ENTORNO RESTAURADO CON ÉXITO. REINICIA LA TERMINAL." -ForegroundColor Green
Write-Host "==========================================================" -ForegroundColor Green