alias l='ls --classify=always --color=always --almost-all'
alias e="$EDITOR"
alias f=nnn
# The --gitignore option isn't used here as I don't want files in 
# $GIT_DIR/info/exclude to be excluded
alias t='tree -a -I .git -I node_modules -I .venv'
alias tma='tmux attach || tmux'
alias tmd='tmux detach'
alias sbcl='rlwrap sbcl'
alias shell='rlwrap xargs -L 1'
alias zathura='zathura --fork'
alias yg='grep -RnHI \
    --exclude-dir=.git \
    --exclude-dir=node_modules \
    --exclude-dir=.venv \
	--color=always'
# Pipe data into xcopy to save it in the clipboard,
# and run this to print the clipboard contents to stdout
alias xcopy='xclip -selection clipboard'
alias pm=pnpm
alias px=pnpx
