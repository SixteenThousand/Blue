export EDITOR=nvim
export TERMINAL='kitty -1'
export BROWSER=firefox
export MAIL="$TERMINAL aerc"

export XDG_CONFIG_HOME="$HOME/.config"
export XDG_SCREENSHOTS_DIR="$HOME/Pictures/Screenshots"

if [ "$XDG_CURRENT_DESKTOP" != "KDE" ]
then
    export QT_QPA_PLATFORMTHEME=qt6ct
fi

# java windows on wayland
export _JAVA_AWT_WM_NONREPARENTING=1

# android studio
export ANDROID_HOME="$HOME/.android-studio/sdk"
export PATH="$PATH:$ANDROID_HOME/emulator:$ANDROID_HOME/platform-tools"

# fnm
export PATH="/run/user/1000/fnm_multishells/41738_1733769755361/bin":"$PATH"
export FNM_MULTISHELL_PATH="/run/user/1000/fnm_multishells/41738_1733769755361"
export FNM_VERSION_FILE_STRATEGY="local"
export FNM_DIR="$HOME/.local/share/fnm"
export FNM_LOGLEVEL="info"
export FNM_NODE_DIST_MIRROR="https://nodejs.org/dist"
export FNM_COREPACK_ENABLED="true"
export FNM_RESOLVE_ENGINES="true"
export FNM_ARCH="x64"

# nnn, the file manager
export NNN_TRASH=1 # -> use trash-cli. Set to 2 for `gio trash`
export NNN_OPTS=HQeuC
export NNN_TMPFILE='/tmp/nnn-lastdir'
export NNN_OPENER=xdg-open
export NNN_PLUG='z:changedir;m:mount;p:playlist;b:browser'

# I hate X11
export XCURSOR_SIZE=48


export PATH="$HOME/.local/bin:$HOME/bin:$PATH"
