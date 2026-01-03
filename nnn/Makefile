CONFIG_DIR=${HOME}/.config/nnn
BOOKMARK_DIR=${CONFIG_DIR}/bookmarks

install:
	mkdir -p ${BOOKMARK_DIR}
	ln -s ${HOME}/Documents ${BOOKMARK_DIR}/Documents || :
	ln -s /mnt ${BOOKMARK_DIR}/mnt || :
	ln -s /usr/share ${BOOKMARK_DIR}/usr-share || :
	ln -s ${HOME}/.local/share ${BOOKMARK_DIR}/local-share || :
	ln -s ${HOME}/Downloads ${BOOKMARK_DIR}/Downloads || :
	ln -s ${HOME}/Scratch ${BOOKMARK_DIR}/Scratch || :
	mv ${CONFIG_DIR}/plugins ./OLD-plugins || :
	ln -s ${PWD}/plugins ${CONFIG_DIR}

uninstall:
	rm -rI ${CONFIG_DIR}/plugins ${BOOKMARK_DIR} || :
