export EDITOR=nvim
export TERMINAL=alacwrapper
export BROWSER=firefox
export MAILCHECK=

export XDG_CONFIG_HOME="$HOME/.config"
export XDG_SCREENSHOTS_DIR="$HOME/Pictures/Screenshots"

if [ "$XDG_CURRENT_DESKTOP" != "KDE" ]
then
    export QT_QPA_PLATFORMTHEME=qt6ct
    export SAL_USE_VCLPLUGIN=qt6
fi

# java windows on wayland
export _JAVA_AWT_WM_NONREPARENTING=1

# android studio
export ANDROID_HOME="$HOME/.android-studio/sdk"
export PATH="$PATH:$ANDROID_HOME/emulator:$ANDROID_HOME/platform-tools"

# python
export PYTHONSTARTUP=$XDG_CONFIG_HOME/python/.pyrc
export PYTHON_HISTORY="$HOME/.local/share/.python_history"

# nnn, the file manager
export NNN_TRASH=2 # see `man nnn` for more info
export NNN_OPTS=QeuC
export NNN_TMPFILE='/tmp/nnn-lastdir'
export NNN_OPENER=xdg-open
export NNN_PLUG='z:changedir;p:playlist;d:nmount;m:mtpmount'

# I hate X11
export XCURSOR_SIZE=48

export RIPGREP_CONFIG_PATH=$HOME/.config/ripgrep.conf

export GPG_TTY=$(tty)


export PATH="$HOME/.local/bin:$HOME/bin:/usr/sbin:$PATH"
