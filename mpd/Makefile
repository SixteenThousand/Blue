STOWIGNORE=--ignore=Makefile

install:
	mkdir -p ${HOME}/.local/share/mpd/playlists ${HOME}/.local/state/mpd
	stow -S . -t ${HOME} ${STOWIGNORE}

uninstall:
	stow -D . -t ${HOME} ${STOWIGNORE}
