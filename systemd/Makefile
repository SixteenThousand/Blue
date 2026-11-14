stow_ignore=--ignore=Makefile

install:
	mkdir -p ${HOME}/.config
	stow -S . -t ${HOME} ${stow_ignore}

uninstall:
	stow -D . -t ${HOME} ${stow_ignore}

.PHONY: install uninstall
