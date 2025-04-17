alias l='ls --classify=always --color=always --group-directories-first --almost-all'
alias e="$EDITOR"
alias el="nvim --cmd 'let g:sixteen_lsp=v:true'"
alias f=nnn
alias t='tree -a -I .git -I node_modules'
alias tma='tmux attach || tmux'
alias tmd='tmux detach'
alias sbcl='rlwrap sbcl'
alias shell='rlwrap xargs -L 1'
alias zathura='zathura --fork'
alias yg='grep -RnH --exclude-dir=.git --exclude-dir=node_modules \
	-I --color=always'
# Pipe data into xcopy to save it in the clipboard,
# and run this to print the clipboard contents to stdout
alias xcopy='xclip -selection clipboard'
