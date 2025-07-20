STOW_IGNORE=--ignore=Makefile --ignore=README.md

install:
	mv ${HOME}/.config/sway ./OLD-sway-config || :
	stow -S . -t ${HOME} ${STOW_IGNORE}

uninstall:
	stow -D . -t ${HOME}
