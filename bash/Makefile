IGNORE=--ignore=Makefile --ignore=.md --ignore=.gitignore
install:
	mkdir -p ${HOME}/.local/share/bash
	stow -S . -t ${HOME} ${IGNORE}
uninstall:
	stow -D . -t ${HOME} ${IGNORE}
