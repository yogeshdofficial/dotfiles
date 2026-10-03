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


# 1. Force load PSReadLine to prevent any timing conflicts
Import-Module PSReadLine

# 2. Strict Fish-Style Arrow Key Prefix Search
# This will strictly match past commands STARTING with your typed text (Fish style)
Set-PSReadLineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadLineKeyHandler -Key DownArrow -Function HistorySearchForward

# 3. Fish-Style Predictive Autosuggestions (Inline Gray Text)
#Set-PSReadLineOption -PredictionSource History
#Set-PSReadLineOption -PredictionViewStyle InlineView

# 4. Power-User Fish Keybindings for Suggestions
# [Right Arrow] accepts the ENTIRE suggestion
Set-PSReadLineKeyHandler -Key RightArrow -Function AcceptSuggestion
# [Ctrl + Right Arrow] accepts only the NEXT WORD of the suggestion (Exactly like Fish!)
Set-PSReadLineKeyHandler -Key Ctrl+RightArrow -Function ForwardWord


Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+t' -PSReadlineChordReverseHistory 'Ctrl+r'

#Set-PSReadLineKeyHandler -Key Tab -ScriptBlock { Invoke-FzfTabCompletion }
# Start with visible preview on the right
#Set-PsFzfOption -TabCompletionPreviewWindow 'right|down|hidden'

# Start hidden and toggle between up, left, and hidden
#Set-PsFzfOption -TabCompletionPreviewWindow 'hidden|up|left|hidden'


# 5. Quick Toggle to List View (Fish/Zsh completion menu)
# Pressing [F2] dynamically switches between Fish inline view and a vertical menu
Set-PSReadLineKeyHandler -Key F2 -ScriptBlock {
  $options = Get-PSReadLineOption
  if ($options.PredictionViewStyle -eq 'InlineView')
  {
    Set-PSReadLineOption -PredictionViewStyle ListView
  } else
  {
    Set-PSReadLineOption -PredictionViewStyle InlineView
  }
}

