# Line editing
setopt beep extendedglob nomatch
unsetopt autocd

autoload -Uz compinit
compinit
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

bindkey -e

# Aliases
alias l='ls --color=always -A'
alias e="$EDITOR"
alias f=nnn
# The --gitignore option isn't used here as I don't want files in 
# $GIT_DIR/info/exclude to be excluded
alias t='tree -C -a -I .git -I node_modules -I .venv'

# Functions
function pathgrep {
	find $(echo $PATH | sed -e 's/:/ /g') -maxdepth 1 -type f,l 2>/dev/null |
		xargs stat -f %R |
		grep $@
}

# Pass argument 'd' to get project directories
function project_files {
    local item_type=f
    [[ -n $1 ]] && item_type=$1
    find . \
        -path '*node_modules*' \
        -o -path '*.git*' \
        -o -path '*.venv*' \
        -prune -o \
        -type $item_type -print
}

SIXTEEN_BOOKMARKS="
${HOME}
${HOME}/Documents
/usr
"

function get_bookmark_dirs {
    find ${=SIXTEEN_BOOKMARKS} \
        -maxdepth 2 \
        -type d \
        -not -path '*/.*' \
        -not -path '*/Library/*' \
        2>/dev/null
}

function z {
    if [[ -z $1 ]]; then
        cd
        return
    fi
    cd "$(get_bookmark_dirs | grep -i "$1.*$2" | head -n 1)"
}

function zi {
    cd "$(get_bookmark_dirs | fzf)"
}

function zz {
    [[ -z $1 ]] && return 1
    cd "$(project_files d | grep -i "$1.*$2" | head -n 1)"
}

# App stuff
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init - zsh)"

# Prompt
function prompt_info {
    GIT_CURRENT_BRANCH=
    local branch
    if branch=$(git branch --show-current 2>/dev/null); then
        GIT_CURRENT_BRANCH=" $branch"
    fi
}
precmd_functions+=( prompt_info )
setopt PROMPT_SUBST
PS1='%F{red}%B%(?..==>> %? <<==)%f%b
%F{red}%n%f@%F{blue}%M%f'\
'+%F{cyan}zsh.$ZSH_VERSION '\
'%f[%B%F{yellow}%2~%f%b] '\
'<%F{red}%j%f> '\
'%F{green}$GIT_CURRENT_BRANCH'$'\033]133;A\033\\''%F{3}
 -> %f'
 
fastfetch 2>/dev/null || :
