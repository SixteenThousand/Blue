CONFIG_DIR=${HOME}/.config/kitty
DESKTOP_FILES_DIR=${HOME}/.local/share/applications
BIN_DIR=${HOME}/.local/bin

install:
	mv ${CONFIG_DIR} ./OLD-kitty-config || :
	mkdir -p $(dirname ${CONFIG_DIR}) ${DESKTOP_FILES_DIR} ${BIN_DIR}
	ln -s ${PWD} ${CONFIG_DIR}
	ln -s ${PWD}/term-file-manager.desktop ${DESKTOP_FILES_DIR}
	ln -s ${PWD}/kittyctl ${BIN_DIR}

uninstall:
	rm -I ${CONFIG_DIR} ${DESKTOP_FILES_DIR}/term-file-manager.desktop ${BIN_DIR}/kittyctl

build: kitty.conf
	kill -SIGUSR1 ${KITTY_PID}
