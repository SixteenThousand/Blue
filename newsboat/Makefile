STOWIGNORE=Makefile

build:
	cd ./.config/newsboat && python3 genurls.py

install:
	stow -S . -t ${HOME} --ignore=${STOWIGNORE}

uninstall:
	stow -D . -t ${HOME} --ignore=${STOWIGNORE}
