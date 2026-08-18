install:
	mkdir -p ${HOME}/.local/share/mpd/playlists ${HOME}/.local/state/mpd
	stow -S . -t ${HOME}

uninstall:
	stow -D . -t ${HOME}
