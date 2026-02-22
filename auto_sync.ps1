$dotfilesPath = "D:\dotfiles"
cd $dotfilesPath


Write-Host "Exportando lista de aplicaciones..." -ForegroundColor Cyan
winget export -o "$dotfilesPath\apps.json" --include-versions --accept-source-agreements


Write-Host "Exportando extensiones de VS Code..." -ForegroundColor Cyan
# Usamos la ruta completa por si el alias falla
$codePath = "$env:LocalAppData\Programs\Microsoft VS Code\bin\code"
if (Test-Path $codePath) {
    & $codePath --list-extensions > "$dotfilesPath\vscode_extensions.txt"
}


Write-Host "Copiando settings de VS Code..." -ForegroundColor Cyan
$vsCodeSettings = "$env:APPDATA\Code\User\settings.json"
if (Test-Path $vsCodeSettings) {
    Copy-Item $vsCodeSettings -Destination "$dotfilesPath\vscode_settings.json" -Force
}


Write-Host "Exportando tema de la terminal..." -ForegroundColor Cyan
oh-my-posh config export --format json > "$dotfilesPath\terminal_theme.json"


Write-Host "Sincronizando archivos de sistema..." -ForegroundColor Cyan
Copy-Item $PROFILE -Destination "$dotfilesPath\Microsoft.PowerShell_profile.ps1" -Force
Copy-Item "$HOME\.wslconfig" -Destination "$dotfilesPath\.wslconfig" -Force
Copy-Item "$HOME\.gitconfig" -Destination "$dotfilesPath\.gitconfig" -Force


Write-Host "Subiendo cambios a GitHub (Muriel627)..." -ForegroundColor Green
git add .
$fecha = Get-Date -Format "dd-MM-yyyy HH:mm"
git commit -m "Auto-Sync: Entorno Completo ($fecha)"
git push origin master

Write-Host "--- Sincronización finalizada con éxito ---" -ForegroundColor Green