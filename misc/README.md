# Misc

## XDG Menus

This only does anything if
```
XDG_MENU_PREFIX=sxtt- kbuildsycoca6 --noincremental
```
is run on login.


## Custom .desktop files

There are none of these now, but if you want to register a new application with 
the OS then you should make a file in `~/.local/share/applications` called 
`something.desktop` and inside you should have something of the form
```
[Desktop Entry]
Name=Some App Name
Exec=Executable argument1 argument2 ...
```
