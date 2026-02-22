$dotfilesPath = "D:\dotfiles"
cd $dotfilesPath


winget export -o "$dotfilesPath\apps.json" --include-versions --accept-source-agreements


copy-item $PROFILE "$dotfilesPath\Microsoft.PowerShell_profile.ps1" -Force
copy-item "$HOME\.wslconfig" "$dotfilesPath\.wslconfig" -Force
copy-item "$HOME\.gitconfig" "$dotfilesPath\.gitconfig" -Force


git add .
$fecha = Get-Date -Format "dd-MM-yyyy HH:mm"
git commit -m "Auto-Update: $fecha"
git push origin master