STOW_IGNORE=--ignore=Makefile --ignore=README.md
install:
	mkdir -p ${HOME}/.config
	stow -S . -t ${HOME} ${STOW_IGNORE}
uninstall:
	stow -D . -t ${HOME}
