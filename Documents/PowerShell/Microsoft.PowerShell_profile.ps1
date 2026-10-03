# ==============================================================================
# 1. ENVIRONMENT VARIABLES & FUNCTIONS
# ==============================================================================
function df
{ 
  git --git-dir="$HOME/.dotfiles" --work-tree="$HOME" $args 
}
$env:CARAPACE_BRIDGES = 'zsh,fish,bash,inshellisense'

# ==============================================================================
# 2. EXTERNAL TOOL INITIALIZATIONS
# ==============================================================================
Invoke-Expression (&starship init powershell)
(&mise activate pwsh) | Out-String | Invoke-Expression
Invoke-Expression (& { (zoxide init powershell | Out-String) })
carapace _carapace | Out-String | Invoke-Expression

# ==============================================================================
# 3. TRUE FISH-SHELL OPTIONS & SUGGESTIONS
# ==============================================================================
Import-Module PSReadLine

Set-PSReadLineOption -Colors @{ 
  "Selection"        = "`e[7m" 
  "InlinePrediction" = "$([char]0x1b)[38;5;244;3m" # Muted gray text style
}
Set-PSReadLineOption -PredictionSource History
Set-PSReadLineOption -PredictionViewStyle InlineView

# FISH CORNERSTONE: Forces cursor to the END of the command during up/down history searches
Set-PSReadLineOption -HistorySearchCursorMovesToEnd

# Standard Tab completion menu interface
Set-PSReadLineKeyHandler -Key Tab -Function MenuComplete

# Strict Fish Prefix Search (e.g. typing 'ab' skips 'pwd' and matches 'abc')
Set-PSReadLineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadLineKeyHandler -Key DownArrow -Function HistorySearchForward

# ==============================================================================
# 4. PURE FISH NAVIGATION ACTIONS
# ==============================================================================
# Right Arrow: Accepts the suggestion LETTER-BY-LETTER
Set-PSReadLineKeyHandler -Key RightArrow -Function ForwardChar

# Ctrl + Right Arrow: Accepts the suggestion WORD-BY-WORD 
Set-PSReadLineKeyHandler -Key Ctrl+RightArrow -Function ForwardWord

# End Key: Jumps to the end and accepts the ENTIRE suggestion instantly
Set-PSReadLineKeyHandler -Key End -ScriptBlock {
  [Microsoft.PowerShell.PSConsoleReadLine]::EndOfLine()
  [Microsoft.PowerShell.PSConsoleReadLine]::AcceptSuggestion()
}

# F2 Key: View Style Switcher (Inline View <-> Visual Dropdown)
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

# ==============================================================================
# 5. FZF INTEGRATION
# ==============================================================================
if (Get-Module -ListAvailable -Name PSFzf)
{
  Import-Module PSFzf
    
  # Configure global FZF behavior chords
  Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+t' -PSReadlineChordReverseHistory 'Ctrl+r'
    
  # Map F3 to trigger interactive fuzzy file search
  Set-PSReadLineKeyHandler -Key F3 -ScriptBlock { Invoke-FzfTabCompletion }
}
