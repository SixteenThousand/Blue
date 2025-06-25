# This script just sets up stuff for awesome that are easier to set from a shell script

# map Caps Lock to Escape
setxkbmap -option caps:escape

# compositor
picom --daemon --backend glx --vsync

# set wallpaper
$HOME/.fehbg

# Change default cursor size
xsetroot -xcf /usr/share/icons/Adwaita/cursors/default 48

# turn off screen saving
xset -dpms
xset s off

xrandr --output LVDS-1 --scale 1.2

xss-lock --transfer-sleep-lock -- i3lock --nofork --color 662266

# open some apps
desktopctl autostart
