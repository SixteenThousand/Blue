CONFIG_DIR=${HOME}/.config/nnn
BOOKMARK_DIR=${CONFIG_DIR}/bookmarks

install:
	mkdir -p ${BOOKMARK_DIR}
	find ${HOME} -mindepth 1 -maxdepth 1 -type d -not -name '.*' | \
		xargs ln -s -t ${BOOKMARK_DIR}
	ln -s /media ${BOOKMARK_DIR}/media || :
	ln -s /usr/share ${BOOKMARK_DIR}/usr-share || :
	ln -s ${HOME}/.local/share ${BOOKMARK_DIR}/local-share || :
	mv ${CONFIG_DIR}/plugins ./plugins.bak || :
	ln -s ${PWD}/plugins ${CONFIG_DIR}

uninstall:
	rm -rI ${CONFIG_DIR}/plugins ${BOOKMARK_DIR} || :

.PHONY: install uninstall
