function df
{ git --git-dir=$HOME/.dotfiles --work-tree=$HOME @args 
}

Invoke-Expression (&starship init powershell)

(&mise activate pwsh) | Out-String | Invoke-Expression

Invoke-Expression (& { (zoxide init powershell | Out-String) })

# ${UserConfigDir}/powershell/Microsoft.PowerShell_profile.ps1
$env:CARAPACE_BRIDGES = 'zsh,fish,bash,inshellisense' # optional
Set-PSReadLineOption -Colors @{ "Selection" = "`e[7m" }
Set-PSReadlineKeyHandler -Key Tab -Function MenuComplete
carapace _carapace | Out-String | Invoke-Expression
