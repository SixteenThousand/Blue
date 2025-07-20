IGNORE="--ignore=Makefile"
CONF_HOME=${HOME}/.config

install:
	mv ${CONF_HOME}/i3 ./OLD-i3-config || :
	stow -S . -t ${CONF_HOME} ${IGNORE}

uninstall:
	stow -D . -t ${CONF_HOME} ${IGNORE}
