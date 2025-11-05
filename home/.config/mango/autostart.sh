waybar &
swaybg -i Pictures/Wallpapers/default
wl-paste --type text --watch cliphist store &
wl-paste --type image --watch cliphist store & 
swaync &
swayidle \
  timeout 600 'wlopm --off "*"' \
  resume 'wlopm --on "*"'
