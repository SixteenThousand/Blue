IGNORE=--ignore=Makefile --ignore=.md --ignore=.gitignore --ignore=.bak

install:
	mkdir -p ${HOME}/.local/share/bash
	mv ${HOME}/.bashrc ${HOME}/.bashrc.bak || :
	mv ${HOME}/.profile ${HOME}/.profile.bak || :
	stow -S . -t ${HOME} ${IGNORE}

uninstall:
	stow -D . -t ${HOME} ${IGNORE}
