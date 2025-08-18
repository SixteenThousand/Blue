function git_prompt {
    GIT_CURRENT_BRANCH=
    local branch
    if branch=$(git branch --show-current 2>/dev/null); then
        GIT_CURRENT_BRANCH=" $branch"
    fi
}

precmd_functions+=( git_prompt)

setopt PROMPT_SUBST

PS1='%F{red}%n%f@%F{blue}%M%f+%F{cyan}zsh %f[%F{yellow}%2~%f] '\
'%F{green}$GIT_CURRENT_BRANCH'$'\033]133;A\033\\''%F{3} -> %f'
