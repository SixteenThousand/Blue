# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	source /etc/bashrc
fi
# -------------------------

# Sections marked with !DANGER! should be edited with care.
# They are used in later sections of the config and changing this
# without taking them into account may break extensions.

# !DANGER!
SIXTEEN_DATA_DIR="$HOME/.local/share/bash"

# history
# !DANGER! (stale)
export HISTFILE="$SIXTEEN_DATA_DIR/.bash_history"
export HISTCONTROL="$HISTCONTROL:erasedups"
export HISTFILESIZE=1000000
export HISTIGNORE="$HISTIGNORE:z *:&:stale"
export HISTTIMEFORMAT='%b-%d %H:%M:%S | '

# github
export MYGITHUB='https://github.com/SixteenThousand'
export GITHUB='https://github.com'
# User specific aliases and functions
if [ -d ~/.config/bash ]; then
	for rc in ~/.config/bash/*; do
		if [ -f "$rc" ]; then
			. "$rc"
		fi
	done
fi
unset rc

shopt -s autocd cdspell nullglob checkjobs dotglob
	# checkjobs doesn't do anything when in a multiplexer
unset command_not_found_handle

# Without this, CTRL-S would stop you being able to type!
# If using another shell without this in its config, use CTRL-C or CTRL-Q to
# let the shell start accepting input again.
# This is called "Software Flow Control".
stty -ixon

fastfetch 2>/dev/null || :
