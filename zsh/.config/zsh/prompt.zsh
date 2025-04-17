git_prompt () {
    if BRANCH=$(git branch --show-current 2>/dev/null)
    then
        export GIT_CURRENT_BRANCH=" $BRANCH"
    fi
    unset BRANCH
}
precmd_functions+=( git_prompt )

setopt PROMPT_SUBST

TERM_INTEGRATION_CHAR=$(printf "")

PS1='%F{red}%n%f@%F{blue}%M%f+%F{cyan}zsh %f[%F{yellow}%2~%f] '\
'%F{green}$GIT_CURRENT_BRANCH'$'\033]133;A\033\\''%F{3} -> %f'
