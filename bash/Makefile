IGNORE=--ignore=Makefile --ignore=.md --ignore=.gitignore

install:
	mkdir -p ${HOME}/.local/share/bash
	mv ${HOME}/.bashrc ./OLD-bashrc || :
	mv ${HOME}/.profile ./OLD-profile || :
	stow -S . -t ${HOME} ${IGNORE}

uninstall:
	stow -D . -t ${HOME} ${IGNORE}
