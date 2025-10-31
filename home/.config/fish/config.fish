if status is-interactive
    # Commands to run in interactive sessions can go here
    starship init fish | source
    zoxide init fish --cmd j | source
    set --export ANDROID_HOME $HOME/Android/Sdk
set -gx PATH $ANDROID_HOME/emulator $PATH;
set -gx PATH $ANDROID_HOME/tools $PATH;
set -gx PATH $ANDROID_HOME/tools/bin $PATH;
set -gx PATH $ANDROID_HOME/platform-tools $PATH;
	source "$HOME/.homesick/repos/homeshick/completions/homeshick.fish"
source "$HOME/.homesick/repos/homeshick/homeshick.fish"
end

# Start X at login
if status is-login
    if test -z "$DISPLAY" -a "$XDG_VTNR" = 1
	    #exec startx -- -keeptty
	    mango
    end
end

# pnpm
set -gx PNPM_HOME "/home/yogesh/.local/share/pnpm"
if not string match -q -- $PNPM_HOME $PATH
  set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end
