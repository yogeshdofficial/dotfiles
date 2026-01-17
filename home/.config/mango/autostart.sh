waybar &
swaybg -i Pictures/Wallpapers/default &
wl-clip-persist --clipboard regular --reconnect-tries 0 &
wl-paste --type text --watch cliphist store &
wl-paste --type image --watch cliphist store & 
swaync &
dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=wlroots
#/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
#swayidle \
#  timeout 600 'wlopm --off "*"' \
#  resume 'wlopm --on "*"'
