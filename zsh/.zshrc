setopt beep extendedglob nomatch
unsetopt autocd

# zstyle :compinstall filename '/

autoload -Uz compinit
compinit


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
 
 
 fastfetch || :
