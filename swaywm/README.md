# My Sway Configuration
This is my configuration for the Sway compositor (some might say "window 
manager"). It's what shows windows on my laptop/desktop screen, and allows 
me to set key bindings (some might say "keyboard shortcuts") to do things 
like:
    - open applications
    - switch focus between windows
    - show how much battery I have left


## Notes
### Output names
"Outputs" in this context mean monitors, or screens. You can get the names 
of outputs currently connected via:
    - `swaymsg --type get_outputs`
    - `wlr-randr` (if installed)
    - `xrandr --query` (on X11, so not Sway)
