IGNORE=--ignore=.gitignore --ignore=Makefile --ignore=themes-license.txt

install:
	mkdir -p ${HOME}/.local/bin ${HOME}/.local/share/applications
	stow -S . -t $(HOME) ${IGNORE}

uninstall:
	stow -D . -t $(HOME) ${IGNORE}
