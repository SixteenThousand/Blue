# General Notes

## Keyboard settings
- run `localectl list-x11-keymap-options` to get all options for use with 
  `setxkbmap -option OPTION`
### Map Caps Lock to Escape
- On X11, use `setxkbmap -option caps:escape`. On Wayland, there should be 
  some kind of similar option.
- On KDE Plasma, use:
    Settings App > Keyboard > Keyboard > Key Bindings > Caps Lock behaviour 
    > Make Caps Lock an additional Esc
### Map Alt Graphic (AltGr) to Alt
- In KDE Plasma, use:
    Settings App > Keyboard > Keyboard > Key Bindings >
    Alt and Win behaviour > tick Alt and Meta are on Alt

## Prevent laptop sleeping on lid close
- see logind.conf(5)
- systemd unit you have to reload is `systemd-logind`

## Backup LibreOffice user profile
You just have to copy a directory:
### windows
~/AppData/Roaming/LibreOffice/4/user
or $env:APPDATA/LibreOffice/4/user

### linux
~/.config/libreoffice/4/user
or $XDG_CONFIG_HOME/libreoffice/4/user
