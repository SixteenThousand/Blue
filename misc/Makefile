IGNORE=--ignore=Makefile

install:
	cd ${HOME} && mkdir -p \
		.local/bin \
		.config/menus
	stow -S . -t ${HOME} ${IGNORE}

uninstall:
	stow -D . -t ${HOME} ${IGNORE}
